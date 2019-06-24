Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B1AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3C9204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfFXNHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:07:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:45774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbfFXNHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:07:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDFDEAEC7;
        Mon, 24 Jun 2019 13:07:46 +0000 (UTC)
Subject: Re: [PATCH 3/6] x86: Add nopv parameter to disable PV extensions
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561294903-6166-3-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <ed451198-9953-7b2d-4963-b60d3015bb5b@suse.com>
Date:   Mon, 24 Jun 2019 15:07:46 +0200
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

You really don't want to use the "xen_" prefix here.


Juergen
