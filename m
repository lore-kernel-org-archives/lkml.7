Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCDFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FCE20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfJ1I2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:28:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3495 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731531AbfJ1I2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:28:31 -0400
X-UUID: 26941fac30af42238146077b5939d355-20191028
X-UUID: 26941fac30af42238146077b5939d355-20191028
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1314836737; Mon, 28 Oct 2019 16:28:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Oct 2019 16:28:23 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 28 Oct 2019 16:28:20 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>,
        Cui Zhang <cui.zhang@mediatek.com>,
        Guangming Cao <guangming.cao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Anan Sun <anan.sun@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH 00/13] MT6779 IOMMU SUPPORT
Date:   Mon, 28 Oct 2019 16:28:07 +0800
Message-ID: <20191028082820.20221-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds mt6779 iommu support and adjusts mtk iommu software architecture mainly.
1. Add mt6779 basic function, such as smi larb port define, registers define and so on.
2. In addition, this patchset will adjust current mtk iommu SW architecture mainly to adapt all the mtk platforms:
   Firstly, mt6779 iommu can support more HW modules, but some modules have special requirements for iova region,
   for example, CCU only can access 0x4000_0000~0x47ff_ffff, VPU only can access 0x7da0_0000~0x7fbf_ffff. Current
   architecture only support one iommu domain(include 0~4GB), all the modules allocate iova from 0~4GB region, so
   it doesn't ensure to allocate expected iova region for special module(CCU and VPU). In order to resolve the problem,
   we will create different iommu domains for special module, and every domain can include iova region which module needs.
   Secondly, all the iommus share one page table for current architecture by "mtk_iommu_get_m4u_data", to make the
   architecture look clearly, we will create a global page table firstly(mtk_iommu_pgtable), and the all the iommus can
   use it. One page table can include 4GB iova space, so multiple iommu domains are created based on the same page table.
   New SW architecture diagram is as below:

                          iommu0   iommu1
                             |        |
                             ----------
                                  |
                         mtk_iommu_pgtable
                                  |
             ------------------------------------------
             |                    |                   |
       mtk_iommu_domain1   mtk_iommu_domain2  mtk_iommu_domain3
             |                    |                   |
        iommu_group1         iommu_group2        iommu_group3
             |                    |                   |
        iommu_domain1        iommu_domain2       iommu_domain3
             |                    |                   |
      iova region1(normal)  iova region2(CCU)   iova region3(VPU)

 This patchset depends on "Improve tlb range flush"[1] and based on v5.4-rc1.
 [1]http://lists.infradead.org/pipermail/linux-mediatek/2019-October/024207.html

 Chao Hao (13):
   dt-bindings: mediatek: Add bindings for MT6779
   iommu/mediatek: Add mt6779 IOMMU basic support
   iommu/mediatek: Add mtk_iommu_pgtable structure
   iommu/mediatek: Remove mtk_iommu_domain_finalise
   iommu/mediatek: Remove pgtable info in mtk_iommu_domain
   iommu/mediatek: Change get the way of m4u_group
   iommu/mediatek: Add smi_larb info about device
   iommu/mediatek: Add mtk_domain_data structure
   iommu/mediatek: Remove the usage of m4u_dom variable
   iommu/mediatek: Remove mtk_iommu_get_m4u_data api
   iommu/mediatek: Add iova reserved function
   iommu/mediatek: Change single domain to multiple domains
   iommu/mediatek: Add multiple mtk_iommu_domain support for mt6779

  .../bindings/iommu/mediatek,iommu.txt         |   2 +
  drivers/iommu/mtk_iommu.c                     | 488 +++++++++++++++---
  drivers/iommu/mtk_iommu.h                     |  50 +-
  include/dt-bindings/memory/mt6779-larb-port.h | 217 ++++++++
  4 files changed, 685 insertions(+), 72 deletions(-)

 --
 2.18.0




