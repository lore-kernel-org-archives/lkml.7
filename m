Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B89C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B7D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfJJK7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:59:20 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14518 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfJJK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:59:19 -0400
X-UUID: dcde47880f39407097ccbc0295c84ea6-20191010
X-UUID: dcde47880f39407097ccbc0295c84ea6-20191010
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 770940995; Thu, 10 Oct 2019 18:59:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Oct
 2019 18:59:05 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Oct 2019 18:59:05 +0800
Message-ID: <1570705147.22261.13.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: mtk-xhci: Set the XHCI_NO_64BIT_SUPPORT quirk
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Changqi Hu <Changqi.Hu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Shik Chen <shik@chromium.org>
Date:   Thu, 10 Oct 2019 18:59:07 +0800
In-Reply-To: <CAAFQd5AU53=BRUrK_i-0dRYueVoSd3Bg3AtvZUMHgFv3hLuNug@mail.gmail.com>
References: <20191010075004.192818-1-tfiga@chromium.org>
         <1570697118.32135.20.camel@mhfsdcap03>
         <CAAFQd5AU53=BRUrK_i-0dRYueVoSd3Bg3AtvZUMHgFv3hLuNug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 22103D692A22632CE9D6326047F5847FE331FD0A1A6C3940FCDD3CC5289A2D152000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 18:00 +0900, Tomasz Figa wrote:
> Hi Chunfeng,
> 
> On Thu, Oct 10, 2019 at 5:45 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > Hi, Tomasz,
> >
> > On Thu, 2019-10-10 at 16:50 +0900, Tomasz Figa wrote:
> > > MediaTek XHCI host controller does not support 64-bit addressing despite
> > > the AC64 bit of HCCPARAMS1 register being set. The platform-specific
> > > glue sets the DMA mask to 32 bits on its own, but it has no effect,
> > > because xhci_gen_setup() overrides it according to hardware
> > > capabilities.
Yes, this is what I want to do, maybe need remove DMA mask setting in
platform-specific.

> > >
> > > Use the XHCI_NO_64BIT_SUPPORT quirk to tell the XHCI core to force
> > > 32-bit DMA mask instead.
> > >
> > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > ---
> > >  drivers/usb/host/xhci-mtk.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > > index b18a6baef204a..4d101d52cc11b 100644
> > > --- a/drivers/usb/host/xhci-mtk.c
> > > +++ b/drivers/usb/host/xhci-mtk.c
> > > @@ -395,6 +395,11 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
> > >       xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> > >       if (mtk->lpm_support)
> > >               xhci->quirks |= XHCI_LPM_SUPPORT;
> > > +     /*
> > > +      * MTK host controller does not support 64-bit addressing, despite
> > > +      * having the AC64 bit of the HCCPARAMS1 register set.
> > > +      */
> > > +     xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
> > Somes SoCs support 64bits in fact, so can't support this quirk, do you
> > encounter any issues without this quirk?
> >
> 
> Thanks for taking a look at this patch.
> 
> Yes, on MT8183 the DMA mask ended up being set to 64 bits, but
> according to the information I received from MediaTek, the controller
> on that SoC only supports 32 bits.
As I know, mt8183 doesn't support memory greater than 4G mode.

> 
> If some SoCs support only 32 bits and some support 64 bits, we may
> either need to use different DT compatible string for them or add a DT
> property and set the quirk based on that. Right now in upstream we
> have:
> 
> 1) "mediatek,mt8173-xhci", used by:
> MT8173
> 
> 2)"mediatek,mtk-xhci", used by:
> MT2712
> MT7622
> MT8183 (not yet upstream, but I suppose it's on the mailing lists)
> 
> Would you be able to check which of the SoCs above report 64 bits but
> support only 32? (and so would need this quirk)
I'm afraid I can't, almost all MTK SoCs supporting xHCI are using this
driver, AC64 should be set rightly according to addressing capability.

 
> 
> Best regards,
> Tomasz
> 
> > >  }
> >
> > >
> > >  /* called during probe() after chip reset completes */
> > > @@ -488,11 +493,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > >               goto disable_clk;
> > >       }
> > >
> > > -     /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> > > -     ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > > -     if (ret)
> > > -             goto disable_clk;
> > > -
> > >       hcd = usb_create_hcd(driver, dev, dev_name(dev));
> > >       if (!hcd) {
> > >               ret = -ENOMEM;
> >
> >


