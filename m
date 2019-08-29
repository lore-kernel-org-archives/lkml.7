Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F126C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9520644
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfH2OvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:51:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39955 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbfH2OvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:13 -0400
X-UUID: 0bedaa378d5e453b839c8786147ec9bf-20190829
X-UUID: 0bedaa378d5e453b839c8786147ec9bf-20190829
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 715400291; Thu, 29 Aug 2019 22:51:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:06 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5, 00/32] add drm support for MT8183
Date:   Thu, 29 Aug 2019 22:50:22 +0800
Message-ID: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This series are based on 5.3-rc1 and provid 32 patch
to support mediatek SOC MT8183

Change since v4
- fix reviewed issue in v4

Change since v3
- fix reviewed issue in v3
- fix type error in v3
- fix conflict with iommu patch

Change since v2
- fix reviewed issue in v2
- add mutex node into dts file

Changes since v1:
- fix reviewed issue in v1
- add dts for mt8183 display nodes
- adjust display clock control flow in patch 22
- add vmap support for mediatek drm in patch 23
- fix page offset issue for mmap function in patch 24
- enable allow_fb_modifiers for mediatek drm in patch 25

Yongqiang Niu (32):
  dt-bindings: mediatek: add binding for mt8183 display
  dt-bindings: mediatek: add ovl_2l description for mt8183 display
  dt-bindings: mediatek: add ccorr description for mt8183 display
  dt-bindings: mediatek: add dither description for mt8183 display
  dt-bindings: mediatek: add mutex description for mt8183 display
  arm64: dts: add display nodes for mt8183
  drm/mediatek: add mutex mod into ddp private data
  drm/mediatek: add mutex mod register offset into ddp private data
  drm/mediatek: add mutex sof into ddp private data
  drm/mediatek: add mutex sof register offset into ddp private data
  drm/mediatek: split DISP_REG_CONFIG_DSI_SEL setting into another use
    case
  drm/mediatek: add mmsys private data for ddp path config
  drm/mediatek: move rdma sout from mtk_ddp_mout_en into
    mtk_ddp_sout_sel
  drm/mediatek: add ddp component CCORR
  drm/mediatek: add commponent OVL_2L0
  drm/mediatek: add component OVL_2L1
  drm/mediatek: add component DITHER
  drm/mediatek: add gmc_bits for ovl private data
  drm/medaitek: add layer_nr for ovl private data
  drm/mediatek: add function to background color input select for
    ovl/ovl_2l direct link
  drm/mediatek: add background color input select function for
    ovl/ovl_2l
  drm/mediatek: add ovl0/ovl_2l0 usecase
  drm/mediatek: distinguish ovl and ovl_2l by layer_nr
  drm/mediatek: add clock property check before get it
  drm/mediatek: add connection from OVL0 to OVL_2L0
  drm/mediatek: add connection from RDMA0 to COLOR0
  drm/mediatek: add connection from RDMA1 to DSI0
  drm/mediatek: add connection from OVL_2L0 to RDMA0
  drm/mediatek: add connection from OVL_2L1 to RDMA1
  drm/mediatek: add connection from DITHER0 to DSI0
  drm/mediatek: add connection from RDMA0 to DSI0
  drm/mediatek: add support for mediatek SOC MT8183

 .../bindings/display/mediatek/mediatek,disp.txt    |  30 +-
 .../bindings/display/mediatek/mediatek,display.txt |  21 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 111 ++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  79 +++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  27 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  42 ++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 410 ++++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  67 ++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  21 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  50 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   3 +
 12 files changed, 745 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt

-- 
1.8.1.1.dirty

