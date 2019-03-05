Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689FCC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CF020652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0bEQTF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfCERIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:08:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfCERIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:08:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so6054575pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ca2rmhIFMYZx78AJXHwnEFBC/h0eDECzkenDaFp6yfw=;
        b=e0bEQTF8824UrXYG6I1AqofOYb09SEQphN/ygG01rDbAZ8c6dfuhCuZstVC5eidvoh
         slTRCzrDTaAXRPx7LpD4TnzvZtF5ny1Xjs5sKzOBOHlqMSImHPhy/14x/ln+hm6cj2us
         Dk3YlTtjpa1yJSygXMrCPXKOkKH3zJcV2ngLgVWVHme32rMf9G0IIc/8/SsDO4nwMYNm
         klVgM0xxlmBYHaNY0SgSnuB7YN3dSOs+6Hauig39tMFMotqBhl9WyQu6JJJD3UoDSNUV
         G8WqJz4UST/IhIinQ+/0IkQ6DibJAK6rOjWPa+6/nNqH3VOw5qWnwo3z2jv2yidR69Lw
         kz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ca2rmhIFMYZx78AJXHwnEFBC/h0eDECzkenDaFp6yfw=;
        b=bjh8APpRnHFDtJCsKhx8ZEVafi+TI1zzqHKQF+l9eSh0mAMl8uWzj/cbAOMXG43r47
         2EoAaoHh6tRU61+mVDNzzOwCq/XtjQRWJH0eWMvbEzm22Fy+1nkqdWmPB7svi/sZsO3B
         KRgJ+v/5QLoqbROlUf2+5vwVdEYGkrXvaSyuKTDcHPqqViUG26teN2+eT5yFsESkjWd2
         ta+rFMS0e2bAv2josSXO5UdwtpUqgazsorvkVsMkBZTW2GdgMsbq1jp6k2LcpTbz5iQz
         RpNqxXvLRkOKQ/tdy5N0g0r354UQ4V4tL8NFIJ3blOozlNKSn8l640rzttHnT/nRgtc+
         0+hg==
X-Gm-Message-State: APjAAAWhc2jM3S0RNtG1DLIi1pYgpa5qamox2ql30xuVUGJv8TUIGN/q
        821n0ngoNkZ2xsTYEG+JwBE=
X-Google-Smtp-Source: APXvYqx/yxa2HqJmCWar1480l/gI8YQoZMQuYi8b/WyivebOtjAbwpOJEnf6UV38qUX/70q62u1EPg==
X-Received: by 2002:a63:4607:: with SMTP id t7mr2255888pga.306.1551805734025;
        Tue, 05 Mar 2019 09:08:54 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id u11sm12530648pfh.23.2019.03.05.09.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 09:08:53 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mark.rutland@arm.com, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clocksource: arm_arch_timer: remove unneeded pr_fmt macro
Date:   Tue,  5 Mar 2019 12:08:51 -0500
Message-Id: <20190305170851.24643-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After this commit ded24019b6b6f(clocksource: arm_arch_timer: clean up
printk usage), the previous macro is redundant, so delete it.

And move the new macro to the previous position.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..675243eb8cd4 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
  */
 
-#define pr_fmt(fmt)	"arm_arch_timer: " fmt
+#define pr_fmt(fmt) 	"arch_timer: " fmt
 
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -33,9 +33,6 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#undef pr_fmt
-#define pr_fmt(fmt) "arch_timer: " fmt
-
 #define CNTTIDR		0x08
 #define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
 
-- 
2.17.0

