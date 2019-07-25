Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A6C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F72238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L2AGmKU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfGYQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:46:21 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37176 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGYQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gbg4j1N6JgeQ3TSdYxXfJ33VmOD+J3jr9Rov8Cr76Q0=; b=L2AGmKU4/hAow0T7f/9azUCpH
        oqKXTbsippZQjAd2mfOoIErqLbiznbgvcAbJVCa2HgFyLTM1P828uHFOtmWoFNXXDeugchDhAFqXt
        znNfTDDc+NF58ZgJE4bzvOUPSti6516F32y1tNrEEJ+aNfjzHvNHSRqkjqw80X4EcLj0pnAUlvslk
        pJEaGVMULpEpmEiYcOWM1sMSYIyfQKcF9EKgnnJVIkfXOG3hgzv4xrXUJAhuzyka7htSmD/N4ig/f
        Ulg+IwSKUMBL6rQDafWkGLEA3K7uenNjKXJ+K5AJpHlSyIXhOTCyzxqRv2DWm8dgIZWjSidrJ9i+2
        09r3NztxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48742)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hqgsi-0001Fr-9K; Thu, 25 Jul 2019 17:46:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hqgsg-0005rk-6X; Thu, 25 Jul 2019 17:46:14 +0100
Date:   Thu, 25 Jul 2019 17:46:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     patches@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: visit mach-* and plat-* directories when cleaning
Message-ID: <20190725164614.GJ1330@shell.armlinux.org.uk>
References: <20190718163523.18842-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718163523.18842-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 01:35:23AM +0900, Masahiro Yamada wrote:
> When you run "make clean" for arm, it never visits mach-* or plat-*
> directories because machine-y and plat-y are just empty.
> 
> When cleaning, all machine, plat directories are accumulated to
> machine-, plat-, respectively. So, let's pass them to core- to
> clean up those directories.

You don't say what actual, real-life issue this patch is solving.
Which files are left behind by a "make clean" ?

From what I can see, this only matters if there are extra files that
are generated (and have set extra-* or clean-*).  Everything else is
cleaned up via the big find command in the top level makefile.

Or is this a "it would be nice if..." patch?

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> KernelVersion: v5.3-rc1
> 
>  arch/arm/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 792f7fa16a24..c3eb0d9a2fdd 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -286,6 +286,10 @@ core-y				+= arch/arm/net/
>  core-y				+= arch/arm/crypto/
>  core-y				+= $(machdirs) $(platdirs)
>  
> +# For cleaning
> +core-				+= $(patsubst %,arch/arm/mach-%/, $(machine-))
> +core-				+= $(patsubst %,arch/arm/plat-%/, $(plat-))
> +
>  drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
>  
>  libs-y				:= arch/arm/lib/ $(libs-y)
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
