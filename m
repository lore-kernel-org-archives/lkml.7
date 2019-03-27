Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1270CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8F42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfC0GTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:19:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:19691 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbfC0GTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:19:36 -0400
X-UUID: cbcb8e45ab9c4edf9bb6c7e4b97f26d8-20190327
X-UUID: cbcb8e45ab9c4edf9bb6c7e4b97f26d8-20190327
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1310697454; Wed, 27 Mar 2019 14:19:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:30 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:29 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 00/25] add drm support for MT8183
Date:   Wed, 27 Mar 2019 14:18:56 +0800
Message-ID: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5FC5F967ED3C29AE1785445935188A9FAA9EED26B1137B9E5F5605692EB2845B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This series are based on 5.1-rc1 and provide 25 patches to
support mediatek SOC MT8183

Changes since v1:
- fix reviewed issue in v1
- add dts for mt8183 display nodes
- adjust display clock control flow in patch 22
- add vmap support for mediatek drm in patch 23
- fix page offset issue for mmap function in patch 24
- enable allow_fb_modifiers for mediatek drm in patch 25

Yongqiang Niu (25):
  arm64: dts: add display nodes for mt8183
  dt-bindings: mediatek: add binding for mt8183 display
  drm/mediatek: add mutex mod into ddp private data
  drm/mediatek: add mutex sof into ddp private data
  drm/mediatek: split DISP_REG_CONFIG_DSI_SEL setting into another use
    case
  drm/mediatek: redefine mtk_ddp_sout_sel
  drm/mediatek: move rdma sout from mtk_ddp_mout_en into
    mtk_ddp_sout_sel
  drm/mediatek: add ddp component CCORR
  drm/mediatek: add mmsys private data for ddp path config
  drm/mediatek: add commponent OVL0_2L
  drm/mediatek: add component OVL1_2L
  drm/mediatek: add component DITHER
  drm/mediatek: add gmc_bits for ovl private data
  drm/medaitek: add layer_nr for ovl private data
  drm/mediatek: add function to background color input select for
    ovl/ovl_2l direct link
  drm/mediatek: add ddp write register common api
  drm/mediatek: add background color input select function for
    ovl/ovl_2l
  drm/mediatek: add RDMA fifo size error handle
  drm/mediatek: add function mtk_ddp_comp_get_type
  drm/mediatek: add ovl0/ovl0_2l usecase
  drm/mediatek: add support for mediatek SOC MT8183
  drm/mediatek: adjust ddp clock control flow
  drm/mediatek: add vmap support for mediatek drm
  drm/mediatek: respect page offset for PRIME mmap calls
  drm/mediatek: enable allow_fb_modifiers for mediatek drm

 .../bindings/display/mediatek/mediatek,disp.txt    |  37 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 107 +++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  81 +++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  21 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  68 +++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 444 ++++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  11 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  87 ++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  28 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  61 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   4 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  14 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.h             |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |  15 +-
 14 files changed, 838 insertions(+), 141 deletions(-)

-- 
1.8.1.1.dirty

