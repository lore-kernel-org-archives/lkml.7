Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E80C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E010821849
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuNV8Hdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbfGWDOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33431 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbfGWDOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so39578447ljg.0;
        Mon, 22 Jul 2019 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=CuNV8Hdw+9zf3zI3zlzrrhOnuZ4XGt7/elGPavigfNAp374wFoS7hJY1NYKL9N3MgY
         U98XYTAd0e/VDxJaLZ1zAz1VLMrnsAnhtiRB3dMUntbM4V7B9WgFlp73XRzdc8g0SAVV
         W9rXGFlSwvYT0Q4ERxMdiJJZX/+X8STQBl66B3fIyIg07Hqg3yKBfR09Z/FTeDxAIorv
         B1RJaljDWId6BKQI3NU7ekhK/rcBNHPIVY8V3BmHBkulUCx2iGh7l8W8s1o+/EhC/u8x
         vSY6L2rWRKD3MuiZbCsA7SCuU4tupy6UsvdoVr8XmNWvnA39jhhx00dwnPi1oaJwhGru
         feRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktJdYx+oayM5XZOYipi+WOTUfNybPIUthW663QchIPc=;
        b=m6aGBy6r1m7ZBor77hABRXDiZ+QmzbOU+CAV6tlz38KiGKTYTl67FTHtCkRVwpqddZ
         yj6DTqKlMIHmhIuC+Fjj6XxKfVBsKfvuVkAOWclrAZga+36itkSioInZYBu/iWLust8s
         nIeLAz7X9M3Dun4c2geSvdWAQTAGeckJbagDUvMYzbWEzGnuQtVsGzxhFsKZ+p2zKB2v
         EC3cPmJybyVHR9GvLNM9nR/rpK2QGzshMwoBJEy8cwBshjYntw5ogzCAKUkNAOUS0zlr
         siIKvJ6XZTEFuWWoHqVq4e9gczOzQWA1izBW6wRhyVL5Tw+/scpDVp75Q3z+rD+EytL1
         8rrw==
X-Gm-Message-State: APjAAAWcyyuWZAPrH9sPjuAjBX4Vy65yJj3+Y5SHCoGjoumaRhSaBFXW
        L3ArGEcwW/8akNR1fm1dK24=
X-Google-Smtp-Source: APXvYqz1iuxSxSg8JCsWKR1D4x7xabXEzoNqNZ6N0ayn4xCf8AGL1sJ0KJwEVQV5/AXvGO3WNaaDUA==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr36324252lji.206.1563851660967;
        Mon, 22 Jul 2019 20:14:20 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:20 -0700 (PDT)
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
Subject: [PATCH v8 13/15] memory: tegra: Ensure timing control debug features are disabled
Date:   Tue, 23 Jul 2019 06:12:45 +0300
Message-Id: <20190723031247.31932-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 43819e8df95c..1bad7f238881 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -657,6 +657,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 410efc4d7e7b..cd52628c2b96 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -30,6 +30,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

