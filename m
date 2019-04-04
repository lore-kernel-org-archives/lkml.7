Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF30C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E732064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jTJto0ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfDDPFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40170 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfDDPFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so4234456wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MzS9le92cojNiBwsEcpVtVjv6C+c3kU/euAgZOl/ICU=;
        b=jTJto0ZXpcizm1AebWMBhu3/fxNqSf460QjW0538A70L95HJpM+9AnJafbMr6ON/1l
         A8dJ5Qz+x9hc9VetY3PqxNJoE/DfVyWPOej/Dmx/NAVmtp7NerkGZJuCSQxdjoy49fq1
         5cIR4goC1kvjh4JuprqmzkcvZBrMafLSqpqmhfz4t7GPApUmymkrx3LonXZok9smVkJC
         KpsVYIHSoJS9CfB5ZT9CgegAph0WBhUTBB0BDVPDi2CxRJkSs2avpsUDYsBkD1hQg/7O
         1M+H0+iVBAIkdScCpUGMUpcWFlM0UmsloYFJM1PXJyhDz5SY7YS0AyenqmoDXxge64mh
         4rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MzS9le92cojNiBwsEcpVtVjv6C+c3kU/euAgZOl/ICU=;
        b=o6qUSum+IBbhg25GSaX01vMdeNuYUZMit1phBkZPueHKlrTADKsAPhJcvDqSwuMy0W
         UqDLTQtqFJzoBKUJdxbKHtne+b2NPD0Yrk2+s9ALGmOBKBT9e8F6DZNq89c+f3HgZfD8
         yigjKL3iwBjZYpgk4J4zK8qCMF3fFrz2n6956/h/L9NcO+gItcktXS5s+UQYFvIVRGn7
         FIvdZmmo9aYIzZtdVypvzyPvgIqrGeMSDTrIX4CcVX4p9hBtc2+cStrLJ5S+TAFWhOEl
         HsIuiSUaJ7N6SExT15Yl/1F+PqC/d32sUwZzXbNOWr0AaZUe8Mp3M9G8HUgXvCupg2Q5
         ub5A==
X-Gm-Message-State: APjAAAXXvcM4xN0Rje/mAxo/IW7zRcw3d4jq2wpvDHOWl/zhnXJdu/qp
        TcKtUGRh5PPYzG7mowy0OyEKDQ==
X-Google-Smtp-Source: APXvYqyZfZQ4gNDAxpQZSyJGinCu8vxmTWP6jr51aQb+A4G7jVIbw9tgWcnqtl1MXVr3JQlytlUT4A==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr4838442wrs.56.1554390343904;
        Thu, 04 Apr 2019 08:05:43 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z23sm9880981wma.0.2019.04.04.08.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 08:05:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 3/6] clk: meson: g12a: mark fclk_div3 as critical
Date:   Thu,  4 Apr 2019 17:05:15 +0200
Message-Id: <20190404150518.30337-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404150518.30337-1-narmstrong@baylibre.com>
References: <20190404150518.30337-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic Meson G12b platform, the fclk_div3 seems to be necessary for
the system to operate correctly.

Disabling it cause the entire system to freeze, including peripherals.

This patch patch marks this clock as critical, fixing boot on G12b platforms.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 14aaa02bb621..3554d1172169 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1060,6 +1060,16 @@ static struct clk_regmap g12a_fclk_div3 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div3_div" },
 		.num_parents = 1,
+		/*
+		 * This clock is used by the resident firmware and is required
+		 * by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.21.0

