Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE3920850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsIyd9cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfEHQxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:53:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34321 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfEHQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:53:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so1182410plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8XEq0BBQxSVWW0G1qgBZYBxdgD+WG/sDOfIGEb9+WEA=;
        b=HsIyd9cnKrmei8aeAdo987X7BR9t6gawxO6jcbTDiuMzXC03Y75Gw/PEWqpdD8V8ji
         S4FmLdswIRS7fcALbNcqw3PxfvdqJkolDph0QsjIBw+aO9VsQpQy8Lkp9mVmrQxcVIFH
         CoZCgT81FC6gwi963hOK2YrEsImLYh8PFi5jAA3diBcBy1+fnFG8KbD9K4MW/Rp+dZPr
         +YdP5HPlIlSeKvJLJch5LAqPEEYGX5hBtaCOnELAkyiN5Hx7Hg8mcxEprk2jaXGAqT3I
         zGrN/UkE5C3zfeIguY7oF33+cQxM7HGlzdYDTAipeqTGIK7FAitZrEfm4fNw8t6uab8S
         1Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8XEq0BBQxSVWW0G1qgBZYBxdgD+WG/sDOfIGEb9+WEA=;
        b=PNsmiJyodhC8J1N/VyCKic+FEIX2N1qXZhTKuh2H2uPOT9lD0mUy3s4TMCx0u8ziMP
         fS0o078v9N8u8lgvEr1dx43DARlVHgW3Q5y0zd/tLl8nlVjJCYTwCphJWX0ZUxWlx473
         S61KLcPc4+t/2wRkutPvZ7ipmtQeSqmxittDnrAp94vCy7Ku8Tjpot4nHHdJxjJC8zVm
         b8PWhDHybG6AOgle5J9N5ArZzyUlQBXXAvIZAfXhiEVAK2erPrd+bTH+j9J98cQwWiW7
         5984AFgpsPw44b5LtxIaV4RdVBBAtDPwtt0GdrbImC/LNNA8XJ49fcNFlkBvyGgdlWAE
         oVyg==
X-Gm-Message-State: APjAAAV42sycmqeSGd6jKd0f5Gq2acFPLqZaM1QycOkk1Xw00yLUkXWr
        iwxriLFmz807wKDCzJoQm9tl
X-Google-Smtp-Source: APXvYqzsIAlPZ+GSgEQWxDteyNmQjXIfdpBO3Lv8XpkqttzH3VntoMJ/btZTYD6RzFDAXZqQ+qcp+g==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr48743439pll.163.1557334428841;
        Wed, 08 May 2019 09:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6000:7ab1:cd79:1ccc:df38:79c0])
        by smtp.gmail.com with ESMTPSA id m2sm25180676pfi.24.2019.05.08.09.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:53:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 4/4] reset: Switch to SPDX license identifier for reset-simple
Date:   Wed,  8 May 2019 22:23:19 +0530
Message-Id: <20190508165319.19822-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
References: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to SPDX license identifier for reset-simple driver.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/reset/reset-simple.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 5e8c86470e6b..8043ba48a30a 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Simple Reset Controller Driver
  *
@@ -8,11 +9,6 @@
  * Copyright 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/device.h>
-- 
2.17.1

