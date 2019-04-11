Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9CDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4512084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnBdangi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDKWEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45050 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfDKWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id h16so6950791ljg.11;
        Thu, 11 Apr 2019 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtZAJxqkYiF84xbr7exvlCrl27ojp0oQWY4kT8UdML4=;
        b=bnBdangi9STj29FectuS/aZA7VszLeetiilc3mMXgT+bATUhhjkvZPOSRc1F7zhFCJ
         IAkUqhVOvR4LFkBH2fBe16e5UkAclyqtyfcl+/VRkWXnimxqt+7KOCc7YGfFEE3/ubQW
         ZQCokjdSOH/2zSndb4gdvIfoRUxZYDuTCIsx7iQN2HFGlvFvCPjYAoND+n0M0rYhQJeF
         OgjMaRnYY0kfLyuRxN7YPmYjm1fXiT5ALEb0UNHEnvFj8Q+MRkEvKA1OqMXc2FFYK/n5
         bnxHHjOACk/VbGTzgeHIQZrz9cNaVO1/4mSNisYR5KsScvR8Ujdk2K7WrPVFaIgQSs1c
         AU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtZAJxqkYiF84xbr7exvlCrl27ojp0oQWY4kT8UdML4=;
        b=hforqc/dR6E3L5pPl31uF6CKcoE58mtsJOkBvPQw9UdyYiCWAZ7FxtDX5x+RLcar+e
         5W7j4teaT46fHKd0zMSSaMKQXOxFfnlvYQQfpgcVTz6Q+fcyoQsb/79RLzcVvs3/dCXN
         7bRNUfa9mSlg+RUf6JvXS0UsUq7lOB/zy1rlSgDQgbXKe0rNFyICNWgToHJoiChoK5dw
         gSirEOk2VMdrN5Pd8EhlUO/giB3GfsrQpe28/6E/HuFWvVJe6DXnnHQOzf1FazKb3XcT
         otkwFVsfA+/G0zBAVa7Y1XcKpQUUwHuiZuwwwc2V+RpdO7QtXcTOsNFP777NltBUtKye
         tWuA==
X-Gm-Message-State: APjAAAXTIsDPEV798g93LkSNXkmRht1nL2tkh8Zoo40BNAJKfypKlu5B
        HMFX4RK+CW/zvA9+mG2B2a4=
X-Google-Smtp-Source: APXvYqzRsUFVQtnAsJK9dwtXr8chUndkpQKBJ6lgonrIKRvRGrwSWQiarmPQmwSrfkJEumiY11izgQ==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr15084016ljg.93.1555020264745;
        Thu, 11 Apr 2019 15:04:24 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e18sm7887808ljb.12.2019.04.11.15.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:04:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] clk: tegra: emc: Support multiple ram codes parsing
Date:   Fri, 12 Apr 2019 01:02:27 +0300
Message-Id: <20190411220230.21726-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220230.21726-1-digetx@gmail.com>
References: <20190411220230.21726-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timings parser doesn't append timings, but instead it parses only
the first timing and hence doesn't store all of the timings when
device-tree has timings for multiple ram codes. In a result EMC scaling
doesn't work if timings are missing.

Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 23416982e7c7..28068584ff6e 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -121,18 +121,23 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	struct tegra_clk_emc *tegra;
 	u8 ram_code = tegra_read_ram_code();
 	struct emc_timing *timing = NULL;
-	int i;
+	int i, k;
 
 	tegra = container_of(hw, struct tegra_clk_emc, hw);
 
-	for (i = 0; i < tegra->num_timings; i++) {
+	for (k = 0; k < tegra->num_timings; k++) {
+		if (tegra->timings[k].ram_code == ram_code)
+			break;
+	}
+
+	for (i = k; i < tegra->num_timings; i++) {
 		if (tegra->timings[i].ram_code != ram_code)
-			continue;
+			break;
 
 		timing = tegra->timings + i;
 
 		if (timing->rate > req->max_rate) {
-			i = max(i, 1);
+			i = max(i, k + 1);
 			req->rate = tegra->timings[i - 1].rate;
 			return 0;
 		}
@@ -282,7 +287,7 @@ static struct emc_timing *get_backup_timing(struct tegra_clk_emc *tegra,
 	for (i = timing_index+1; i < tegra->num_timings; i++) {
 		timing = tegra->timings + i;
 		if (timing->ram_code != ram_code)
-			continue;
+			break;
 
 		if (emc_parent_clk_sources[timing->parent_index] !=
 		    emc_parent_clk_sources[
@@ -293,7 +298,7 @@ static struct emc_timing *get_backup_timing(struct tegra_clk_emc *tegra,
 	for (i = timing_index-1; i >= 0; --i) {
 		timing = tegra->timings + i;
 		if (timing->ram_code != ram_code)
-			continue;
+			break;
 
 		if (emc_parent_clk_sources[timing->parent_index] !=
 		    emc_parent_clk_sources[
@@ -433,19 +438,23 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 				struct device_node *node,
 				u32 ram_code)
 {
+	struct emc_timing *timings_ptr;
 	struct device_node *child;
 	int child_count = of_get_child_count(node);
 	int i = 0, err;
+	size_t size;
+
+	size = (tegra->num_timings + child_count) * sizeof(struct emc_timing);
 
-	tegra->timings = kcalloc(child_count, sizeof(struct emc_timing),
-				 GFP_KERNEL);
+	tegra->timings = krealloc(tegra->timings, size, GFP_KERNEL);
 	if (!tegra->timings)
 		return -ENOMEM;
 
-	tegra->num_timings = child_count;
+	timings_ptr = tegra->timings + tegra->num_timings;
+	tegra->num_timings += child_count;
 
 	for_each_child_of_node(node, child) {
-		struct emc_timing *timing = tegra->timings + (i++);
+		struct emc_timing *timing = timings_ptr + (i++);
 
 		err = load_one_timing_from_dt(tegra, timing, child);
 		if (err) {
@@ -456,7 +465,7 @@ static int load_timings_from_dt(struct tegra_clk_emc *tegra,
 		timing->ram_code = ram_code;
 	}
 
-	sort(tegra->timings, tegra->num_timings, sizeof(struct emc_timing),
+	sort(timings_ptr, child_count, sizeof(struct emc_timing),
 	     cmp_timings, NULL);
 
 	return 0;
@@ -499,10 +508,10 @@ struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
 		 * fuses until the apbmisc driver is loaded.
 		 */
 		err = load_timings_from_dt(tegra, node, node_ram_code);
-		of_node_put(node);
-		if (err)
+		if (err) {
+			of_node_put(node);
 			return ERR_PTR(err);
-		break;
+		}
 	}
 
 	if (tegra->num_timings == 0)
-- 
2.21.0

