Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91AFC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A403720821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Se66Dvjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfDQJNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:13:12 -0400
Received: from m50-132.163.com ([123.125.50.132]:44415 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfDQJNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=2SxV/BhUZVREHKWzjf
        qPFkoNwq53MrugvQ4cnZWBR08=; b=Se66DvjpGrci6kcX4GoTapOYDhvK3F2Xh9
        bqtXVxMkezHucvoYFxeYyxK4Ke0zWUa1MYJ8XpEvpQV3t9nSRBC7VrHnq+Iyn7J1
        AMHOUZR4FgIoOCP+MK9dVj4+6VMqYN0i1+5oFxfQIVDSSiV/5X6qnG7h5ed/wD99
        VUiz3F+0A=
Received: from bp.localdomain (unknown [218.106.182.174])
        by smtp2 (Coremail) with SMTP id DNGowADn9RIa7rZcdfJRAA--.23S3;
        Wed, 17 Apr 2019 17:13:01 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: iommu/vt-d: drop mm use count if address is not canonical
Date:   Wed, 17 Apr 2019 17:12:57 +0800
Message-Id: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowADn9RIa7rZcdfJRAA--.23S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4kAF1xJw17JrW7ZFy5Arb_yoWfurcE9a
        48ursrXr90yr13W3WFyFyxZryv9a4j9FyxX348Kas3tFy7XFyfGasaq34DX34fKr4UtrnI
        g3s7Wa1rZry2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUURnQ5UUUUU==
X-Originating-IP: [218.106.182.174]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiVAGZclUMH9evpAAAsk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use count of svm->mm is incremented by mmget_not_zero. However, it
is not dropped when the address is not canonical. This patch fixes the
bug.

Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check if
address is canonical.")

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iommu/intel-svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a4b09a..2630d2e 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto bad_req;
 
 		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
+		if (!is_canonical_address(address)) {
+			mmput(svm->mm);
 			goto bad_req;
+		}
 
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
-- 
2.7.4


