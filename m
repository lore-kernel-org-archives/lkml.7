Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9210DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFD72184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5cphJCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbfDQWkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:40:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33748 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387506AbfDQWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:40:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id h5so150586pfo.0;
        Wed, 17 Apr 2019 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQt5SyxbZBQA5PhlPjU2yH3iv3jJNAlRNNELR/55A5Y=;
        b=q5cphJCaaTLcNknoPQphcV0nu8xswtz8zVzOAHIQZFvyaeadsYryNGKxoViGHMB8vG
         tELPG1co8EOqaiCr8gk05Lfvd+EMw5Bh7fhPq+OzFLVqNGsODE72I9LcYBKzqnrwEtOF
         B/ZGt59L2bJgqFuuIRNMVwJvpX5HgcdpA1daX79qRT0ujWw5GtpuuCUe2ejY+oUe/DI/
         +D2sL6HncDHsbshy31lwxfv7hS1gj8ykCx86H5YhQBsEFNuciqgSxLnrzF8BsxRZ8aQY
         Nx1o/M/zntiC7r+phTTtbxo/YhereEWlB7B/Hv6WLIs5hnda9CxoNVHs5J9t7BFHMVqE
         Q/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQt5SyxbZBQA5PhlPjU2yH3iv3jJNAlRNNELR/55A5Y=;
        b=CjQIWyXP2u48+yp/b26qpCeOZLs1u/+iyS149fP4/gVMI37YcZjDtp7he1fuN/fWXD
         FI5CBIxS9D9nh7ZH7Jzi15e0j+ov30zGQNVb3vodSJ39Fdyto6Y5J2voN5b7MRtl86Dr
         Kifxd6hlKPQh74SX564qJEbni/1rScAZB89OwNj85Da08PrrkTGRvMOVEqW9oNrZm4wv
         5Y1EPACtabEw8vrkJOvaa8b1uZ5THrETs5tADsiiREKeZ0ifD5ZksM76Mg78lvMer9aI
         3M3I5uUcmeR6MwAcifit2qnGubK5NkfLZRFQyLoVm21GpcylgfKcSQdXFlayxfRzZzFw
         U0HA==
X-Gm-Message-State: APjAAAXC+VIbih2H7I5ntUxW8ghJ1QGJGSEIyOf0jX+8WoE3BM8pT853
        fqW+hu+OEXmVlAAWICIXSko=
X-Google-Smtp-Source: APXvYqzPy+1pd3AnQMWyzEo7Vtv0dunMOHGYZbQgTrXS/VLJW+GIvWF76kBQq3DM8gRCkJy3Kp1ZKQ==
X-Received: by 2002:a05:6a00:11:: with SMTP id h17mr44286279pfk.232.1555540464015;
        Wed, 17 Apr 2019 15:34:24 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 04/16] PM / devfreq: tegra: Don't ignore clk errors
Date:   Thu, 18 Apr 2019 01:29:13 +0300
Message-Id: <20190417222925.5815-5-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_set_min_rate() could fail and in this case clk_set_rate() sets
rate to 0, which may drop EMC rate to minimum and make machine very
difficult to use.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 7d7b9a5895b2..c7428c5eee23 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -484,8 +484,10 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 				u32 flags)
 {
 	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
+	struct devfreq *devfreq = tegra->devfreq;
 	struct dev_pm_opp *opp;
 	unsigned long rate;
+	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp)) {
@@ -495,10 +497,20 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
-	clk_set_min_rate(tegra->emc_clock, rate);
-	clk_set_rate(tegra->emc_clock, 0);
+	err = clk_set_min_rate(tegra->emc_clock, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(tegra->emc_clock, 0);
+	if (err)
+		goto restore_min_rate;
 
 	return 0;
+
+restore_min_rate:
+	clk_set_min_rate(tegra->emc_clock, devfreq->previous_freq);
+
+	return err;
 }
 
 static int tegra_devfreq_get_dev_status(struct device *dev,
-- 
2.21.0

