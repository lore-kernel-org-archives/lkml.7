Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544F3C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA4420873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uu0kpaZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfGTMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:30:50 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36680 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfGTMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jkXExdv2OgUgh2v85Up+9hbscBqdBooc8aMcR8qKW8A=; b=uu0kpaZ8Sts16zKoiPDagXPfc
        3buPdQLyI8khgjSZlmxZkZJ0Qkfn51HxQiKPFeeR6CoxnSf9MlNqOaHlrmB/t+pSi7uVVaPsjq6Ip
        GpfJxRpwBWObaMIj8mD4h5XkjKGFbnCQZW24eB0cnZHXAWKHnpJv50tpY3FvNiLWEiW3FNyVdvzKE
        Q+nvXGqTDGEajX6xecWNM8QqClpVfnH5t3lu6y2fs8IYGz5kJ5LtkWtBwEayfw00xh/ZiB1qDjfdT
        wlwDRqBa35sskhTd0ssSEzjgpJgjUj8cxaUHnk6qsLioTDc/YH9E4DB8LX/fvoy3F1lGJ2mUmaRad
        7yg0dhxRg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:36768)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hooVP-00026T-HN; Sat, 20 Jul 2019 13:30:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hooVL-0001BJ-F1; Sat, 20 Jul 2019 13:30:23 +0100
Date:   Sat, 20 Jul 2019 13:30:23 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "George G. Davis" <george_davis@mentor.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: Fix null die() string for unhandled data and
 prefetch abort cases
Message-ID: <20190720123023.GA1330@shell.armlinux.org.uk>
References: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563589976-19004-1-git-send-email-george_davis@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 10:32:55PM -0400, George G. Davis wrote:
> When an unhandled data or prefetch abort occurs, the die() string
> is empty resulting in backtrace messages similar to the following:
> 
> 	Internal error: : 1 [#1] PREEMPT SMP ARM
> 
> Replace the null string with the name of the abort handler in order
> to provide more meaningful hints as to the cause of the fault.

NAK.

We already print the cause of the abort earlier in the dump, and we've
also added a "cut here" marker to help people include all the necessary
information when reporting a problem.

It's unfortunate that we have the additional colon in the oops dump,
but repeating the information that we've printed on one of the previous
two lines is really not necessary.

> 
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
>  arch/arm/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 0048eadd0681..dddea0a21220 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -557,7 +557,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  		inf->name, fsr, addr);
>  	show_pte(current->mm, addr);
>  
> -	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
> +	arm_notify_die(inf->name, regs, inf->sig, inf->code, (void __user *)addr,
>  		       fsr, 0);
>  }
>  
> @@ -585,7 +585,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
>  	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
>  		inf->name, ifsr, addr);
>  
> -	arm_notify_die("", regs, inf->sig, inf->code, (void __user *)addr,
> +	arm_notify_die(inf->name, regs, inf->sig, inf->code, (void __user *)addr,
>  		       ifsr, 0);
>  }
>  
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
