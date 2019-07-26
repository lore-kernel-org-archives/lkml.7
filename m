Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C85DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7C722CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfGZPVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:21:36 -0400
Received: from smtp.infotech.no ([82.134.31.41]:52302 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfGZPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:21:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 3618C204194;
        Fri, 26 Jul 2019 17:21:33 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WrYd0Hozk3az; Fri, 26 Jul 2019 17:21:26 +0200 (CEST)
Received: from [192.168.48.23] (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 473D7204187;
        Fri, 26 Jul 2019 17:21:24 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown
 alternate mode requests
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <a6bff0eb-6b6f-5724-ddca-42bc46e794b8@interlog.com>
Date:   Fri, 26 Jul 2019 11:21:23 -0400
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

On 2019-07-25 12:30 a.m., Guenter Roeck wrote:
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

Took a little while because I was changing my Linux end to being based
on a Acme Systems Arietta (at91sam9g25). Reason: on the sama5d2xplained
I can't have the shield plugged into the Arduino sockets because it
drives the pin used by the OM13588 for its interrupt (nalert). So I
need to "jump" the pins needed (SDA, SCL, nALERT, 3v3 and ground) to
get this working (and 'cat /proc/interrupts' shows me its working
with >0 interrupts on "2-0050").

Anyway the DUT is a OM13588+sama5d2xplained running lk 5.1.18 and the
other end of the USB-C cable is a OM13588+KL27Z running NXP PD
software. Both ends can "play" sink or source (power). The oops
occurred when the DUT was source and the other end sent a "send
attention" ("l") command. With this patch I do not see the oops.


BTW I have tried to run lk 5.2.1 on the sama5d2xplained and the
kernel wouldn't start :-( Zilch after u-boot said it was loading
the kernel.

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

