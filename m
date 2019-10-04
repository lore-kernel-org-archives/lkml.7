Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8C207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="b+mFR/U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfJDJsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:48:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35555 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJDJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:48:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so5850641lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwueem1EPljcXnRaD27ju0e/9VU20MKGGmsIv6bb3i0=;
        b=b+mFR/U2BxINAX/eyE5WBsgp7vVFGbtCqpa+sBArULMdsFouNVX8qQQ9oIqtt/7PXO
         rLRaRYVJ9nZ/zHSApPl2quJdLSe1h5NKL6q6bqsIzy3T3yyyjoSnuR3+6keQH9p4L8Uc
         NxtA8F8AmmvvkW297Daepygynaz0Qd7NmPzhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwueem1EPljcXnRaD27ju0e/9VU20MKGGmsIv6bb3i0=;
        b=nyksuQM/nDXPjfjnAE5LSBh3phtEUAK/8VovpT5u9OOMEny6OWN42ZMH2Zfyo5TbMj
         SCqCeYjJkwEjOhiWB+Nk9nkL2l3x5A5hmJ8AS5BcEP3QclEMt/GK5CSG8fjb7oaUVcPK
         2vGsQS0Uo0LcKDmNnNZDNVKPwUrHvcB6/QlOKcvxrPUT3SIE4XixA3jzMc7ePo9gHqSj
         Iroz6O4Q5pF+1guXr7hBjWgj3Ll2YaXxE7oqHsYbuZvpR1ZLlBhN8hzgEqam4WK1q6up
         QenH4Dlp2eVRc1UDa1Rgq+8vFDIB0ERcLfhzKwVWAEPgqtB8QicxtYdFe7CFfeTaiiIp
         9SLg==
X-Gm-Message-State: APjAAAVobIKiZlv5eqH13JlZ58cRI4heNLwkXk1yML/kT7ZdmkouUzo1
        F2mJLl5n/UZJKrRbLzj0RouH1w==
X-Google-Smtp-Source: APXvYqxTCTBrpEDR2lu1tIgV66peqc6OizLuq+XpAAIjRmrKavdVP3wIaE8w/80MGY4hLE1/npPqwQ==
X-Received: by 2002:a2e:4296:: with SMTP id h22mr9113125ljf.208.1570182509097;
        Fri, 04 Oct 2019 02:48:29 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h12sm1116585ljg.24.2019.10.04.02.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:48:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: mark clk_disable_unused() as __init
Date:   Fri,  4 Oct 2019 11:48:25 +0200
Message-Id: <20191004094826.8320-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unused is only called once, as a late_initcall, so reclaim
a bit of memory by marking it (and the functions and data it is the
sole user of) as __init/__initdata. This moves ~1900 bytes from .text
to .init.text for a imx_v6_v7_defconfig.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/clk/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1c677d7f7f53..a81985285a3d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1187,7 +1187,7 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void clk_unprepare_unused_subtree(struct clk_core *core)
+static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
@@ -1217,7 +1217,7 @@ static void clk_unprepare_unused_subtree(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
-static void clk_disable_unused_subtree(struct clk_core *core)
+static void __init clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 	unsigned long flags;
@@ -1263,7 +1263,7 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 		clk_core_disable_unprepare(core->parent);
 }
 
-static bool clk_ignore_unused;
+static bool clk_ignore_unused __initdata;
 static int __init clk_ignore_unused_setup(char *__unused)
 {
 	clk_ignore_unused = true;
@@ -1271,7 +1271,7 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int clk_disable_unused(void)
+static int __init clk_disable_unused(void)
 {
 	struct clk_core *core;
 
-- 
2.20.1

