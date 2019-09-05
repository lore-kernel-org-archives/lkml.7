Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C5C00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074EA20CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5DiiY2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfIEQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:19:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38523 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbfIEQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:18:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id d10so1683928pgo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpqdWISBmI7/K+eXW/BM3B61WGwPfixYNx9jyTHk1dU=;
        b=K5DiiY2Fgz6MUrPKTtz10HsJkolwwVvGrdqBD69mgIMaQbkMXiTRCgCbb2ZyUxaTSS
         TsurgVMOb8XwbIXgdyeF+rfzsvnXsAM1sHLEQ4y5Ke840f0eEdtxvvN3Pb5ZdVwNLiXE
         UV+r4cWr5AN6DgFXtNn2GrDrgfsbA6uZcFqrnHfIbgan0lx/1+ZKIyh6gDp63fdh/v9I
         KCxMrdpVzkF4eB9dCxcnzu4IORv5zjU09dggJmJTVefvcrHEGmUqyNXgA3hCndJldZef
         81oH34LbhykA0VcHebAOIDd2RLBykltXAikm9fusMU2Bx4GGt+Kmw89s92q1rKZ+QSBQ
         hcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpqdWISBmI7/K+eXW/BM3B61WGwPfixYNx9jyTHk1dU=;
        b=KJ4M+hPtvVYBU6QneECk7pHvrUungWnkafS7pnJbAxHpVLSPqOgywavXaBKErAkSzf
         N6soLAJWRPPrS0W8LZR5G58NbYX+b3cCyNO5ygz710bc9CR3FbL+4mlK6Wqs+EV2KwaW
         XhA8YeQ5eHEh1+Y+tA1cYi8GC+vhYwLkuKSavQS+CCJz/olJgNKPBQmg3uttIuoTvUE5
         P9OedYRjgw7VstXqlb+L2edsCGwR9HzkEfkGbYlv8GMZoh9Oz9rLQ1vkamxqBRO1n2uy
         M2X/ywO37qj3Tcn3oE/StstuydDE7xO/fmDXXeRy+P2SEB8d+5x4AeoWoVsio3sIHa4v
         pLlg==
X-Gm-Message-State: APjAAAWkUbXvTha11TQsB7xJ4n8oUmaVPVbkXX88XAS46KHPtvdScLBD
        XcfgH0j7IpT/VNesNSb9kmSrdg==
X-Google-Smtp-Source: APXvYqzLPzIYaG0mi1vPeoIIvWEzHscZk32TWtoUUzrIK69h3pf7m60GZNfheMkCm5xxBpsI0LrElA==
X-Received: by 2002:aa7:8e08:: with SMTP id c8mr849847pfr.238.1567700294324;
        Thu, 05 Sep 2019 09:18:14 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m129sm6324005pga.39.2019.09.05.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 09:18:13 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [BACKPORT 4.14.y 11/18] misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi()
Date:   Thu,  5 Sep 2019 10:17:52 -0600
Message-Id: <20190905161759.28036-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
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
---
 drivers/misc/pci_endpoint_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 504fa680825d..230f1e8538dc 100644
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
@@ -514,6 +515,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
 		if (irq < 0)
 			dev_err(dev, "failed to get MSI interrupts\n");
+		test->num_irqs = irq;
 	}
 
 	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
@@ -581,6 +583,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
+	for (i = 0; i < irq; i++)
+		devm_free_irq(dev, pdev->irq + i, test);
+
 err_disable_msi:
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
@@ -594,6 +599,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 static void pci_endpoint_test_remove(struct pci_dev *pdev)
 {
 	int id;
+	int i;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
 	struct miscdevice *misc_device = &test->miscdev;
@@ -609,6 +615,8 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 		if (test->bar[bar])
 			pci_iounmap(pdev, test->bar[bar]);
 	}
+	for (i = 0; i < test->num_irqs; i++)
+		devm_free_irq(&pdev->dev, pdev->irq + i, test);
 	pci_disable_msi(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1

