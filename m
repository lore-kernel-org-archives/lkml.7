Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E9D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So7OONN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDAEOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37283 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfDAEOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so857517ply.4;
        Sun, 31 Mar 2019 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAwJIfjiKM8pNEDoKthQiwiD5cmEPkYI7KIwumNS0FM=;
        b=So7OONN/Jl8GvkDVch0T872FIN21y9QwE0KIvi/p/xu3ZvB2lR8QzcvgPnUFca5EeB
         07asoKR98oTeUxC9bZlPc+Vws0qWXAJDBq+BVvhDk05FhknM2+5/lPbfzc5HAxkn6AdR
         8zyuH+ZR6j0pMohXoZY6oH6sv/2UDfuY+rONNTj0cq5369r6osXEeVRDxb3a63SiGCKX
         SULZP6wDnd5CjrxJrLkblV337rNpz4halYjgNBzq2+qReXqenYTZM49vwcTyLljxRf+T
         q78dQ8GWPfqHxC2+iuzGfvghFsN16TUSDS9zTivU7rF7naoyeiLaEewj5dCAkxiijwAA
         d0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAwJIfjiKM8pNEDoKthQiwiD5cmEPkYI7KIwumNS0FM=;
        b=RQUb0Dl6wbbPSSTamBzt3egCK6aLmBs+521YJgVlE/ZLua2s5QNFkUfqGPUqzHZePa
         hawtJmse1HUAX2Hda2TnwMTKISWa1GFsqcEip8pnQD96xEsNEmtQje6az8u8yTLsId2h
         6XP9qfX3OxcKys5y6bmzGF8vFMMG5cTyY39VjfbRiMgGQacOzb1n4HeUrhGzSYlTR/1r
         fISdrqjLtxT8jOx+Da+XPcH5kvUGg1kuqtNAFEJiuYkB/4Tw/hykS4NETFwQ1I1vIUX8
         ArLbd4kaksMpCX/d2mOZlp3NWemU/YWZFO73BgzNLUmGUqYX3bP8kFmfCJHoNILGp8Nh
         lXIA==
X-Gm-Message-State: APjAAAVaDL1QmexquYd+C9+N46MCk3eFuU+p7YCbrJsqKx6z03YcdEbk
        rFdZYXnx9iwLUbcLLIZawoJEdUKE
X-Google-Smtp-Source: APXvYqyR4UbVPafDEPsugdhxVdepYjl0LDBln/ayrT4BtNtSBzgPt38gOcEyCNm4OMknVqt8SDQvKQ==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr63118768plb.312.1554092077964;
        Sun, 31 Mar 2019 21:14:37 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/13] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Sun, 31 Mar 2019 21:14:08 -0700
Message-Id: <20190401041418.5999-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct thermal_zone_device reference stored as sensor's private data
isn't really used anywhere in the code. Drop it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 91f9f49d2776..6d40b9788266 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -65,7 +65,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		qdata->sensor[id]->id = id;
 		qdata->sensor[id]->qdata = qdata;
-		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
-				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
-		if (IS_ERR(qdata->sensor[id]->tzd)) {
-			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
+
+		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+							   qdata->sensor[id],
+							   &tmu_tz_ops);
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
 			else
-				return PTR_ERR(qdata->sensor[id]->tzd);
+				return PTR_ERR(tzd);
 		}
 
 		sites |= 0x1 << (15 - id);
-- 
2.20.1

