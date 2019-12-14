Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D087C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB92924125
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLNLzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:55:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40796 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfLNLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:55:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8BB3C289F5A
Subject: Re: [PATCH v2] platform/chrome: cros_ec_proto: Add response tracing
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     akshu.agrawal@amd.com, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
References: <20191125104537.v2.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <af447845-5d6a-1bb7-c7c2-5a275351796e@collabora.com>
Date:   Sat, 14 Dec 2019 12:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125104537.v2.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/11/19 18:45, Raul E Rangel wrote:
> Add the ability to view response codes as well.
> 
> I dropped the EVENT_CLASS since there is only one event per class.
> 
> cros_ec_cmd has now been renamed to cros_ec_request_start.
> 
> Example:
> $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
> $ cat /sys/kernel/debug/tracing/trace
> 
> 369.416372: cros_ec_request_start: version: 0, command: EC_CMD_USB_PD_POWER_INFO
> 369.420528: cros_ec_request_done: version: 0, command: EC_CMD_USB_PD_POWER_INFO, ec result: EC_RES_SUCCESS, retval: 16
> 369.420529: cros_ec_request_start: version: 0, command: EC_CMD_USB_PD_DISCOVERY
> 369.421383: cros_ec_request_done: version: 0, command: EC_CMD_USB_PD_DISCOVERY, ec result: EC_RES_SUCCESS, retval: 5
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Merge window is open now!  Queued for 5.6.

Thanks,
 Enric

> ---
> 
> Changes in v2:
> * Renamed events to cros_ec_request_start and cros_ec_request_done.
> * Minor printf changes.
> * Moved trace_cros_ec_request_start right above xfer_fxn.
> * Fixed comment style.
> END
> 
>  drivers/platform/chrome/cros_ec_proto.c |  8 ++++++--
>  drivers/platform/chrome/cros_ec_trace.c | 24 ++++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_trace.h | 27 +++++++++++++++++++------
>  3 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index bd485ce98a42..1b98193a9fc1 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -54,8 +54,6 @@ static int send_command(struct cros_ec_device *ec_dev,
>  	int ret;
>  	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
>  
> -	trace_cros_ec_cmd(msg);
> -
>  	if (ec_dev->proto_version > 2)
>  		xfer_fxn = ec_dev->pkt_xfer;
>  	else
> @@ -72,7 +70,10 @@ static int send_command(struct cros_ec_device *ec_dev,
>  		return -EIO;
>  	}
>  
> +	trace_cros_ec_request_start(msg);
>  	ret = (*xfer_fxn)(ec_dev, msg);
> +	trace_cros_ec_request_done(msg, ret);
> +
>  	if (msg->result == EC_RES_IN_PROGRESS) {
>  		int i;
>  		struct cros_ec_command *status_msg;
> @@ -95,7 +96,10 @@ static int send_command(struct cros_ec_device *ec_dev,
>  		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
>  			usleep_range(10000, 11000);
>  
> +			trace_cros_ec_request_start(status_msg);
>  			ret = (*xfer_fxn)(ec_dev, status_msg);
> +			trace_cros_ec_request_done(status_msg, ret);
> +
>  			if (ret == -EAGAIN)
>  				continue;
>  			if (ret < 0)
> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> index 6f80ff4532ae..ef423522bedc 100644
> --- a/drivers/platform/chrome/cros_ec_trace.c
> +++ b/drivers/platform/chrome/cros_ec_trace.c
> @@ -120,5 +120,29 @@
>  	TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
>  	TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
>  
> +/* See enum ec_status */
> +#define EC_RESULT \
> +	TRACE_SYMBOL(EC_RES_SUCCESS), \
> +	TRACE_SYMBOL(EC_RES_INVALID_COMMAND), \
> +	TRACE_SYMBOL(EC_RES_ERROR), \
> +	TRACE_SYMBOL(EC_RES_INVALID_PARAM), \
> +	TRACE_SYMBOL(EC_RES_ACCESS_DENIED), \
> +	TRACE_SYMBOL(EC_RES_INVALID_RESPONSE), \
> +	TRACE_SYMBOL(EC_RES_INVALID_VERSION), \
> +	TRACE_SYMBOL(EC_RES_INVALID_CHECKSUM), \
> +	TRACE_SYMBOL(EC_RES_IN_PROGRESS), \
> +	TRACE_SYMBOL(EC_RES_UNAVAILABLE), \
> +	TRACE_SYMBOL(EC_RES_TIMEOUT), \
> +	TRACE_SYMBOL(EC_RES_OVERFLOW), \
> +	TRACE_SYMBOL(EC_RES_INVALID_HEADER), \
> +	TRACE_SYMBOL(EC_RES_REQUEST_TRUNCATED), \
> +	TRACE_SYMBOL(EC_RES_RESPONSE_TOO_BIG), \
> +	TRACE_SYMBOL(EC_RES_BUS_ERROR), \
> +	TRACE_SYMBOL(EC_RES_BUSY), \
> +	TRACE_SYMBOL(EC_RES_INVALID_HEADER_VERSION), \
> +	TRACE_SYMBOL(EC_RES_INVALID_HEADER_CRC), \
> +	TRACE_SYMBOL(EC_RES_INVALID_DATA_CRC), \
> +	TRACE_SYMBOL(EC_RES_DUP_UNAVAILABLE)
> +
>  #define CREATE_TRACE_POINTS
>  #include "cros_ec_trace.h"
> diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
> index 0dd4df30fa89..ee20d8571796 100644
> --- a/drivers/platform/chrome/cros_ec_trace.h
> +++ b/drivers/platform/chrome/cros_ec_trace.h
> @@ -18,7 +18,7 @@
>  
>  #include <linux/tracepoint.h>
>  
> -DECLARE_EVENT_CLASS(cros_ec_cmd_class,
> +TRACE_EVENT(cros_ec_request_start,
>  	TP_PROTO(struct cros_ec_command *cmd),
>  	TP_ARGS(cmd),
>  	TP_STRUCT__entry(
> @@ -33,13 +33,28 @@ DECLARE_EVENT_CLASS(cros_ec_cmd_class,
>  		  __print_symbolic(__entry->command, EC_CMDS))
>  );
>  
> -
> -DEFINE_EVENT(cros_ec_cmd_class, cros_ec_cmd,
> -	TP_PROTO(struct cros_ec_command *cmd),
> -	TP_ARGS(cmd)
> +TRACE_EVENT(cros_ec_request_done,
> +	TP_PROTO(struct cros_ec_command *cmd, int retval),
> +	TP_ARGS(cmd, retval),
> +	TP_STRUCT__entry(
> +		__field(uint32_t, version)
> +		__field(uint32_t, command)
> +		__field(uint32_t, result)
> +		__field(int, retval)
> +	),
> +	TP_fast_assign(
> +		__entry->version = cmd->version;
> +		__entry->command = cmd->command;
> +		__entry->result = cmd->result;
> +		__entry->retval = retval;
> +	),
> +	TP_printk("version: %u, command: %s, ec result: %s, retval: %d",
> +		  __entry->version,
> +		  __print_symbolic(__entry->command, EC_CMDS),
> +		  __print_symbolic(__entry->result, EC_RESULT),
> +		  __entry->retval)
>  );
>  
> -
>  #endif /* _CROS_EC_TRACE_H_ */
>  
>  /* this part must be outside header guard */
> 
