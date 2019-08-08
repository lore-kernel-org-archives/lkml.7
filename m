Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E16420B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxEKfnJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfHHHgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:36:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41870 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:36:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so43615874pff.8;
        Thu, 08 Aug 2019 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgFG813H9M+J+MaK+iihIFj7Hhcb4vweQ9Wlnc563TY=;
        b=oxEKfnJLHnkBqy3PeQ++eGzd5GonzM/yqAHc0TFe7tL5rITGGPF6fCIwfVDzefgrT3
         iY9D23MA/5WWyaXK5wvBvnLR96RjCkyN2sPMVEotzRp9vNRYK7pltFVJXRTOSaG4Zirr
         C1ONodpGSv2ie7s53atih5P+HB97PmZTRG/Kr7NWvVURSBfsKROuzjitc3ncuKpDzfoa
         ZFj9HurZn68Rjf1fCiKrMMpehbS6cXCceMMuK/CbiQevkkiIaegsw1aCEGknC4+iPt4y
         apU3IkPyA0eswDhSnwfNAe2ar20qV0p+sOh7Mj1xDcw/1l7byJMr2x+HNbn4IOJJVslJ
         R2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgFG813H9M+J+MaK+iihIFj7Hhcb4vweQ9Wlnc563TY=;
        b=e5ZrfyRzYM1Xw6KWkxsfbHSM0Ozz0VXf5KxIDlfBBORh/GFd9oOYLRea5U94TMERns
         5/OxAPQm5Lb4r12cBmF8Nr9iFGw/Wmk8m6PHm1g9rEf5fliuA2Woh10hYO/NJcEXcaSu
         saFHUEx34ecJWCwZc7wQ0hlpIXXjQQpDWayXjofHcpecNS4ZSOxuWI0VG+p28GCLebRL
         YDAo3GjLl1+3i2VS9YoeO1oKcjRGcXgXCXxXty1gHZSrg1fo5ioVRBFOIQHqLq7oqGWe
         E1OSmZqIl/RWE1m0Ir8GgPh1C7KKIvW4Tr+QhxFnFoZX4gZErgHgiqcw9urvClvCzXlT
         iA9A==
X-Gm-Message-State: APjAAAUnMmf1W31GU3etHoLLhcS6iJFmdcUAP0cY99kq9Ct8UNJTUlV8
        Hi74Y9oTlgesaGtMH+Aow1I=
X-Google-Smtp-Source: APXvYqyNcp4TD9HuuIqvPKerRFAMYqI63NmNdeTWdXxnIjedGf6uhTvj1onW4EcZ43vq2J1RfyY21w==
X-Received: by 2002:a65:6850:: with SMTP id q16mr11802967pgt.423.1565249804482;
        Thu, 08 Aug 2019 00:36:44 -0700 (PDT)
Received: from localhost.localdomain ([122.163.44.6])
        by smtp.gmail.com with ESMTPSA id z13sm1492106pjn.32.2019.08.08.00.36.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:36:44 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] soc: qcom: smp2p: Add of_node_put() at goto
Date:   Thu,  8 Aug 2019 13:06:32 +0530
Message-Id: <20190808073632.15224-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_available_child_of_node() puts the previous
node, but in the case of a goto from the middle of the loop, there is no
put, thus causing a memory leak. Hence add an of_node_put() before each
mid-loop goto.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v2:
- Remove the extra label.
- Add the of_node_put() statements individually before each goto.

 drivers/soc/qcom/smp2p.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d54e444..c51b392f4000 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -501,6 +501,7 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		entry = devm_kzalloc(&pdev->dev, sizeof(*entry), GFP_KERNEL);
 		if (!entry) {
 			ret = -ENOMEM;
+			of_node_put(node);
 			goto unwind_interfaces;
 		}
 
@@ -508,19 +509,25 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		spin_lock_init(&entry->lock);
 
 		ret = of_property_read_string(node, "qcom,entry-name", &entry->name);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(node);
 			goto unwind_interfaces;
+		}
 
 		if (of_property_read_bool(node, "interrupt-controller")) {
 			ret = qcom_smp2p_inbound_entry(smp2p, entry, node);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(node);
 				goto unwind_interfaces;
+			}
 
 			list_add(&entry->node, &smp2p->inbound);
 		} else  {
 			ret = qcom_smp2p_outbound_entry(smp2p, entry, node);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(node);
 				goto unwind_interfaces;
+			}
 
 			list_add(&entry->node, &smp2p->outbound);
 		}
-- 
2.19.1

