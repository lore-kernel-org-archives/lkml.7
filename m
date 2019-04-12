Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2439C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82C820869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDLB6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:58:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27558 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbfDLB6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:58:19 -0400
X-UUID: 37c69f99e45a4ddeb989bc5b338849a1-20190412
X-UUID: 37c69f99e45a4ddeb989bc5b338849a1-20190412
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 262702972; Fri, 12 Apr 2019 09:58:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 12 Apr 2019 09:58:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Apr 2019 09:58:12 +0800
Message-ID: <1555034293.349.6.camel@mtkswgap22>
Subject: Re: [PATCH] pinctrl: Add kernel config PINCTRL_MTK_V2
From:   Light Hsieh <light.hsieh@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 12 Apr 2019 09:58:13 +0800
In-Reply-To: <CAGp9LzpExWGCHtiggQmPtCwBD6o4JUmGSGfm7VostCq+EK2egw@mail.gmail.com>
References: <1554975138-801-1-git-send-email-light.hsieh@mediatek.com>
         <CAGp9LzpExWGCHtiggQmPtCwBD6o4JUmGSGfm7VostCq+EK2egw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear reviewer,

The points of  Sean are right. Please forget this patch proposal.


On Thu, 2019-04-11 at 15:04 -0700, Sean Wang wrote:
> Hi, Light
> 
> On Thu, Apr 11, 2019 at 2:32 AM Light Hsieh <light.hsieh@mediatek.com> wrote:
> >
> > Since no single Mediatek chip use code for PINCTRL_MTK and code for
> > PINCTRL_MTK_MOORE/PINCTRL_MTK_PARIS simultaneously, it is better to use
> > different config to determine if related code will be built or not on
> > building non-generic kernel.
> >
> > Add kernel config PINCTRL_MTK_V2 selected by either PINCTRL_MTK_MOORE
> > or PINCTRL_MTK_PARIS.
> > Use PINCTRL_MTK and PINCTRL_MTK_V2 to control building of
> > drivers/pinctrl/medaitek/.
> > Remove selection of EINT_MTK from PINCTRL_MTK since code for EINT_MTK is
> > only related to PINCTRL_MTK_MOORE/PINCTRL_MTK_PARIS, i.e. PINCTL_MTK_V2.
> >
> 
> PINCTRL_MTK also depends on EINT_MTK such as the symbol
> mtk_eint_do_init, it is a commonlibrary for the two kinds of the
> pinctrl core.
> 

Yes, you are right. 
It is my fault that I don't see some mtk_eint_* functions originally in
pinctrl-mtk-common.c had been moved to mtk-eint.c since kernel-4.18 and
now pinctrl-mtk-common.c depends on mtk-eint.c.

> > ---
> >  drivers/pinctrl/Makefile         |  3 ++-
> >  drivers/pinctrl/mediatek/Kconfig | 15 ++++++++++++---
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> > index 712184b..fcee0e0 100644
> > --- a/drivers/pinctrl/Makefile
> > +++ b/drivers/pinctrl/Makefile
> > @@ -65,6 +65,7 @@ obj-$(CONFIG_PINCTRL_SUNXI)   += sunxi/
> >  obj-y                          += ti/
> >  obj-$(CONFIG_PINCTRL_UNIPHIER) += uniphier/
> >  obj-$(CONFIG_ARCH_VT8500)      += vt8500/
> > -obj-y                          += mediatek/
> > +obj-$(CONFIG_PINCTRL_MTK)      += mediatek/
> > +obj-$(CONFIG_PINCTRL_MTK_V2)   += mediatek/
> 
> I would think it is good if deciding V1 or not should be done inside
> the vendor directory and the change also would cause COMPILE_TEST not
> be applied to

Agree.

> >  obj-$(CONFIG_PINCTRL_ZX)       += zte/
> >  obj-y                          += cirrus/
> > diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> > index a005cbc..5e26462 100644
> > --- a/drivers/pinctrl/mediatek/Kconfig
> > +++ b/drivers/pinctrl/mediatek/Kconfig
> > @@ -2,10 +2,15 @@ menu "MediaTek pinctrl drivers"
> >         depends on ARCH_MEDIATEK || COMPILE_TEST
> >
> >  config EINT_MTK
> > -       bool "MediaTek External Interrupt Support"
> > -       depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
> > +       bool "MediaTek External Interrupt driver that is based on PINCTRL_MTK_V2"
> > +       depends on PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
> >         select GPIOLIB
> >         select IRQ_DOMAIN
> > +       help
> > +         Say yes here to enable support for MediaTek External Interrupt
> > +         (EINT) driver based on PINCTRL_MTK version 2.
> > +         This driver is combined with MediaTek Pinctrl driver version 2
> > +         so PINCTRL_MTK_V2 shall be set first.
> >
> >  config PINCTRL_MTK
> >         bool
> > @@ -13,9 +18,11 @@ config PINCTRL_MTK
> >         select PINMUX
> >         select GENERIC_PINCONF
> >         select GPIOLIB
> > -       select EINT_MTK
> >         select OF_GPIO
> >
> > +config PINCTRL_MTK_V2
> > +       bool "MediaTek Pinctrl Support V2"
> > +
> >  config PINCTRL_MTK_MOORE
> >         bool
> >         depends on OF
> > @@ -24,6 +31,7 @@ config PINCTRL_MTK_MOORE
> >         select GENERIC_PINMUX_FUNCTIONS
> >         select GPIOLIB
> >         select OF_GPIO
> > +       select PINCTRL_MTK_V2
> >
> >  config PINCTRL_MTK_PARIS
> >         bool
> > @@ -33,6 +41,7 @@ config PINCTRL_MTK_PARIS
> >         select GPIOLIB
> >         select EINT_MTK
> >         select OF_GPIO
> > +       select PINCTRL_MTK_V2
> >
> >  # For ARMv7 SoCs
> >  config PINCTRL_MT2701
> > --
> > 1.8.1.1.dirty
> >


