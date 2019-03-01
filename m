Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC54C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537A520851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfCAK6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:58:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfCAK6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:58:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1515AEBD;
        Fri,  1 Mar 2019 02:58:47 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 487723F575;
        Fri,  1 Mar 2019 02:58:45 -0800 (PST)
Date:   Fri, 1 Mar 2019 10:58:42 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: linux-next: manual merge of the arm-soc tree with the arm64 tree
Message-ID: <20190301105842.GA10733@arrakis.emea.arm.com>
References: <20190301091036.3e97bb49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301091036.3e97bb49@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:10:36AM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in:
> 
>   arch/arm64/Kconfig.platforms
> 
> between commit:
> 
>   a29c78234942 ("arm64: Kconfig.platforms: fix warning unmet direct dependencies")
> 
> from the arm64 tree and commits:
> 
>   67b9282387c5 ("arm64: imx8mq: select GPCv2 irqchip driver")
>   84a2ab25b12d ("arm64: imx8mq: select PM support")
> 
> from the arm-soc tree.
[...]
> diff --cc arch/arm64/Kconfig.platforms
> index d4faca775d9c,c5f6a57f16b8..000000000000
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@@ -145,7 -151,11 +151,11 @@@ config ARCH_MVEB
>   config ARCH_MXC
>   	bool "ARMv8 based NXP i.MX SoC family"
>   	select ARM64_ERRATUM_843419
>  -	select ARM64_ERRATUM_845719
>  +	select ARM64_ERRATUM_845719 if COMPAT
> + 	select IMX_GPCV2
> + 	select IMX_GPCV2_PM_DOMAINS
> + 	select PM
> + 	select PM_GENERIC_DOMAINS
>   	help
>   	  This enables support for the ARMv8 based SoCs in the
>   	  NXP i.MX family.

The resolution looks fine, thanks Stephen.

Olof, Arnd, I can drop this commit if you'd rather merge it via the
arm-soc tree (it was related to a CPU erratum and thought I'd pick it
up).

-- 
Catalin
