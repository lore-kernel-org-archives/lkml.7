Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBBCC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF2320850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfDMH6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:58:16 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:33517 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726207AbfDMH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:58:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5533018224D75;
        Sat, 13 Apr 2019 07:58:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: farm08_2a691f63a644d
X-Filterd-Recvd-Size: 2143
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Apr 2019 07:58:11 +0000 (UTC)
Message-ID: <1dd04eada63b51d768d568c9f09e59f6afbe963b.camel@perches.com>
Subject: Re: [PATCH 0/4] ARM: imx legacy: cleanups
From:   Joe Perches <joe@perches.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 Apr 2019 00:58:10 -0700
In-Reply-To: <1555139666-948-1-git-send-email-hofrat@osadl.org>
References: <1555139666-948-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-04-13 at 09:14 +0200, Nicholas Mc Guire wrote:
> While preparing a proposed fix for a missing check on zmalloc a few
> other checkpatch warnings poped up - this little set fixes those
> warnings. There is one remaining checkpatch warning but that looks
> like a false-positive to me:
> 
> ERROR: Use of __initconst requires a separate use of const
> #171: FILE: arch/arm/mach-imx/mach-mx27ads.c:171:
> +mx27ads_nand_board_info __initconst = {
> 
> The false positive seems due to the definition spanning two lines
> anyway looks good to me
> 
> <snip>
> static const struct mxc_nand_platform_data
> mx27ads_nand_board_info __initconst = {
>         .width = 1,
>         .hw_ecc = 1,
> };

Yeah, it's a false positive.

You could use

static const __initconst etc...

if you really wanted to avoid this but feel free
to ignore checkpatch anyway when it's dumb.


