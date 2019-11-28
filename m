Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96CF216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9JevNY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfK1QuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfK1QuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so10825574pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dfqbr0RxajlO5BfpaJ+gj/cruGVf9oBCHGspuRMYLGM=;
        b=O9JevNY1LOgHwoZQBP3JRCrkxMNX7g335LWvtIGE8TSf0gdh7CvuTTvGfjm78nXgUM
         +p1zMhh+nbn6ISXwf21PH0Z60BkeYpF4a6JzV8KEkI2WqyswsIDCbpxjl7X+PRhKCzIs
         DXpIhvG/INtLpkzRZFie2gEw9yF+o67uC62GGi7F3QILehtJeR3fMeC9qJxpd4Rb5bQn
         9z5+WTrOoWg7fT07bhstV28T/EBnSeUD0loJ3jbO1F/0igGdeu3+T9Nt13ydF/Z+DFFs
         rkThpEXWnl23uu7cSgvOhyGVz2L72jGZfYqVGe0hqI/1KBTny0XVSPtvXsQb4D+rZIxg
         X5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dfqbr0RxajlO5BfpaJ+gj/cruGVf9oBCHGspuRMYLGM=;
        b=P/PVFBsCHdQ8zNuCqkhQyIeQMi+hvY3+hVtkJ/7FjErDfiXLYQu51l/lbEtv+TaBUr
         MpDsHqeqwAh1Qz6ktNoQqYaAAEity0s/bFpWyETyYyabSgXaKP62Z7A5Fpa4/Tk78Y3L
         GGDdLXBsS5S+LLYMT7WyCaALHp4qafA02BNAF89bXbFqYf3YN6QVwxlInZS9CnIhO+EA
         /cK+68dEGBTjkClnIajC9zYvv8IigtmUHesAC2bzsBNuvlezNe2z4FaJeADKzvSeVeN8
         AqgLu3UOCvF+eMnsAUil+xjMCbZXJQ/UGcIABrPgR47p4okfAxjJ62Fu7Ligp907E4x7
         EnzA==
X-Gm-Message-State: APjAAAWt3iyRMSAGE63eYLc37YopyCjFsYNm4IHDfw9HNpP0hv8KOMFN
        V1Hb1oKyYlaAAN4LUSNBM5daMA==
X-Google-Smtp-Source: APXvYqz1CZkfXWlCWREUSYNgSlKLOyyH6hBE4kK1EF/EFkOotdf16LQQAGFxMXT09S3PLDy00ju7iA==
X-Received: by 2002:a63:907:: with SMTP id 7mr11914734pgj.361.1574959814421;
        Thu, 28 Nov 2019 08:50:14 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:14 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 11/17] mailbox: mailbox-test: fix null pointer if no mmio
Date:   Thu, 28 Nov 2019 09:49:56 -0700
Message-Id: <20191128165002.6234-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Dessenne <fabien.dessenne@st.com>

commit 6899b4f7c99c72968e58e502f96084f74f6e5e86 upstream

Fix null pointer issue if resource_size is called with no ioresource.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/mailbox/mailbox-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 58bfafc34bc4..129b3656c453 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -363,22 +363,24 @@ static int mbox_test_probe(struct platform_device *pdev)
 
 	/* It's okay for MMIO to be NULL */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	size = resource_size(res);
 	tdev->tx_mmio = devm_ioremap_resource(&pdev->dev, res);
-	if (PTR_ERR(tdev->tx_mmio) == -EBUSY)
+	if (PTR_ERR(tdev->tx_mmio) == -EBUSY) {
 		/* if reserved area in SRAM, try just ioremap */
+		size = resource_size(res);
 		tdev->tx_mmio = devm_ioremap(&pdev->dev, res->start, size);
-	else if (IS_ERR(tdev->tx_mmio))
+	} else if (IS_ERR(tdev->tx_mmio)) {
 		tdev->tx_mmio = NULL;
+	}
 
 	/* If specified, second reg entry is Rx MMIO */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	size = resource_size(res);
 	tdev->rx_mmio = devm_ioremap_resource(&pdev->dev, res);
-	if (PTR_ERR(tdev->rx_mmio) == -EBUSY)
+	if (PTR_ERR(tdev->rx_mmio) == -EBUSY) {
+		size = resource_size(res);
 		tdev->rx_mmio = devm_ioremap(&pdev->dev, res->start, size);
-	else if (IS_ERR(tdev->rx_mmio))
+	} else if (IS_ERR(tdev->rx_mmio)) {
 		tdev->rx_mmio = tdev->tx_mmio;
+	}
 
 	tdev->tx_channel = mbox_test_request_channel(pdev, "tx");
 	tdev->rx_channel = mbox_test_request_channel(pdev, "rx");
-- 
2.17.1

