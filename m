Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD247C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9920830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="AHQhjqzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfJCR3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:29:10 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:38989 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbfJCR3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570123745; x=1601659745;
  h=from:to:cc:subject:date:message-id;
  bh=Mr/HQci3u3rRGYq/s4Glr5VxHGEGmVqkkQJmECKmcB4=;
  b=AHQhjqzNc2UfyZ+3qMvQ+o4JhiYWCMHZ22bWMQAPB/yT4qS/kRwkPBkz
   Iaaxy9AguSgNBP3cNOTsIiD8KRETMC3PFqjh9TgjWJCc+O4f1yr+sE0UL
   E722nB85rpdORrt3Fztv0xtV+UV7aKSkbv66wNgfGEMzW1RVMuglCnbAo
   hy3wwv+2WT6XrRIjMdIotHRJ25T55sSRXTK5sFZSi0Lr5CAsssDgS3lYj
   9ymHRC0A24Xdl8ioklwkxcCnYmpPooTYLOFYn91AeXR5MyivdOgKk6QUw
   TiJ1vk39YgjizqwgapC72VVVm++UY4ObXeuWBCh3db3ENUN0h0fbB+01D
   w==;
IronPort-SDR: 0TfxothWkXzANr6f2vHDrfGnbPgE4y1jRaRyZ2uAKevfgSXPjjytDHA/xCL5p41caUNURz2GaP
 DeyhtGkXrP2Z0u+JqZXCBSXlKleZYiVixQbPrWoFVDkDNg1OwIJeIftbeYQ0RvuaU3dIpLExCW
 KvQLHP8DC3tooBBsZ3MTjk+omWXmGqknMLXEFemOH2aiqXwC2Q27yx1KxNCypo9VYv5gsCySwd
 iz8HYl0/GzN7swpAoZO1mVYDx++jB2735GekhUheVjJhlpT8VjuVPY27f/8UMSGV9Q2OCMWRBq
 unk=
IronPort-PHdr: =?us-ascii?q?9a23=3ARk4yEBQf7v5kir4P4dqbeiUtO9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69bRCN2/xhgRfzUJnB7Loc0qyK6vumBTxLuM/Y+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLucQbgoRuJrssxh?=
 =?us-ascii?q?fUv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4O5bosPFPEBPeder4nyulAAswKwDhSiBOPu1DBIgmL51rA+3+?=
 =?us-ascii?q?kvDQ3K2QotFM8MvnvJttX4LKccX/6owqfGzjvNaOhb1Svh5IXSbhwsu+2AUa?=
 =?us-ascii?q?52fMHMyUcvDQTFjlCIpIPnPjOU1+QNs3Wc7+F9Uu+ui28mqwFrrTiu2ssglo?=
 =?us-ascii?q?fEi5kIyl/Y7yV12pg6KsClSENiZ9OvDZhetzmCOodoXs8vR3tktSU6x7Ecp5?=
 =?us-ascii?q?K3YScHxI45yxLDd/CLa5WE7xPnWeqLPzt1inJodKihixuz60StyOLxW8+p21?=
 =?us-ascii?q?hQtCVFiMPDtnUV2hzW7ciIV+Vy81+62TaKywDT8uZEIV0olabDK54u3Lowlp?=
 =?us-ascii?q?0LvETGBCD2mUH2gLaOdkUg5+Sk8urnbqv6qpOALYN0hQb+MqMhmsy7H+s0KB?=
 =?us-ascii?q?QBX2+e+eik1b3j+1P2QKlSg/EojqXUtIrWKMcbq6KjHQNZz4ku5wyhAzu6zN?=
 =?us-ascii?q?gUhXwHI0hEeBKDgYjpIVbOIPXgAPa/glWskC1kx/HaMrH9DJjANWXDn6v7fb?=
 =?us-ascii?q?pn9UFT1RczwchF551IErEBPO7zWkjpudzcDx85NRG0wun+BNV+yIweQ2SPDb?=
 =?us-ascii?q?GdMK7Jr1+I6fwgI/OWaI8Wpjn9Mf4l6ODqjXMjnl8dZ6apjtM5cne9S8VnMU?=
 =?us-ascii?q?WEZjK4k8UBGGZS5lEWUefwzlCOTGgAND6JQ6sg62RjW8qdBoDZS9Xo3+SM?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HdCgAaL5Zdh8jWVdFlHgEGEoFcCwK?=
 =?us-ascii?q?DXEwQjSSGLAEBBosmgQmFeoMLhSiBewEIAQEBDAEBLQIBAYRAgkgjNQgOAgM?=
 =?us-ascii?q?JAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAQgEMAYFqKYM1CxYVUoEVAQUBNSI?=
 =?us-ascii?q?5gkcBgXYUBaIkgQM8jCUziGYBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEKIM9gkQ?=
 =?us-ascii?q?EgTcBAQGLPQeJZ3CVYgEGAoIRFIF4kxQnhDyJP4tEAS2MEpsdAgoHBg8jgTA?=
 =?us-ascii?q?BghBNJYFsCoFEUBAUgVsOCRWOLiEzgQiCc41iAQ?=
X-IPAS-Result: =?us-ascii?q?A2HdCgAaL5Zdh8jWVdFlHgEGEoFcCwKDXEwQjSSGLAEBB?=
 =?us-ascii?q?osmgQmFeoMLhSiBewEIAQEBDAEBLQIBAYRAgkgjNQgOAgMJAQEFAQEBAQEFB?=
 =?us-ascii?q?AEBAhABAQEIDQkIKYVAQgEMAYFqKYM1CxYVUoEVAQUBNSI5gkcBgXYUBaIkg?=
 =?us-ascii?q?QM8jCUziGYBCQ2BSAkBCIEiAYc0hFmBEIEHhGGEKIM9gkQEgTcBAQGLPQeJZ?=
 =?us-ascii?q?3CVYgEGAoIRFIF4kxQnhDyJP4tEAS2MEpsdAgoHBg8jgTABghBNJYFsCoFEU?=
 =?us-ascii?q?BAUgVsOCRWOLiEzgQiCc41iAQ?=
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="80465613"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 10:29:03 -0700
Received: by mail-pl1-f200.google.com with SMTP id f8so2169228plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7xuYVaL6kMkVdyoXuZH4xe6VghxajLsnhwu8EUF2ekg=;
        b=g3fXJ7mHA78bTmyoi4z/IIoTj4FmcHL2235+LeWeNz9oySobqrZCKoDytP+3z+IVsy
         TMaAA86Dw1F1zirzTSZ7c7Ta8fMrhsEQoUeJGNWF8LyjxoQhHenbjxP1BjYwYiDyOOBm
         7bVMSjscO7R1QQhwVb+eFq4BkKu1yMqG/fh2sjM1k81J1Nidq9TY5RVX/V0dmwTgsYTy
         tZxBwLsmdU605HGgv2RhOygpcraM1QsG0H3u0MSSHTvNqO01zgWBO5H3FZiE/RwEjjKD
         FEs7341kGNVCSUqP78fjNsLpMvUPmROAf/QrXpkAXCVRWU3pyG/rBSuaI2YZs7/IA5NU
         L/Dw==
X-Gm-Message-State: APjAAAVSau8Q9GuL+TeRRSYMW841Wiqmtzxw5Ath7bhutHPM0zUUtNM+
        7P0jaHuxIGlMJ8EyhPqmm3AqCYaE75HuZaSzhI9eSLxUE7k9Hv1pykP73FlKOAdnz+SmWL3PlfK
        qczJZFmnkfH3ubnJPzGkGmB1u+w==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr10426926plz.313.1570123743271;
        Thu, 03 Oct 2019 10:29:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSfAqTaew0JD5ZU0+Z9NkYE4T9Dt3wJBWjJZFhmQ0ZxSZ4KisCFXx7oPCag5yPjJxnTPRSIA==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr10426899plz.313.1570123742854;
        Thu, 03 Oct 2019 10:29:02 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id c62sm4638873pfa.92.2019.10.03.10.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:29:01 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: max17042_battery: fix some usage of uninitialized variables
Date:   Thu,  3 Oct 2019 10:29:48 -0700
Message-Id: <20191003172948.15834-1-yzhai003@ucr.edu>
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
index e6a2dacaa730..b897776a2749 100644
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
+		return;
+
+	ret = regmap_read(map, MAX17042_VFSOC, &vfSoc);
+	if (ret)
+		return;
 
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

