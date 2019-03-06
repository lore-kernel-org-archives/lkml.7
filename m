Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF249C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894D2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LmoSHYkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfCFBnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:43:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:43:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id j3so6973815pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pFAjRRBj1pO2whqlwDredkFtqi/GUpNMd3ybXvYvNs=;
        b=LmoSHYkdREWgpmbE0Xc4p2vWmzrLnLMK4gU/wF+Wd3X8fIONy9pmWVqVP6cKc4y5yp
         03b+2DZKB1YUUDWSLkch9Z/2ekRaoHMi8+TJhNUfdilKRd9wC+lhvs2XxjzR+k62aoCL
         XpbhQnEv52NU5ilEUfbJ6LUa0XRFMvGPQczh4X3giFrBVWYmOnDVd8qj+AxslgYTryA8
         58+L/28h23KFa6UWP0nUMsV2SwwC/lKUfSBbAi7fIEvpv1GIOk80gwTmaIYx4x51XJLT
         p5/GU7beqNmmb3Aww2bdRHCUBpoySFnAG3ec8f8FKkC8FB7GEa0IaaJiSGjL5CBWSzlE
         Vzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pFAjRRBj1pO2whqlwDredkFtqi/GUpNMd3ybXvYvNs=;
        b=Nq4f8pnlondldZ4Z/FuYqN7REttmWJA2pkiDQrPCBsh+5ihiWqBYdtHWgraMSidXmF
         rX7wbWa0A5/DHOqB/PglN4g6trTdyZgMHp40v6DtgYHdExO5b5FN7P85u7G7ds4bXE08
         PSnnxbeJ/aBNRcDpTGZSCn1n7C/rw9E9swcjrV0eVDh+cmmVgEKM8wdFpECFs3aO+0xA
         bfExEiWpV3Gi/8jyEmUWkhJKOXFlL4mmEuiPOxoALUF8EesE6x/vkhgA5Upj+4fUO6mk
         PT/xKEP5VHe6tGIYFY7pXdA+/iHOnvFUS9wm7TYazUiQNzrth+p6hMWlEFeXNdwmZrrC
         FO5Q==
X-Gm-Message-State: APjAAAX8byqeiT4SVVOwI4kHO2umzf4lApT12YlIutQJhN8h16++nqMp
        za0feBt2RoRQ1gQbcQLT7747lA==
X-Google-Smtp-Source: APXvYqxz62QVTxyGfXAXOwFj9puy3CEO1ybL9OJygDj9ckoOcjjExEAt1dMhB0mV0k8Z83JI40O3jg==
X-Received: by 2002:a63:7503:: with SMTP id q3mr3780255pgc.98.1551836628369;
        Tue, 05 Mar 2019 17:43:48 -0800 (PST)
Received: from localhost.localdomain (218-164-96-47.dynamic-ip.hinet.net. [218.164.96.47])
        by smtp.gmail.com with ESMTPSA id j14sm356665pfe.12.2019.03.05.17.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 17:43:47 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: mt6380: Use unsigned int for volt_tables
Date:   Wed,  6 Mar 2019 09:43:31 +0800
Message-Id: <20190306014332.9131-2-axel.lin@ingics.com>
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
 drivers/regulator/mt6380-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index 127dd720cbcc..86bc332df3f2 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -173,19 +173,19 @@ static const struct regulator_linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0, 0x3c, 25000),
 };
 
-static const u32 ldo_volt_table1[] = {
+static const unsigned int ldo_volt_table1[] = {
 	1400000, 1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1050000,
 };
 
-static const u32 ldo_volt_table2[] = {
+static const unsigned int ldo_volt_table2[] = {
 	2200000, 3300000,
 };
 
-static const u32 ldo_volt_table3[] = {
+static const unsigned int ldo_volt_table3[] = {
 	1240000, 1390000, 1540000, 1840000,
 };
 
-static const u32 ldo_volt_table4[] = {
+static const unsigned int ldo_volt_table4[] = {
 	2200000, 3300000,
 };
 
-- 
2.17.1

