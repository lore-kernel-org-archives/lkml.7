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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90206C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C552184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBHd9zUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfHHH3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:29:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33294 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbfHHH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:29:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so2768737pgn.0;
        Thu, 08 Aug 2019 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCiqzVCyq/mHzkP/zEMY8TGaXcPuh2nCv39WdsVYm/U=;
        b=UBHd9zUyzBBGwf/TyDAihmS7BPQCX09cnR/DGsu9/uTzjfFA5cQ+aHAdjD1Gi/h/3T
         qrQwoWJ54q38QL74CW1CCP8eTAG58Tva3uXO40Ea71z5PPS7U3SgVpa06GPLbe0x+AhM
         Af/THxRANmNtD2Cgk9j7oBjmvbONNwhJbJB1Xg/oasGImZPew5lxxXtBnVqWyHgmFMzt
         u6HCal4okypS2+DUvGEvM/V5DX6Wn4rRZfQ+sjSYlvCh6VcqjF27Fm0ZC9N57i8FjZ5/
         4frSgXnOnFMrGa6Kw07Qt/m5lMNnLAGKNs2zFuX9cmlbH+6Qgj2VO+8Sq4gRcP7xXRxt
         58vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCiqzVCyq/mHzkP/zEMY8TGaXcPuh2nCv39WdsVYm/U=;
        b=F2HnfCDnC/8y94/5WZp2MVEfemlqqTmjCLw00oPDJVQ0P1ywn8aOstNKTb8DQ/8n7F
         4eFW8FKvqZszxgcRAr4YWsUP0dIxdvQ0vnc3a3RJSNfv2pWFBVSThvYMZc46NgUICXLx
         1/rqtHBDm4yXCe9cWCN/ZIVhZ3Mj/2tp+tQC8V8JMv6XyfpAfMtdl8/yx5GM/Pw5H2Pj
         s4YlPgJsbPLJUG+osyu++MzG0RR6OgDmhkuUfM2qQZn+FGFBx4KtLw2CcPSftB/6iXpM
         OPCIRbmuH1TViJDJIwE/4QMEM+X6zmrkDDW1nEahnFeZbYZJzTD50ZVKv6RhuGzBjluB
         EUXA==
X-Gm-Message-State: APjAAAXOx8L2+wxavdk1gnvvRy6DEUMyuXXltMWUO34vFNJs0nxP7BOq
        esYRgRWkMncjKs1wkro0sqA=
X-Google-Smtp-Source: APXvYqzUU4RNtzMYs77dUlpQujBVvO4cfq3bMOHKRPrmYlpGQvauYBlM67KlWg7Ce+DC0mnfBbgv0w==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr2677208pjr.116.1565249389698;
        Thu, 08 Aug 2019 00:29:49 -0700 (PDT)
Received: from localhost.localdomain ([122.163.44.6])
        by smtp.gmail.com with ESMTPSA id i123sm127512060pfe.147.2019.08.08.00.29.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:29:49 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     agross@kernel.org, kishon@ti.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v3] phy: qualcomm: phy-qcom-qmp: Add of_node_put() before return
Date:   Thu,  8 Aug 2019 12:59:37 +0530
Message-Id: <20190808072937.14387-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_available_child_of_node() puts the previous
node, but in the case of a return from the middle of the loop, there is
no put, thus causing a memory leak. Hence create a new label,
err_node_put, that puts the previous node (child) before returning the
required value. Also include the statement pm_runtime_disable() under
this label in order to avoid repetition among mid-loop return
conditions. Edit the mid-loop return statements to instead go to this
new label err_node_put.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
Changes in v3:
- Add version number.
- Add change log.
Changes in v2:
- Move put and return statements to a label.

 drivers/phy/qualcomm/phy-qcom-qmp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 34ff6434da8f..e7b8283acce8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -2093,8 +2093,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(dev, "failed to create lane%d phy, %d\n",
 				id, ret);
-			pm_runtime_disable(dev);
-			return ret;
+			goto err_node_put;
 		}
 
 		/*
@@ -2105,8 +2104,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(qmp->dev,
 				"failed to register pipe clock source\n");
-			pm_runtime_disable(dev);
-			return ret;
+			goto err_node_put;
 		}
 		id++;
 	}
@@ -2118,6 +2116,11 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 		pm_runtime_disable(dev);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
+
+err_node_put:
+	pm_runtime_disable(dev);
+	of_node_put(child);
+	return ret;
 }
 
 static struct platform_driver qcom_qmp_phy_driver = {
-- 
2.19.1

