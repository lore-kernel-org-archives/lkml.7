Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380AA206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn0QN+NP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfGORgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:36:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42809 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbfGORgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:36:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so17106778lje.9;
        Mon, 15 Jul 2019 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Izt+ifnTdXDEdpjOeoavyKG1OamdhIvLqFqLmRqtdBw=;
        b=Dn0QN+NPAmGj7e3TS5cEs/Sd6D8+yQfObWTSqfbum3gsfER6MPh3aKVowzKQTv6SVd
         LCzh105qCcsYb9PLaZeKV1bK5T27h+1kptY1DgFu4noH9Y7RQWRSOnVXTKvDooE0BQIA
         xH1UJvWwwhEQf7p/27hp4//xUMze21b8rdRwa3zqoWyigx/ZVAWvzlOmqzRdpAwDSxYN
         NBWBhVrVWExWlbWdNCBNCh2DHaExwx4MT1DLuHmxyCA3YleSzkU68rATALa+YSn/XokC
         +/amsCsLc8gaDnSfZunMCQRPUJOXEj2w1Y+1rgdC+VDSeIzl93d7ui+WbbJ+L6Z6Lxtc
         sr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Izt+ifnTdXDEdpjOeoavyKG1OamdhIvLqFqLmRqtdBw=;
        b=seyiab0lLdIWA8jJ2P7Abm9iCx+c8xopIdbYERbmj4uuDv6mg2neg3+Wm/OWeCVxej
         XdQaDzkWRAcF4NzMXJ4V0lEYLxB8o+n8ROwxDguLMN8Oe0BWiE/rmWIglvXdNC1ANDoP
         ge7AcOGBnJZyfa4JunaEJtH6rSffXkbb4xnEU4I2D11wf0c+DDtdEU+pABJIZQ5+zmfq
         +tpM1JEk2fBjEhIPXKpya6K0K/s52hhwGusxA/2prG0oFVax57DoLDeSRgehF+3L+0GT
         zcTiZUSID8JGFB8P1wMIhUoj8oTNxLWZ8HZPpbxZR7GFYmD2VhCD3oVMGv3u0dwvih4d
         U7YA==
X-Gm-Message-State: APjAAAUOSOyr0Fggl4Ek50/V3xWymXaejyyGrc3R8UdcuGMAmeqT6HXJ
        De9Hoq8gxXKBWF/QEnsoFoT/9g0K
X-Google-Smtp-Source: APXvYqxpvqvI0+jk9iLbgqR2x/SuIW6p0cd6GajffhStu1ZAxQkb7D0C/6AxPUCMlN4UK656Ra4/KA==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr14359695ljk.154.1563212171248;
        Mon, 15 Jul 2019 10:36:11 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id o8sm1869131lfi.15.2019.07.15.10.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:36:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] clk: tegra: divider: Fix missing check for enable-bit on rate's recalculation
Date:   Mon, 15 Jul 2019 20:35:26 +0300
Message-Id: <20190715173527.5719-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unset "enable" bit means that divider is in bypass mode, hence it doesn't
have any effect in that case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index e76731fb7d69..f33c19045386 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	int div, mul;
 	u64 rate = parent_rate;
 
-	reg = readl_relaxed(divider->reg) >> divider->shift;
-	div = reg & div_mask(divider);
+	reg = readl_relaxed(divider->reg);
+
+	if ((divider->flags & TEGRA_DIVIDER_UART) &&
+	    !(reg & PERIPH_CLK_UART_DIV_ENB))
+		return rate;
+
+	div = (reg >> divider->shift) & div_mask(divider);
 
 	mul = get_mul(divider);
 	div += mul;
-- 
2.22.0

