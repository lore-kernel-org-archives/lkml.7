Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF5C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5833F2182B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa5ufhqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfGOUMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:12:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36381 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfGOUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:12:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so7942608pfl.3;
        Mon, 15 Jul 2019 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFHU8jgY3TxdaihzIPG/nX9WOPct/kS+iwLsN1JrgDM=;
        b=Xa5ufhqNsV9uATb0H6bQ9qRGI8kVtjsLrscoS0+hms16q6PLbWMSaa6sQX8NOQRkhH
         YE/6yIF6C+Oa1eKVkzw9iQ6Sukx8HB5eMmPJarAUJ/S8YmGdX5e1RJ3Xe8xIIVr9Lrvp
         16RkgL9NpGLfLKcnxUG1nt4CfozEkvEsIdiuEgE9J3XaXRTMEWVMpxS1G96tPUwsp/Ce
         RuDgMewdxAx/cEvnq9uUGg06xpALNXL56bw+EGdLBCYs0dnjAlPjDRsM2eCgMQ/ufFQT
         7Qxj0p/qGDkQnZYG2MZza4/KzdOab9ANH6CK7ZvgQzFSYNmW6+nINttW+N33VEcmIu6V
         4DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFHU8jgY3TxdaihzIPG/nX9WOPct/kS+iwLsN1JrgDM=;
        b=dt4rm+1bIL2xuL8YvZtRlvuQBHdGKYSFJRI9UWqgX9ITuHRJe50e4YaRfGBBE5Z90t
         101qY8qxYTq1L+/N9iVqzhgLiuNPmvT3eHoKXfHUffMu4kPfAES2QctMMQpQSHWe9QtD
         489LGZEXl5oyyNsDqehbuglOray7wFM9hFJ91UrlYa1LLuoUMerS4pUzboOiyE/Ca1Br
         iCwiZVVpVENRZNti9M/5BcfZsqkAhf9kWMHK7b/Dq5CAheRfsy/nMyq10rr9bXie6hGA
         65Fe8y3Ctyv1QpU+bd9UXgm62aJ9mYSZbLEAZ3RwDJgMJ1CuGgW9BilGrO/lh/2uufYS
         NjNQ==
X-Gm-Message-State: APjAAAUNQQ2Au2OfW52D7U7LOzbffQhaWKzFRY3XvPZ81JpWkudc91Em
        C7iwAQ+ThiZ+W5l4GHFL4XBq893q
X-Google-Smtp-Source: APXvYqxEIpLPloFXmRit3o8nJFvto+NCwRwwNByFuexN1TfVy9Gep+QkIU4Yqc32w7cRa7kQT9cr2w==
X-Received: by 2002:a63:ad07:: with SMTP id g7mr26834526pgf.405.1563221566834;
        Mon, 15 Jul 2019 13:12:46 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d21sm7327783pgm.75.2019.07.15.13.12.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:46 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] clk: Sync prototypes for clk_bulk_enable()
Date:   Mon, 15 Jul 2019 13:12:29 -0700
Message-Id: <20190715201234.13556-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No-op version of clk_bulk_enable() should have the same protoype as
the real implementation, so constify the last argument to make it so.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 3c096c7a51dc..a35868ccc912 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -819,7 +819,8 @@ static inline int clk_enable(struct clk *clk)
 	return 0;
 }
 
-static inline int __must_check clk_bulk_enable(int num_clks, struct clk_bulk_data *clks)
+static inline int __must_check clk_bulk_enable(int num_clks,
+					       const struct clk_bulk_data *clks)
 {
 	return 0;
 }
-- 
2.21.0

