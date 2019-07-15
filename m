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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED182171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXN4+qHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfGOUMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:12:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35450 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbfGOUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:12:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so8860911plp.2;
        Mon, 15 Jul 2019 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+5ugNZRQxfWrkMH7xBRPlgfACJf+lsKKWOLG3sHEZI=;
        b=RXN4+qHRhdhlOH7Or3fIU7WZ3bhRzkZTBhNS3mOj7DWhbbfQNQrFJAUfC2mVT5X5vN
         B5Qrofj/qRnQ5/hi3cnwHTGVXrpz4hwMjA4fVhyu/l3I4zdtTVx72HLNgXfbmHiPsqTF
         ibCeSkE/39hi7T47h1BXJidDJs5wSlXVEhX84ZdO5f1rexsZupXudtJyvafu/VQYxq6O
         1q2e2FhoyJ8tiSEyujaKUI0JDN+iUbPUHP9qrCL+XPCF+o2XekqVq06JuN2GmSJ1xteu
         +kl/oKTHfx7ChAbc7ytkXCrC0I4nqBaihbA3lcBAMWLPVQCoCzttA4HlfW7fn007dtaK
         HWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+5ugNZRQxfWrkMH7xBRPlgfACJf+lsKKWOLG3sHEZI=;
        b=n4sZmkvsEl5QQHlgIKUthYTzIdIARVK569Ck6oPS+POPP5Lw6dtQRTO1baGwNFUc2J
         qkC/l6zV0fMC2a2vDOzXaMfX1WXArKN2H/hmfIk2rJuMN3d8KJqtqnJrD2ixlA3OAy9Z
         Rez0WqVwGafGpGV2Bd4P3q5VMX2+k8P/QRdpH1qUOR1C8bjzMxcAsJFyvKy8ldoc8lS2
         k+2woy0rczls+tZHdWYoDM7YhvIAUIYLI3Ifzzl8YeiSGo3pDdmIgPykDdFIj2stSTv6
         kXkvhI0VSE4z3X/CZY8fIFZX6WyY41YWeVHpS65rX4TW5eBxmTp9CPc7IFp8aj+WfCN7
         yXYg==
X-Gm-Message-State: APjAAAWnoEWZd2YyGlqYvHsRYuHZDotDZnoWAxDSksExD+CxZxjE22xx
        R6503Fi7Ci32JFg/LzMXlm6T6xbD
X-Google-Smtp-Source: APXvYqwF7wMHHLOh5VMqIIA0qEVHT7dxhESDoigyz6IJ/GW1dktwZYO6iLaPJ/Z82bC1NuhVgJ1HpQ==
X-Received: by 2002:a17:902:204:: with SMTP id 4mr29695152plc.178.1563221567958;
        Mon, 15 Jul 2019 13:12:47 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d21sm7327783pgm.75.2019.07.15.13.12.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:47 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] clk: Sync prototypes for clk_bulk_prepare()
Date:   Mon, 15 Jul 2019 13:12:30 -0700
Message-Id: <20190715201234.13556-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201234.13556-1-andrew.smirnov@gmail.com>
References: <20190715201234.13556-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No-op version of clk_bulk_prepare() should have the same protoype as
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
index a35868ccc912..8af6b943bb9a 100644
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
-- 
2.21.0

