Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D13C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D75218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="IeurD74d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDLOHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:07:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45323 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:07:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so5175134plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=O3evRTcozZ41uzbbaDbrD9A98dQu8Qti1LdaNPG41+8=;
        b=IeurD74dypbDdFvzkX1N93UTsvQvgFEYZmu82XvR1cVGIWFoIdURTr/tTK7qPp3WLZ
         W2HCxQq8CKZqCYFZB25bIyF6/lHMymbUh9FcdujaovwCCTTRSoABXgbJL7KbX7U8S46j
         uy28xy2WDf8UIJKAMrfpni/+BBdt6LoLk02AGqVrsEcGcgyOUPHp4c9FMTAzn7oX7+o3
         jKH2vVZ8bfv6Ha4v+15IV+Q/Fl+XBBFw6v54DJtt4Xbbay8fA8Mj9zVvEc6t3s2bAclZ
         HmjRx+Mzx+32E0pvnuDRuqHpY7ZFB+BFbR8a3Po1gjrxsRdQCD1DpstIdouF0cfBQf1h
         Xq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O3evRTcozZ41uzbbaDbrD9A98dQu8Qti1LdaNPG41+8=;
        b=deqVtw9jx79s0Qb61NHVyNxqM/zes3QUg924IVqDel4mkAeHHKD1TLKpARKMSUKzFD
         N/rt463uE58tAcLw2npS7ofj63VcGsXwex5OtWldkFoAl7F/pPwk4qe/9XJ2hgBkydGG
         qkf4gf5h36jMM7iPerkgGbofbGnSqlbnnlz1G1jPOAwZNLzGfT4GgyLyrXKA4wQfMzYo
         IWojBHVcBdaG6cSABkVxAB0b0Dxo0212A49Tobefhz1YoZwlKj9hZ5klymq3ZhgiEd0U
         mQiHCTWkqRYFD2og1+eVy4rgNs+BYlGC/zuaOUntuYCnIhzM0WiT1qVX82llZe10muae
         2TFw==
X-Gm-Message-State: APjAAAWxKCZe9/pvdy3vI0loZaqTr+7VdN3Pv96PZJvZ0Lc65gEAM19O
        uzyH26WJhsBXMawTgofyqyZIAQ==
X-Google-Smtp-Source: APXvYqyeOYtisWQtRISYi5Ww3FH/jXsVaASEh4KLTHI2uN9nZfkDgHn+Hc81PQa/ql/grmz0KqZ3Nw==
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr57255640pln.207.1555078033330;
        Fri, 12 Apr 2019 07:07:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id d68sm63862024pfg.16.2019.04.12.07.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:07:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: ab8500-ext: Constify ab8500_ext_regulator_ops
Date:   Fri, 12 Apr 2019 22:06:56 +0800
Message-Id: <20190412140658.11754-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ab8500_ext_regulator_ops never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/ab8500-ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 2ca00045eb99..2268c934d6be 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -720,7 +720,7 @@ static int ab8500_ext_list_voltage(struct regulator_dev *rdev,
 	return -EINVAL;
 }
 
-static struct regulator_ops ab8500_ext_regulator_ops = {
+static const struct regulator_ops ab8500_ext_regulator_ops = {
 	.enable			= ab8500_ext_regulator_enable,
 	.disable		= ab8500_ext_regulator_disable,
 	.is_enabled		= ab8500_ext_regulator_is_enabled,
-- 
2.17.1

