Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ACC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728682147A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNiYyNB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfHKVBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44614 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKVBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so96561755ljc.11;
        Sun, 11 Aug 2019 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=tNiYyNB3cvyC4/QUKSMT9YOJv62sMHvGidVO5bs+dSUiBm80MlsWk8raAgygcgEIbi
         2GsgaNFFC6Ri8/ypdOAnzC/CGsGriMcRBHDKto9DW/wWuH8Vf0ttjWxL2M54jDBojL9o
         VPslXrtEQUsj8KNQUabvSkQO8ttqcyvVcXeiHwolcA9NoxlKL0/sJUPHymMXe+KdnxUK
         gyoxNAErTV7px365UsZRsV1FmAf3G3Hwjva4yGGiwfoPN13LO3gfEfwtGyxAe8yACv9d
         7M+EiVlQyJG1PH2KVGfdt5V3iCVD4Om+iTwGxpL5yeqn9gfCPJNl6nFkbt8K6fupIs5f
         BgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvMj+TSXx0caGJICPDntAoDwA9dWuEv6I6M6qTAotek=;
        b=VTmqf6sacTkvrXfifI/vvfJ1ekdUVQlQZAsQZykuLfSAPa94bRfJbAyUo6Ux+4VmNi
         gy8IKKHMul1wRrK7RfK7viSMn2V1g5UyPoeCcH1jw/zquwfnVXqP8KrxyEhd4CFfahR0
         FrlUuiogmD2Lzy7AtUQyCQ1GmNbynnZXw7TVlF/GPSdcl5iKPWg+2fl6Vw7ot6dCFYHp
         kZye4qZWFsD62P2TwydO71Rm8nMLTytaFK0F0e6k1QJEQ5JJN5Rd51vU6LnC+QjMOQd5
         zN95wlg/Daaxz67VKVdG4Bk+jXHUgviTVSnrl9QjFMxknTnqqEb9xnW6wSBTaaWcEv4a
         1nUg==
X-Gm-Message-State: APjAAAUUUH5+tgrMOWMqD063lhVgWMK15XV6AnJyde3pfCfvZ7YqGuWa
        Yy7rLp/WYYep+iNfhrFLcA4=
X-Google-Smtp-Source: APXvYqxUB9CoDk/j8AnZb9XyZOfh6AGAiD7xKQycPnMlWsyIiYYDhX1LhCa8ybbPUODLN+NiesgBOw==
X-Received: by 2002:a2e:781a:: with SMTP id t26mr17021603ljc.28.1565557290722;
        Sun, 11 Aug 2019 14:01:30 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:30 -0700 (PDT)
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
Subject: [PATCH v10 04/15] memory: tegra20-emc: Include io.h instead of iopoll.h
Date:   Mon, 12 Aug 2019 00:00:32 +0300
Message-Id: <20190811210043.20122-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register polling code was gone, but the included header change was
missed. Fix it up for consistency.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b519f02b0ee9..1ce351dd5461 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.22.0

