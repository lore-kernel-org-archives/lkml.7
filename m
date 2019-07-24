Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F8DC41517
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7A229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="P7r26X8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGXA6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:58:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36510 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfGXA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:58:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so19995753pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWRBDptpvGExrL+LyWWAbEmVmW1hvUPL5daLiJ4nWjg=;
        b=P7r26X8LA2xaGR51pT+9ncHw7KvKkSSF7K6iF+2FowcbqpHFOKjyvQVoo7pzraNduW
         5kz9RYQ8aJo3w8k8flOPlTLbuuNxlpbs10UEcP4pF18u5sYE48gA0nwCcqeiCFA6j08Z
         b6LuRaJA0YuhYrPaszZK5M2df9haQgZmtiaZuB5K0niTU1t67B/WnFOBNIgQYGskjEEe
         wujqW/cZLFMasHm1oVfGuHBDJeBAFHOY6sIeeoRVZn5VlDciYISnvCjMF2HYVcXEyypF
         G7yFDTC+c6kesjkNddoHqI8I31VweyYtatbBy8niBd9gsNecSMsXasv2vqFhOpV7JQ2a
         cRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWRBDptpvGExrL+LyWWAbEmVmW1hvUPL5daLiJ4nWjg=;
        b=fi1SWTh2inpQK72h/NT67SuUIyFec1r6sRdes3KL15BE3OWt+OL4ohj2dh2MNLX8WU
         NCg4kgESepbgFPBntuR5xBhY6kDY+49ocnJoKlKyYulq3M04AcDrRoGJz4iHtKhSH/IL
         VxJ/KGUnsIlI9liz3ANE0Wjdc7fiZLmd1mONj0mt4v1jqQCAuewRTqSRSCAJGjqOhsff
         suNp7ZkGhGRkAMAMVhj4k+7waWYDh9xNpe45yMue40N3NWTsENX9asNXAjAx4/ss58aU
         RzORXKPMKj9xqMn62Sf3lc1Y7/G/4CTSjsPdpbf9QEVzVt5oEFpFskOiWLg1FnAdgm77
         UHUQ==
X-Gm-Message-State: APjAAAUnxOXMhwG32LKUXQS/LgWfIa1mKQ2cb8mfYCea38YNSPHvuG0K
        9wNAMkuEeFXuECQGtWUtLzs=
X-Google-Smtp-Source: APXvYqzfqb20vNtSnlS1tF8gfna4i6ht0Ii4lmD+QWNCOKbd65ee3Pfx/iuPa+DcT1auNw67FFKgAQ==
X-Received: by 2002:a17:90a:3ae8:: with SMTP id b95mr82886422pjc.68.1563929916628;
        Tue, 23 Jul 2019 17:58:36 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-194.dynamic-ip.hinet.net. [36.239.234.194])
        by smtp.gmail.com with ESMTPSA id 4sm53942530pfc.92.2019.07.23.17.58.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 17:58:35 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] regulator: lp87565: Fix probe failure for "ti,lp87565"
Date:   Wed, 24 Jul 2019 08:58:25 +0800
Message-Id: <20190724005825.28562-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ti,lp87565" compatible string is still in of_lp87565_match_table,
but current code will return -EINVAL because lp87565->dev_type is unknown.
This was working in earlier kernel versions, so fix it.

Fixes: 7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on https://lkml.org/lkml/2019/7/11/203
This resend re-generate the patch against regulator tree for-5.3 branch.

Note there is a conflict with commit f3f4363b1239 on Linus' tree which is merged from mfd tree.
("regulator: lp87565: Fix missing break in switch statement")

 drivers/regulator/lp87565-regulator.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 993c11702083..0c440c5e2832 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -163,7 +163,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
+	int i, min_idx, max_idx;
 
 	platform_set_drvdata(pdev, lp87565);
 
@@ -180,10 +180,11 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	case LP87565_DEVICE_TYPE_LP87561_Q1:
 		min_idx = LP87565_BUCK_3210;
 		max_idx = LP87565_BUCK_3210;
+		break;
 	default:
-		dev_err(lp87565->dev, "Invalid lp config %d\n",
-			lp87565->dev_type);
-		return -EINVAL;
+		min_idx = LP87565_BUCK_0;
+		max_idx = LP87565_BUCK_3;
+		break;
 	}
 
 	for (i = min_idx; i <= max_idx; i++) {
-- 
2.20.1

