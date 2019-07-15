Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5735F2173B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+N+PDtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfGOUNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:13:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37638 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbfGOUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:12:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so8860374plr.4;
        Mon, 15 Jul 2019 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rliH8Z9/AMGeY4YMz60xVhAI42Yyu7aejFX+MviXFi8=;
        b=e+N+PDtM5s802dekMVKshzBTu7UFxDCa82kuwmHHsWf/u1Fl+HHN1qJhJuuJWjNB98
         dszTDxLAm8YyXwBg8oY3ocSC/eToE/O2TbY1vG9pJKWMdBzo550l/9DW1ZHOkesluyyz
         EAFa6sS0OR7d4PBAQeQ/xgJdG+rAsGkSvN6e2QSYREeoG7NX7CHwyEsG2PKfEIrYpC2v
         DxX2A/tRcF78VmqlB9y5mtBK7qs5tArHnFd76zqG4ekhsxh1IF9hiA4Inkfk2NczVPzW
         3Wgc1Jotr9N3We4VY+s5J7TtV/YE0u23uoPcKZaEsS5ZQ7I6cqknT/Ss0yxh8VBtUlj1
         UlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rliH8Z9/AMGeY4YMz60xVhAI42Yyu7aejFX+MviXFi8=;
        b=m3hg5G8PCJQAHGaphcknDraTizanj/CIxvP8r2jqcY4lSgGIdb/60LVikmAS+XylVy
         RBYpnK8YrijgF7yH0yxQgE7kXcmeej0/SLavs64vgdGJB80IMBgWir+cnJi38Q1d55PX
         4XARaIYloek7S3lr5azLqTQcTRzmpb3A3V0b0YnzXTyMUaWhtuuTmVD0KtSdFGAO/FVW
         +w2ZALdKvcI5+47AlyZ57ew7Ihflm5rpt2zSFugKPu2cA5w1ObSRy0GQCtDria3PauzT
         pL0J4RKoxrPhrw2lrQU3Ty6W3nuZWzwaBbIyYveETiTb5TdevYQc60vdSq0yROakhty5
         AWbQ==
X-Gm-Message-State: APjAAAV8puPOrrytdzLpJPTlwMYPy9RSO0A/V610j+89MWXPK3GMJOzu
        TIsuW5lIUGQLJdwZQB+8ky6/qnua
X-Google-Smtp-Source: APXvYqy8DRjK41Iu4VuR/EY0KSKX5Ch868kLyJrTD9sgAiG2KP6R4bqXde/c2NKif5JiNwcbPJlPqg==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr29667313plk.180.1563221572139;
        Mon, 15 Jul 2019 13:12:52 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d21sm7327783pgm.75.2019.07.15.13.12.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] clk: Sync prototypes for clk_bulk_unprepare()
Date:   Mon, 15 Jul 2019 13:12:33 -0700
Message-Id: <20190715201234.13556-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201234.13556-1-andrew.smirnov@gmail.com>
References: <20190715201234.13556-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No-op version of clk_bulk_unprepare() should have the same protoype as
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
index 2d3f2a55795a..3956ae05b1cf 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -264,7 +264,8 @@ static inline void clk_unprepare(struct clk *clk)
 {
 	might_sleep();
 }
-static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
+static inline void clk_bulk_unprepare(int num_clks,
+				      const struct clk_bulk_data *clks)
 {
 	might_sleep();
 }
-- 
2.21.0

