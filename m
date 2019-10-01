Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43FAC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B098B2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfJAQGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:06:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42954 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbfJAQGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:06:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6CC9128B56C
Subject: Re: [PATCH v5] platform/chrome: wilco_ec: Add debugfs test_event file
To:     Benson Leung <bleung@google.com>,
        Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>
References: <20190924203716.209420-1-campello@chromium.org>
 <20190924213613.GB210752@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0097a619-439d-6257-7b4a-301b23ba046b@collabora.com>
Date:   Tue, 1 Oct 2019 18:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924213613.GB210752@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/9/19 23:36, Benson Leung wrote:
> Hi Daniel,
> 
> On Tue, Sep 24, 2019 at 02:37:16PM -0600, Daniel Campello wrote:
>> This change introduces a new debugfs file 'test_event' that when written
>> to causes the EC to generate a test event.
>> This adds a second sub cmd for the test event, and pulls out send_ec_cmd
>> to be a common helper between h1_gpio_get and test_event_set.
>>
>> Signed-off-by: Daniel Campello <campello@chromium.org>
> 
> LGTM.
> Reviewed-by: Benson Leung <bleung@chromium.org>
> 
> Merge window is open right now for v5.4, so we can't quite merge this change
> for chrome-platform-5.5 yet.
> 
> Enric, can you queue this for the next branch if you have no objections?
> 

Queued for the autobuilders to play with. If all goes well will appear in
chrome-platform-5.5 and linux-next in 24/48h

Thanks,
 Enric

> Thanks,
> Benson
> 
>> ---
>> Changes for v2:
>>   - Cleaned up and added comments.
>>   - Renamed and updated function signature from write_to_mailbox to
>>     send_ec_cmd.
>> Changes for v3:
>>   - Switched NULL format string to empty format string
>>   - Renamed val parameter on send_ec_cmd to out_val
>> Changes for v4:
>>   - Provided a format string to avoid -Wformat-zero-length warning
>> Changes for v5:
>>   - Updated commit message to include more implementation details
>>   - Restored removed empty line between functions
>>
>>  drivers/platform/chrome/wilco_ec/debugfs.c | 47 +++++++++++++++++-----
>>  1 file changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
>> index 8d65a1e2f1a3..df5a5f6c3ec6 100644
>> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
>> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
>> @@ -160,29 +160,29 @@ static const struct file_operations fops_raw = {
>>
>>  #define CMD_KB_CHROME		0x88
>>  #define SUB_CMD_H1_GPIO		0x0A
>> +#define SUB_CMD_TEST_EVENT	0x0B
>>
>> -struct h1_gpio_status_request {
>> +struct ec_request {
>>  	u8 cmd;		/* Always CMD_KB_CHROME */
>>  	u8 reserved;
>> -	u8 sub_cmd;	/* Always SUB_CMD_H1_GPIO */
>> +	u8 sub_cmd;
>>  } __packed;
>>
>> -struct hi_gpio_status_response {
>> +struct ec_response {
>>  	u8 status;	/* 0 if allowed */
>> -	u8 val;		/* BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL */
>> +	u8 val;
>>  } __packed;
>>
>> -static int h1_gpio_get(void *arg, u64 *val)
>> +static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *out_val)
>>  {
>> -	struct wilco_ec_device *ec = arg;
>> -	struct h1_gpio_status_request rq;
>> -	struct hi_gpio_status_response rs;
>> +	struct ec_request rq;
>> +	struct ec_response rs;
>>  	struct wilco_ec_message msg;
>>  	int ret;
>>
>>  	memset(&rq, 0, sizeof(rq));
>>  	rq.cmd = CMD_KB_CHROME;
>> -	rq.sub_cmd = SUB_CMD_H1_GPIO;
>> +	rq.sub_cmd = sub_cmd;
>>
>>  	memset(&msg, 0, sizeof(msg));
>>  	msg.type = WILCO_EC_MSG_LEGACY;
>> @@ -196,13 +196,38 @@ static int h1_gpio_get(void *arg, u64 *val)
>>  	if (rs.status)
>>  		return -EIO;
>>
>> -	*val = rs.val;
>> +	*out_val = rs.val;
>>
>>  	return 0;
>>  }
>>
>> +/**
>> + * h1_gpio_get() - Gets h1 gpio status.
>> + * @arg: The wilco EC device.
>> + * @val: BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL
>> + */
>> +static int h1_gpio_get(void *arg, u64 *val)
>> +{
>> +	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
>> +}
>> +
>>  DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
>>
>> +/**
>> + * test_event_set() - Sends command to EC to cause an EC test event.
>> + * @arg: The wilco EC device.
>> + * @val: unused.
>> + */
>> +static int test_event_set(void *arg, u64 val)
>> +{
>> +	u8 ret;
>> +
>> +	return send_ec_cmd(arg, SUB_CMD_TEST_EVENT, &ret);
>> +}
>> +
>> +/* Format is unused since it is only required for get method which is NULL */
>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_test_event, NULL, test_event_set, "%llu\n");
>> +
>>  /**
>>   * wilco_ec_debugfs_probe() - Create the debugfs node
>>   * @pdev: The platform device, probably created in core.c
>> @@ -226,6 +251,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
>>  	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
>>  	debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
>>  			    &fops_h1_gpio);
>> +	debugfs_create_file("test_event", 0200, debug_info->dir, ec,
>> +			    &fops_test_event);
>>
>>  	return 0;
>>  }
>> --
>> 2.23.0.351.gc4317032e6-goog
>>
> 
