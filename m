Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D39AC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6899421670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9aGZO9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEAHHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 03:07:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfEAHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 03:07:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so8244744pfi.12;
        Wed, 01 May 2019 00:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cS7rJIaL8pwN44UnD0NGYAHiEv3VfG6a3NVrHHK0S7g=;
        b=h9aGZO9cksXANDPwTh7uZA1Ut4uD/u65eBW2yV1+jUaE1Sxf5hhwgTQWtUK7wmOEoj
         21/27g/I9OyridO3OCyAGaC0uu/vL/ZGPrPbtkEKhbfjX++WloCfMeVUH2Rlp35BZqty
         eTMxWu2ck8N2EaTEdIM5wYCdRvs/4YV7pphgDXqLgt0JnDqCth7en3UOSteQM9arEgj8
         /nPSIlcu1XeFdHY07F8XGAGHrJvCXTHBEA7FGEmJtu+HBMzX2BonAqITR5YoUDwBAu1C
         7gsLtnWq+lOZSSEf5cOFaGOArKFVA+/cD6FggSh3Ukq81WtrCUzKcFWj8nyg1kOP6NIu
         kCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cS7rJIaL8pwN44UnD0NGYAHiEv3VfG6a3NVrHHK0S7g=;
        b=X6DlNnz0SRNGw9KOLGHIEbf1SUjWI4Pw3m/VJFMmStkmo24OoEJTekQKztMPVTONqp
         DYYAtYnyhqmPGKXiwk/f1jSJMhD3N544qhKmTfa5C8x/OQYkIZD6I8EudPZid2Y5appj
         7OPlIJgNfZPnK6wrrgzPOv8DhyIuKD33+ylpG+WQuI5KvnP0u3qVZP7IgLc5UKX1wjWP
         5bW4cIeTlhf6+oQeWFbR0KI1RHgLObSFtFN6azTRRSInJUps+WJWLH7Ftw0eBsFbPrcu
         diJTwPeYo5kUH9B3LdXHqKa6N+oKJYFHVj9lbu6lMY784LbMxTeNDD4tgIe9WOyExiFI
         BGyQ==
X-Gm-Message-State: APjAAAVdGrN3T441ADJ8mlYH6whZIfrV9zTVSg1vCU1hiXb3br1Hnu9C
        4h3cK7r7+8dsVS2PcMvW8bOksFooqTZw5A==
X-Google-Smtp-Source: APXvYqwoUoswg+N0X7irtWbmVi8CGt3FJayjhGPhZnWvuH9T6Cbp6yIPc9tC0ZaglL48dyX3rxlj/w==
X-Received: by 2002:a62:5795:: with SMTP id i21mr49146617pfj.194.1556694438381;
        Wed, 01 May 2019 00:07:18 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id q80sm71273674pfa.66.2019.05.01.00.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 00:07:17 -0700 (PDT)
Date:   Wed, 1 May 2019 12:37:11 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: actions: Use the correct style for SPDX License
 Identifier
Message-ID: <20190501070707.GA5619@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to Clock Drivers for Actions Semi Socs.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/clk/actions/owl-common.h       | 2 +-
 drivers/clk/actions/owl-composite.h    | 2 +-
 drivers/clk/actions/owl-divider.h      | 2 +-
 drivers/clk/actions/owl-factor.h       | 2 +-
 drivers/clk/actions/owl-fixed-factor.h | 2 +-
 drivers/clk/actions/owl-gate.h         | 2 +-
 drivers/clk/actions/owl-mux.h          | 2 +-
 drivers/clk/actions/owl-pll.h          | 2 +-
 drivers/clk/actions/owl-reset.h        | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
index 5a866a8b913d..c000a431471e 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL common clock driver
 //
diff --git a/drivers/clk/actions/owl-composite.h b/drivers/clk/actions/owl-composite.h
index b410ed5bf308..bca38bf8f218 100644
--- a/drivers/clk/actions/owl-composite.h
+++ b/drivers/clk/actions/owl-composite.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL composite clock driver
 //
diff --git a/drivers/clk/actions/owl-divider.h b/drivers/clk/actions/owl-divider.h
index 92d3e3d23967..083be6d80954 100644
--- a/drivers/clk/actions/owl-divider.h
+++ b/drivers/clk/actions/owl-divider.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL divider clock driver
 //
diff --git a/drivers/clk/actions/owl-factor.h b/drivers/clk/actions/owl-factor.h
index f1a7ffe896e1..04b89cbfdccb 100644
--- a/drivers/clk/actions/owl-factor.h
+++ b/drivers/clk/actions/owl-factor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL factor clock driver
 //
diff --git a/drivers/clk/actions/owl-fixed-factor.h b/drivers/clk/actions/owl-fixed-factor.h
index cc9fe36c0964..3dfd7fd7d292 100644
--- a/drivers/clk/actions/owl-fixed-factor.h
+++ b/drivers/clk/actions/owl-fixed-factor.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL fixed factor clock driver
 //
diff --git a/drivers/clk/actions/owl-gate.h b/drivers/clk/actions/owl-gate.h
index c2d61ceebce2..c2f161c93fda 100644
--- a/drivers/clk/actions/owl-gate.h
+++ b/drivers/clk/actions/owl-gate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL gate clock driver
 //
diff --git a/drivers/clk/actions/owl-mux.h b/drivers/clk/actions/owl-mux.h
index 834284c8c3ae..53b9ab665294 100644
--- a/drivers/clk/actions/owl-mux.h
+++ b/drivers/clk/actions/owl-mux.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL mux clock driver
 //
diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
index 6fb0d45bb088..78e5fc360b03 100644
--- a/drivers/clk/actions/owl-pll.h
+++ b/drivers/clk/actions/owl-pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 //
 // OWL pll clock driver
 //
diff --git a/drivers/clk/actions/owl-reset.h b/drivers/clk/actions/owl-reset.h
index 10f5774979a6..a947ffcb5a02 100644
--- a/drivers/clk/actions/owl-reset.h
+++ b/drivers/clk/actions/owl-reset.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 //
 // Actions Semi Owl SoCs Reset Management Unit driver
 //
-- 
2.17.1

