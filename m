Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326C621848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392000AbfHVTdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:33:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37656 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732558AbfHVTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:33:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A786928CAE4
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add batt_ppid_info command to
 telemetry driver
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org
References: <20190805202214.3408-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <44b2fcef-4192-7931-b0dc-6f674d2ff5b6@collabora.com>
Date:   Thu, 22 Aug 2019 21:33:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805202214.3408-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 5/8/19 22:22, Nick Crews wrote:
> Add the GET_BATT_PPID_INFO=0x8A command to the allowlist of accepted
> telemetry commands. In addition, since this new command requires
> verifying the contents of some of the arguments, I also restructure
> the request to use a union of the argument structs. Also, zero out the
> request buffer before each request, and change "whitelist" to
> "allowlist".
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>

Sorry for my late reply on this, I took some vacations :)

I added for the patch for the autobuilders to play with and if everything goes
well I'll add the patch to chrome-platform-5.4

Thanks,
Enric

> ---
>  drivers/platform/chrome/wilco_ec/telemetry.c | 64 +++++++++++++-------
>  1 file changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
> index 94cdc166c840..b9d03c33d8dc 100644
> --- a/drivers/platform/chrome/wilco_ec/telemetry.c
> +++ b/drivers/platform/chrome/wilco_ec/telemetry.c
> @@ -9,7 +9,7 @@
>   * the OS sends a command to the EC via a write() to a char device,
>   * and can read the response with a read(). The write() request is
>   * verified by the driver to ensure that it is performing only one
> - * of the whitelisted commands, and that no extraneous data is
> + * of the allowlisted commands, and that no extraneous data is
>   * being transmitted to the EC. The response is passed directly
>   * back to the reader with no modification.
>   *
> @@ -59,21 +59,10 @@ static DEFINE_IDA(telem_ida);
>  #define WILCO_EC_TELEM_GET_TEMP_INFO		0x95
>  #define WILCO_EC_TELEM_GET_TEMP_READ		0x2C
>  #define WILCO_EC_TELEM_GET_BATT_EXT_INFO	0x07
> +#define WILCO_EC_TELEM_GET_BATT_PPID_INFO	0x8A
>  
>  #define TELEM_ARGS_SIZE_MAX	30
>  
> -/**
> - * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
> - * @command: One of WILCO_EC_TELEM_GET_* command codes.
> - * @reserved: Must be 0.
> - * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
> - */
> -struct wilco_ec_telem_request {
> -	u8 command;
> -	u8 reserved;
> -	u8 args[TELEM_ARGS_SIZE_MAX];
> -} __packed;
> -
>  /*
>   * The following telem_args_get_* structs are embedded within the |args| field
>   * of wilco_ec_telem_request.
> @@ -122,6 +111,32 @@ struct telem_args_get_batt_ext_info {
>  	u8 var_args[5];
>  } __packed;
>  
> +struct telem_args_get_batt_ppid_info {
> +	u8 always1; /* Should always be 1 */
> +} __packed;
> +
> +/**
> + * struct wilco_ec_telem_request - Telemetry command and arguments sent to EC.
> + * @command: One of WILCO_EC_TELEM_GET_* command codes.
> + * @reserved: Must be 0.
> + * @args: The first N bytes are one of telem_args_get_* structs, the rest is 0.
> + */
> +struct wilco_ec_telem_request {
> +	u8 command;
> +	u8 reserved;
> +	union {
> +		u8 buf[TELEM_ARGS_SIZE_MAX];
> +		struct telem_args_get_log		get_log;
> +		struct telem_args_get_version		get_version;
> +		struct telem_args_get_fan_info		get_fan_info;
> +		struct telem_args_get_diag_info		get_diag_info;
> +		struct telem_args_get_temp_info		get_temp_info;
> +		struct telem_args_get_temp_read		get_temp_read;
> +		struct telem_args_get_batt_ext_info	get_batt_ext_info;
> +		struct telem_args_get_batt_ppid_info	get_batt_ppid_info;
> +	} args;
> +} __packed;
> +
>  /**
>   * check_telem_request() - Ensure that a request from userspace is valid.
>   * @rq: Request buffer copied from userspace.
> @@ -133,7 +148,7 @@ struct telem_args_get_batt_ext_info {
>   * We do not want to allow userspace to send arbitrary telemetry commands to
>   * the EC. Therefore we check to ensure that
>   * 1. The request follows the format of struct wilco_ec_telem_request.
> - * 2. The supplied command code is one of the whitelisted commands.
> + * 2. The supplied command code is one of the allowlisted commands.
>   * 3. The request only contains the necessary data for the header and arguments.
>   */
>  static int check_telem_request(struct wilco_ec_telem_request *rq,
> @@ -146,25 +161,31 @@ static int check_telem_request(struct wilco_ec_telem_request *rq,
>  
>  	switch (rq->command) {
>  	case WILCO_EC_TELEM_GET_LOG:
> -		max_size += sizeof(struct telem_args_get_log);
> +		max_size += sizeof(rq->args.get_log);
>  		break;
>  	case WILCO_EC_TELEM_GET_VERSION:
> -		max_size += sizeof(struct telem_args_get_version);
> +		max_size += sizeof(rq->args.get_version);
>  		break;
>  	case WILCO_EC_TELEM_GET_FAN_INFO:
> -		max_size += sizeof(struct telem_args_get_fan_info);
> +		max_size += sizeof(rq->args.get_fan_info);
>  		break;
>  	case WILCO_EC_TELEM_GET_DIAG_INFO:
> -		max_size += sizeof(struct telem_args_get_diag_info);
> +		max_size += sizeof(rq->args.get_diag_info);
>  		break;
>  	case WILCO_EC_TELEM_GET_TEMP_INFO:
> -		max_size += sizeof(struct telem_args_get_temp_info);
> +		max_size += sizeof(rq->args.get_temp_info);
>  		break;
>  	case WILCO_EC_TELEM_GET_TEMP_READ:
> -		max_size += sizeof(struct telem_args_get_temp_read);
> +		max_size += sizeof(rq->args.get_temp_read);
>  		break;
>  	case WILCO_EC_TELEM_GET_BATT_EXT_INFO:
> -		max_size += sizeof(struct telem_args_get_batt_ext_info);
> +		max_size += sizeof(rq->args.get_batt_ext_info);
> +		break;
> +	case WILCO_EC_TELEM_GET_BATT_PPID_INFO:
> +		if (rq->args.get_batt_ppid_info.always1 != 1)
> +			return -EINVAL;
> +
> +		max_size += sizeof(rq->args.get_batt_ppid_info);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -250,6 +271,7 @@ static ssize_t telem_write(struct file *filp, const char __user *buf,
>  
>  	if (count > sizeof(sess_data->request))
>  		return -EMSGSIZE;
> +	memset(&sess_data->request, 0, sizeof(sess_data->request));
>  	if (copy_from_user(&sess_data->request, buf, count))
>  		return -EFAULT;
>  	ret = check_telem_request(&sess_data->request, count);
> 
