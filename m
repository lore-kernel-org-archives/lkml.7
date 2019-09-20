Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B66FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592112080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="F5uLX2no";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5MFIhya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404697AbfITFx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:53:28 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55385 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390596AbfITFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 01:53:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B096155D;
        Fri, 20 Sep 2019 01:53:26 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Fri, 20 Sep 2019 01:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=sYqoSELWDB8JtRDLGnIHP2w4CWUd69D
        2d/NJIApm9X4=; b=F5uLX2noa80V2YgZkxsR/Ju/5z1IDtVut1FBoQ3K/K2q3mD
        FE6eXLmDmKqMneAD0c04mrhmY4lp00+nxzO6fDYkLKzKgUfKeryBcERc+HbIFQsz
        T+DyyH66+F0qBBALece+nVYTr6G8kwe4v9LpXRca9QQ+guy5hDULbhoz1EqYfAMk
        Lp0IO+LgtNJ74k8ttvSXpu31yYRKy00qqakUSgjvoaI8sDd5K0akorMRsXz4PVGS
        WChHRRqFcroepQWNK/1Bc2IBkvilH3aUBmLiaI2kuyzmUyRJ2UlYevcoOQSAaDi9
        rebW2epsehsCl4/f4wR6hQyj5v5cpvTUWAPb8yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sYqoSE
        LWDB8JtRDLGnIHP2w4CWUd69D2d/NJIApm9X4=; b=X5MFIhyam3OwRQGxeEFfqN
        vbZqP7dsUy3wq0Y2PwKLDdy5Yva5q5pHE5lZOWAUTLh+QnJ+kUk/xDOcjLhdW5gj
        +u67i2DkQ/kP0zmMvE/8GOO0uD4r9hBaITdSLSBAT7obvobxl99ZMwNkfnS8Rbyq
        RkF7Nlt9xw7L6EM709+FUgHeyIoYog/VrwVGjd/1AxRA22JIrxXsbmAdfrd67i/o
        L+tIex7vBBfGGdDq52mkqguAm1sCAjCz6urP72b4vq0QvPdttyuJcazsDjwvune3
        P42qiZK68dFQwy7WS80Nv8qleKFNQw6LWOEoY9r104qIsVgxMI65KbOoPC3oLNvA
        ==
X-ME-Sender: <xms:VWmEXQnLmTqB_ZYGyZLv6wMBigE-jyluAPiu9gh8CJSwdmVLHyeUAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:VWmEXddD0WcvobIQxoECsJpegeP3Mx3I0K1CUx3Bd_9afJ_Ghprpgg>
    <xmx:VWmEXWCeeQLUHUt88jH6xISWu-YyomLDowuhLtkmvtZtUDHpzMEy_w>
    <xmx:VWmEXUx7umQBGJFWRPFYV9eZAcgRofrJwONCOvswIf4lAfz_7jd1gw>
    <xmx:VmmEXedHSKeRbg6evgvXPcH7JKpCfkj_PGivqKOqAJFNlJBEDFygZQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1AF35E00A9; Fri, 20 Sep 2019 01:53:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-238-g170a812-fmstable-20190913v1
Mime-Version: 1.0
Message-Id: <a26c90b8-8f85-4fe5-9dab-d7213f181efd@www.fastmail.com>
In-Reply-To: <20190919142654.1578823-1-arnd@arndb.de>
References: <20190919142654.1578823-1-arnd@arndb.de>
Date:   Fri, 20 Sep 2019 15:24:01 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Arnd Bergmann" <arnd@arndb.de>, "Joel Stanley" <joel@jms.id.au>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: aspeed: ast2500 is ARMv6K
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Sep 2019, at 23:56, Arnd Bergmann wrote:
> Linux supports both the original ARMv6 level (early ARM1136) and ARMv6K
> (later ARM1136, ARM1176 and ARM11mpcore).
> 
> ast2500 falls into the second categoy, being based on arm1176jzf-s.
> This is enabled by default when using ARCH_MULTI_V6, so we should
> not 'select CPU_V6'.
> 
> Removing this will lead to more efficient use of atomic instructions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-aspeed/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> index a293137f5814..163931a03136 100644
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -26,7 +26,6 @@ config MACH_ASPEED_G4
>  config MACH_ASPEED_G5
>  	bool "Aspeed SoC 5th Generation"
>  	depends on ARCH_MULTI_V6
> -	select CPU_V6
>  	select PINCTRL_ASPEED_G5 if !CC_IS_CLANG

Unrelated, but I'm intrigued by this. Looks like I should try compile it with clang
and fix the fallout.

Andrew
