Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE5921773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="kNyOIgAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbfEXKDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:03:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44702 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389745AbfEXKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:03:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so5030626pfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILSd7AgcVrNYTTK5AHOpXVLYnP4TZd4ozyOxxgxmapM=;
        b=kNyOIgAxXJ0x85UofLxl3r2+HjVJ24lHpmR5PW3aj/ztUsV44QAiF4i9YTRi1MWDFG
         e5U7KfJsRIMoWC9iaBblFqCTFEtScuOSO3lQwl9JBqbCNOBZBn/qz/etvfeiYd1w7Kgi
         J1+bvycjt8kBAUb6W7WQd5KpkzWhojj7Zo6T1ccZlD1SB2byLwQiyiBNQ14VYRsMWaK1
         4BVDpCNBspAw+HV1R9rmsEvbuVj1PbK0/WYLmhYwD93arpmexfuqNoNOsDN3MwHdEwNy
         tK8MidoA3bQivQ1yG/fkOBotJoW8XuLQGHyVEPedlEjguAZ4RdWXyIklCNgOr8rK+RDd
         KJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILSd7AgcVrNYTTK5AHOpXVLYnP4TZd4ozyOxxgxmapM=;
        b=Zi2jFYdfjNvAluhXOduVgvHtcgiLN0jOdO2MM3/vngwCF8r+nTvKAlClGePj+4SanY
         S0A2mB8dIx2nl3aoyEKvsADkX12oxvNhT1Nxtkzu4+FxZBreqA6HeFOwZh4PkvPplAcp
         qf0z5iQJvhoN9XGC6dtV1p2gWeSdM0py1ffn1zjQgZ4bsRpBxILf+nFFhSOjg8YB9dnb
         WDiJ4GEhKEZ/7zKDdI3/6AHHJVZuK/GgPEYDDN07JSp2SNkcb++gtj3kncTyZSKXNI9w
         jlWvdaCcrjV0EVPU3dlqGl/kGShRXtibn81JPzAz1MSB3gAPQl0dz9DkmSYXpITY7Nhl
         aO0Q==
X-Gm-Message-State: APjAAAXAnFu0bFrh0MxCNeQ2+6zxNo18x1HehSOtyL8An+OyILjesPgX
        sZyVU9fzajS2jNaqa/yFWrv9Mw==
X-Google-Smtp-Source: APXvYqxdCZEbu8HCYnsXCvmShwwAswxgQnR89+ps2SVDvobg/vIQT3B1BlTms7oyWVosBKSl7eWl5A==
X-Received: by 2002:a63:1950:: with SMTP id 16mr8254067pgz.205.1558692189719;
        Fri, 24 May 2019 03:03:09 -0700 (PDT)
Received: from localhost.localdomain (36-239-208-165.dynamic-ip.hinet.net. [36.239.208.165])
        by smtp.gmail.com with ESMTPSA id f29sm3126700pfq.11.2019.05.24.03.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:03:08 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Eric Jeong <eric.jeong.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: slg51000: Constify slg51000_regl_ops and slg51000_switch_ops
Date:   Fri, 24 May 2019 18:02:46 +0800
Message-Id: <20190524100247.7267-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/slg51000-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 12e21d43030b..a06a18f220e0 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -183,7 +183,7 @@ static const struct regmap_config slg51000_regmap_config = {
 	.volatile_table = &slg51000_volatile_table,
 };
 
-static struct regulator_ops slg51000_regl_ops = {
+static const struct regulator_ops slg51000_regl_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -193,7 +193,7 @@ static struct regulator_ops slg51000_regl_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_ops slg51000_switch_ops = {
+static const struct regulator_ops slg51000_switch_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.20.1

