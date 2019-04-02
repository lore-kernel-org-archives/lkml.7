Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9ACC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F09220674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="J3TOJbfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfDBMOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:14:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:14:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so6485720pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+hjiJjVrhVZw3SAVj9ZfOCC0/U3RnZpABy72ZJ8DU0=;
        b=J3TOJbfweFe8K+W8o27GqnknjYSSejpv5Do2tNsKJugWxEfAR+N4TtvHoXuB4uQv5B
         mP3C7Km20wVRuGZKoo4OCj0mYcPrOTlnwHPHlYQF7BU079c3qUVJX8nyaBUjXao6trp7
         lToDq3rdNvm9HSPpoH3+BvY70ceEwXSy15U70O9FHR6q6WE3OLfAhd3igCrUXUYQpVLr
         F60nRp7Wzm5EzgKY99mqpzN1IeiNhfAW540RmuiIlv/rkeD1p7SPmZnqZuv33iYhaCBL
         mde5+YSAZ4wKSvl6ZQs+dTm8UuzRDdXA0y6BwrteOwBTfKhhC+99A0u9XLGsRTa/945D
         +J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+hjiJjVrhVZw3SAVj9ZfOCC0/U3RnZpABy72ZJ8DU0=;
        b=dxdiWT5mZfeh5AcbLwdh3iqsUZt2cStaJjVf85MtxDP2iRGrKGfeyOl2lw9zVXjduZ
         ec0oYO3JZJuc/kIOQemV1/zX4A2n3jkzhrsF0UZg7zKNJ1t1woHHVVx4mHwMdGupP7En
         MspHRArUWKbQh3647FVqg9tDT+O6WPzxn2isKVTSpJoRlSj9Wgt4yv3O6a51uHNhZHRS
         +f5wNQsRBKp5p1DeAaCMmKYAyryMu6LKa65Ex+nsMYCa2ci5Xdw2FUQgkJA0aRc5xHq8
         sra5w8IiExM8baC6YXW79m71VZG/BD9myZNlcRnptKOblxIY5w2GxM0UzZxILzcLleOp
         As3A==
X-Gm-Message-State: APjAAAXqqzK+SIbQNf3eX9ee8QaGzQJ7meAVk373tXq0uvovQvSiafMm
        lurCuXVTtbeHknrcBqaDD47pQQ==
X-Google-Smtp-Source: APXvYqwGYnVJYQpDmL354+mH4UENtiX23T5DZ4Gf78SHIB97tRsvQVXYLYM2isVtME2G0aVzs0rj6w==
X-Received: by 2002:a63:195e:: with SMTP id 30mr63276526pgz.312.1554207241098;
        Tue, 02 Apr 2019 05:14:01 -0700 (PDT)
Received: from localhost.localdomain (36-239-229-248.dynamic-ip.hinet.net. [36.239.229.248])
        by smtp.gmail.com with ESMTPSA id a80sm36928415pfj.61.2019.04.02.05.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 05:14:00 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: lm363x: Constify regulator_ops
Date:   Tue,  2 Apr 2019 20:13:48 +0800
Message-Id: <20190402121348.23477-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402121348.23477-1-axel.lin@ingics.com>
References: <20190402121348.23477-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lm363x_boost_voltage_table_ops and lm363x_regulator_voltage_table_ops
never need to be modified, make them const so compiler can put them to
.rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lm363x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index ebec91b55ceb..e02fdd1dd092 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -82,13 +82,13 @@ static int lm363x_regulator_enable_time(struct regulator_dev *rdev)
 		return ENABLE_TIME_USEC * val;
 }
 
-static struct regulator_ops lm363x_boost_voltage_table_ops = {
+static const struct regulator_ops lm363x_boost_voltage_table_ops = {
 	.list_voltage     = regulator_list_voltage_linear,
 	.set_voltage_sel  = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel  = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops lm363x_regulator_voltage_table_ops = {
+static const struct regulator_ops lm363x_regulator_voltage_table_ops = {
 	.list_voltage     = regulator_list_voltage_linear,
 	.set_voltage_sel  = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel  = regulator_get_voltage_sel_regmap,
-- 
2.17.1

