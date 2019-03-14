Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234C32184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfCNMom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:44:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5530 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727091AbfCNMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:44:41 -0400
X-UUID: d1705e43722d4a0baf257db8f13cd08f-20190314
X-UUID: d1705e43722d4a0baf257db8f13cd08f-20190314
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1753450216; Thu, 14 Mar 2019 20:44:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 20:44:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 20:44:33 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v1 00/18] add drm support for MT8183
Date:   Thu, 14 Mar 2019 20:05:02 +0800
Message-ID: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This series are based on 4.20-rc1 and provide 18 patches to
support mediatek SOC MT8183
Resend first version 

Yongqiang Niu (18):
  drm/mediatek: update dt-bindings for mt8183
  drm/mediatek: add mutex mod and sof into ddp private data
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
  drm/mediatek: add function to connect module with it's previous one
  drm/mediatek: add ddp write register common api
  drm/mediatek: add connect function for ovl
  drm/mediatek: add RDMA1 fifo size into RDMA private data
  drm/mediatek: add function mtk_ddp_comp_get_type
  drm/mediatek: add ovl0/ovl0_2l usecase
  drm/mediatek: add support for mediatek SOC MT8183

 .../bindings/display/mediatek/mediatek,disp.txt    |  11 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  64 ++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  42 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 458 ++++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  11 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 100 +++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  24 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  55 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   4 +
 10 files changed, 688 insertions(+), 104 deletions(-)

-- 
1.8.1.1.dirty

