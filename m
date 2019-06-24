Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7589DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5448920820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfFXNSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:18:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728666AbfFXNSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:18:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D1B7AFB7;
        Mon, 24 Jun 2019 13:18:01 +0000 (UTC)
Subject: Re: [PATCH 3/6] x86: Add nopv parameter to disable PV extensions
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561294903-6166-3-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <9e60cea2-a15f-b816-9049-f22be14c04b2@suse.com>
Date:   Mon, 24 Jun 2019 15:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561294903-6166-3-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.06.19 15:01, Zhenzhong Duan wrote:
> In virtualization environment, PV extensions (drivers, interrupts,
> timers, etc) are enabled in the majority of use cases which is the
> best option.
> 
> However, in some cases (kexec not fully working, benchmarking)
> we want to disable PV extensions. As such introduce the
> 'nopv' parameter that will do it.
> 
> There is already 'xen_nopv' parameter for XEN platform but not for
> others. 'xen_nopv' can then be removed with this change.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>   arch/x86/kernel/cpu/hypervisor.c                | 11 +++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 138f666..b352f36 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5268,6 +5268,10 @@
>   			improve timer resolution at the expense of processing
>   			more timer interrupts.
>   
> +	nopv=		[X86]
> +			Disables the PV optimizations forcing the guest to run
> +			as generic guest with no PV drivers.
> +
>   	xirc2ps_cs=	[NET,PCMCIA]
>   			Format:
>   			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
> diff --git a/arch/x86/kernel/cpu/hypervisor.c b/arch/x86/kernel/cpu/hypervisor.c
> index 479ca47..4f2c875 100644
> --- a/arch/x86/kernel/cpu/hypervisor.c
> +++ b/arch/x86/kernel/cpu/hypervisor.c
> @@ -85,10 +85,21 @@ static void __init copy_array(const void *src, void *target, unsigned int size)
>   			to[i] = from[i];
>   }
>   
> +static bool nopv;
> +static __init int xen_parse_nopv(char *arg)
> +{
> +	nopv = true;
> +	return 0;
> +}
> +early_param("nopv", xen_parse_nopv);
> +
>   void __init init_hypervisor_platform(void)
>   {
>   	const struct hypervisor_x86 *h;
>   
> +	if (nopv)
> +		return;
> +

Oh, this is no good idea.

There are guest types which just won't work without pv interfaces, like
Xen PV and Xen PVH. Letting them fail due to just a wrong command line
parameter is not nice, especially as the failure might be very hard to
track down to the issue for the user.

I guess you could add a "ignore_nopv" member to struct hypervisor_x86
set to true for the mentioned guest types and call the detect functions
only if nopv is false or ignore_nopv is true.


Juergen
