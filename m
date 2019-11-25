Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FEAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827A020863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfKYPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:45:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59680 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfKYPpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:45:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3AB9428DE53
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Add response tracing
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     akshu.agrawal@amd.com, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
References: <20191121115542.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4eef47ad-8d42-1ab4-0c99-028a121cc27c@collabora.com>
Date:   Mon, 25 Nov 2019 16:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121115542.1.Iaf98f0ab455b626537e77cfa71cef6ff2ab6f37b@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

Many tanks for sending this patch upstream, some few comments below.

On 21/11/19 19:55, Raul E Rangel wrote:
> Add the ability to view response codes as well.
> 
> I renamed the trace event from cros_ec_cmd to cros_ec_request and added
> a cros_ec_response.
> 
> Example:
> $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
> $ cat /sys/kernel/debug/tracing/trace
> 
> cros_ec_request: version: 1, command: EC_CMD_CONSOLE_READ
> cros_ec_response: version: 1, command: EC_CMD_CONSOLE_READ, result: EC_RES_SUCCESS, rc: 0

I don't see the advantage of have two traces, one for the request and another
one for the response. Do you expect get stuck between them?

What about just move the trace_cros_ec_cmd after the xfer_fnx call and add the
results?

Thanks,
 Enric

> cros_ec_request: version: 0, command: EC_CMD_USB_PD_POWER_INFO
> cros_ec_response: version: 0, command: EC_CMD_USB_PD_POWER_INFO, result: EC_RES_SUCCESS, rc: 16
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/platform/chrome/cros_ec_proto.c |  7 +++++-
>  drivers/platform/chrome/cros_ec_trace.c | 24 +++++++++++++++++++
>  drivers/platform/chrome/cros_ec_trace.h | 32 +++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index bd485ce98a42..ef2229047e0f 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -54,7 +54,7 @@ static int send_command(struct cros_ec_device *ec_dev,
>  	int ret;
>  	int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
>  
> -	trace_cros_ec_cmd(msg);
> +	trace_cros_ec_request(msg);
>  
>  	if (ec_dev->proto_version > 2)
>  		xfer_fxn = ec_dev->pkt_xfer;
> @@ -73,6 +73,8 @@ static int send_command(struct cros_ec_device *ec_dev,
>  	}
>  
>  	ret = (*xfer_fxn)(ec_dev, msg);
> +
> +	trace_cros_ec_response(msg, ret);
>  	if (msg->result == EC_RES_IN_PROGRESS) {
>  		int i;
>  		struct cros_ec_command *status_msg;
> @@ -95,7 +97,10 @@ static int send_command(struct cros_ec_device *ec_dev,
>  		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
>  			usleep_range(10000, 11000);
>  
> +			trace_cros_ec_request(status_msg);
>  			ret = (*xfer_fxn)(ec_dev, status_msg);
> +			trace_cros_ec_response(status_msg, ret);
> +
>  			if (ret == -EAGAIN)
>  				continue;
>  			if (ret < 0)
> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> index 6f80ff4532ae..28eb94d99ba2 100644
> --- a/drivers/platform/chrome/cros_ec_trace.c
> +++ b/drivers/platform/chrome/cros_ec_trace.c
> @@ -120,5 +120,29 @@
>  	TRACE_SYMBOL(EC_CMD_PD_GET_LOG_ENTRY), \
>  	TRACE_SYMBOL(EC_CMD_USB_PD_MUX_INFO)
>  
> +// See enum ec_status

Use the C comment style, please.

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
> index 0dd4df30fa89..853eeaaac9da 100644
> --- a/drivers/platform/chrome/cros_ec_trace.h
> +++ b/drivers/platform/chrome/cros_ec_trace.h
> @@ -18,7 +18,7 @@
>  
>  #include <linux/tracepoint.h>
>  
> -DECLARE_EVENT_CLASS(cros_ec_cmd_class,
> +DECLARE_EVENT_CLASS(cros_ec_request_class,
>  	TP_PROTO(struct cros_ec_command *cmd),
>  	TP_ARGS(cmd),
>  	TP_STRUCT__entry(
> @@ -34,11 +34,39 @@ DECLARE_EVENT_CLASS(cros_ec_cmd_class,
>  );
>  
>  
> -DEFINE_EVENT(cros_ec_cmd_class, cros_ec_cmd,
> +DEFINE_EVENT(cros_ec_request_class, cros_ec_request,
>  	TP_PROTO(struct cros_ec_command *cmd),
>  	TP_ARGS(cmd)
>  );
>  
> +DECLARE_EVENT_CLASS(cros_ec_response_class,
> +	TP_PROTO(struct cros_ec_command *cmd, int rc),
> +	TP_ARGS(cmd, rc),
> +	TP_STRUCT__entry(
> +		__field(uint32_t, version)
> +		__field(uint32_t, command)
> +		__field(uint32_t, result)
> +		__field(int, rc)
> +	),
> +	TP_fast_assign(
> +		__entry->version = cmd->version;
> +		__entry->command = cmd->command;
> +		__entry->result = cmd->result;
> +		__entry->rc = rc;
> +	),
> +	TP_printk("version: %u, command: %s, result: %s, rc: %d",
> +		  __entry->version,
> +		  __print_symbolic(__entry->command, EC_CMDS),
> +		  __print_symbolic(__entry->result, EC_RESULT),
> +		  __entry->rc)
> +);
> +
> +
> +DEFINE_EVENT(cros_ec_response_class, cros_ec_response,
> +	TP_PROTO(struct cros_ec_command *cmd, int rc),
> +	TP_ARGS(cmd, rc)
> +);
> +
>  
>  #endif /* _CROS_EC_TRACE_H_ */
>  
> 
