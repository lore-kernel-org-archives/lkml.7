Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ED92146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyxNEw6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDKWNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:13:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37144 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id o19so1570094lfl.4;
        Thu, 11 Apr 2019 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ht8h2cpLS/BSBUoBAwWrSOt2yNwGAUYfPpqEVndiK6k=;
        b=MyxNEw6KKDUlWqUxdYd99pm8Zubvd+DgFLH4iLZrki008B6YnGiO6qJl3zx6A+pLxZ
         xv2JaVg2DVUH/1+BwImVjZGNbzrTakleFwDf+ZdcnZd3tT0YmoNpMXLv+blih7KAHACj
         neLWuXfTF/U0dyrxsEp8kGuarXECZdQlAeMxRrf2PTzXLM0viKgnZZhrYoUABTrKiMfW
         cfwulRMb2Ji8kXO/Ve0hiuGikBZ1WBUoETZSNKM2koFf5ZxiDXlDGHJYVHF9xkekqhd1
         aEdfdf290cjF/+UzQelqxUpeoU4a42kt/ferpVYjIJotnlDeQBzdnZvlyriu/S+YMlFV
         NKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ht8h2cpLS/BSBUoBAwWrSOt2yNwGAUYfPpqEVndiK6k=;
        b=Xwt2P/2LJ9XHTMSbZlR1GYDPo4/zmKO8iWKU59r4juI8sTvaaDixhwHVq1j8Pew7Wy
         eab1aXyWByV018XNgagi4RXVeO3bPJe1l1BpvsQOYmb05CUaU20/K3c928yKIVI8VN2Z
         Xb9whzckgOFm0uwSgWF1f448Ui5js3qDDbbUnPtGX98uWR/VifUVouuuKVqp9wBEq0K3
         FoS7NjxqyH0PhS0QAfz+NnVH4bJobfe1PChATJfx1mipZX8AcPyM2VxIO9CDtWwHQV+G
         3VKADBnCdh/xYZtOK1v0Dxaocq3CHSw9GI3z/xuwcQcpl+wrIKRgepvlbf3C9b8g+wOq
         iF2Q==
X-Gm-Message-State: APjAAAWOMbUV3vl6nRkQhg+mMAOtpmK+Zv59t7EU6nMOq0ZO3vkZlwHj
        MDOSJ4mOfMM+4PCFqI3NMjyHHTeq
X-Google-Smtp-Source: APXvYqyMInMvqvAisVuN1BfC/RYNHivuDyQYwY68qmKhe0u2/eXaq4HwbS9QGwh5lRIArppP7GS7RQ==
X-Received: by 2002:ac2:44a9:: with SMTP id c9mr9123373lfm.68.1555020809568;
        Thu, 11 Apr 2019 15:13:29 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id f4sm7953526ljg.37.2019.04.11.15.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:13:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] memory: tegra: Fix missed registers values latching
Date:   Fri, 12 Apr 2019 01:12:47 +0300
Message-Id: <20190411221250.23233-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411221250.23233-1-digetx@gmail.com>
References: <20190411221250.23233-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Memory Controller registers are shadowed and require latching in
order to copy assembly state into the active, MC_EMEM_ARB_CFG is one of
these registers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 0a53598d982f..60474597180b 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -51,6 +51,9 @@
 #define MC_EMEM_ADR_CFG 0x54
 #define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
 
+#define MC_TIMING_CONTROL		0xfc
+#define MC_TIMING_UPDATE		BIT(0)
+
 static const struct of_device_id tegra_mc_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
@@ -301,6 +304,9 @@ static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 		writel(value, mc->regs + la->reg);
 	}
 
+	/* latch new values */
+	writel(MC_TIMING_UPDATE, mc->regs + MC_TIMING_CONTROL);
+
 	return 0;
 }
 
-- 
2.21.0

