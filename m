Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BE6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C343A21920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931099;
	bh=7jrej0KAdtSGw1xy2W0LyObM7950SsjKvp9AEmqT/q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CZWhxKA3TY0ax7iKgUCjlM5iW7lB6npsHD8LOWSi7P/8ejQSGudwiwOF6QU5xrZhM
	 frCQtftvnEyRDuNa8TGZE2QH6siu7w48wkyv3HtDgGWnafzP8I6bRMEXPDb+bBDpm7
	 FFYEatN8yv7T84bDR0klRUWnRbjHD59jVbsU1e3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405865AbfISWLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391879AbfISWLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:11:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FC721907;
        Thu, 19 Sep 2019 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931095;
        bh=7jrej0KAdtSGw1xy2W0LyObM7950SsjKvp9AEmqT/q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2SSRjD7Ub6f7aoWCQW1iZtkmNpJna5+Xsltvxkda8yPy7XHK35/t2Zha11MEiWqsW
         z98OdghIBB6M3uiqYX903PsAEPfh/a5APthu0fGZR+ttZ2kZdW6DRQyxq9VzrwTJj7
         JLKRYZKEDcgnwJ3fCFImRJD5qKJ12orjcnMOctDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 107/124] enetc: Add missing call to pci_free_irq_vectors() in probe and remove functions
Date:   Fri, 20 Sep 2019 00:03:15 +0200
Message-Id: <20190919214823.087474354@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit dd7078f05e1b774a9e8c9f117101d97e4ccd0691 ]

Call to 'pci_free_irq_vectors()' are missing both in the error handling
path of the probe function, and in the remove function.
Add them.

Fixes: 19971f5ea0ab ("enetc: add PTP clock driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index 8c1497e7d9c5c..aa31948eac644 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -79,7 +79,7 @@ static int enetc_ptp_probe(struct pci_dev *pdev,
 	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 	if (n != 1) {
 		err = -EPERM;
-		goto err_irq;
+		goto err_irq_vectors;
 	}
 
 	ptp_qoriq->irq = pci_irq_vector(pdev, 0);
@@ -103,6 +103,8 @@ static int enetc_ptp_probe(struct pci_dev *pdev,
 err_no_clock:
 	free_irq(ptp_qoriq->irq, ptp_qoriq);
 err_irq:
+	pci_free_irq_vectors(pdev);
+err_irq_vectors:
 	iounmap(base);
 err_ioremap:
 	kfree(ptp_qoriq);
@@ -120,6 +122,7 @@ static void enetc_ptp_remove(struct pci_dev *pdev)
 	struct ptp_qoriq *ptp_qoriq = pci_get_drvdata(pdev);
 
 	ptp_qoriq_free(ptp_qoriq);
+	pci_free_irq_vectors(pdev);
 	kfree(ptp_qoriq);
 
 	pci_release_mem_regions(pdev);
-- 
2.20.1



