Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB6C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86232218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="an+ginnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDMHaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:30:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfDMHaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:30:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so6190520pfd.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2Mygzz2I98mxvu5zJeBoQfPyaa6XVvE6Q0AyA7pm0VY=;
        b=an+ginnRqrch6FcJJyBFqS43sRJv9esz/Ri62febck+sqJuSQhR6d6pjLgdQ9Xipak
         +j8oF9cKz7WGct8IF8aU/9hpl20FccBsBAf785MfQO1KedpynTVAFGFUnkr0xkFLvaG7
         rNjbjZIF6fmiKT4UNRC46geqr/3IPSukU4CkNWU/WqWeUTSQuxLhZd4xo5lN+yw61gh9
         pUb3WFOCfm7VzndgvMiR7+3M4p9wRM8GkHJ9n07dmxhwQ1B8kyQTh/iNSaPRMP6Nwaei
         r4M/82oNf0axXI//Mw5+GNio++V9gOo6MUMg2MYyy27f6EmHxISG+8BZUQvhKWPFTcjO
         rsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Mygzz2I98mxvu5zJeBoQfPyaa6XVvE6Q0AyA7pm0VY=;
        b=Bvo2yuJTgKyp/Bw0tqSIqDFqjCa1sPT11IyiKN5/Saym4X6EAMftIj7mIKbD1gC8rF
         TluEh+5qrKVKMSHLY4tigrqMvt4N0UwcwN9rbyQSG/3FB9UjI88KIxXfoAUnynZjNM1/
         J4iAVgcyFzI8mRFq2TuVbv3dlcmJSb4b/zYhIq9Huxs7Dh4hl90v6CcBE7tEArgu678y
         N2/f8tIvaUBqmBjTtbjy726rfZjghT3e0K/rAWc96lzRAJUkeJPKdKwQIu+aRzl3Jq/7
         JEMF6Xg2+SBox4mWVzLotceLI+F2HhzpIQFnNVi7sA5jpq7MqEfBYVbH02i5hDSblxDQ
         rSbQ==
X-Gm-Message-State: APjAAAUzZCaPrkleGqwbtIx7hU1vR/Fb0rbG7C+UI6S4zPLeuEvLdH/j
        M8/Mhj4XyMjMa4CNaSYhK13YNw==
X-Google-Smtp-Source: APXvYqzgroXewGXzBjIq7gAYPdoGBweVuSy4Axt8Oj8PeDEzlyKLfY67HLEkB7lgKRHIYzYsfVJAxA==
X-Received: by 2002:a62:4351:: with SMTP id q78mr63144271pfa.86.1555140613615;
        Sat, 13 Apr 2019 00:30:13 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-188.dynamic-ip.hinet.net. [36.239.234.188])
        by smtp.gmail.com with ESMTPSA id q80sm84418286pfa.66.2019.04.13.00.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 00:30:12 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cyril Chemparathy <cyril@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: tps6524x: Constify regulator_ops
Date:   Sat, 13 Apr 2019 15:30:01 +0800
Message-Id: <20190413073002.764-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_ops is never changed, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps6524x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 67cac2682f50..c09223c34dbf 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -565,7 +565,7 @@ static int is_supply_enabled(struct regulator_dev *rdev)
 	return read_field(hw, &info->enable);
 }
 
-static struct regulator_ops regulator_ops = {
+static const struct regulator_ops regulator_ops = {
 	.is_enabled		= is_supply_enabled,
 	.enable			= enable_supply,
 	.disable		= disable_supply,
-- 
2.17.1

