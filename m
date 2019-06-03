Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4104C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDFB24195
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="1cEQIfCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfFCW3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:29:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44687 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFCW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id p67so1308963ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YUw6e+dM1SFz4LeXvxWXBqLHb/4EQFux2poSTpQulfs=;
        b=1cEQIfCIKJfVCTos3XMuSoqM2U+PvoPD7LC7s6YoZfoxGpkDY9eXGkU/Th/FXYTUVF
         5XC2sFEp7cNyN73zx/nz3xzU8Tz/QzjeBXE0O7LL2DW3XM2bFjCG/bXF2mx8/KCshYbX
         PUW760UiVlfCTVCQS4DuofV6W2ZG3gp+gJNTpGggKTwdYwUFOPtbXIrxmSNeNDwW408k
         UXeTb2PDO4g8q1gFCe5rqyxU4+MfoFqOO319qY7HWKYnjHCCZkaVDvaGPPhKIfauJIgc
         qK5Bgog3ZeIbRLvc4KAvnAYYIp8AXJ+4Qu5X87QZcuSE0zhGuVPum3a0J7Ba0Dta1PS/
         YSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YUw6e+dM1SFz4LeXvxWXBqLHb/4EQFux2poSTpQulfs=;
        b=eytlpui22RFRer1RBc8RICC2sn3LzLCFYIxVSzm7d7rmXBMv9pineRMS6cDpFV3ZXE
         7dXWKJWDT+Up90FKiAMw93OmaiNVmu7ACc19NK1vzYfDf+w7VETZj999SLpRB7nIAuyB
         rPlWCQ9iu2HyCbVm6hfQb28G65vCiBW2VpVdMSlEQ5Kbo8OX3v/mD+PKt+esudAX7aVV
         zyh2WVMjfX1Jh/6KTUNMJ5Jt5gb0UfSkUmZVXVIHKlfCLs6eO6tRFA58LEDSnzNgIHcH
         hRfqCGT9GApTYSPDtFK1rm7Z+Ku+xx6Gx5/R7fQoMZ0j1kH639sCFHdfUW+gND2P/KwR
         jA/w==
X-Gm-Message-State: APjAAAWZ0gI9ArTnqqW77h2ZPCKzBsZkm2w5/1dJlnPTrpLX2IJt8ZCC
        jgEZ5t4YslVDF7VzTeGBFbiNIg==
X-Google-Smtp-Source: APXvYqwuNbQDJm9cbNb24r/eoLAKrjnQfU3R0fDqZHb/fRAksALPYf2adShFQXQ0CIZQgQ8ImcBe9g==
X-Received: by 2002:a2e:9185:: with SMTP id f5mr12072389ljg.51.1559600961696;
        Mon, 03 Jun 2019 15:29:21 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:21 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: kpc2000: remove unnecessary parentheses in core.c
Date:   Tue,  4 Jun 2019 00:29:11 +0200
Message-Id: <20190603222916.20698-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl check "Unnecessary parentheses around
pdev->dev.kobj".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 356a272c0b9c..dc6940e6c320 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -491,7 +491,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	/*
 	 * Step 9: Setup sysfs attributes
 	 */
-	err = sysfs_create_files(&(pdev->dev.kobj), kp_attr_list);
+	err = sysfs_create_files(&pdev->dev.kobj, kp_attr_list);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add sysfs files: %d\n", err);
 		goto out9;
@@ -515,7 +515,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	return 0;
 
 out10:
-	sysfs_remove_files(&(pdev->dev.kobj), kp_attr_list);
+	sysfs_remove_files(&pdev->dev.kobj, kp_attr_list);
 out9:
 	free_irq(pcard->pdev->irq, pcard);
 out8b:
@@ -552,7 +552,7 @@ static void kp2000_pcie_remove(struct pci_dev *pdev)
 	mutex_lock(&pcard->sem);
 	kp2000_remove_cores(pcard);
 	mfd_remove_devices(PCARD_TO_DEV(pcard));
-	sysfs_remove_files(&(pdev->dev.kobj), kp_attr_list);
+	sysfs_remove_files(&pdev->dev.kobj, kp_attr_list);
 	free_irq(pcard->pdev->irq, pcard);
 	pci_disable_msi(pcard->pdev);
 	if (pcard->dma_bar_base) {
-- 
2.20.1

