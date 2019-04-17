Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A32920693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqhSHNmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbfDQWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:42:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37775 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:42:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so213826pgc.4;
        Wed, 17 Apr 2019 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pafXGoHRoY3A9Ph0hnVkDMbF8BglHn/cfuWPvnCS8lw=;
        b=fqhSHNmQRy7y06vC6WeN/3ibyxgU8qX9OHe08A8MxJjWQcI/wUreW9AfoBVOwKkXg5
         J01KwnlgyKtGg7ZTdBJ/atOPYOaJMLeLDxsG+xwbjvHdPPfyTHO/u+/ZpY2ZvGLJC9K4
         IzawYgvu+kTRXBRhoDTRsVqFJY5AGQgAS8KXDmDQJOw7JTW8zGZcoBsEs1n1BUzQLjuO
         XfwT9EN7hihmyxpQrGpwo6beC1hnHwl9NpxRWuT9rUQ0GHFdCjNHFH0V4cDLq6MmC/Cn
         2VUcrG+gKdqNQC8fB+LaEZR+T7zjYYzY7uxl4wM85Iffi3867tUFZjyme6rUSFVfgjoJ
         ys2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pafXGoHRoY3A9Ph0hnVkDMbF8BglHn/cfuWPvnCS8lw=;
        b=UcANLHnjdoqKJhz1CfBvdr82puLbAGJQRZ1z0ar05c/iBByFVDDJ1fBKhANienpEDM
         CsPf9rUJNCzA+6yPs16SxjQ1A/mXl5K2S14o+ocyEQ30RUqe4/Wq/rvNCALaJV2RjjvT
         Y3lca3Hu0fQJIPygAjquq5ADobaYXqlk6moMET0MHctrEmk1S40re3mDAYYx6TTAnksw
         KiVUG3O5Y9l+I4ja4FuW/U+swUrLX9RRPfxPAvJQMSUB8wdNWAkWLntO268E82fsETdE
         l/jWjGnV+3jaE4WXuyvFAIOY/HJQ45uAmWjXDbLcY+mDbk08dU2XdWaGI2F9qzKXltsg
         GGnw==
X-Gm-Message-State: APjAAAUrUYAhNorcEx0r3eI9gLf1yOpVrRdK+BSQRa2EosaLOWU3j3b9
        Z7VuyFOZmNNL1w2Mn4WWXAw=
X-Google-Smtp-Source: APXvYqz1NF1ezLUhlkM2Vr4oOeYBbg7GWGjmBKTim7Qiq+4Q8cX3IuyIH1/ixYKCcuKByFdkG1Km+Q==
X-Received: by 2002:aa7:85d9:: with SMTP id z25mr92085581pfn.31.1555540457209;
        Wed, 17 Apr 2019 15:34:17 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id l26sm281030pfb.20.2019.04.17.15.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 15:34:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 03/16] PM / devfreq: tegra: Replace write memory barrier with the read barrier
Date:   Thu, 18 Apr 2019 01:29:12 +0300
Message-Id: <20190417222925.5815-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417222925.5815-1-digetx@gmail.com>
References: <20190417222925.5815-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write memory barrier isn't needed because the BUS buffer is flushed
by read after write that happens after the removed wmb(), we will also
use readl() instead of the relaxed version to ensure that read is indeed
completed.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra-devfreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index f7378a42d184..7d7b9a5895b2 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 static void actmon_write_barrier(struct tegra_devfreq *tegra)
 {
 	/* ensure the update has reached the ACTMON */
-	wmb();
-	actmon_readl(tegra, ACTMON_GLB_STATUS);
+	readl(tegra->regs + ACTMON_GLB_STATUS);
 }
 
 static void actmon_isr_device(struct tegra_devfreq *tegra,
-- 
2.21.0

