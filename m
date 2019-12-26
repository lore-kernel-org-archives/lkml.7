Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE0FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D923920882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nN/5xERv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfLZTMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:12:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39271 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfLZTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 14:12:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so6672126wmj.4;
        Thu, 26 Dec 2019 11:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tt36REs6xTGhoAu/DRKUVnoYElZnOVVi2F4lvnCzwxk=;
        b=nN/5xERvRFlldF3gW7sAZTJtfO1cS4PM2gDnf67/zENyO5n4o77HOWTbJd+ZG9QQEk
         rRmgS1gcOjN3hRQiIL+owsaJVLwFqTfL1/vG+uggrbXC0yBGM+RxK1zFTo6OGeRaCvvr
         2bIXCEAwf2NTdJkSs9YLL71Y1MeiMYh+cgkFAqIiuMUmEUldmHj5l+11ytV6bc1yFMBx
         KSK2b/dgA5OZI681Yv5LvSHPpYjq5STPnwC0M/RjXSjn/F7jJrOyJThiJKZl71YehIwR
         pNI8Gvuz2bqniQpEFgzsYaEu9XkhkxVZNHC6U7sQeTE0867hzRQ7yq0Gjwpl4SU2o4WP
         c7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tt36REs6xTGhoAu/DRKUVnoYElZnOVVi2F4lvnCzwxk=;
        b=do5BZXSygILym60TcUevkjx44J+wPa9w6u0vlxoMR6yeVOX9oMds4nGeqfRVOYyL/3
         M4UQwYTRxd7Lv2+tBxeOfvXyDVi7cEKvqxotARwWRZLZLmQT4Ac42/p72OInw9yniiz3
         hzjPU7VwqBexJFJkv9njjFPYHgbNtQSrNBqcfp7kqcwa890y4B12B0Ez30HNC/bHJZiZ
         uTIVXxZY8Xo6gK7w11CKloIaUYqsBVsARSxPJSvwogeGJxvJn7t9ngtKvldvN2bOUNJt
         Fb66jN/GHBP4m64LfsQWpHgW0G0ZUNRWS6L9E7LVdaO4u2oY/x7jRyrHCwzSaKLlGrWs
         b+Zw==
X-Gm-Message-State: APjAAAUhjn7DWTKjFCdBCU8hdcU7ILvaKOV/Ri2Eyj2lS8vmC3SM18UP
        SIPNbhc/v/PzCdsYDhgsW/cx4hItaB0=
X-Google-Smtp-Source: APXvYqzZGxtmKwZ1j7QZvBVzxdXGXdom8ptwX/pQlRuThGcOkzVdWLF8jTR6H/5QaAJYZ0p+Ul4wvw==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr15657682wmd.115.1577387564126;
        Thu, 26 Dec 2019 11:12:44 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o7sm8965937wmh.11.2019.12.26.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:12:43 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        sboyd@kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] clk: meson: meson8b: make the CCF use the glitch-free "mali" mux
Date:   Thu, 26 Dec 2019 20:12:23 +0100
Message-Id: <20191226191224.3785282-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
References: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mali_0" or "mali_1" clock trees should not be updated while the
clock is running. Enforce this by setting CLK_SET_RATE_GATE on the
"mali_0" and "mali_1" gates. This makes the CCF switch to the "mali_1"
tree when "mali_0" is currently active and vice versa, which is exactly
what the vendor driver does when updating the frequency of the mali
clock.

This fixes a potential hang when changing the GPU frequency at runtime.

Fixes: 74e1f2521f16ff ("clk: meson: meson8b: add the GPU clock tree")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 3408297bff65..9fd31f23b2a9 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1772,8 +1772,11 @@ static struct clk_regmap meson8b_hdmi_sys = {
 
 /*
  * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
- * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
- * has mali_0 and no glitch-free mux.
+ * muxed by a glitch-free switch on Meson8b and Meson8m2. The CCF can
+ * actually manage this glitch-free mux because it does top-to-bottom
+ * updates the each clock tree and switches to the "inactive" one when
+ * CLK_SET_RATE_GATE is set.
+ * Meson8 only has mali_0 and no glitch-free mux.
  */
 static const struct clk_parent_data meson8b_mali_0_1_parent_data[] = {
 	{ .fw_name = "xtal", .name = "xtal", .index = -1, },
@@ -1838,7 +1841,7 @@ static struct clk_regmap meson8b_mali_0 = {
 			&meson8b_mali_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1893,7 +1896,7 @@ static struct clk_regmap meson8b_mali_1 = {
 			&meson8b_mali_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.24.1

