Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A32BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CF2238E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG0RtlFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfGWDOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37879 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGWDOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so28166731lfh.4;
        Mon, 22 Jul 2019 20:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=RG0RtlFd/fD4GYY8AkzYLd7WDdqeGC2FAxAjKo2AW0FRB/4avEkHThfk6z4GQutOM1
         QpeUFnajCh5lZMo5NRe0AHWio0tWlzdILoNGKbyHsY2p1252Jq8l3xbbkGsILQe1CDgg
         OOsMmBiTlFs2MZxVMIGtciHo0llUp6pcQEhzH8Qtlce++ZZiOOkItEEwmZOoBBjGyRgD
         EUdgZMpFRifUBPPBp30nAE22jLuGz96/4uDdp7wHYcdo1fNcm5POQDgb6A2qjKCc/rLV
         KvGjsJMzrV0UUljAnkvNlgJBxhQXcjBRit5BIVEfvR5jcDojVY31epNivQMmUHVvBSlt
         B/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=JHpEpYgLbwei5MSBiCbYmHoOoXSINb1Rh0h29rt+1/b1x0EAck0Hwp3QcrCnPs0fXO
         ZRgvdOo9a7b7Tz6ewwDh582ApJbzbE2+sz4bGAYSsPJpgqJYw7myKJ7eNQDQ2khufRyG
         0RZwGiW/rbdEIHbTOZ3VRBH+6KL/wTD28tsjWUMdA6XXSs62deTVcyMTxTR0Gf+V5sVU
         Ou+AJF6T+SzgzrzItjcqz6wo+DX0hyb/ywmHCNw7IfQaebzO0BRQNi7WVPZqs9dKJOnW
         F8vLShyGrLN55P8BctNkiiAhEcCrQwmt1ndQ+I9g691xmD5IIdit6m4W9tYsIh9JY1ci
         N3tA==
X-Gm-Message-State: APjAAAXTZrgTDc70hYGvqE8RGju1UA1QVWQo/0uuPYYHfgJDxs5um81k
        njysbYeMMzp6Z4I58r2Uqtk=
X-Google-Smtp-Source: APXvYqwIKVZhdCy9sGL2izfi33q17XPNIUwq5k87W9N7G2sgAXetuQTmtF5aW1392TVZmXnJXBQ59g==
X-Received: by 2002:a19:5044:: with SMTP id z4mr32444974lfj.80.1563851649955;
        Mon, 22 Jul 2019 20:14:09 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/15] memory: tegra20-emc: Adapt for clock driver changes
Date:   Tue, 23 Jul 2019 06:12:35 +0300
Message-Id: <20190723031247.31932-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now Terga20 and Tegra30 EMC drivers should provide clock-rounding
functionality using the new Tegra-CLK driver API.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 50 ++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da8fa592b071..b519f02b0ee9 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/tegra.h>
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -421,6 +422,44 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	return 0;
 }
 
+static long emc_round_rate(unsigned long rate,
+			   unsigned long min_rate,
+			   unsigned long max_rate,
+			   void *arg)
+{
+	struct emc_timing *timing = NULL;
+	struct tegra_emc *emc = arg;
+	unsigned int i;
+
+	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
+
+	for (i = 0; i < emc->num_timings; i++) {
+		if (emc->timings[i].rate < rate && i != emc->num_timings - 1)
+			continue;
+
+		if (emc->timings[i].rate > max_rate) {
+			i = max(i, 1u) - 1;
+
+			if (emc->timings[i].rate < min_rate)
+				break;
+		}
+
+		if (emc->timings[i].rate < min_rate)
+			continue;
+
+		timing = &emc->timings[i];
+		break;
+	}
+
+	if (!timing) {
+		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
+			rate, min_rate, max_rate);
+		return -EINVAL;
+	}
+
+	return timing->rate;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -477,21 +516,28 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
+
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
 	if (IS_ERR(emc->clk)) {
 		err = PTR_ERR(emc->clk);
 		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
-		return err;
+		goto unset_cb;
 	}
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
 			err);
-		return err;
+		goto unset_cb;
 	}
 
 	return 0;
+
+unset_cb:
+	tegra20_clk_set_emc_round_callback(NULL, NULL);
+
+	return err;
 }
 
 static const struct of_device_id tegra_emc_of_match[] = {
-- 
2.22.0

