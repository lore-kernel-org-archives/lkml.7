Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BFCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DCC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499270;
	bh=LXXefkn7p8AQImuoepIaWvtbHVSn6+lPhVa3zsDkwBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cmWzF7tad6hgRhq324MEndwI3ZS+lhUdbuBm/aPmJdy8p1L6Y9d9MqTrpfzFnGQkg
	 cZgnnVJoknrsH9SLK95Ih8i1uZjFaOA90xxKXmh/rWoy6fN2GC36aBNmRCdEQdZ8NA
	 jzF/XsLfxahAgN/TsCzGOp+KROlYGDTdMbR4TAw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfKKTHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:07:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfKKShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:37:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C156521655;
        Mon, 11 Nov 2019 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497433;
        bh=LXXefkn7p8AQImuoepIaWvtbHVSn6+lPhVa3zsDkwBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HieXN1DeKkp7EcbMy49/wKEMuPLRqFWlwF308j8l1vZQDRxMatP7DHrz1jVz/+ugi
         UbHpUwMe8SKbW41vel/S7PJJrUeLpmdF2UU2X/U2K2Ml9R4hbMix4z2as1ohK7IPKd
         ex5p30Zd+BSUu4B8D+7pdbprYxskWkf5MUA4CY6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.14 053/105] misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi()
Date:   Mon, 11 Nov 2019 19:28:23 +0100
Message-Id: <20191111181443.403909088@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

commit b7636e816adcb52bc96b6fb7bc9d141cbfd17ddb upstream

pci_disable_msi() throws a Kernel BUG if the driver has successfully
requested an IRQ and not released it. Fix it here by freeing IRQs before
invoking pci_disable_msi().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/pci_endpoint_test.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -92,6 +92,7 @@ struct pci_endpoint_test {
 	void __iomem	*bar[6];
 	struct completion irq_raised;
 	int		last_irq;
+	int		num_irqs;
 	/* mutex to protect the ioctls */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
@@ -514,6 +515,7 @@ static int pci_endpoint_test_probe(struc
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
 			dev_err(dev, "failed to get MSI interrupts\n");
+		test->num_irqs = irq;
 	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
@@ -581,6 +583,9 @@ err_iounmap:
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
+	for (i = 0; i < irq; i++)
+		devm_free_irq(dev, pdev->irq + i, test);
+
 err_disable_msi:
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
@@ -594,6 +599,7 @@ err_disable_pdev:
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
 {
 	int id;
+	int i;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &test->miscdev;
@@ -609,6 +615,8 @@ static void pci_endpoint_test_remove(str
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
+	for (i = 0; i < test->num_irqs; i++)
+		devm_free_irq(&pdev->dev, pdev->irq + i, test);
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);


