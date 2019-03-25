Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0684C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33AA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="nsuESjwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfCYK7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:59:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35356 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfCYK73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:59:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so6171190pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8a5K5Kp3coBNnqFIb9DMB5cgQbEzSbzrjPjs1y/oqag=;
        b=nsuESjwgS3KELfSb4QHC+i8dvzpwEnybfuzvCp0WUFdBjWHQIPn8oD3AYCC+yvBPE8
         Kn/u5CKnzwAXscUKOt4wnh3HMGYdJNWEZB0s+QB7lbBTn3wpzVakRcPHzN1ySMWsb15c
         ekFjbFJjWeJinAKircGIyPu7+PQU7BavSzCqs7/rLP/D7tWfxixaDLWB0+ftnuXM/h6r
         JL+BsN1C5L5nuUeXAw8+ZJabfPtGaZsU8rpoIXg3yabpS3l1UK/vDqmmw4P8IMYV5PUX
         +GygFVNIN2kYqHKkFRgv8PvdpbF5zum0Qm+ZmDzVTY7tfWrM4q2K9bLlu0SlSkQOCsiW
         PNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8a5K5Kp3coBNnqFIb9DMB5cgQbEzSbzrjPjs1y/oqag=;
        b=ElPXIl1l2D85VtIuR34Mg7sJ59GiZPpZrwTmGg6Q5zizMT7jYAS5yNUbDOEoYir9xI
         4+iOOLq5Ad5qSxGssa3bv6IDNU3lFa22pNI4Fr200UF+8rEVtDrEojxcbQ6zn05XLi69
         J36g2h9wbVeZ8KGf8P4uBOrkqdWVS01tChCzsz+FlCisXNcq0/8JO19Qrrbu879EFaAD
         dECYzwxN/HPC9ykxsDRoNP3OhfJF/vjRz47nshPPQQKsRT8M+qG8zTMj0XnnABIXIadu
         zisTOjyDcogxLm7RXlwzFE3zPkVQqkbEq/v/zNX76uwCM4z07TgULc0mz2j2xr2/6x6B
         N4Ww==
X-Gm-Message-State: APjAAAUz976MX9VKkvLprHifdmpFR2qr77lTsHawO5uaxDairpss62XH
        4xfE6Y1gLJ/dJuellpeNc9AzSQ==
X-Google-Smtp-Source: APXvYqwoMX0cGFSYkwhzIbkAuziGo275/8sy8Lsf/Hj8cTyP7/Jhypl4n4DdIoOMQHDRT7ME5Eu0eQ==
X-Received: by 2002:a62:1385:: with SMTP id 5mr23245081pft.221.1553511569221;
        Mon, 25 Mar 2019 03:59:29 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id b15sm19934413pgg.90.2019.03.25.03.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:59:28 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: uniphier: Fix build dependency
Date:   Mon, 25 Mar 2019 18:59:19 +0800
Message-Id: <20190325105919.19015-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use any syscon APIs, so remove MFD_SYSCON dependency.
Select REGMAP_MMIO since this driver uses devm_regmap_init_mmio().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6d2651cd9887..c4dc2bcafb56 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1011,7 +1011,8 @@ config REGULATOR_TWL4030
 config REGULATOR_UNIPHIER
 	tristate "UniPhier regulator driver"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && MFD_SYSCON
+	depends on OF
+	select REGMAP_MMIO
 	default ARCH_UNIPHIER
 	help
 	  Support for regulators implemented on Socionext UniPhier SoCs.
-- 
2.17.1

