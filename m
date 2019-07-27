Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83503C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 07:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557D22084C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 07:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfG0Hvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 03:51:43 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23368 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbfG0Hvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 03:51:42 -0400
X-UUID: 1bcd27e4c7944f1bab7eb96d63b4cb02-20190727
X-UUID: 1bcd27e4c7944f1bab7eb96d63b4cb02-20190727
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 682007720; Sat, 27 Jul 2019 15:51:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 27 Jul
 2019 15:51:28 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 27 Jul 2019 15:51:28 +0800
Message-ID: <1564213888.22908.4.camel@mhfsdcap03>
Subject: Re: [PATCH v2 00/12] Clean up "mediatek,larb" after adding
 device_link
From:   Yong Wu <yong.wu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <yingjoe.chen@mediatek.com>,
        <anan.sun@mediatek.com>, Robin Murphy <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <joey.pan@mediatek.com>
Date:   Sat, 27 Jul 2019 15:51:28 +0800
In-Reply-To: <1563849109.27558.14.camel@mtksdaap41>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
         <1563849109.27558.14.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: B3B5B4BEFFF99C65728AE2E1DD572EDEE773F4B9A5223F313A27C88854DAF4DC2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 10:31 +0800, CK Hu wrote:
> Hi, Yong:
> 
> I've added log  in mtk_smi_clk_enable() and mtk_smi_clk_disable(), and I
> boot MT8183 with display, the log is
> 
> [    4.020340] mtk-smi-common 14019000.smi: mtk_smi_clk_enable()
> [    4.331371] mtk-smi-common 14019000.smi: mtk_smi_clk_disable()
> [    4.429578] mtk-smi-common 14019000.smi: mtk_smi_clk_enable()
> [    4.719743] mtk-smi-common 14019000.smi: mtk_smi_clk_disable()
> [    5.084770] mtk-smi-common 14019000.smi: mtk_smi_clk_enable()
> [    5.904310] mtk-smi-common 14019000.smi: mtk_smi_clk_disable()
> 
> From the log, the clock is finally turned off, but the display works
> normally. This is because scpsys has turn the clock on,
> 
> 		scpsys: syscon@10006000 {
> 			compatible = "mediatek,mt8183-scpsys", "syscon";
> 			#power-domain-cells = <1>;
> 			reg = <0 0x10006000 0 0x1000>;
> 			clocks = <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
> 				 <&mmsys CLK_MM_SMI_COMMON>,
> 				 <&mmsys CLK_MM_GALS_COMM0>,
> 				 <&mmsys CLK_MM_GALS_COMM1>,
> 			clock-names = "audio","mm-0",
> 				      "mm-1", "mm-2";
> 		}
> 
> I'm worried that for MT8173, scpsys would not turn on subsys clock, this
> series would let display work abnormally, so I think smi common should
> not depend on scpsys to turn on the clock.
> 
> You could simply remove the clock parameter in scpsys device node, and
> you would see the display works abnormally.

Thanks for the report. I have reproduced this issue by removing the smi
clock in scpsys node.

Now the probe sequence is like this:
a) mtk scpsys (genpd) probe
b) smi probe
c) iommu probe
d) display and the other MM probe.

The log above are called from device_link_add and rpm_idle which is
called between iommu-probe and display-probe.

At the beginning, all the clocks are enabled. But after this
mtk_smi_clk_enable and mtk_smi_clk_disable, the display clock will be
turned off. If the fastlogo is displayed before kernel, then the display
HW will work abnormally.

I have no mt8173 evb board now, I remembered that the screen only is
showed in display driver of kernel in mt8173, It may be ok in that case.
But It really is a problem when the fastlogo is showed before kernel.

This clock issue happened before display driver, It looks display driver
can not help this. I will try to fix it in SMI(smi try to help
display(larb0) to pm_runtime_get_sync one time and put later).


> 
> Regards,
> CK
> 
> 
> On Mon, 2019-06-10 at 20:55 +0800, Yong Wu wrote:
> > MediaTek IOMMU block diagram always like below:
> > 
> >         M4U
> >          |
> >     smi-common
> >          |
> >   -------------
> >   |         |  ...
> >   |         |
> > larb1     larb2
> >   |         |
> > vdec       venc
> > 
> > All the consumer connect with smi-larb, then connect with smi-common.
> > 
> > MediaTek IOMMU don't have its power-domain. When the consumer works,
> > it should enable the smi-larb's power which also need enable the smi-common's
> > power firstly.
> > 
> > Thus, Firstly, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> > 
> > After adding the device_link, then "mediatek,larb" property can be removed.
> > the iommu consumer don't need call the mtk_smi_larb_get/put to enable
> > the power and clock of smi-larb and smi-common.
> > 
> > This patchset depends on "MT8183 IOMMU SUPPORT"[1].
> > 
> > [1] https://lists.linuxfoundation.org/pipermail/iommu/2019-June/036552.html
> > 
> > Change notes:
> > v2:
> >    1) rebase on v5.2-rc1.
> >    2) Move adding device_link between the consumer and smi-larb into
> > iommu_add_device from Robin.
> >    3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
> >    4) Remove the shutdown callback in iommu.   
> > 
> > v1: https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html
> > 
> > Yong Wu (12):
> >   dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
> >   iommu/mediatek: Add probe_defer for smi-larb
> >   iommu/mediatek: Add device_link between the consumer and the larb
> >     devices
> >   memory: mtk-smi: Add device-link between smi-larb and smi-common
> >   media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
> >   media: mtk-mdp: Get rid of mtk_smi_larb_get/put
> >   media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
> >   drm/mediatek: Get rid of mtk_smi_larb_get/put
> >   memory: mtk-smi: Get rid of mtk_smi_larb_get/put
> >   iommu/mediatek: Use builtin_platform_driver
> >   arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
> >   arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
> > 
> >  .../bindings/display/mediatek/mediatek,disp.txt    |  9 -----
> >  .../bindings/media/mediatek-jpeg-decoder.txt       |  4 --
> >  .../devicetree/bindings/media/mediatek-mdp.txt     |  8 ----
> >  .../devicetree/bindings/media/mediatek-vcodec.txt  |  4 --
> >  arch/arm/boot/dts/mt2701.dtsi                      |  1 -
> >  arch/arm/boot/dts/mt7623.dtsi                      |  1 -
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 15 -------
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 11 -----
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 26 ------------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  1 -
> >  drivers/iommu/mtk_iommu.c                          | 45 +++++++--------------
> >  drivers/iommu/mtk_iommu_v1.c                       | 39 +++++++-----------
> >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 22 ----------
> >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |  2 -
> >  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      | 38 -----------------
> >  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h      |  2 -
> >  drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |  1 -
> >  .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 21 ----------
> >  drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
> >  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
> >  .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 47 ----------------------
> >  drivers/memory/mtk-smi.c                           | 31 ++++----------
> >  include/soc/mediatek/smi.h                         | 20 ---------
> >  23 files changed, 36 insertions(+), 316 deletions(-)
> > 
> 
> 


