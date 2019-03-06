Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C500B20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FgmdzcPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfCFBnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:43:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46084 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:43:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so6978245pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7OnsGceNGqScaz7pnungyZwr4fD4y5VRmZ05HgF5zgU=;
        b=FgmdzcPq7dQh8chu4weq8GxeSsqgJBy9r8U9OtNNggxyqkbeTFWHLGf1eyCVgWP5uw
         K/7YYHCbkC89aEMS2Jdy5xmFBZHTJ1r0cf/eg8a2lG7h36SOKBxYWcpSDx+jZOUQS80c
         Za4kBSPtE7c9njDPCtWRHZSZBFTIpnaak48CPu8zJoB715259KqL0h4nqEYY97OzDsvx
         mHCY3+NmQMrMjkllcZidY2cKMrdhzE0is5+ameOvuww1s+K/POUwhCWLEOfN/nRYuXJM
         feOL96cLzeE7NferpPhBTBRnCItX+W7IzJ+zt6PIK/zkv6Oyv7MtNeVkXvD0tlFggUHZ
         0e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7OnsGceNGqScaz7pnungyZwr4fD4y5VRmZ05HgF5zgU=;
        b=rkQrgkYWhxAyumNOtxwJ6xnc5lA0vlhCF6Lxf5JvueUHx+p640TTNyJ/2stnnhJ39Q
         SRez0oKI3uzQs8W9h2smCLIBZZp6OgQ+HIjpw1mZbSddpn96i2Q8wVw9rU6HGI9p7i4p
         hx8y5PKLqkyS7UfMr+h+8O5XN4QCltbjyQwoi3yzWRURpIuZe00+FY0xtfMmzGWkItWj
         K7vexEVjnypPBnjus3z+npRVRjfuvA1ZXmf/pDKKlzr5OlcvUbLCpunOSrXToNQraark
         nIxp4QsJSbcloozTgfjxHNiAxxD060TcpoN+TdZcFjIRZynryZNbhEm9UJ9IXzD3waRH
         IfNQ==
X-Gm-Message-State: APjAAAV8uRa7ZDv2dtQmneQwa0hZfjJ8mMR57wJYdLRwHD4E5mt2rx4o
        Jnq2+ChWDNZUmB25dKqwBKI1UA==
X-Google-Smtp-Source: APXvYqx3EVQYZO8KKOsB1ss171LFcnQ+Doyin0d6eZ1OGtW0B/G+iRcE8AgGwO+77k+sJpLU/RcYug==
X-Received: by 2002:a17:902:2a48:: with SMTP id i66mr4178504plb.14.1551836624249;
        Tue, 05 Mar 2019 17:43:44 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id j14sm356665pfe.12.2019.03.05.17.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 17:43:43 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: mt6323: Use unsigned int for volt_tables
Date:   Wed,  6 Mar 2019 09:43:30 +0800
Message-Id: <20190306014332.9131-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it consistent as .volt_table should be const unsigned int *.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6323-regulator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index b7b9670f0979..25b002328910 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -118,43 +118,43 @@ static const struct regulator_linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
 };
 
-static const u32 ldo_volt_table1[] = {
+static const unsigned int ldo_volt_table1[] = {
 	3300000, 3400000, 3500000, 3600000,
 };
 
-static const u32 ldo_volt_table2[] = {
+static const unsigned int ldo_volt_table2[] = {
 	1500000, 1800000, 2500000, 2800000,
 };
 
-static const u32 ldo_volt_table3[] = {
+static const unsigned int ldo_volt_table3[] = {
 	1800000, 3300000,
 };
 
-static const u32 ldo_volt_table4[] = {
+static const unsigned int ldo_volt_table4[] = {
 	3000000, 3300000,
 };
 
-static const u32 ldo_volt_table5[] = {
+static const unsigned int ldo_volt_table5[] = {
 	1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 3300000,
 };
 
-static const u32 ldo_volt_table6[] = {
+static const unsigned int ldo_volt_table6[] = {
 	1200000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 2000000,
 };
 
-static const u32 ldo_volt_table7[] = {
+static const unsigned int ldo_volt_table7[] = {
 	1200000, 1300000, 1500000, 1800000,
 };
 
-static const u32 ldo_volt_table8[] = {
+static const unsigned int ldo_volt_table8[] = {
 	1800000, 3000000,
 };
 
-static const u32 ldo_volt_table9[] = {
+static const unsigned int ldo_volt_table9[] = {
 	1200000, 1350000, 1500000, 1800000,
 };
 
-static const u32 ldo_volt_table10[] = {
+static const unsigned int ldo_volt_table10[] = {
 	1200000, 1300000, 1500000, 1800000,
 };
 
-- 
2.17.1

