Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2107DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F07208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAZRF14q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbfGZOXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:23:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45098 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGZOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:23:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so24599586pfq.12;
        Fri, 26 Jul 2019 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=en0pvNZcM3kkSmz8hVt+Vi3uAvo2FewDy+aMfhbvUlY=;
        b=UAZRF14qLpPXvi9pHNnuQV/IcqDc5nYKJ9twIxHfUrzZPxIBa9sFMHCyCppny4w8Tr
         kvNN7W702YBcnJ4C9S0oimLwk5PYqtSujw17of0xIGjpyx37ThgNIu6e+4vGx5SO5teF
         7F1USnTH9dvIosE0fH8fbZoV8zP/lXPb5Crb8vbz2nQ8L5owpl2X0VpJsmkmHIwOd56J
         PNgg5hK0j/Cbp9zheN/Gi/tQmkaVFnwIe/W9Yo7PzNt1D6df2DSdlKjhqZO7ddfDxDo6
         L+v19zvEIAn3zmtF1xuougreky5RaoxVe3EGKUjpNY7sfB4XdItsCv7WcyWUOoJoGIcy
         67wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=en0pvNZcM3kkSmz8hVt+Vi3uAvo2FewDy+aMfhbvUlY=;
        b=NSWLKMNeaacRx9cmzzXzEOY9HMzvZ0KR3t2Rl6Vc+WhQk9GJy/RgWuV+1cA3e297X3
         WgqkiUCsOpAXjHQVNwpim7Z4nOgd6s4tZefcEQI3OL299anrM9dnkNl4kmcbjHa8IXJn
         eQN5YEhxMoCznCxzH14Lm1vIfPyfhMV+efMwwkhdYgbeUtqtZVW1QFT5ERRFvQfNjdUU
         Y9DuGw9IoFp+HR7f3ASZvTwQXka0G1oj5IkDhQ8antEujjKzI2rVXy7U4CPxp63FXUKS
         XBaflvLsANwwnjDvQ4nE+LFUWL59JoTSioIWOUoHS3bE5pnZ9nV/vWROEY/jyaN748Pb
         ORow==
X-Gm-Message-State: APjAAAWGFcRUY1BpafTnhft10Ti/wO5pSdp+VXwIp3Dj4QPCfEdoP+b4
        hj5qYeGE0fPVezZGOAPreKq1BN/KYnU=
X-Google-Smtp-Source: APXvYqwflgYhWxBQM/ZUSLNQz04HoE44wm/0LodHQNfZiB33HlkE2tRq/7pbDjKnMMHWzHnC1dO8Fg==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr64297087pje.129.1564150980639;
        Fri, 26 Jul 2019 07:23:00 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id a6sm51371671pfa.162.2019.07.26.07.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 07:23:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mmc: host: dw_mmc: Fix possible null-pointer dereferences in dw_mci_runtime_resume()
Date:   Fri, 26 Jul 2019 22:22:52 +0800
Message-Id: <20190726142252.9654-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dw_mci_runtime_resume(), there is an if statement on line 3420 
to check whether host->slot is NULL:
    if (host->slot && ...)

When host->slot is NULL, it is used on line 3458:
    if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
and on line 3462:
    dw_mci_setup_bus(host->slot, true);
        struct dw_mci *host = slot->host;

Thus, possible null-pointer dereferences may occur.

To fix these bugs, host->slot is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index faaaf52a46d2..91bd6c3ccf50 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3455,11 +3455,12 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+	if (host->slot && (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER))
 		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(host->slot, true);
+	if (host->slot)
+		dw_mci_setup_bus(host->slot, true);
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
-- 
2.17.0

