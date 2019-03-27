Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD9B204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713550;
	bh=T70lNnotiabU0xgmaR9v6Nw/LXyGkWLVN9PmIFObsso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sadLLgCjFmu2j9CKKl1Shg2oS+oiEuBj/IopIGEu4VHukaXL3COuKe9o6vOoquJO+
	 jxdJGYTZhHxYBkKskCqkPeSBofLmLFHrCFcXerhmsDgdiY6MOlv2GWpiakOoxBZ2kp
	 2Fjyd43WHgwWoXpQ62tzAqCFZ+TlbOi5Zpnqk4mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfC0SMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389223AbfC0SMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A7D21738;
        Wed, 27 Mar 2019 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710354;
        bh=T70lNnotiabU0xgmaR9v6Nw/LXyGkWLVN9PmIFObsso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a2QEyXfnhC2TpbN1dSK11fAEiLB3lvFTn0KDQBASNOj4oyKMZKwt3DMGJ1Kk9sD3J
         8YWFtmKluysLhxzuZ0Zlej0WfQuKKto9b1+4O+Uc9yN8gpdIQm9Yq9MqTJtXvbpt/a
         cZOBJ9KswNSnSBYUjGouWRE7AssD+YXG8sb5RWFo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 076/192] s390/ism: ignore some errors during deregistration
Date:   Wed, 27 Mar 2019 14:08:28 -0400
Message-Id: <20190327181025.13507-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Ott <sebott@linux.ibm.com>

[ Upstream commit 0ff06c44efeede4acd068847d3bf8cf894b6c664 ]

Prior to dma unmap/free operations the ism driver tries to ensure
that the memory is no longer accessed by the HW. When errors
during deregistration of memory regions from the HW occur the ism
driver will not unmap/free this memory.

When we receive notification from the hypervisor that a PCI function
has been detached we can no longer access the device and would never
unmap/free these memory regions which led to complaints by the DMA
debug API.

Treat this kind of errors during the deregistration of memory regions
from the HW as success since it is already ensured that the memory
is no longer accessed by HW.

Reported-by: Karsten Graul <kgraul@linux.ibm.com>
Reported-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 8684bcec8ff4..00cc96341411 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -141,10 +141,13 @@ static int register_ieq(struct ism_dev *ism)
 
 static int unregister_sba(struct ism_dev *ism)
 {
+	int ret;
+
 	if (!ism->sba)
 		return 0;
 
-	if (ism_cmd_simple(ism, ISM_UNREG_SBA))
+	ret = ism_cmd_simple(ism, ISM_UNREG_SBA);
+	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
@@ -158,10 +161,13 @@ static int unregister_sba(struct ism_dev *ism)
 
 static int unregister_ieq(struct ism_dev *ism)
 {
+	int ret;
+
 	if (!ism->ieq)
 		return 0;
 
-	if (ism_cmd_simple(ism, ISM_UNREG_IEQ))
+	ret = ism_cmd_simple(ism, ISM_UNREG_IEQ);
+	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
@@ -288,7 +294,7 @@ static int ism_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	cmd.request.dmb_tok = dmb->dmb_tok;
 
 	ret = ism_cmd(ism, &cmd);
-	if (ret)
+	if (ret && ret != ISM_ERROR)
 		goto out;
 
 	ism_free_dmb(ism, dmb);
-- 
2.19.1

