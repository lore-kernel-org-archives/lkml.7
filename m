Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA0FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ACD20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BRq3c+Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbfJNSh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:37:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33008 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfJNSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:37:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9EIbtM3130441;
        Mon, 14 Oct 2019 13:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571078275;
        bh=gjpe0/tPdjeJbD6c0yP9qpUnp8n/wsrLxgxIz+sbP64=;
        h=From:To:CC:Subject:Date;
        b=BRq3c+PlhEgCqEv7DyeL7aC1gjybRH4gu7HwQylBeqVScBl5DiKs4NbvG33uXdf7B
         AIL+vaopmZbK+tMyzVzZOoWZ+LXxAVhYsf8SeBhNv560F61yjo1F/396hL+E7tFxOL
         jde/s3EdZ26stbKXdAD3UXzEE51unTjFpj5u1OQk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9EIbtsv021834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Oct 2019 13:37:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 14
 Oct 2019 13:37:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 14 Oct 2019 13:37:49 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9EIbqfI014449;
        Mon, 14 Oct 2019 13:37:53 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <asutoshd@codeaurora.org>,
        <riteshh@codeaurora.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
Date:   Tue, 15 Oct 2019 00:08:49 +0530
Message-ID: <20191014183849.14864-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a write memory barrier to make sure that descriptors are actually
written to memory before ringing the doorbell.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

This patch fixes a very infrequent ADMA error (1 out of 100 times) that
I have been seeing after enabling command queuing for J721e.
Also looking at memory-barriers.txt and this commit[1],
it looks like we should be doing this before any descriptor write
followed by a doorbell ring operation. It'll be nice if someone with more
expertise in memory barriers can comment.

[1] ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the
    doorbell")

 drivers/mmc/host/cqhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index f7bdae5354c3..5047f7343ffc 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -611,7 +611,8 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	cq_host->slot[tag].flags = 0;
 
 	cq_host->qcnt += 1;
-
+	/* Make sure descriptors are ready before ringing the doorbell */
+	wmb();
 	cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
 	if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
 		pr_debug("%s: cqhci: doorbell not set for tag %d\n",
-- 
2.19.2

