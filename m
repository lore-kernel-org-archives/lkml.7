Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82D2C5B54D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB677208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtr7dxkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfF0VMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:12:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40809 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfF0VMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:12:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so3802876ljh.7;
        Thu, 27 Jun 2019 14:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+zsYLd/TxuJoQ7Gjrs2QtHMuA3Aa0hLQXOLsKMrZQo=;
        b=qtr7dxklHonkJZ1eb3ockr/ATk09g12g1kGfBu4TBlvy3yVSJSAUEjU1kaTWAv2UZP
         0uIaWw6lxlDY3Tuhm7NGYPzlDVXr6u3IEZ635JGiLBCLZ1SrzjnvhTrirSlNrk98P6iU
         UwLfpR2UIn1zOAVliyR8STdQZk3gQ10zruZInn9dUT6yr0KfCrH15vetUDESbeS3X94v
         ydL1KI7Wjvjl7FTVoKP6btwIw1ONcFMjqKzQI5yKwrMor+eY0e28TJDGaPYl0N6AAe/P
         qaSh30zfkQaM3PiWorbpYFhL+wQrp8hR4lMDMnvWe7XGAp+5EqvP1IZKkJL9/tb5nRJ3
         G7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+zsYLd/TxuJoQ7Gjrs2QtHMuA3Aa0hLQXOLsKMrZQo=;
        b=p0VWKAmFGPjLW7XCe/4096qG4I7E90GWG++QUUuW4G+KmZacyyhnUWu2dKtFke0WRe
         iOmIFH/0IaIjj7jatViXEVJi8e/3bxW7iZ2+DzoYkJ5FVGp53YdHUYRFGDe10ijo+yx8
         /mSIhBiz0ZyEnxPg5n8D96GYeaH2aSKdYmkKDG2ky0hncZNWyPuDFDE9pq4nOnAVY6DX
         I2iYNq/+D0Q5HUQH9nSTEgUQHwmSjrfhp78gXSOTK7jLxiFjbJthULjKNOmjcnKK5Xr4
         7rgojK9BUdBaLz489lrDYZ9BwV1e/+dFi+PV8wrSSgnGLiXTl7OLWhiNvplNmkMfCy3i
         sBlw==
X-Gm-Message-State: APjAAAXTd3NhdzlUY0I+xDTzb4eiVmgb8rpJkd7GWtrEthutUSb3zkxw
        pcPOYlHnDEtnu9w0CnGI6G4=
X-Google-Smtp-Source: APXvYqz/f0ZLpI2TCdOZHWCUq/4j/WpoUYj+Sf28qq3pVuPP0enr+VdJ/AgbAqEvSaskPub7xPH5Dw==
X-Received: by 2002:a2e:8e90:: with SMTP id z16mr3998487ljk.4.1561669957063;
        Thu, 27 Jun 2019 14:12:37 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/22] PM / devfreq: tegra30: Constify structs
Date:   Fri, 28 Jun 2019 00:11:06 +0300
Message-Id: <20190627211115.21138-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify unmodifiable structs for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index ecbd58504cd8..d3e117d827d2 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -106,7 +106,7 @@ enum tegra_actmon_device {
 	MCCPU,
 };
 
-static struct tegra_devfreq_device_config actmon_device_configs[] = {
+static const struct tegra_devfreq_device_config actmon_device_configs[] = {
 	{
 		/* MCALL: All memory accesses (including from the CPUs) */
 		.offset = 0x1c0,
@@ -171,7 +171,7 @@ struct tegra_actmon_emc_ratio {
 	unsigned long emc_freq;
 };
 
-static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
+static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
 	{ 1400000, ULONG_MAX },
 	{ 1200000,    750000 },
 	{ 1100000,    600000 },
@@ -210,7 +210,7 @@ static inline unsigned long do_percent(unsigned long val, unsigned int pct)
 
 static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
 {
-	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
+	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 	unsigned int cpu_freq = cpufreq_get(0);
 	unsigned int i;
 
-- 
2.22.0

