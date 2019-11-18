Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2555C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D019214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uen7qFUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfKRUHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:07:19 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37078 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfKRUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:05:40 -0500
Received: by mail-lf1-f44.google.com with SMTP id b20so14913518lfp.4;
        Mon, 18 Nov 2019 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bfGeYRpAIb7Vt687NPjP6ZPCPNVBieu/nr7ieOj26E=;
        b=uen7qFUTySXP1efIkJ1D1dayy9+YWpPkb6RejWcxCsVjJwfODMnFF3axpHp9uot8qO
         kWX/wEinZELq8SCJcMTgCqMtRtXigRVG+J/cDynQ+ErfPgeU5fuuNYrHkHWEhbrX77WQ
         ZGzCZIsIMaacx4h9WciGXJeoPVUWsFIMy2IO4fdpvTwvoOadwyfC/SMxbf5J7aJxlMN5
         bi7RSFO3Uw+26DUb+3iP6JytiDkjquLOsssWxAFAh0ZafK1r/Ux/cxItKjTGFbZi+RI8
         h1KUrGBCsWCI1s3KhBCaINQaq7kWBRiBim5QTgiS5dopMYBLadoZPnXtfzx95ycYcfM9
         TEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bfGeYRpAIb7Vt687NPjP6ZPCPNVBieu/nr7ieOj26E=;
        b=W8mGNXZheC2EcDJfafBdtzWUFQX8E4qnQQcqK3+Zxs0y191Bq1KBn11qZCGdBNpR3N
         cARFc3kBjYdJr9bKCrfyGhuaoO3A0Em67hLejO1mZiWszrCU/EZ5VCQyj3HmWPSHCpbd
         vVscXs4KInTpWUeWanrPBbe4mTz59xwb2hwWklAQ2wgcp06kvIqFJwf9Fkl+Y4MPqpG+
         R8kf+Ca7q49J0kOn1o7RHfSAOZb3N6MxPlSxVnqP9xOqncmQGnRWSIJjjC6dlpytw7t+
         DtRQUUGzbE7u9F0JY8K+fLe7sFH+OiTqq9Ec7WIJRa5nJ1psszaTggmU6Kx9N5XokFEV
         ssbQ==
X-Gm-Message-State: APjAAAVnOhEXv1pOpofoo9juIJoiXu2IKWiDTr11ZJa84JlyordbBTtl
        rlNMyLlw28NieaRz+wcwH/Sa4/Co
X-Google-Smtp-Source: APXvYqxjGaEE1J26V9CzM6qhm1dzop3yORXmRLeUpQt2ugEUp+YI3ahrkxWJNyTQEP+dhbY4FYaHzQ==
X-Received: by 2002:a19:c606:: with SMTP id w6mr829239lff.71.1574107538243;
        Mon, 18 Nov 2019 12:05:38 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 08/29] dt-bindings: interconnect: tegra: Add initial IDs
Date:   Mon, 18 Nov 2019 23:02:26 +0300
Message-Id: <20191118200247.3567-9-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define interconnect IDs for memory controller (MC), external memory
controller (EMC), external memory (EMEM) and memory clients of display
controllers (DC).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/dt-bindings/interconnect/tegra-icc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/tegra-icc.h

diff --git a/include/dt-bindings/interconnect/tegra-icc.h b/include/dt-bindings/interconnect/tegra-icc.h
new file mode 100644
index 000000000000..e6b6a819434a
--- /dev/null
+++ b/include/dt-bindings/interconnect/tegra-icc.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef DT_BINDINGS_ICC_TEGRA_H
+#define DT_BINDINGS_ICC_TEGRA_H
+
+#define TEGRA_ICC_EMC			0
+#define TEGRA_ICC_EMEM			1
+#define TEGRA_ICC_MC			2
+#define TEGRA_ICC_MC_DC			3
+#define TEGRA_ICC_MC_DCB		4
+
+#endif
-- 
2.23.0

