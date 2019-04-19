Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531C7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FDC20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfDSTCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:02:00 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16086 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfDSTB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:59 -0400
X-IronPort-AV: E=Sophos;i="5.60,369,1549954800"; 
   d="scan'208";a="30262762"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Apr 2019 04:40:02 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Fri, 19 Apr 2019
 04:40:01 -0700
Date:   Fri, 19 Apr 2019 13:39:37 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>, <arm@kernel.org>,
        "Olof Johansson" <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/3] ARM: at91: move platform-specific asm-offset.h to
 arch/arm/mach-at91
Message-ID: <20190419113937.jtkdqcud7lozoqpo@M43218.corp.atmel.com>
Mail-Followup-To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>, arm@kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
 <20190408075427.6052-2-yamada.masahiro@socionext.com>
 <20190415151450.GG3578@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190415151450.GG3578@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:14:50PM +0200, Alexandre Belloni wrote:
> External E-Mail
> 
> 
> On 08/04/2019 16:54:26+0900, Masahiro Yamada wrote:
> > <generated/at91_pm_data-offsets.h> is only generated and included
> > by arch/arm/mach-at91/, so it does not need to reside in the
> > globally visible include/generated/.
> > 
> > I moved and renamed it to arch/arm/mach-at91/pm_data-offsets.h
> > since the prefix 'at91_' is just redundant in mach-at91/.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 

Applied in at91-soc. Let me know if it's an issue, I plan to do the PR
soon.

Regards

Ludovic

> > ---
> > 
> > Can this be applied to ARM-SOC tree in a series?
> > (with Ack from the platform sub-maintainer.)
> > 
> > at91_pm_data-offsets.h header does not need to reside in
> > include/generated/, but you may ask
> > "Why must it get out of include/generated/?"
> > 
> > My main motivation is to avoid a race condition in the currently
> > proposed patch:
> > 
> > https://lore.kernel.org/patchwork/patch/1052763/
> > 
> > This patch tries to embed some build artifacts into the kernel.
> > 
> > If arch/arm/mach-at91/ and kernel/ are built at the same time,
> > it may embed a truncated file.
> > 
> > 
> >  arch/arm/mach-at91/.gitignore   | 1 +
> >  arch/arm/mach-at91/Makefile     | 5 +++--
> >  arch/arm/mach-at91/pm_suspend.S | 2 +-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/arm/mach-at91/.gitignore
> > 
> > diff --git a/arch/arm/mach-at91/.gitignore b/arch/arm/mach-at91/.gitignore
> > new file mode 100644
> > index 000000000000..2ecd6f51c8a9
> > --- /dev/null
> > +++ b/arch/arm/mach-at91/.gitignore
> > @@ -0,0 +1 @@
> > +pm_data-offsets.h
> > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> > index 31b61f0e1c07..de64301dcff2 100644
> > --- a/arch/arm/mach-at91/Makefile
> > +++ b/arch/arm/mach-at91/Makefile
> > @@ -19,9 +19,10 @@ ifeq ($(CONFIG_PM_DEBUG),y)
> >  CFLAGS_pm.o += -DDEBUG
> >  endif
> >  
> > -include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
> > +$(obj)/pm_data-offsets.h: $(obj)/pm_data-offsets.s FORCE
> >  	$(call filechk,offsets,__PM_DATA_OFFSETS_H__)
> >  
> > -arch/arm/mach-at91/pm_suspend.o: include/generated/at91_pm_data-offsets.h
> > +$(obj)/pm_suspend.o: $(obj)/pm_data-offsets.h
> >  
> >  targets += pm_data-offsets.s
> > +clean-files += pm_data-offsets.h
> > diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
> > index bfe1c4d06901..a31c1b20f3fa 100644
> > --- a/arch/arm/mach-at91/pm_suspend.S
> > +++ b/arch/arm/mach-at91/pm_suspend.S
> > @@ -14,7 +14,7 @@
> >  #include <linux/linkage.h>
> >  #include <linux/clk/at91_pmc.h>
> >  #include "pm.h"
> > -#include "generated/at91_pm_data-offsets.h"
> > +#include "pm_data-offsets.h"
> >  
> >  #define	SRAMC_SELF_FRESH_ACTIVE		0x01
> >  #define	SRAMC_SELF_FRESH_EXIT		0x00
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
