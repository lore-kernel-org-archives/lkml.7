Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10018C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BFA2063F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUBGN7nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfGGWzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44413 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfGGWzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:55:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so7613754qke.11;
        Sun, 07 Jul 2019 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=IUBGN7nNDIDXucEn9aZ+U8zeRM2oDKrBfFkudQ48ykLwXfvudOIpMiyJz93zd6nYsb
         cUqWcuRtEOt7NolPwRVf8AdxBvmfi+B0Stg/wnAXUrMqtWw3YIx7iWfZzaeh5VjIWQwE
         zd0AkW9yDGElNDo3+hQ3PchDq3w1PCW36T95CR7sD0Do9K0qoSa1CEE8tbkWERNbxIW2
         xVQipT2Xxxhw3R+43YiaoKIZRb1Bt1TOe6oDb04XHmBsuJG5R7y9Fqbsgbahud4bJ5nf
         g406m4zNd8JANFs8NhOqrrsx3MRl6ClQsfipfwMre/XUf1O/+AGkT5XXtmgGUWc88OH0
         YSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0shjWZR4s9zJHqVWwZPltTGcrU0R1di6AYm7h2L5QM=;
        b=gt1PjhUJBO2Mtbk8Bz1MEecOhTtHDrYRHm/badIuB4VK92RliJn5dYMv+Ga6SwjnQg
         AxnzhAivrtf1BciSqFds1J0SWvtMxPZ/kzexPCDAGPDsovKlZZIY4ObHmxL51evO/8jG
         pUpzDbLA75Kt5e2Xn83KPRf2rTBWAz0IMsUAO9O8yoNLZMxX+1F5Nd2EUFAjt4UZj9iD
         uKy3rV2Hf7VpiVCIdtbzxlvVrxhu/eOMYeJuY2ac9e8zzDJxqRbcBfe3wyrbxSRPOXdm
         kIBnUr0ESh6y9qGxjlHMu5uTefeIZeqmHeKojNKP79TWdMyInG6ML4qsKglgHQPAJPfK
         xVTg==
X-Gm-Message-State: APjAAAW3//CMBbDhXo975HX8aaM4H7gqnigpXBecH7A67JNwAX7HYv3z
        D8S9eqJDjwGcMz7PGY/2mzKnI3YZ
X-Google-Smtp-Source: APXvYqzBbkQslMYsznzArSXy9OMXsab9p3u5VC3savYrjLxtBlt2zEqYEl75dzAWLs/ECffI9fW1zg==
X-Received: by 2002:a37:a5cb:: with SMTP id o194mr12095921qke.371.1562540100879;
        Sun, 07 Jul 2019 15:55:00 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:55:00 -0700 (PDT)
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
Subject: [PATCH v7 05/13] memory: tegra20-emc: Pre-configure debug register
Date:   Mon,  8 Jul 2019 01:54:16 +0300
Message-Id: <20190707225424.9562-6-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver expects certain debug features to be disabled in order to
work properly. Let's disable them explicitly for consistency and to not
rely on a boot state.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 1ce351dd5461..85c24f285fd4 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -22,6 +22,7 @@
 
 #define EMC_INTSTATUS				0x000
 #define EMC_INTMASK				0x004
+#define EMC_DBG					0x008
 #define EMC_TIMING_CONTROL			0x028
 #define EMC_RC					0x02c
 #define EMC_RFC					0x030
@@ -80,6 +81,12 @@
 #define EMC_REFRESH_OVERFLOW_INT		BIT(3)
 #define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
 
+#define EMC_DBG_READ_MUX_ASSEMBLY		BIT(0)
+#define EMC_DBG_WRITE_MUX_ACTIVE		BIT(1)
+#define EMC_DBG_FORCE_UPDATE			BIT(2)
+#define EMC_DBG_READ_DQM_CTRL			BIT(9)
+#define EMC_DBG_CFG_PRIORITY			BIT(24)
+
 static const u16 emc_timing_registers[] = {
 	EMC_RC,
 	EMC_RFC,
@@ -396,7 +403,7 @@ tegra_emc_find_node_by_ram_code(struct device *dev)
 static int emc_setup_hw(struct tegra_emc *emc)
 {
 	u32 intmask = EMC_REFRESH_OVERFLOW_INT | EMC_CLKCHANGE_COMPLETE_INT;
-	u32 emc_cfg;
+	u32 emc_cfg, emc_dbg;
 
 	emc_cfg = readl_relaxed(emc->regs + EMC_CFG_2);
 
@@ -419,6 +426,14 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	writel_relaxed(intmask, emc->regs + EMC_INTMASK);
 	writel_relaxed(intmask, emc->regs + EMC_INTSTATUS);
 
+	/* ensure that unwanted debug features are disabled */
+	emc_dbg = readl_relaxed(emc->regs + EMC_DBG);
+	emc_dbg |= EMC_DBG_CFG_PRIORITY;
+	emc_dbg &= ~EMC_DBG_READ_MUX_ASSEMBLY;
+	emc_dbg &= ~EMC_DBG_WRITE_MUX_ACTIVE;
+	emc_dbg &= ~EMC_DBG_FORCE_UPDATE;
+	writel_relaxed(emc_dbg, emc->regs + EMC_DBG);
+
 	return 0;
 }
 
-- 
2.22.0

