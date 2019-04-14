Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1381CC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A035A2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vNe42JRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDNR0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:26:22 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33454 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BoixTUrM58QhLIGqkkXnVCGjoXLsor6OntDo/Wl+gm4=; b=vNe42JRtLO1YFBSYGHK0ebk+x
        oy5n/gvVrKwK9TT0tcgtVdHLwCfvODQJvqz6WP/wgsCVRGK3poUeFHFttTKBg7u9tspUWu62XF8YL
        5GJ7gooUeOafR8mjHB90KN+stzl8rEgD+LQC25qgt+RuVunR9FMbgY56RajfNezBuYrH1sjMKwOW6
        jd+Rt/OOdQKDUFOAe2afHHd12/8ukYUD54VBLRhznyvC5pgHpcHXPpJ4S5/e1Sq8L1hr1qaTT24SY
        CYn9Xv/4kjVkuJIwuScklgBRTgZpLJjVIClQCd4JOQ5CosIc1ui8hh/LGzTCmLb57pZEGo5W6AU8e
        S9sxwy4+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52108)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hFitO-00005m-W6; Sun, 14 Apr 2019 18:26:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hFitH-0006nT-1g; Sun, 14 Apr 2019 18:26:03 +0100
Date:   Sun, 14 Apr 2019 18:26:02 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 RFC] ARM: mvebu: at least warn on kzalloc failure
Message-ID: <20190414172602.z6d4swzk6bjjumls@shell.armlinux.org.uk>
References: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 06:49:49AM +0200, Nicholas Mc Guire wrote:
> Although it is very unlikely that the allocation during init would
> fail any such failure should point to the original cause rather
> than waiting for a null-pointer dereference to splat.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Problem located with experimental coccinelle script
> 
> While this will not really help much - but kzalloc failures should not
> go unhandled. 

Sorry, no, not like this.

With this patch, rather than getting an oops and a stacktrace which
people can capture and email, we instead end up getting a warning
line, a stack trace, followed by an oops containing another stack
trace.

We _already_ have problems getting people to send us kernel message
debug information without editing out what they deem to be "unnecessary
verbage", like all those numbers and function names that comprise a
stack trace.  We don't need yet more of that stuff, especially when it
is redundant.

So, I think throwing WARN_ON() at this case is way too excessive, and
will only have a detrimental effect on the reports we receive - and
that is extremely important.

IMHO, A better solution would be to just print a warning, rather than
causing the kernel to print several kB of needless messages.

	if (!new_compat)
		pr_err("new_compat allocation failure in %s()\n",
		       __func__);

> 
> Patch was compile-tested: mvebu_v7_defconfig (implies MACH_MVEBU_ANY=y)
> (with some unrelated sparse warnings about missing syscalls)
> 
> Patch is against 5.1-rc4 (localversion-next is 20190412)
> 
>  arch/arm/mach-mvebu/board-v7.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 0b10acd..37f8cb6 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -128,6 +128,7 @@ static void __init i2c_quirk(void)
>  		struct property *new_compat;
>  
>  		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
> +		WARN_ON(!new_compat);
>  
>  		new_compat->name = kstrdup("compatible", GFP_KERNEL);
>  		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
> -- 
> 2.1.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
