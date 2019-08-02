Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127ECC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC552087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfHBPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:25:21 -0400
Received: from smtp.infotech.no ([82.134.31.41]:52223 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732454AbfHBPZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:25:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 39F21204237;
        Fri,  2 Aug 2019 17:25:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jq7iAZgMYHUl; Fri,  2 Aug 2019 17:25:18 +0200 (CEST)
Received: from [82.134.31.183] (unknown [82.134.31.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 15BBC20415B;
        Fri,  2 Aug 2019 17:25:17 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown
 alternate mode requests
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <03853a25-cc33-cdf6-f12b-e8688c8491a5@interlog.com>
Date:   Fri, 2 Aug 2019 17:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-25 6:30 a.m., Guenter Roeck wrote:
> TCPM may receive PD messages associated with unknown or unsupported
> alternate modes. If that happens, calls to typec_match_altmode()
> will return NULL. The tcpm code does not currently take this into
> account. This results in crashes.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000001f0
> pgd = 41dad9a1
> [000001f0] *pgd=00000000
> Internal error: Oops: 5 [#1] THUMB2
> Modules linked in: tcpci tcpm
> CPU: 0 PID: 2338 Comm: kworker/u2:0 Not tainted 5.1.18-sama5-armv7-r2 #6
> Hardware name: Atmel SAMA5
> Workqueue: 2-0050 tcpm_pd_rx_handler [tcpm]
> PC is at typec_altmode_attention+0x0/0x14
> LR is at tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm]
> ...
> [<c03fbee8>] (typec_altmode_attention) from [<bf8030fb>]
> 				(tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm])
> [<bf8030fb>] (tcpm_pd_rx_handler [tcpm]) from [<c012082b>]
> 				(process_one_work+0x123/0x2a8)
> [<c012082b>] (process_one_work) from [<c0120a6d>]
> 				(worker_thread+0xbd/0x3b0)
> [<c0120a6d>] (worker_thread) from [<c012431f>] (kthread+0xcf/0xf4)
> [<c012431f>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
> 
> Ignore PD messages if the asociated alternate mode is not supported.
> 
> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Taking a stab at the problem. I don't really know if this is the correct
> fix, or even if my understanding of the problem is correct, thus marking
> the patch as RFC.

Tested-by: Douglas Gilbert <dgilbert@interlog.com>

Tested on different hardware (Acme Arietta based on at91sam9g25) and
lk 5.2.5 . Without this patch the oops was at
    PC is at typec_altmode_attention+0x0/0x24 [typec]

The DUT was a Arietta with a OM13588 attached acting as a PD sink.
At the other end of the type C cable was a KL27Z+OM13588 running
NXP's usb_pd_bm app and it was a PD source. The other end did a
"send attention" to cause the oops.

With this patch nothing happened. Notable there was no oops.
The other end (KL27Z+OM13588 reported "send attention result:
success" but it also did that in the previous "oops" case.

Is there something to replace "tail -f" that would make it
easier to monitor what is being sent to
     /sys/kernel/debug/tcpm/1-0050
?

Doug Gilbert

>   drivers/usb/typec/tcpm/tcpm.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 77f71f602f73..1df2844469aa 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1096,7 +1096,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
>   			break;
>   		case CMD_ATTENTION:
>   			/* Attention command does not have response */
> -			typec_altmode_attention(adev, p[1]);
> +			if (adev)
> +				typec_altmode_attention(adev, p[1]);
>   			return 0;
>   		default:
>   			break;
> @@ -1148,20 +1149,26 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
>   			}
>   			break;
>   		case CMD_ENTER_MODE:
> -			typec_altmode_update_active(pdev, true);
> -
> -			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> -				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
> -				response[0] |= VDO_OPOS(adev->mode);
> -				return 1;
> +			if (adev && pdev) {
> +				typec_altmode_update_active(pdev, true);
> +
> +				if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
> +					response[0] = VDO(adev->svid, 1,
> +							  CMD_EXIT_MODE);
> +					response[0] |= VDO_OPOS(adev->mode);
> +					return 1;
> +				}
>   			}
>   			return 0;
>   		case CMD_EXIT_MODE:
> -			typec_altmode_update_active(pdev, false);
> +			if (adev && pdev) {
> +				typec_altmode_update_active(pdev, false);
>   
> -			/* Back to USB Operation */
> -			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
> -						     NULL));
> +				/* Back to USB Operation */
> +				WARN_ON(typec_altmode_notify(adev,
> +							     TYPEC_STATE_USB,
> +							     NULL));
> +			}
>   			break;
>   		default:
>   			break;
> @@ -1171,8 +1178,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
>   		switch (cmd) {
>   		case CMD_ENTER_MODE:
>   			/* Back to USB Operation */
> -			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
> -						     NULL));
> +			if (adev)
> +				WARN_ON(typec_altmode_notify(adev,
> +							     TYPEC_STATE_USB,
> +							     NULL));
>   			break;
>   		default:
>   			break;
> @@ -1183,7 +1192,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
>   	}
>   
>   	/* Informing the alternate mode drivers about everything */
> -	typec_altmode_vdm(adev, p[0], &p[1], cnt);
> +	if (adev)
> +		typec_altmode_vdm(adev, p[0], &p[1], cnt);
>   
>   	return rlen;
>   }
> 

