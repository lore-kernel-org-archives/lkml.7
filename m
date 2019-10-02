Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70932C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1C121848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="HZK27wtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfJBPzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:55:06 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:18668 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfJBPzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570031706; x=1601567706;
  h=from:to:cc:subject:date:message-id;
  bh=bj0cxGKPfe8MhxQf55HPC2pGXsBBiMQq3I7Z648xezQ=;
  b=HZK27wtX1WTcMPpk0LC51VzUsI+vnilSGs9G9fIRLx/ZooTEdD4LcGFO
   0Cb6PgHFlZcvaeA6VD6YOuMNyWw2tDANdniVW8+P386cu7N1IMWGgaN5o
   m7Z+IIsx/ndBB/qbcmTLT0ee4iVqU6HM+BQG5QCC6KlxfdfYalgnLEv3V
   m49d4JV2+ga/9NNaumPDEd0eaG5nD74nKs+ch2fz3uTrK0A5ypfUvkHdE
   2nBtTPUwHUitCQuU+F6ItXEUdPkrbSxTepmrUpvbU+wg+DkYSu4mFz8ru
   hTnPhihaEHQAyT0OIlycXVZab1aIjRWHwpM4pGaDJ4Hw+99jZoZB+zVXa
   A==;
IronPort-SDR: r2q/yjjxPelVpMAzC4qRy5Q8UJZHrHFD4NLrIzSXMdwMHZo7tcR323m91l5zzI+aabDkgBHOE1
 aJA8h3sNgTZWQdSNDOIYRL+C3D1I+pVBTLveyiy+ax4gFrRPE2222hqxthpJyv0lBviyWdZ/sW
 o0unA2NYldvZuSGM8GgIn6HLrzZ3ojs9yfub76ClV5pih8Q6s38lGIKlteTvWq54OfdFbv7Uw1
 poo2ZdSXDXWXBb6tLCV2t/ifPg9ozGIV5PIKpOpNMIa+78N5jeYjYus0n0FQ/jPhK5J+6fffz9
 bcA=
IronPort-PHdr: =?us-ascii?q?9a23=3A589tChPY9w6xrCgy47sl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfX6rarrMEGX3/hxlliBBdydt6sfzbaI+PG7EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oIxi7rArdu80YjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSG?=
 =?us-ascii?q?xEXsZQTCxBGYK8b40AD+EcI+hWtpT2p1UPrRSgAQmjGf7kxjtGi3Pq2KE31f?=
 =?us-ascii?q?kqHwPb0ww6B98AsGraosj7OqkRVu6417XEwSnZYv9Kwzrx9JTEfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEtGAPEj1SQqZHlPzSI3ekKs2ma7upgWviui2I7tw18rCOixtowhY?=
 =?us-ascii?q?nTnI4a1E3L9ThgzYszONa2S1Z7bMa6HJdMsyyWLYh7T8M4T212pSo21qcKtY?=
 =?us-ascii?q?O/cSUO0Jgr2h/SZvidf4SW7B/uVPydLSl5iX5/er+yiBC/+lW6xOLmTMm7yl?=
 =?us-ascii?q?NKozJAktnLq38CyQTe6tOCSvth5keh3iuP1xzL5uFEP080ka3bJoYkwrEql5?=
 =?us-ascii?q?oTtV3PHjf4mEnrlaOWeFgo9+ys5uj9bbXmoZicN4Bwig7gKKghhsu/AeEgPg?=
 =?us-ascii?q?gPWWiU5/i82aX98UHlRLhGlP47n6nDvJzEOMgXurS1DxJR34sn8xq/Ci2p0N?=
 =?us-ascii?q?UcnXkJNlJFfxeHgpDpOlDPIPD3F/a/j0iwnDpl3P3GI6HuAo/XInfdjbjhYK?=
 =?us-ascii?q?5x61RAxwor0dBf+5VUB6kFIPLyXE/xqdPZAgY6MwOq2ebnDsty1ocFVGKRDa?=
 =?us-ascii?q?+WLrnSvUWL5u0xOemMYpEauDLnJ/gi/f7ugixxt0UaePyY3IkXdXfwSuV0I0?=
 =?us-ascii?q?yYOSK3qsoKCyEHshdoH7+is0GLTTMGPyX6ZKk7/DxuTd3+AA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F4BAAdyJRdgMfSVdFmHgEGEoVFTBC?=
 =?us-ascii?q?NIIYpBos+cYV6gwuHIgEIAQEBDAEBLQIBAYRAgkAjOBMCAwkBAQUBAQEBAQU?=
 =?us-ascii?q?EAQECEAEBCQ0JCCeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBgXYUpASBAzyMJTO?=
 =?us-ascii?q?IYwEJDYFICQEIgSKHNYRZgRCBB4RhhCiDPYJEBIE3AQEBizsHiWFwlV0BBgK?=
 =?us-ascii?q?CEBSBeJMSJ4Q6iT2LQQEtjA2bGAIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXFY4?=
 =?us-ascii?q?uITOBCJA8AQ?=
X-IPAS-Result: =?us-ascii?q?A2F4BAAdyJRdgMfSVdFmHgEGEoVFTBCNIIYpBos+cYV6g?=
 =?us-ascii?q?wuHIgEIAQEBDAEBLQIBAYRAgkAjOBMCAwkBAQUBAQEBAQUEAQECEAEBCQ0JC?=
 =?us-ascii?q?CeFQoI6KYM1CxYVUoEVAQUBNSI5gkcBgXYUpASBAzyMJTOIYwEJDYFICQEIg?=
 =?us-ascii?q?SKHNYRZgRCBB4RhhCiDPYJEBIE3AQEBizsHiWFwlV0BBgKCEBSBeJMSJ4Q6i?=
 =?us-ascii?q?T2LQQEtjA2bGAIKBwYPI4FGgXtNJYFsCoFEUBAUgVsXFY4uITOBCJA8AQ?=
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="84526235"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2019 08:55:01 -0700
Received: by mail-pf1-f199.google.com with SMTP id z13so12908380pfr.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j3XM934BgcvR4S3GWK972GfeJ1Pu9gnBBD2xLxEu5nI=;
        b=ZnLZS54cWn+PdRyPnl1bW/UPnhNj7eQ+pwgbS0udbhpbko/oad6rjgTIB0rmEKbQMp
         uJRvKJknKXknGuVCLG50jFimtScMkLtXXUqPd0T7S8pqnHE9JPzpPfZV3PMH+OLG9pWF
         47LQnAMlneVxTk9r3hACqcylg6a5khV+G6AQNS4B/wJiarDvpEnarDY7LIjd3thJu7/r
         VuhqOn7unWscb3h5IXQYAMy2yWou1LfCkbmKXt3RGYiIu2iRkwlR+PHGucYkEeOf7fSB
         FoPkES3Qlmf0Sf14mLjscEqmoex3UzOH//eWMkvgZ+U1BzKTutrX6z7r1pc4bPbhOrOn
         Zctg==
X-Gm-Message-State: APjAAAV3O3jJ/sANqDyB64rjiNqIykVteE9UaYBGjt+bhs+CY9jhubkC
        +pNMSrzviXY1OoWeaALrqHV8ySzO9S+dhbffMvaspWED0JTvH81j26Y9VU23bQPk5lOw9NtuqWB
        p+UaZaUyjLvL0jkBx7ZCX3E/WZw==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr5190852pjr.116.1570031700665;
        Wed, 02 Oct 2019 08:55:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzaceMrlI3m0IF4H1HJAHPFI0DTM8kNCQIWt1N9YAjTQ/sgOnhDPuMQdGUPQsL0yw7vmAbfzA==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr5190829pjr.116.1570031700402;
        Wed, 02 Oct 2019 08:55:00 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id p17sm18198326pfn.50.2019.10.02.08.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:54:59 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max17042_battery: fix some usage of uninitialized variables
Date:   Wed,  2 Oct 2019 08:55:47 -0700
Message-Id: <20191002155547.9137-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions in this file are trying to use regmap_read() to
initialize the specific variable, however, if regmap_read() fails,
the variable could be uninitialized but used directly, which is
potentially unsafe. The return value of regmap_read() should be
checked and handled. The same case also happens in function
max17042_thread_handler() but it needs more effort to patch.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/power/supply/max17042_battery.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index e6a2dacaa730..8e5727010ed2 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -675,8 +675,12 @@ static void max17042_reset_vfsoc0_reg(struct max17042_chip *chip)
 {
 	unsigned int vfSoc;
 	struct regmap *map = chip->regmap;
+	int ret;
+
+	ret = regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	if (ret)
+		return;
 
-	regmap_read(map, MAX17042_VFSOC, &vfSoc);
 	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_UNLOCK);
 	max17042_write_verify_reg(map, MAX17042_VFSOC0, vfSoc);
 	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_LOCK);
@@ -686,12 +690,18 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
 {
 	u32 full_cap0, rep_cap, dq_acc, vfSoc;
 	u32 rem_cap;
+	int ret;
 
 	struct max17042_config_data *config = chip->pdata->config_data;
 	struct regmap *map = chip->regmap;
 
-	regmap_read(map, MAX17042_FullCAP0, &full_cap0);
-	regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	ret = regmap_read(map, MAX17042_FullCAP0, &full_cap0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	if (ret)
+		return ret;
 
 	/* fg_vfSoc needs to shifted by 8 bits to get the
 	 * perc in 1% accuracy, to get the right rem_cap multiply
@@ -1108,7 +1118,12 @@ static int max17042_probe(struct i2c_client *client,
 	if (!client->irq)
 		regmap_write(chip->regmap, MAX17042_SALRT_Th, 0xff00);
 
-	regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	ret = regmap_read(chip->regmap, MAX17042_STATUS, &val);
+	if (ret) {
+		dev_err(&client->dev, "Failed to get MAX17042_STATUS.\n");
+		return ret;
+	}
+
 	if (val & STATUS_POR_BIT) {
 		INIT_WORK(&chip->work, max17042_init_worker);
 		ret = devm_add_action(&client->dev, max17042_stop_work, chip);
-- 
2.17.1

