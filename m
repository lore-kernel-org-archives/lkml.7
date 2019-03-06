Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E67EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB0F20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FYhD/dXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfCFBny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:43:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33994 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:43:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so6987704pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nNVa2+UE6ZCzuzJxfQP4MPwW+4cSSM7gLy29syfioyY=;
        b=FYhD/dXuNnM9ZO3bNR30HoUaHhSvANpRWHXXUyKkGsFa4+T+188oQuf06dwWbNl1v9
         T488BN+EViDLf/SewUoaRdRZvO5nxMC37gpxYtZyOVXrcBL8E1uFXyZ3MckfDqOf3nZP
         aQyXCvitQwBreSXwjYBGOqrAhjjxBxSuEw0YUO+4oC4IYV3xq3x3FeuJEyWgvAKDPcA5
         953islJMXBrX2aES0G27/ZzcKVj4zwl6MZ1itcWmlNgp6YzKeDM5yJnqhub/0G6xgVFP
         tWdEo2qUgZYs7DMHgPme6RDiSAfzvvxD6D2Lvym5PO2WdZhlodZn3qG3lgulook0F4nu
         Nkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nNVa2+UE6ZCzuzJxfQP4MPwW+4cSSM7gLy29syfioyY=;
        b=bKEjzup2uf8CkBtuum6KHKAaqAo2ySHvVfB/LkwuQoVbimTGo52eYocoqae6QEsnES
         EdpkoNYeRC7N0dAhdYruMSh0NRewS+SnGNuuY4QjLbLn2At7htuZh07+uGyI5n3RBKir
         uXhTlED75uPEQKE26JtjY37iM1QzlAfn5DkD4MGDMDEVH+7TbPuHyMO3g/m0IoLv6Y40
         Ex0cyhMe6WUtoxDFN2o3fuvvbdmTOkWfGymZzpxo5MVIPhe3m9xsr9kqxI0iW/WbjVxY
         6jhMzm1dFI5ty5ZIAooYmeGSCk+5QdFp3bCuH5bfQ5uVS2dZrfjZDtkmjltC39K/bqgC
         BEDA==
X-Gm-Message-State: APjAAAW0OH8PvQ9BZ0gDBOkLuKKW1WlDFhIQu5oThe/XajMMfIja44oM
        fWmqBH5jO+mv8i8nbtiUHC13jA==
X-Google-Smtp-Source: APXvYqyRugNkm4hxq1zGsmwZbsqvwgFWaPJ80a57bcoUXQMK04T33+hl7+MLnCKyksYXuNoHVTNKhA==
X-Received: by 2002:a17:902:be16:: with SMTP id r22mr4333723pls.128.1551836632670;
        Tue, 05 Mar 2019 17:43:52 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id j14sm356665pfe.12.2019.03.05.17.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 17:43:52 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: mt6397: Use unsigned int for volt_tables
Date:   Wed,  6 Mar 2019 09:43:32 +0800
Message-Id: <20190306014332.9131-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190306014332.9131-1-axel.lin@ingics.com>
References: <20190306014332.9131-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it consistent as .volt_table should be const unsigned int *.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6397-regulator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index c6c6aa85e4e8..3e6c8d99ec0f 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -123,35 +123,35 @@ static const struct regulator_linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 0, 0x1f, 20000),
 };
 
-static const u32 ldo_volt_table1[] = {
+static const unsigned int ldo_volt_table1[] = {
 	1500000, 1800000, 2500000, 2800000,
 };
 
-static const u32 ldo_volt_table2[] = {
+static const unsigned int ldo_volt_table2[] = {
 	1800000, 3300000,
 };
 
-static const u32 ldo_volt_table3[] = {
+static const unsigned int ldo_volt_table3[] = {
 	3000000, 3300000,
 };
 
-static const u32 ldo_volt_table4[] = {
+static const unsigned int ldo_volt_table4[] = {
 	1220000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 3300000,
 };
 
-static const u32 ldo_volt_table5[] = {
+static const unsigned int ldo_volt_table5[] = {
 	1200000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 3300000,
 };
 
-static const u32 ldo_volt_table5_v2[] = {
+static const unsigned int ldo_volt_table5_v2[] = {
 	1200000, 1000000, 1500000, 1800000, 2500000, 2800000, 3000000, 3300000,
 };
 
-static const u32 ldo_volt_table6[] = {
+static const unsigned int ldo_volt_table6[] = {
 	1200000, 1300000, 1500000, 1800000, 2500000, 2800000, 3000000, 2000000,
 };
 
-static const u32 ldo_volt_table7[] = {
+static const unsigned int ldo_volt_table7[] = {
 	1300000, 1500000, 1800000, 2000000, 2500000, 2800000, 3000000, 3300000,
 };
 
-- 
2.17.1

