Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CFC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5E620854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfJNGif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:38:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15746 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbfJNGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:38:35 -0400
X-UUID: 3c212a6db640499e8e73f90b78eabc5a-20191014
X-UUID: 3c212a6db640499e8e73f90b78eabc5a-20191014
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 89117099; Mon, 14 Oct 2019 14:38:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 14:38:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 14:38:26 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <edison.hsieh@mediatek.com>
Subject: [PATCH v3 0/7] Improve tlb range flush
Date:   Mon, 14 Oct 2019 14:38:14 +0800
Message-ID: <1571035101-4213-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset mainly fixes a tlb flush timeout issue and use the new
iommu_gather to re-implement the tlb flush flow. and several clean up
patches about the tlb_flush.

change note:
v3:
   1. Use the gather to implement the tlb_flush suggested from Tomasz.
   2. add some clean up patches.

v2:
https://lore.kernel.org/linux-iommu/1570627143-29441-1-git-send-email-yong.wu@mediatek.com/T/#t
   1. rebase on v5.4-rc1
   2. only split to several patches.

v1:
https://lore.kernel.org/linux-iommu/CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com/T/#t

Yong Wu (7):
  iommu/mediatek: Correct the flush_iotlb_all callback
  iommu/mediatek: Add pgtlock in the iotlb_sync
  iommu/mediatek: Use gather to achieve the tlb range flush
  iommu/mediatek: Delete the leaf in the tlb flush
  iommu/mediatek: Move the tlb_sync into tlb_flush
  iommu/mediatek: Use writel for TLB range invalidation
  iommu/mediatek: Reduce the tlb flush timeout value

 drivers/iommu/mtk_iommu.c | 77 +++++++++++++++++++++++------------------------
 drivers/iommu/mtk_iommu.h |  2 +-
 2 files changed, 38 insertions(+), 41 deletions(-)

-- 
1.9.1

