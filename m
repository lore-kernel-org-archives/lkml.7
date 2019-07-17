Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B91C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E02173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo/M4+A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfGQO5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:57:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38970 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfGQO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:57:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so11286707pgi.6;
        Wed, 17 Jul 2019 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APKDRZEodNYbxFJbsXASACTORPNNRtndtW62G0tC3Bs=;
        b=Xo/M4+A9W6s7+ydaDiL/9Y4limQn12WQE5SuGUc/AiEKrK4b6ZpDHIwweIrULBYQH2
         y6wvm69pQwfSQZZCwi0zb3urMH5VPb6AzKDxQtQ/vdppaWHe31cvAfYj3POemBt6Jwjq
         0B/+lBnJ2VeDWCb9O0g9Ywn0c176IddhF3EGag4Mbzu0qtDWE2MkAL05+tB/6HNouSFl
         vYffuTUcwbx1eLZ5HkHg9FPIFU/ktbzVaSyI+cFU0Tob97mANblL79PoT7f4dykZ4Ha+
         1BOcmoniGG/dBxv68kB5T9AT9bhl3GV5rhZpJsUemsoj5SW+djP3jj+Jd7Muu4rq3W44
         peBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APKDRZEodNYbxFJbsXASACTORPNNRtndtW62G0tC3Bs=;
        b=Ed+u7kQDSm3gEtGMNz0zOUk2x1usRm9DFMnI6f5jnjZjSGy7mnw9i7roNe0uBympD0
         Y/7EinBFRohknhhd7eFtlaCn1XDBmm/2EdihaEJYnKiU672C4ZODHs0mi7rTT3XSDSwE
         rLim9+zrVynEDzzvd2CkmTMUr2okf6cbMwpChIM+6lrw62Hbsjmm2DUdS8MUUOEsv+UD
         ldxG5pc0vix5il4hiA91RDIwz/UdEcXq86hFcVbD224zDAYt5Q9t9UJIgNCOa2ypNuBE
         uKCOdcBahJ65wBhc8Q7iYG2jaKuQfYnSf0Ka/gQpKc7K5GYjUItaXz+k3FJbAJA2fd/5
         haKQ==
X-Gm-Message-State: APjAAAUIqMZYpXkFF4NMskYNAhOQDLfknopvMN3AXHP5ssuKbwON0E1P
        ZjsqG9eAbrx34QIwJo8f14G6j8WY
X-Google-Smtp-Source: APXvYqy+vtd5DQ7nWV7htQSM0PWQRsw15tCnUYpyo1MxVvvc3bL3aIOsdPy1IzyNSyfWPRnXEFqVjQ==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr42263921pju.40.1563375423469;
        Wed, 17 Jul 2019 07:57:03 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id r13sm32361191pfr.25.2019.07.17.07.57.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 07:57:02 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Boyd <sboyd@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: Constify struct clk_bulk_data * where possible
Date:   Wed, 17 Jul 2019 07:56:51 -0700
Message-Id: <20190717145651.17250-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions:

    - clk_bulk_enable()
    - clk_bulk_prepare()
    - clk_bulk_disable()
    - clk_bulk_unprepare()

already expect const clk_bulk_data * as a second parameter, however
their no-op version have mismatching prototypes that don't. Fix that.

While at it, constify the second argument of clk_bulk_prepare_enable()
and clk_bulk_disable_unprepare(), since the functions they are
comprised of already accept const clk_bulk_data *.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Whole series squased into a single patch
    
[v1] lkml.kernel.org/r/20190715201234.13556-1-andrew.smirnov@gmail.com

 include/linux/clk.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 3c096c7a51dc..7a795fd6d141 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -239,7 +239,8 @@ static inline int clk_prepare(struct clk *clk)
 	return 0;
 }
 
-static inline int __must_check clk_bulk_prepare(int num_clks, struct clk_bulk_data *clks)
+static inline int __must_check
+clk_bulk_prepare(int num_clks, const struct clk_bulk_data *clks)
 {
 	might_sleep();
 	return 0;
@@ -263,7 +264,8 @@ static inline void clk_unprepare(struct clk *clk)
 {
 	might_sleep();
 }
-static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
+static inline void clk_bulk_unprepare(int num_clks,
+				      const struct clk_bulk_data *clks)
 {
 	might_sleep();
 }
@@ -819,7 +821,8 @@ static inline int clk_enable(struct clk *clk)
 	return 0;
 }
 
-static inline int __must_check clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
+static inline int __must_check clk_bulk_enable(int num_clks,
+					       const struct clk_bulk_data *clks)
 {
 	return 0;
 }
@@ -828,7 +831,7 @@ static inline void clk_disable(struct clk *clk) {}
 
 
 static inline void clk_bulk_disable(int num_clks,
-				    struct clk_bulk_data *clks) {}
+				    const struct clk_bulk_data *clks) {}
 
 static inline unsigned long clk_get_rate(struct clk *clk)
 {
@@ -917,8 +920,8 @@ static inline void clk_disable_unprepare(struct clk *clk)
 	clk_unprepare(clk);
 }
 
-static inline int __must_check clk_bulk_prepare_enable(int num_clks,
-					struct clk_bulk_data *clks)
+static inline int __must_check
+clk_bulk_prepare_enable(int num_clks, const struct clk_bulk_data *clks)
 {
 	int ret;
 
@@ -933,7 +936,7 @@ static inline int __must_check clk_bulk_prepare_enable(int num_clks,
 }
 
 static inline void clk_bulk_disable_unprepare(int num_clks,
-					      struct clk_bulk_data *clks)
+					      const struct clk_bulk_data *clks)
 {
 	clk_bulk_disable(num_clks, clks);
 	clk_bulk_unprepare(num_clks, clks);
-- 
2.21.0

