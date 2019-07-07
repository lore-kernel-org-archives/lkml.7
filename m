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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C060C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D922063F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoY66fPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfGGWzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41846 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfGGWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:55:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so14875261qtj.8;
        Sun, 07 Jul 2019 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=LoY66fPYg85t4te8HoRiEMV8k/UF0/LgrmlMvqgOP6TN3TGIHJG3DqxlAu39/lfjkm
         st+MwJPZOlk6cgpch6Z9Ox6062BTKeXGnJzL3JafprtU//PxlrLKO0ZEv2ca8ibhmnzp
         /27csEff62SgvpvdIRD0Nd0uskg/VEzZd07LCB1WKZT2ApKOfDqM+0W5GclBNczMdX+R
         w4cThhfNwCT6x0L56lcBQYcobJ9iDF2vLnTw0eF1olwL02kenta6k2Jd259qqdJK01r0
         mRQMpobURWPX0fwjG8gFRtXWZSZe/sTgz2j5gLwgZWjHzFqtNMOGvMbavXFmXBA/4Ldz
         dcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHY/PWsCS9Gy0qH6S2V8hqONNTeRxBp0T3nKwM2El6E=;
        b=P6NpoKZv1of743kGHFELGlm6mXYiUWk5/3Oi2xxiYifGpZYj88X8ob+v7gSdsCG3Ql
         fSVvqk+xtaHCKTBCjmZtuPpOKPxwlr0kj5qwGzTkEXjbjzUiiG2wzJzLUj/fOYCzsghp
         ZKuGCDd4RyBwZw1TUJRyzmKW29sGfc6aGsawQxxTE3KUzQsHvxz+2Ofkus1VrbSgCyvD
         dPtP9ai4tYTSHpaygJBgQvMy+aQQ6u/4rdPjdrZG67F4URjzhDM9PxIrbTGM9IG6Iel5
         yDgYopklyfiIqnFRtFGFt/Zvdi3orWpvgzRMsBHASd3aqN7J6kguTAxL2cQUccMm7Pa7
         93uw==
X-Gm-Message-State: APjAAAXxxqW5JboyNvE32w0kMgk4NvuBn83tomawikrkq9hMUq3DAcCN
        ipOpI03kshgEi7qJUuBO0+0=
X-Google-Smtp-Source: APXvYqw/WGQ0N9MsVr2DCMkQftNGPnoGXYo4DNnFAxlqO6MhkC6Lw+1eAc68if7pbMucvrK0BXSBRw==
X-Received: by 2002:ac8:f8c:: with SMTP id b12mr11853475qtk.381.1562540103482;
        Sun, 07 Jul 2019 15:55:03 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:55:03 -0700 (PDT)
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
Subject: [PATCH v7 06/13] memory: tegra20-emc: Print a brief info message about the timings
Date:   Mon,  8 Jul 2019 01:54:17 +0300
Message-Id: <20190707225424.9562-7-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot print how many memory timings got the driver and what's the
RAM code. This is a very useful information when something is wrong with
boards memory timing.

Suggested-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 85c24f285fd4..25a6aad6a7a9 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -368,6 +368,13 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
 	     NULL);
 
+	dev_info(emc->dev,
+		 "got %u timings for RAM code %u (min %luMHz max %luMHz)\n",
+		 emc->num_timings,
+		 tegra_read_ram_code(),
+		 emc->timings[0].rate / 1000000,
+		 emc->timings[emc->num_timings - 1].rate / 1000000);
+
 	return 0;
 }
 
-- 
2.22.0

