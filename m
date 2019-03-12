Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC9AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D072206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 23:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="qLC/QcmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="60pYjIon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCLXyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 19:54:33 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53561 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfCLXyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 19:54:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 88558228FA;
        Tue, 12 Mar 2019 19:54:31 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 12 Mar 2019 19:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:in-reply-to:references:date:from:to:cc:subject
        :content-type; s=fm2; bh=ZLdYJ59TEy60Z1sd2pKkiHH2eFd04bPLAA+LnR5
        TkVc=; b=qLC/QcmLddDtBDYrWEG4OGzQTafY2nZMhZbHBk2OXSrylnoaPqoJk8f
        H3m4Mj5CfZMAJl+FV53mSTzQjaU4qA5wSY7EMLhSMHfwue5U4Sg2xDPM8L/TaTdc
        wfU64GTybNwAagx5VWYxqwD3Cz8Qpwv12X7zLiUq/l+J1VkfZoNqJXS9VlEcnlOr
        aiiCo33bn+QmPFMvh3WsaGeeMcuqZOhCCjKlFX4de2DL2UUS/hyWBHzcNeI3XAnD
        IScEZOJqpRjWKkhzuK6fcG6iMcuFEkQxv4iLr4UU8VxBv3YILD3enb/wld9Fah7g
        /VgQKcHMx/6a2qRFrm20Nfpz8OoTnsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:references:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZLdYJ59TEy60Z1sd2
        pKkiHH2eFd04bPLAA+LnR5TkVc=; b=60pYjIona/YDv6z3xJTlfQ838tDicA8i1
        yP56AndqJKhNmA7xERmLtvNOzVDYzGpuYVxJgqIEhriW1LTSYyBNO1JoCzCa+o5b
        y0IiGMZGuzZxlbZjZOD6EZY4QYjHAwZZnyDMwO6XWIjNarLYNoTd8oSlfIUpdz+C
        TM/dIiExGTAjoLRNE/eMOf0Tu4GqwxJMIMm/4ppmZ7VNiZdhWVbdycCTZOr3O0K0
        xSc/A8+KwMlgs3JSAn8TaTgMQMLrjtYm24p+uKIY2ASx4Vx6CI+GjCwXsFOxI0o+
        fH7bs/RoYS2z0DFrlX3AofaoHXnX2BYoDY5XXUwAGlLx190Nd6Cvg==
X-ME-Sender: <xms:tkaIXEFv1g1y9-XeWftFHqKzSDTYR99o-KXNt7lWAv9vGInOcczZJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfkfgjfhffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedftehnughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfies
    rghjrdhiugdrrghuqeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjh
    drihgurdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:tkaIXKgbZpBqSpehNs-t1xz8gnhkE6GNuSFJU1dT-HZ0ZXzw-URhOA>
    <xmx:tkaIXCov6l7uaBoXqM-dxgjP84pJJHAG06eMhgDscL-fS2ljXwO_Jg>
    <xmx:tkaIXCTYlsyoPhBRtNryYMGdlZp9LY0SkMPLdBZJZUE73oG96arSww>
    <xmx:t0aIXBMDhct4TjZy6mHyI6sKYUm2LIgyCoYaH0QKC1YVpDrgFMPzBw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1AB97C1EB; Tue, 12 Mar 2019 19:54:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.5-925-g644bf8c-fmstable-20190228v5
X-Me-Personality: 52947553
Message-Id: <cc4d6c18-6c94-4f0b-8c6c-139496fa49aa@www.fastmail.com>
In-Reply-To: <1552312598-25574-1-git-send-email-info@metux.net>
References: <1552312598-25574-1-git-send-email-info@metux.net>
Date:   Tue, 12 Mar 2019 19:54:28 -0400
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        kaloz@openwrt.org, khalasa@piap.pl, lkundrak@v3.sk,
        aaro.koskinen@iki.fi, tony@atomide.com, baohua@kernel.org,
        kgene@kernel.org, krzk@kernel.org, linux@prisktech.co.nz,
        mcuos.com@gmail.com, matthias.bgg@gmail.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Mar 2019, at 00:26, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/arm/Kconfig              | 24 +++++++++++-----------
>  arch/arm/mach-aspeed/Kconfig  | 10 ++++-----
>  arch/arm/mach-ep93xx/Kconfig  |  8 ++++----
>  arch/arm/mach-hisi/Kconfig    | 14 ++++++-------
>  arch/arm/mach-ixp4xx/Kconfig  | 32 ++++++++++++++---------------
>  arch/arm/mach-mmp/Kconfig     |  2 +-
>  arch/arm/mach-omap1/Kconfig   | 36 ++++++++++++++++----------------
>  arch/arm/mach-omap2/Kconfig   | 12 +++++------
>  arch/arm/mach-prima2/Kconfig  |  6 +++---
>  arch/arm/mach-s3c24xx/Kconfig | 32 ++++++++++++++---------------
>  arch/arm/mach-s3c64xx/Kconfig | 16 +++++++--------
>  arch/arm/mach-sa1100/Kconfig  |  4 ++--
>  arch/arm/mach-vt8500/Kconfig  |  6 +++---
>  arch/arm/mach-w90x900/Kconfig |  6 +++---
>  arch/arm/mm/Kconfig           | 48 +++++++++++++++++++++----------------------
>  arch/arm/plat-samsung/Kconfig | 26 +++++++++++------------
>  16 files changed, 140 insertions(+), 142 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5085a1e..c89f683 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1115,14 +1115,14 @@ config ARM_ERRATA_764369
>  	  in the diagnostic control register of the SCU.
>  
>  config ARM_ERRATA_775420
> -       bool "ARM errata: A data cache maintenance operation which 
> aborts, might lead to deadlock"
> -       depends on CPU_V7
> -       help
> -	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> -	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> -	 operation aborts with MMU exception, it might cause the processor
> -	 to deadlock. This workaround puts DSB before executing ISB if
> -	 an abort may occur on cache maintenance.
> +	bool "ARM errata: A data cache maintenance operation which aborts, 
> might lead to deadlock"
> +	depends on CPU_V7
> +	help
> +	  This option enables the workaround for the 775420 Cortex-A9 (r2p2,
> +	  r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
> +	  operation aborts with MMU exception, it might cause the processor
> +	  to deadlock. This workaround puts DSB before executing ISB if
> +	  an abort may occur on cache maintenance.
>  
>  config ARM_ERRATA_798181
>  	bool "ARM errata: TLBI/DSB failure on Cortex-A15"
> @@ -1650,12 +1650,12 @@ config HW_PERF_EVENTS
>  	depends on ARM_PMU
>  
>  config SYS_SUPPORTS_HUGETLBFS
> -       def_bool y
> -       depends on ARM_LPAE
> +	def_bool y
> +	depends on ARM_LPAE
>  
>  config HAVE_ARCH_TRANSPARENT_HUGEPAGE
> -       def_bool y
> -       depends on ARM_LPAE
> +	def_bool y
> +	depends on ARM_LPAE
>  
>  config ARCH_WANT_GENERAL_HUGETLB
>  	def_bool y
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index 2d5570e..f6eaf05 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -18,9 +18,9 @@ config MACH_ASPEED_G4
>  	select CPU_ARM926T
>  	select PINCTRL_ASPEED_G4
>  	help
> -	 Say yes if you intend to run on an Aspeed ast2400 or similar
> -	 fourth generation BMCs, such as those used by OpenPower Power8
> -	 systems.
> +	  Say yes if you intend to run on an Aspeed ast2400 or similar
> +	  fourth generation BMCs, such as those used by OpenPower Power8
> +	  systems.
>  
>  config MACH_ASPEED_G5
>  	bool "Aspeed SoC 5th Generation"
> @@ -28,7 +28,7 @@ config MACH_ASPEED_G5
>  	select CPU_V6
>  	select PINCTRL_ASPEED_G5
>  	help
> -	 Say yes if you intend to run on an Aspeed ast2500 or similar
> -	 fifth generation Aspeed BMCs.
> +	  Say yes if you intend to run on an Aspeed ast2500 or similar
> +	  fifth generation Aspeed BMCs.

For the ASPEED bits:

Acked-by: Andrew Jeffery <andrew@aj.id.au>
