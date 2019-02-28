Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1082171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="C7njXfss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfB1Nks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:40:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41440 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfB1Nks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:40:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so9773810plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1p9EKkq3w7FaJD+Tlncy1PvSmx0pgivmEYulJW6Rx3k=;
        b=C7njXfssNEaRX1Q6nuBvY9xJYRhCXDjDG+2p09oNbci43kz0AzmASIu3LtBDELoA4C
         V3qLGTKx/DLlZd+nM8U7xx2bg+4/1kjIETnzQVEhjdC0qFb+4CajpQ3f0gqGjO1xy64c
         mi0ZLtaSJYGkIa02F/LHKzBQqSTgrUggY3tD0jY2nv+M1PzpjPZGzHhj/QSA+I4IgVnR
         gW7WzPCOlQiqbrOpKkX+zC3xokHBciqOR1rLknP1tKO4gMR38zze1nirQ5tnG6CMoNGY
         NidSyaLZGEPawjxWnBA0xSQTcklFBjXThk65hZEW5kdbxHGT0Sf/aggiCmMw6ZklkTFM
         miRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1p9EKkq3w7FaJD+Tlncy1PvSmx0pgivmEYulJW6Rx3k=;
        b=jPv4hTXytkdVsRHzNB/ijdCp8q909hHwS8Z7/UTHfsOBcyRo4OOxiSThcVnRHgTyL1
         iSCLRR1rZX7LJvhVnbq2hgn+gbcCP85fNYEJOpUVc0kVfccU01AnnfCmqVNd7JqkEigo
         cvm6zfwE1PcwplYsmKz2NLVXzEuTfn/NwxphS3qjrdxRjTbovRGQKSIEEvHXWW/N1DvF
         YJ4d0Z7CK2Xp0yxvQ6GIOj3h4qAg0c3IXZD/y8wd2JVN9/h+/ZMMbDq9SwazqyfiiMe9
         gPnsYQT6aS/Q+kISIrQhytbmwjVrHg9A+s+OtrhgcTbv3t935CVrmRDeeeOtaMRD1m1c
         eHeQ==
X-Gm-Message-State: AHQUAuadgQ7KpizY7LiQMHt2+EvepNMCsV4/jQjTrPkZyARqFUeKSU6Q
        kJNSNmkwNryeLK/g0JFw17T6qg==
X-Google-Smtp-Source: AHgI3IYU1XqkEENoNkHRIXWUZgk9OowBAYC6GdSPPQfnVDMhJDUgLwO5uYc/Hhc+UEpMZF5Kp/hMVQ==
X-Received: by 2002:a17:902:46a4:: with SMTP id p33mr8102006pld.48.1551361247067;
        Thu, 28 Feb 2019 05:40:47 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:40:46 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 01/11] regulator: Fix comment for csel_reg and csel_mask
Date:   Thu, 28 Feb 2019 21:40:12 +0800
Message-Id: <20190228134022.32625-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228134022.32625-1-axel.lin@ingics.com>
References: <20190228134022.32625-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csel_reg and csel_mask fields in struct regulator_desc needs to
be generic for drivers. Not just for TPS65218.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 include/linux/regulator/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 05efe2b057c1..a0b9df5f60e0 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -284,8 +284,8 @@ enum regulator_type {
  * @vsel_range_mask: Mask for register bitfield used for range selector
  * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
  * @vsel_mask: Mask for register bitfield used for selector
- * @csel_reg: Register for TPS65218 LS3 current regulator
- * @csel_mask: Mask for TPS65218 LS3 current regulator
+ * @csel_reg: Register for current limit selector using regmap set_current_limit
+ * @csel_mask: Mask for register bitfield used for current limit selector
  * @apply_reg: Register for initiate voltage change on the output when
  *                using regulator_set_voltage_sel_regmap
  * @apply_bit: Register bitfield used for initiate voltage change on the
-- 
2.17.1

