Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491E9C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDCOjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:39:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50858 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:39:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 414B62806B8
Subject: Re: [PATCH v3 1/2] platform/chrome: wilco_ec: Standardize mailbox
 interface
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
References: <20190403020519.211483-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d1b882d3-4a4f-def6-d13c-cf893b3e81e8@collabora.com>
Date:   Wed, 3 Apr 2019 16:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403020519.211483-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 3/4/19 4:05, Nick Crews wrote:
> The current API for the wilco EC mailbox interface is bad.
> 
> It assumes that most messages sent to the EC follow a similar structure,
> with a command byte in MBOX[0], followed by a junk byte, followed by
> actual data. This doesn't happen in several cases, such as setting the
> RTC time, using the raw debugfs interface, and reading or writing
> properties such as the Peak Shift policy (this last to be submitted soon).
> 
> Similarly for the response message from the EC, the current interface
> assumes that the first byte of data is always 0, and the second byte
> is unused. However, in both setting and getting the RTC time, in the
> debugfs interface, and for reading and writing properties, this isn't
> true.
> 
> The current way to resolve this is to use WILCO_EC_FLAG_RAW* flags to
> specify when and when not to skip these initial bytes in the sent and
> received message. They are confusing and used so much that they are
> normal, and not exceptions. In addition, the first byte of
> response in the debugfs interface is still always skipped, which is
> weird, since this raw interface should be giving the entire result.
> 
> Additionally, sent messages assume the first byte is a command, and so
> struct wilco_ec_message contains the "command" field. In setting or
> getting properties however, the first byte is not a command, and so this
> field has to be filled with a byte that isn't actually a command. This
> is again inconsistent.
> 
> wilco_ec_message contains a result field as well, copied from
> wilco_ec_response->result. The message result field should be removed:
> if the message fails, the cause is already logged, and the callers are
> alerted. They will never care about the actual state of the result flag.
> 
> These flags and different cases make the wilco_ec_transfer() function,
> used in wilco_ec_mailbox(), really gross, dealing with a bunch of
> different cases. It's difficult to figure out what it is doing.
> 
> Finally, making these assumptions about the structure of a message make
> it so that the messages do not correspond well with the specification
> for the EC's mailbox interface. For instance, this interface
> specification may say that MBOX[9] in the received message contains
> some information, but the calling code needs to remember that the first
> byte of response is always skipped, and because it didn't set the
> RESPONSE_RAW flag, the next byte is also skipped, so this information
> is actually contained within wilco_ec_message->response_data[7]. This
> makes it difficult to maintain this code in the future.
> 
> To fix these problems this patch standardizes the mailbox interface by:
> - Removing the WILCO_EC_FLAG_RAW* flags
> - Removing the command and reserved_raw bytes from wilco_ec_request
> - Removing the mbox0 byte from wilco_ec_response
> - Simplifying wilco_ec_transfer() because of these changes
> - Gives the callers of wilco_ec_mailbox() the responsibility of exactly
>   and consistently defining the structure of the mailbox request and
>   response
> - Removing command and result from wilco_ec_message.
> 
> This results in the reduction of total code, and makes it much more
> maintainable and understandable.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/platform/chrome/wilco_ec/debugfs.c | 43 ++++++++-------
>  drivers/platform/chrome/wilco_ec/mailbox.c | 53 ++++++++----------
>  drivers/rtc/rtc-wilco-ec.c                 | 63 +++++++++++++---------

I'd like to see an ack from rtc maintainer before merging this. Cc'ing the RTC
maintainers and the rtc mailing list.

The patch looks good to me. I think that this can go all through the
platform/chrome tree if the RTC maintainers are agree.

>  include/linux/platform_data/wilco-ec.h     | 22 +-------
>  4 files changed, 83 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index c090db2cd5be..17c4c9068aaf 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -10,25 +10,26 @@
>   * by reading from raw.
>   *
>   * For writing:
> - * Bytes 0-1 indicate the message type:
> - *         00 F0 = Execute Legacy Command
> - *         00 F2 = Read/Write NVRAM Property
> - * Byte 2 provides the command code
> - * Bytes 3+ consist of the data passed in the request
> + * Bytes 0-1 indicate the message type, one of enum wilco_ec_msg_type
> + * Byte 2+ consist of the data passed in the request, starting at MBOX[0]
>   *
> - * When referencing the EC interface spec, byte 2 corresponds to MBOX[0],
> - * byte 3 corresponds to MBOX[1], etc.
> - *
> - * At least three bytes are required, for the msg type and command,
> - * with additional bytes optional for additional data.
> + * At least three bytes are required for writing, two for the type and at
> + * least a single byte of data. Only the first EC_MAILBOX_DATA_SIZE bytes
> + * of MBOX will be used.
>   *
>   * Example:
>   * // Request EC info type 3 (EC firmware build date)
> - * $ echo 00 f0 38 00 03 00 > raw
> + * // Corresponds with sending type 0x00f0 with MBOX = [38, 00, 03, 00]
> + * $ echo 00 f0 38 00 03 00 > /sys/kernel/debug/wilco_ec/raw
>   * // View the result. The decoded ASCII result "12/21/18" is
>   * // included after the raw hex.
> - * $ cat raw
> - * 00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
> + * // Corresponds with MBOX = [00, 00, 31, 32, 2f, 32, 31, ...]
> + * $ cat /sys/kernel/debug/wilco_ec/raw
> + * 00 00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  ..12/21/18.8...
> + *
> + * Note that the first 32 bytes of the received MBOX[] will be printed,
> + * even if some of the data is junk. It is up to you to know how many of
> + * the first bytes of data are the actual response.
>   */
>  
>  #include <linux/ctype.h>
> @@ -136,18 +137,15 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
>  	ret = parse_hex_sentence(buf, kcount, request_data, TYPE_AND_DATA_SIZE);
>  	if (ret < 0)
>  		return ret;
> -	/* Need at least two bytes for message type and one for command */
> +	/* Need at least two bytes for message type and one byte of data */
>  	if (ret < 3)
>  		return -EINVAL;
>  
> -	/* Clear response data buffer */
> -	memset(debug_info->raw_data, '\0', EC_MAILBOX_DATA_SIZE_EXTENDED);
> -
>  	msg.type = request_data[0] << 8 | request_data[1];
> -	msg.flags = WILCO_EC_FLAG_RAW;
> -	msg.command = request_data[2];
> -	msg.request_data = ret > 3 ? request_data + 3 : 0;
> -	msg.request_size = ret - 3;
> +	msg.flags = 0;
> +	msg.request_data = request_data + 2;
> +	msg.request_size = ret - 2;
> +	memset(debug_info->raw_data, 0, sizeof(debug_info->raw_data));
>  	msg.response_data = debug_info->raw_data;
>  	msg.response_size = EC_MAILBOX_DATA_SIZE;
>  
> @@ -174,7 +172,8 @@ static ssize_t raw_read(struct file *file, char __user *user_buf, size_t count,
>  		fmt_len = hex_dump_to_buffer(debug_info->raw_data,
>  					     debug_info->response_size,
>  					     16, 1, debug_info->formatted_data,
> -					     FORMATTED_BUFFER_SIZE, true);
> +					     sizeof(debug_info->formatted_data),
> +					     true);
>  		/* Only return response the first time it is read */
>  		debug_info->response_size = 0;
>  	}
> diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
> index 14355668ddfa..7fb58b487963 100644
> --- a/drivers/platform/chrome/wilco_ec/mailbox.c
> +++ b/drivers/platform/chrome/wilco_ec/mailbox.c
> @@ -92,21 +92,10 @@ static void wilco_ec_prepare(struct wilco_ec_message *msg,
>  			     struct wilco_ec_request *rq)
>  {
>  	memset(rq, 0, sizeof(*rq));
> -
> -	/* Handle messages without trimming bytes from the request */
> -	if (msg->request_size && msg->flags & WILCO_EC_FLAG_RAW_REQUEST) {
> -		rq->reserved_raw = *(u8 *)msg->request_data;
> -		msg->request_size--;
> -		memmove(msg->request_data, msg->request_data + 1,
> -			msg->request_size);
> -	}
> -
> -	/* Fill in request packet */
>  	rq->struct_version = EC_MAILBOX_PROTO_VERSION;
>  	rq->mailbox_id = msg->type;
>  	rq->mailbox_version = EC_MAILBOX_VERSION;
> -	rq->data_size = msg->request_size + EC_MAILBOX_DATA_EXTRA;
> -	rq->command = msg->command;
> +	rq->data_size = msg->request_size;
>  
>  	/* Checksum header and data */
>  	rq->checksum = wilco_ec_checksum(rq, sizeof(*rq));
> @@ -159,6 +148,12 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
>  		return -EIO;
>  	}
>  
> +	/*
> +	 * The EC always returns either EC_MAILBOX_DATA_SIZE or
> +	 * EC_MAILBOX_DATA_SIZE_EXTENDED bytes of data, so we need to
> +	 * calculate the checksum on **all** of this data, even if we
> +	 * won't use all of it.
> +	 */
>  	if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA)
>  		size = EC_MAILBOX_DATA_SIZE_EXTENDED;
>  	else
> @@ -173,33 +168,26 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
>  		return -EBADMSG;
>  	}
>  
> -	/* Check that the EC reported success */
> -	msg->result = rs->result;
> -	if (msg->result) {
> -		dev_dbg(ec->dev, "bad response: 0x%02x\n", msg->result);
> +	if (rs->result) {
> +		dev_dbg(ec->dev, "EC reported failure: 0x%02x\n", rs->result);
>  		return -EBADMSG;
>  	}
>  
> -	/* Check the returned data size, skipping the header */
>  	if (rs->data_size != size) {
>  		dev_dbg(ec->dev, "unexpected packet size (%u != %zu)",
>  			rs->data_size, size);
>  		return -EMSGSIZE;
>  	}
>  
> -	/* Skip 1 response data byte unless specified */
> -	size = (msg->flags & WILCO_EC_FLAG_RAW_RESPONSE) ? 0 : 1;
> -	if ((ssize_t) rs->data_size - size < msg->response_size) {
> -		dev_dbg(ec->dev, "response data too short (%zd < %zu)",
> -			(ssize_t) rs->data_size - size, msg->response_size);
> +	if (rs->data_size < msg->response_size) {
> +		dev_dbg(ec->dev, "EC didn't return enough data (%u < %zu)",
> +			rs->data_size, msg->response_size);
>  		return -EMSGSIZE;
>  	}
>  
> -	/* Ignore response data bytes as requested */
> -	memcpy(msg->response_data, rs->data + size, msg->response_size);
> +	memcpy(msg->response_data, rs->data, msg->response_size);
>  
> -	/* Return actual amount of data received */
> -	return msg->response_size;
> +	return rs->data_size;
>  }
>  
>  /**
> @@ -207,10 +195,12 @@ static int wilco_ec_transfer(struct wilco_ec_device *ec,
>   * @ec: EC device.
>   * @msg: EC message data for request and response.
>   *
> - * On entry msg->type, msg->flags, msg->command, msg->request_size,
> - * msg->response_size, and msg->request_data should all be filled in.
> + * On entry msg->type, msg->request_size, and msg->request_data should all be
> + * filled in. If desired, msg->flags can be set.
>   *
> - * On exit msg->result and msg->response_data will be filled.
> + * If a response is expected, msg->response_size should be set, and
> + * msg->response_data should point to a buffer with enough space. On exit
> + * msg->response_data will be filled.
>   *
>   * Return: number of bytes received or negative error code on failure.
>   */
> @@ -219,9 +209,8 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
>  	struct wilco_ec_request *rq;
>  	int ret;
>  
> -	dev_dbg(ec->dev, "cmd=%02x type=%04x flags=%02x rslen=%zu rqlen=%zu\n",
> -		msg->command, msg->type, msg->flags, msg->response_size,
> -		msg->request_size);
> +	dev_dbg(ec->dev, "type=%04x flags=%02x rslen=%zu rqlen=%zu\n",
> +		msg->type, msg->flags, msg->response_size, msg->request_size);
>  
>  	mutex_lock(&ec->mailbox_lock);
>  	/* Prepare request packet */
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> index e62bda0cb53e..8ad4c4e6d557 100644
> --- a/drivers/rtc/rtc-wilco-ec.c
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -21,8 +21,20 @@
>  #define EC_CMOS_TOD_WRITE		0x02
>  #define EC_CMOS_TOD_READ		0x08
>  
> +/* Message sent to the EC to request the current time. */
> +struct ec_rtc_read_request {
> +	u8 command;
> +	u8 reserved;
> +	u8 param;
> +} __packed;

Add and empty line, don't need to resend for this, I can fix myself when I merge.

> +static struct ec_rtc_read_request read_rq = {
> +	.command = EC_COMMAND_CMOS,
> +	.param = EC_CMOS_TOD_READ,
> +};
> +
>  /**
> - * struct ec_rtc_read - Format of RTC returned by EC.
> + * struct ec_rtc_read_response - Format of RTC returned by EC.
> + * @reserved: Unused byte
>   * @second: Second value (0..59)
>   * @minute: Minute value (0..59)
>   * @hour: Hour value (0..23)
> @@ -33,7 +45,8 @@
>   *
>   * All values are presented in binary (not BCD).
>   */
> -struct ec_rtc_read {
> +struct ec_rtc_read_response {
> +	u8 reserved;
>  	u8 second;
>  	u8 minute;
>  	u8 hour;
> @@ -44,8 +57,10 @@ struct ec_rtc_read {
>  } __packed;
>  
>  /**
> - * struct ec_rtc_write - Format of RTC sent to the EC.
> - * @param: EC_CMOS_TOD_WRITE
> + * struct ec_rtc_write_request - Format of RTC sent to the EC.
> + * @command: Always EC_COMMAND_CMOS
> + * @reserved: Unused byte
> + * @param: Always EC_CMOS_TOD_WRITE
>   * @century: Century value (full year / 100)
>   * @year: Year value (full year % 100)
>   * @month: Month value (1..12)
> @@ -57,7 +72,9 @@ struct ec_rtc_read {
>   *
>   * All values are presented in BCD.
>   */
> -struct ec_rtc_write {
> +struct ec_rtc_write_request {
> +	u8 command;
> +	u8 reserved;
>  	u8 param;
>  	u8 century;
>  	u8 year;
> @@ -72,19 +89,17 @@ struct ec_rtc_write {
>  static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
>  {
>  	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> -	u8 param = EC_CMOS_TOD_READ;
> -	struct ec_rtc_read rtc;
> -	struct wilco_ec_message msg = {
> -		.type = WILCO_EC_MSG_LEGACY,
> -		.flags = WILCO_EC_FLAG_RAW_RESPONSE,
> -		.command = EC_COMMAND_CMOS,
> -		.request_data = &param,
> -		.request_size = sizeof(param),
> -		.response_data = &rtc,
> -		.response_size = sizeof(rtc),
> -	};
> +	struct ec_rtc_read_response rtc;
> +	struct wilco_ec_message msg;
>  	int ret;
>  
> +	memset(&msg, 0, sizeof(msg));
> +	msg.type = WILCO_EC_MSG_LEGACY;
> +	msg.request_data = &read_rq;
> +	msg.request_size = sizeof(read_rq);
> +	msg.response_data = &rtc;
> +	msg.response_size = sizeof(rtc);
> +
>  	ret = wilco_ec_mailbox(ec, &msg);
>  	if (ret < 0)
>  		return ret;
> @@ -106,14 +121,8 @@ static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
>  static int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
>  {
>  	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> -	struct ec_rtc_write rtc;
> -	struct wilco_ec_message msg = {
> -		.type = WILCO_EC_MSG_LEGACY,
> -		.flags = WILCO_EC_FLAG_RAW_RESPONSE,
> -		.command = EC_COMMAND_CMOS,
> -		.request_data = &rtc,
> -		.request_size = sizeof(rtc),
> -	};
> +	struct ec_rtc_write_request rtc;
> +	struct wilco_ec_message msg;
>  	int year = tm->tm_year + 1900;
>  	/*
>  	 * Convert from 0=Sunday to 0=Saturday for the EC
> @@ -123,6 +132,7 @@ static int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
>  	int wday = tm->tm_wday == 6 ? 0 : tm->tm_wday + 1;
>  	int ret;
>  
> +	rtc.command	= EC_COMMAND_CMOS;
>  	rtc.param	= EC_CMOS_TOD_WRITE;
>  	rtc.century	= bin2bcd(year / 100);
>  	rtc.year	= bin2bcd(year % 100);
> @@ -133,6 +143,11 @@ static int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
>  	rtc.second	= bin2bcd(tm->tm_sec);
>  	rtc.weekday	= bin2bcd(wday);
>  
> +	memset(&msg, 0, sizeof(msg));
> +	msg.type = WILCO_EC_MSG_LEGACY;
> +	msg.request_data = &rtc;
> +	msg.request_size = sizeof(rtc);
> +
>  	ret = wilco_ec_mailbox(ec, &msg);
>  	if (ret < 0)
>  		return ret;
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index 446473a46b88..1ff224793c99 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -14,10 +14,6 @@
>  /* Message flags for using the mailbox() interface */
>  #define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
>  #define WILCO_EC_FLAG_EXTENDED_DATA	BIT(1) /* EC returns 256 data bytes */
> -#define WILCO_EC_FLAG_RAW_REQUEST	BIT(2) /* Do not trim request data */
> -#define WILCO_EC_FLAG_RAW_RESPONSE	BIT(3) /* Do not trim response data */
> -#define WILCO_EC_FLAG_RAW		(WILCO_EC_FLAG_RAW_REQUEST | \
> -					 WILCO_EC_FLAG_RAW_RESPONSE)
>  
>  /* Normal commands have a maximum 32 bytes of data */
>  #define EC_MAILBOX_DATA_SIZE		32
> @@ -56,10 +52,7 @@ struct wilco_ec_device {
>   * @mailbox_id: Mailbox identifier, specifies the command set.
>   * @mailbox_version: Mailbox interface version %EC_MAILBOX_VERSION
>   * @reserved: Set to zero.
> - * @data_size: Length of request, data + last 2 bytes of the header.
> - * @command: Mailbox command code, unique for each mailbox_id set.
> - * @reserved_raw: Set to zero for most commands, but is used by
> - *                some command types and for raw commands.
> + * @data_size: Length of following data.
>   */
>  struct wilco_ec_request {
>  	u8 struct_version;
> @@ -68,8 +61,6 @@ struct wilco_ec_request {
>  	u8 mailbox_version;
>  	u8 reserved;
>  	u16 data_size;
> -	u8 command;
> -	u8 reserved_raw;
>  } __packed;
>  
>  /**
> @@ -79,8 +70,6 @@ struct wilco_ec_request {
>   * @result: Result code from the EC.  Non-zero indicates an error.
>   * @data_size: Length of the response data buffer.
>   * @reserved: Set to zero.
> - * @mbox0: EC returned data at offset 0 is unused (always 0) so this byte
> - *         is treated as part of the header instead of the data.
>   * @data: Response data buffer.  Max size is %EC_MAILBOX_DATA_SIZE_EXTENDED.
>   */
>  struct wilco_ec_response {
> @@ -89,7 +78,6 @@ struct wilco_ec_response {
>  	u16 result;
>  	u16 data_size;
>  	u8 reserved[2];
> -	u8 mbox0;
>  	u8 data[0];
>  } __packed;
>  
> @@ -111,21 +99,15 @@ enum wilco_ec_msg_type {
>   * struct wilco_ec_message - Request and response message.
>   * @type: Mailbox message type.
>   * @flags: Message flags, e.g. %WILCO_EC_FLAG_NO_RESPONSE.
> - * @command: Mailbox command code.
> - * @result: Result code from the EC.  Non-zero indicates an error.
>   * @request_size: Number of bytes to send to the EC.
>   * @request_data: Buffer containing the request data.
> - * @response_size: Number of bytes expected from the EC.
> - *                 This is 32 by default and 256 if the flag
> - *                 is set for %WILCO_EC_FLAG_EXTENDED_DATA
> + * @response_size: Number of bytes to read from EC.
>   * @response_data: Buffer containing the response data, should be
>   *                 response_size bytes and allocated by caller.
>   */
>  struct wilco_ec_message {
>  	enum wilco_ec_msg_type type;
>  	u8 flags;
> -	u8 command;
> -	u8 result;
>  	size_t request_size;
>  	void *request_data;
>  	size_t response_size;
> 
