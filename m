Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EB4C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620820863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 04:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fikD2paB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfCDElx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 23:41:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34135 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDElx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 23:41:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so2142021pgd.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 20:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=xZGTl0F2cLrlkk8+/4xCtlIfESSiFDF/oSjQAK4FQxE=;
        b=fikD2paB5/JU5iI0pB5h8RDhlQhkYb5V4/EKroEQThJdxcbFfBJ8LZ3CzzKRBG7hjI
         ASuyl1N0f64ayJ9w1JbdNZkwk3IE/pU3rzpuG17eoeZ+OUbZ/oYAZth6zJEUjmxBgG5/
         Nlnb8amzlOFhsUKtnf3n5YxhUEmlj0h6sl23AmbYnmZPlGWly2xloWaL0g/gy4CT626+
         uUebKMl21DKxHSevxccrL4cwPs7NnAhvgGndqdPgiTza30DUcIQnRtOOc39yUBL+UGby
         ZgfqoOisvnWj70y49HSLKDmGoPPiTRmtdsayfkRbh3vZOEuPUA6A538G0nLv3hncVqYF
         p3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZGTl0F2cLrlkk8+/4xCtlIfESSiFDF/oSjQAK4FQxE=;
        b=bhIDzApbxv6WQhToBxPgmlprWpOvYCbLWh3KNnbaEkOfKzXT5EzKfGxa2zCDWQ0GJi
         MPP84ACZB7FQ2phLQYEuwWB4wEAw/bJLe11Teu3zGcu45gGA8lqUyyO3PbinK4mGZtRI
         E0zfj1g0j3uzt6oDi4+Leu0MX8YFAaSXkbWH2rXt5QLPCSe3vbCNTmfKtdDEgCeplpCt
         Qk2BYmOC1jOY7LUKnoITjlaawZRftGK50jWAhdIFgB4cYaZ03Ts03kOeCjbuLotpFkmG
         aI3HI1KVvbEasbf+MmSPLGF7RQXC1MNAne6SV9XJnEZUrIVled3h/wrKX3o0C2Qgn0uM
         8gFw==
X-Gm-Message-State: APjAAAUx/GLQA/wG3nCtyR4mX/tHGwCVp4SbhL2qb4PinT2pPKfFNaZC
        gbdm8JF0GTrF75q6rprpJ5RmZw==
X-Google-Smtp-Source: APXvYqyz9g4Nl4nyKlOZSmiSTbymKgvdlT3bm9L/84lOI45KczDfsRLaXQ+HgJN5uqxGHdqnGchqww==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2mr18847267plb.286.1551674512352;
        Sun, 03 Mar 2019 20:41:52 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id l2sm6998984pgj.64.2019.03.03.20.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 20:41:51 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?M=C3=A5ns=20Andersson?= <mans.andersson@nibe.se>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: tps65217: Simplify linear range for selector 25-52
Date:   Mon,  4 Mar 2019 12:41:33 +0800
Message-Id: <20190304044133.3651-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code separates the selector 25-52 into 2 ranges on purpose
because DCDC1/DCDC3 only support up to 1.8V/1.5V in the old code.
Both DCDC1 and DCDC3 support up to 3.3V since commit b4c2e158a1e1
("regulator: tps65217: Allow DCDC1 and DCDC3 up to 3.3V"), so merge
25-30 and 31-52 ranges to one range.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps65217-regulator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index d84fab616abf..ada62f792258 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -58,8 +58,7 @@ static const unsigned int LDO1_VSEL_table[] = {
 
 static const struct regulator_linear_range tps65217_uv1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 25000),
-	REGULATOR_LINEAR_RANGE(1550000, 25, 30, 50000),
-	REGULATOR_LINEAR_RANGE(1850000, 31, 52, 50000),
+	REGULATOR_LINEAR_RANGE(1550000, 25, 52, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 53, 55, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 56, 62, 0),
 };
-- 
2.17.1

