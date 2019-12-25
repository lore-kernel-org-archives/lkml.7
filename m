Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7383C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DC72075B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfLYNag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 08:30:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfLYNag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:30:36 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE21732CC7E7C3A84FA6;
        Wed, 25 Dec 2019 21:30:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Wed, 25 Dec 2019 21:30:23 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>
CC:     <andre.przywara@arm.com>, <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm/arm64: vgic-its: Check hopefully the last DISCARD command error
Date:   Wed, 25 Dec 2019 21:30:14 +0800
Message-ID: <20191225133014.1825-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DISCARD command error occurs if any of the following apply:

 - [ ... (those which we have already handled) ]
 - The EventID for the device is mapped to a collection that
   has not been mapped to an RDbase using MAPC.

Let's take the unmapped collection case into account and report
a DISCARD command error if it really happens.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 17920d1b350a..d53d34a33e35 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -839,9 +839,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 	u32 event_id = its_cmd_get_id(its_cmd);
 	struct its_ite *ite;
 
-
 	ite = find_ite(its, device_id, event_id);
-	if (ite && ite->collection) {
+	if (ite && its_is_collection_mapped(ite->collection)) {
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
-- 
2.19.1


