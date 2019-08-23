Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD5FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D1C2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 19:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391812AbfHWTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 15:50:33 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39107 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfHWTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:50:33 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 17EB91BF205;
        Fri, 23 Aug 2019 19:50:30 +0000 (UTC)
Date:   Fri, 23 Aug 2019 21:50:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: at91: move platform-specific asm-offset.h to
 arch/arm/mach-at91
Message-ID: <20190823195030.GD30479@piout.net>
References: <20190823024346.591-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823024346.591-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2019 11:43:45+0900, Masahiro Yamada wrote:
> <generated/at91_pm_data-offsets.h> is only generated and included by
> arch/arm/mach-at91/, so it does not need to reside in the globally
> visible include/generated/.
> 
> I renamed it to arch/arm/mach-at91/pm_data-offsets.h since the prefix
> 'at91_' is just redundant in mach-at91/.
> 
> My main motivation of this change is to avoid the race condition for
> the parallel build (-j) when CONFIG_IKHEADERS is enabled.
> 
> When it is enabled, all the headers under include/ are archived into
> kernel/kheaders_data.tar.xz and exposed in the sysfs.
> 
> In the parallel build, we have no idea in which order files are built.
> 
>  - If at91_pm_data-offsets.h is built before kheaders_data.tar.xz,
>    the header will be included in the archive. Probably nobody will
>    use it, but it is harmless except that it will increase the archive
>    size needlessly.
> 
>  - If kheaders_data.tar.xz is built before at91_pm_data-offsets.h,
>    the header will not be included in the archive. However, in the next
>    build, the archive will be re-generated to include the newly-found
>    at91_pm_data-offsets.h. This is not nice from the build system point
>    of view.
> 
>  - If at91_pm_data-offsets.h and kheaders_data.tar.xz are built at the
>    same time, the corrupted header might be included in the archive,
>    which does not look nice either.
> 
> This commit fixes the race.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm/mach-at91/.gitignore   | 1 +
>  arch/arm/mach-at91/Makefile     | 5 +++--
>  arch/arm/mach-at91/pm_suspend.S | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-at91/.gitignore
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
