Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF8C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4EC2467A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 21:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EdMEfomi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfLOVCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 16:02:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33151 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfLOVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 16:02:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so4849883wrq.0;
        Sun, 15 Dec 2019 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gHIa9kqk84t33T9/NR0KW4i+WbdOUW3zGPJ6/IWE5o=;
        b=EdMEfomij+fA1v4b/Yor6lscI3NPOuQmskR5Fr1gAOqyq5dbnCqVnM4yIIEtgkWAku
         EW4kz6sHZIwfrf/X1Y/uXzcuWcaS/m5ukjlM+f0sPTwKyWthLe5RKObOyDdacAoQ6iOV
         jDBbUqupMO0Bk+5UwEw4vCAI7QrBxmfjOp3n5KHnUkRmMhS99a+slIp74029MYHP8zmk
         R05TuKtLVIJwPF5FRrhw1XJF301yoURMYqgtBvsCAVGcpxlgBMBSjVjTZuywFsSuIDxj
         f6DfoCT7iZM+pVHl6DIQr3qo3nxoKCL4LTvc3a5AfroEXdwPs8TW7A0eKfsf8swGHYHn
         9qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gHIa9kqk84t33T9/NR0KW4i+WbdOUW3zGPJ6/IWE5o=;
        b=dsibvf5H6VlroESQgr+pM6xJV4oYG4G96Z8XZt8X6j12vZF5lWQJa2Xfqs17YtQQHX
         mDcZS6YCd1HSRcWJ0rapTVHZhMIKg6gJ8SHP8xEEFEe9pAS3Q9gZezRMgdlo2vAJN/R+
         S/D4OBoi8p1LLKh7CNE70k42Ez6ISU45dUdkycCQIVprNN0gH1zABQzLPpKR0GWIUNyA
         FEfps6qpSK5iSQB3Z+vBqD/yPQqfygYOd72mQ1uS8b94CaSjZeT5mZRaSkKXNajZnkAI
         oXmU/XuxnqGPF5naaSc+Gg6LG6KSbQpOjwE8d7rhSKgyExbpOUOCXQUOoD1Km5QrdBkO
         GodQ==
X-Gm-Message-State: APjAAAVQ4aCdEB2+W2W+qePG/+QlqoQKG7ZsxgxQFtFm3iWLfli6ilRJ
        eKGOMhs2mEELCMUbgdjjTHM=
X-Google-Smtp-Source: APXvYqwgM/b7u1mLXpFZdVCEUisopxkubQb3HOxGH/WKnOjGP69jUA3GLe0OxIjfyI4giLcKZXVjTA==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr26014162wru.344.1576443733657;
        Sun, 15 Dec 2019 13:02:13 -0800 (PST)
Received: from localhost.localdomain (p200300F1370FCC00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:370f:cc00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f1sm19565645wrp.93.2019.12.15.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 13:02:13 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] clk: meson: meson8b: make the CCF use the glitch-free "mali" mux
Date:   Sun, 15 Dec 2019 22:01:53 +0100
Message-Id: <20191215210153.1449067-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com>
References: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali clock tree should not be updated while the clock is running.
Enforce this by setting CLK_SET_RATE_GATE on the "mali_0" and "mali_1"
gates. This makes the CCF switch to the "mali_1" tree when "mali_0" is
currently active and vice versa which is exactly what the vendor driver
does when updating the frequency of the mali clock.

This fixes a potential hang when changing the GPU frequency at runtime.

Fixes: 74e1f2521f16ff ("clk: meson: meson8b: add the GPU clock tree")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 3408297bff65..6b13084eebf5 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1838,7 +1838,7 @@ static struct clk_regmap meson8b_mali_0 = {
 			&meson8b_mali_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1893,7 +1893,7 @@ static struct clk_regmap meson8b_mali_1 = {
 			&meson8b_mali_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.24.1

