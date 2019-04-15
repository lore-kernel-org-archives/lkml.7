Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2461C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn7ta0qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfDOOzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:55:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34465 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfDOOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:55:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id j89so15964494ljb.1;
        Mon, 15 Apr 2019 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBA/ZMY4L1vdrvxaRh3YG36Kn12w5WQabTbSgaahxao=;
        b=Rn7ta0qn5pQd5j80L2NNfiOt+0m6Zj80jOQHk5lwAxmAav+AbUH2/UzHPCzB01h0Iv
         GGJTr2SDrGqvs5cql3+Rb987+6/0xRTkTVulsPCScXC5DCSGpmEAi1CUTS1ZFCD6ia9Z
         GVux8cGlVapwr4dg+aoIV9i6WGwta0KQRWaGiej3FJBCMwpICJN4k/8vYpiNewZ59f1f
         HonkkUFlXKszkxaiXsaJ/USOin/zPzO6tCMZbun0HQSjpS0mvykZx3Hx+Cx6QA2Rbvbx
         6wV2Sglltm6ouWZs88AhMjmuzumUBGrUq7JJk0S2hX9YjOFLfy7OnlK+qdVh/5i5P1D7
         yzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBA/ZMY4L1vdrvxaRh3YG36Kn12w5WQabTbSgaahxao=;
        b=EF8W1vrjXQoXB6+cVtOXI0HpkMfC7OIlPuhBGzE3pIkGuWMw7nlEm23Q8piEBc9HN2
         /JQ2EDjRgv3eyhAQ+ycYXNKsJsFfPVw3ysSl+bGHN8m95yPBrcKDAcFA6upt+jcLxVSg
         +pc5Dm2DYHWALfeR35dyUXWZm5ccgHmrmIdhmTOZ4U21Pe6ZBEHbXDJc9oHNZSXSuWcl
         IqRsSCOu61EjxaZVxVepLFK0z7O3Kthsi/Mq6JyNxz5+EJxpEow0RP2SYg5eRYry9noE
         OAQtOW5s2YXvJYhmOmyKhtwyGJaJLqlZrnDxWML3BFx5wd19WlyB9shGi3LSx9PQopyQ
         AYQw==
X-Gm-Message-State: APjAAAUB99MbS86K4fGmKOiwapKf5MyP2vOIoedrfNt3OA0iLAL+VNZo
        x+ScJZq6T+GOh8gLp9hNl6U=
X-Google-Smtp-Source: APXvYqywHld9ZlUmtrLWMCsLR4OVnsMP0M+g0xZ84w60ykIGleHwsIIMBhB0hubRrF5IDOBbCPCECQ==
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr20937235ljt.148.1555340136896;
        Mon, 15 Apr 2019 07:55:36 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l12sm9989932lfc.61.2019.04.15.07.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:55:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 02/19] PM / devfreq: tegra: Replace readl-writel with relaxed versions
Date:   Mon, 15 Apr 2019 17:54:48 +0300
Message-Id: <20190415145505.18397-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415145505.18397-1-digetx@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to insert memory barrier on each readl/writel
invocation, hence use the relaxed versions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 02905978abe1..0c0909fba545 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -191,23 +191,23 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 
 static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
 {
-	return readl(tegra->regs + offset);
+	return readl_relaxed(tegra->regs + offset);
 }
 
 static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
 {
-	writel(val, tegra->regs + offset);
+	writel_relaxed(val, tegra->regs + offset);
 }
 
 static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
 {
-	return readl(dev->regs + offset);
+	return readl_relaxed(dev->regs + offset);
 }
 
 static void device_writel(struct tegra_devfreq_device *dev, u32 val,
 			  u32 offset)
 {
-	writel(val, dev->regs + offset);
+	writel_relaxed(val, dev->regs + offset);
 }
 
 static unsigned long do_percent(unsigned long val, unsigned int pct)
-- 
2.21.0

