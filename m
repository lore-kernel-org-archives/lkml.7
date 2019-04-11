Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B292C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BC32084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLV8eGoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDKWEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:04:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38863 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKWEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:04:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id u24so5889615lfg.5;
        Thu, 11 Apr 2019 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6GANWBDVM2KX1F8CGIb5rvHRK0fnuEyNN/3002XmRQg=;
        b=mLV8eGoS9WVHaiAT/cTt29GwqAoiuaAZq1E6zRvLUfwjBRYGj08VnG8Ii7zNX2oQZh
         OSktjqGL27hacGSfZUg9pHPCM4L38IHgjy1fZod2iYvKOgrsQ24Nc5VfJBMP9dAJ2V5u
         2xAwsydlnGvWby5UlXbaLryzGyvUETYlnzPx+BZ9KkAo6kq5+GJHdKIVpvgeL5yXrjIC
         xvJaV9MX/cfALSbuYaeP0gV44hXQgX6O49/v4z633OXQ5yKjcM7tZRzVmUVANEQoSZpe
         RQrWPhNib+gLT21/96mmOyNLefSesN1TGIe/t2ET6ZyepdgZ/0kctQpgGV+mnOBA/CWn
         RuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GANWBDVM2KX1F8CGIb5rvHRK0fnuEyNN/3002XmRQg=;
        b=jmtlBxAopjkMFhoQy1oDYc6+tISBxAeXbSN346hetIZE+oiTUF+SO81nB4QDItLBKo
         sipm503HpVs6cmc7QzKoEucnT4TOMo0ReFqWC87wQd/rrtEIvDOKekGNu0hu6Gb6T81b
         9ad9E8Ec29qKvdX1VL/cTzNgltCg/FoPM1u61Q3sXMV5BSHV8WNgXIP6R0nPGy6gbbnw
         CaqrK0sLhCeM0GDReSK/l2yJmga99CUs6529wJ+zLGQ7Mim2jTIMheJWvhB/+EwwcAx6
         fiUf6v7SW+cdi/EaVWBVOxkJ/ub2bc3YDH4Nx3Q9VLfqLAhorbrwIUUZXuPUp18y+iYa
         sTKA==
X-Gm-Message-State: APjAAAWbo5pQfvZjTBv/+z0G0Zu45BCHPTgLIUuhyMiu87I6XXeYunuU
        aa+mYydqnQNpUbufJxUZmWA=
X-Google-Smtp-Source: APXvYqzMW6BwV6mmbIecSGpQekgBuTWyxqmkLx0KiSbcF9v/Xset+oMq/gGAgEfrOTIZ6ya3qCG3Og==
X-Received: by 2002:ac2:50d8:: with SMTP id h24mr27193823lfm.7.1555020268360;
        Thu, 11 Apr 2019 15:04:28 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id e18sm7887808ljb.12.2019.04.11.15.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 15:04:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] clk: tegra: divider: Mark Memory Controller clock as read-only
Date:   Fri, 12 Apr 2019 01:02:30 +0300
Message-Id: <20190411220230.21726-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411220230.21726-1-digetx@gmail.com>
References: <20190411220230.21726-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Memory Controller clock rate can't be simply changed and nothing in
kernel need to change the rate, hence let's make the clock read-only.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 205fe8ff63f0..f891bbb0d06d 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -175,6 +175,7 @@ struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
 				  void __iomem *reg, spinlock_t *lock)
 {
 	return clk_register_divider_table(NULL, name, parent_name,
-					  CLK_IS_CRITICAL, reg, 16, 1, 0,
-					  mc_div_table, lock);
+					  CLK_IS_CRITICAL |
+					  CLK_DIVIDER_READ_ONLY,
+					  reg, 16, 1, 0, mc_div_table, lock);
 }
-- 
2.21.0

