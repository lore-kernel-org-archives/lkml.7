Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA65C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226F02081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="1Ky2bLiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCHGPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:15:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37732 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCHGPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:15:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so13362018pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 22:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2BtCeDNCMKmjQDHmILFDyZ6PlUp38CHBYfdR2ytXWus=;
        b=1Ky2bLiSeNxhJMls0eSzd5SNvgxyZzIFfv3FRkJKgBchnyDEBkiOqIPUJwBIlhG2qm
         PTh52CNOptFi/zKwuSM15Na3bnmVG79PE9HudV1+/PNX8dCiV7IwCVi/ibk7c0/vod0j
         dTeXtStPlKkCkgvMT2xdZ3d/3Ymef5ELR+kbdKuI2TPYgMdlUgSvTz7NWLjd7Apr6VWC
         E2v6AO6nqp6lKus+kBE+vT9HDp6Q5PE4I2S+amEluNpZi5HG435GlfDKvPVr/DK2UW14
         SrFGufwcecvM0bfi5jNCqUfwMEODnS/NaUyswUNClQu0AWwjh9qCatOBRalgYGNPxL3V
         9eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2BtCeDNCMKmjQDHmILFDyZ6PlUp38CHBYfdR2ytXWus=;
        b=HigDC/ZBpvUWJC4XzuBIWajoPGrSXaZ0nHesXn/ll0yU27RbWkMLYYklPjf0kTyrYJ
         74scppxpqZqiuvhxLDnoP0fNpCVELHOaO8wdV4h/4KNX9NYzqv4oN/il7Y+ryGHf6IG2
         LLKDgau2psDijl3NLhyBzwNWZFxCoUULO8DBKhLlpmlakkvAB/54h1zMP8HXeLOMzpiI
         lPJOtEBLtZDNIc+dsAG/LTiQGdXd42v+q5b3u0Go8R1IcH+0+pObSkjY07I7bpQyiNqo
         yJUJsJ6Lge6FYHUCxQY1KlzLZQG6OUaiR8pYJd9hbB1EA4UlN4zf6MuAvH0P4G+IucrG
         1Lfg==
X-Gm-Message-State: APjAAAU74YtcZrnXJizdjxkA8gpXZl0FGiUsKlC+Jb9ofh5jZlDXvcyR
        qEgGfjseM8Tv9ZTQWREGjZ2pCg==
X-Google-Smtp-Source: APXvYqxIY2DLXiivV/BTA6JVQC6RcdrYE6JBVxQv/+BBFdfM713HxQMOeK+qN8brsKNu1Jejg2Jz+A==
X-Received: by 2002:a17:902:5992:: with SMTP id p18mr16933699pli.231.1552025743596;
        Thu, 07 Mar 2019 22:15:43 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id b65sm11484765pfm.127.2019.03.07.22.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 22:15:42 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: gpio: Constify regulator_ops
Date:   Fri,  8 Mar 2019 14:15:29 +0800
Message-Id: <20190308061529.31394-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190308061529.31394-1-axel.lin@ingics.com>
References: <20190308061529.31394-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpio_regulator_voltage_ops and gpio_regulator_current_ops should never
change, make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/gpio-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 967338bf1dc1..f50d86a66138 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -124,7 +124,7 @@ static int gpio_regulator_set_current_limit(struct regulator_dev *dev,
 	return 0;
 }
 
-static struct regulator_ops gpio_regulator_voltage_ops = {
+static const struct regulator_ops gpio_regulator_voltage_ops = {
 	.get_voltage = gpio_regulator_get_value,
 	.set_voltage = gpio_regulator_set_voltage,
 	.list_voltage = gpio_regulator_list_voltage,
@@ -220,7 +220,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 	return config;
 }
 
-static struct regulator_ops gpio_regulator_current_ops = {
+static const struct regulator_ops gpio_regulator_current_ops = {
 	.get_current_limit = gpio_regulator_get_value,
 	.set_current_limit = gpio_regulator_set_current_limit,
 };
-- 
2.17.1

