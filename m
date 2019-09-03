Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDE0206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfICJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:38:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11874 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728618AbfICJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:38:01 -0400
X-UUID: 0f932c9f62d6477390f393006cbe4443-20190903
X-UUID: 0f932c9f62d6477390f393006cbe4443-20190903
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 175340227; Tue, 03 Sep 2019 17:37:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 17:37:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 17:37:54 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v3 00/14] Clean up "mediatek,larb" after adding device_link
Date:   Tue, 3 Sep 2019 17:37:22 +0800
Message-ID: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU block diagram always like below:

        M4U
         |
    smi-common
         |
  -------------
  |         |  ...
  |         |
larb1     larb2
  |         |
vdec       venc

All the consumer connect with smi-larb, then connect with smi-common.

MediaTek IOMMU don't have its power-domain. When the consumer works,
it should enable the smi-larb's power which also need enable the smi-common's
power firstly.

Thus, Firstly, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

After adding the device_link, then "mediatek,larb" property can be removed.
the iommu consumer don't need call the mtk_smi_larb_get/put to enable
the power and clock of smi-larb and smi-common.

This patchset depends on "MT8183 IOMMU SUPPORT"[1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2019-August/022611.html

Change notes:
v3: 1) rebase on v5.3-rc1 and the latest mt8183 patchset.
    2) Use device_is_bound to check whether the driver is ready from Matthias.    
    3) Add DL_FLAG_STATELESS flag when calling device_link_add and explain the
   reason in the commit message[3/14].
    4) Add a display patch[12/14] into this series. otherwise it may affect
   display HW fastlogo even though it don't happen in mt8183.
   
v2: http://lists.infradead.org/pipermail/linux-mediatek/2019-June/020440.html
   1) rebase on v5.2-rc1.
   2) Move adding device_link between the consumer and smi-larb into
iommu_add_device from Robin.
   3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
   4) Remove the shutdown callback in iommu.   

v1: https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html

Yong Wu (13):
  dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
  iommu/mediatek: Add probe_defer for smi-larb
  iommu/mediatek: Add device_link between the consumer and the larb
    devices
  memory: mtk-smi: Add device-link between smi-larb and smi-common
  media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
  media: mtk-mdp: Get rid of mtk_smi_larb_get/put
  media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
  drm/mediatek: Get rid of mtk_smi_larb_get/put
  memory: mtk-smi: Get rid of mtk_smi_larb_get/put
  iommu/mediatek: Use builtin_platform_driver
  memory: mtk-smi: Use device_is_bound to check if smi-common is ready
  arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
  arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes

Yongqiang Niu (1):
  drm/mediatek: Add pm runtime support for ovl and rdma

 .../bindings/display/mediatek/mediatek,disp.txt    |  9 ----
 .../bindings/media/mediatek-jpeg-decoder.txt       |  4 --
 .../devicetree/bindings/media/mediatek-mdp.txt     |  8 ----
 .../devicetree/bindings/media/mediatek-vcodec.txt  |  4 --
 arch/arm/boot/dts/mt2701.dtsi                      |  1 -
 arch/arm/boot/dts/mt7623.dtsi                      |  1 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 15 ------
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  5 ++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  5 ++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 20 ++++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 31 ++----------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  2 +-
 drivers/iommu/mtk_iommu.c                          | 56 ++++++++++------------
 drivers/iommu/mtk_iommu_v1.c                       | 49 ++++++++++---------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 22 ---------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |  2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      | 38 ---------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h      |  2 -
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 22 ---------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 47 ------------------
 drivers/memory/mtk-smi.c                           | 41 +++++++---------
 include/soc/mediatek/smi.h                         | 20 --------
 25 files changed, 93 insertions(+), 316 deletions(-)

-- 
1.9.1 

