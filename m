Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E640C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B02B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq5ZHYYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDKWNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:13:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36680 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDKWNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so7023773ljg.3;
        Thu, 11 Apr 2019 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYx1hGoCqngE7p4NfMTPeatrlHsHAzwIjVKWWgfdPuY=;
        b=Wq5ZHYYsegMEHaJSoWtN1OdM2eCjjcl3Q/lw8IM8jepd0rqytodDIuFWLPFrwE9yjn
         JauWIKNhIjMKKh8GlMp82yQRaNscIiL/DMBguvymzhn6/IbjB7OsIuSsYFtrB/euWDpU
         SYNWCBAv7lETWLt/wrK1GxucJupal6Ka1mZ+FRtz0wl4TKabmEPA7zE7Zqesm6hAOAnR
         9xPIzN3UB28Xe7WoEJ0H33j4QPn5/i5uHPK/gP4YTwQtjS1CeEUlxRsi9wvyvEB9/vJ4
         0YKU4iGS74IDOW2Z3sci94U1nKhyET4u066ZHCg2/5xqjP6cP/7MPqLr0iD+cn77PtdJ
         p6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYx1hGoCqngE7p4NfMTPeatrlHsHAzwIjVKWWgfdPuY=;
        b=I4mmEkCpbCQbBauASK+0mXSKHbU9C631LydsbSYfoiYmJBjJFD29Y7MvDs8diFPdNF
         JTYMkhIOwvR2T88MhsHwk8HZ+ybPtHwOoI9Lc1M6cC79HOJvDLx6s5UWvQkFE7B9+7F6
         aQdK3HGYkeZJsgr+Nwx2N/sSUOq2fp6eVV4Xo0nP0m46JdeGDG+fCUHkTBjjI3d2VZjy
         P3uZLAKVFnqwKWOAVZiPOELvryxIBeVyofyPD69FSV+q/QiXXUYVgW8uEYXhl6BE9bcD
         lK8gLlu3iQQSFEvl+i+yPWC4CUje/6bFQI+JAh+wl7R//EyfsYSX7nQCAJvszM9UCa+7
         Ut5Q==
X-Gm-Message-State: APjAAAX7KZKt+C/vNGPvDKHijxRG5jDHPg97HIZojIonDGoRXp7h+wI2
        ywZrewmtMBiK8TA4YVNuV1A=
X-Google-Smtp-Source: APXvYqw9Q04PNBahupFJ78kB1ckwLqWUpp0wP5VBYWGsmmENpJZYjT0mpv4BWLqK7H48I5Q34DhZXg==
X-Received: by 2002:a2e:8803:: with SMTP id x3mr27613832ljh.178.1555020811347;
        Thu, 11 Apr 2019 15:13:31 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id f4sm7953526ljg.37.2019.04.11.15.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:13:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] memory: tegra: Replace readl-writel with mc_readl-mc_writel
Date:   Fri, 12 Apr 2019 01:12:49 +0300
Message-Id: <20190411221250.23233-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411221250.23233-1-digetx@gmail.com>
References: <20190411221250.23233-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for a memory barriers on reading/writing of register
values as we only care about the read/write order, hence let's use the
common helpers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 89e463952b8a..31b47459c84d 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -288,24 +288,24 @@ static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 	tick = (unsigned long long)mc->tick * clk_get_rate(mc->clk);
 	do_div(tick, NSEC_PER_SEC);
 
-	value = readl(mc->regs + MC_EMEM_ARB_CFG);
+	value = mc_readl(mc, MC_EMEM_ARB_CFG);
 	value &= ~MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK;
 	value |= MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(tick);
-	writel(value, mc->regs + MC_EMEM_ARB_CFG);
+	mc_writel(mc, value, MC_EMEM_ARB_CFG);
 
 	/* write latency allowance defaults */
 	for (i = 0; i < mc->soc->num_clients; i++) {
 		const struct tegra_mc_la *la = &mc->soc->clients[i].la;
 		u32 value;
 
-		value = readl(mc->regs + la->reg);
+		value = mc_readl(mc, la->reg);
 		value &= ~(la->mask << la->shift);
 		value |= (la->def & la->mask) << la->shift;
-		writel(value, mc->regs + la->reg);
+		mc_writel(mc, value, la->reg);
 	}
 
 	/* latch new values */
-	writel(MC_TIMING_UPDATE, mc->regs + MC_TIMING_CONTROL);
+	mc_writel(mc, MC_TIMING_UPDATE, MC_TIMING_CONTROL);
 
 	return 0;
 }
-- 
2.21.0

