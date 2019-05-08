Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02481C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B0621530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDRhoNuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfEHSCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:02:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfEHSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z175ufgHfKNpVPfjQ5KBrbanxr8MORY0umGXUAhhLNA=; b=uDRhoNuzBQQGvsYBHhUiWCGw6
        PZjQtP2+4ZRKNW0b1dWOp3LkIjR9dc3tHQpBnu+Mryw23ZYpUyTvjRMRbQ2PFTXfMmA5gwAO3MImO
        pw3YtmXiFlIZ10hufp/Tdn5LM+RuPl2RPJ41/PylmuC8wNU8lznNOd+S0T6B6/VepyI4ehSONIIwB
        CR4RCUreuFC9rtpbHdqiC8qk2jO2QrhUMesNR7Ac7tFpldyyOT/85KNv8es9A5O8mQrizDX89vdoZ
        i+AEQ54CzPbJHAzPhblPZ7jgOfcMSXcCh5VEfLGstJZiB+tMtq9AhUtyh/gO1vVF6p1EecJwMDq+O
        mTi7ye5OQ==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOQta-0000Jf-2R; Wed, 08 May 2019 18:02:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ide: officially deprecated the legacy IDE driver
Date:   Wed,  8 May 2019 20:01:40 +0200
Message-Id: <20190508180140.12364-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a recent chat with Dave we agreed to try to finally kill off the
legacy IDE code base.  Set a two year grace period in which we try
to move everyone over.  There are a few pieces of hardware not
supported by libata yet, but for many of them we aren't even sure
if there are any users.  For those that have users we have usually
found a volunteer to add libata support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 5aeaca24a28f..4ad824984581 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1437,6 +1437,9 @@ int ide_host_register(struct ide_host *host, const struct ide_port_info *d,
 	ide_hwif_t *hwif, *mate = NULL;
 	int i, j = 0;
 
+	pr_warn("legacy IDE will be removed in 2021, please switch to libata\n"
+		"Report any missing HW support to linux-ide@vger.kernel.org\n");
+
 	ide_host_for_each_port(i, hwif, host) {
 		if (hwif == NULL) {
 			mate = NULL;
-- 
2.20.1

