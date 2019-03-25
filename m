Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA5C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lf6/cFX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfCYRY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:24:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38408 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbfCYRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:24:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so6764675pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=liX18Cu3SdiagJ0uzSPFRGNBoXYY0S6TuTgqfIep++k=;
        b=lf6/cFX26dAT2yZeCF0OrFHG7M5xvCHcD6vsG5Knp4RKBj1gYJN3a7lWq44SGmt2UV
         2ZJZ2EylrHvISOuBWbjdSJzKQgOfpmvPodfozMUiFimOXvU4vztFwl3egPfnbBSCEQON
         yIUbBPiwwtu0GrrVZqzhQB8UK0JznA038MT/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=liX18Cu3SdiagJ0uzSPFRGNBoXYY0S6TuTgqfIep++k=;
        b=UIrbuxNUzk4BSpeDIa9Sw+/29UUWMi4XMncihbXpqRstmmlH1qwTsbgFyP9j3rKWJm
         ++G5MRQ/W8KfoZ9NBifAJD8tifm/+EupGXTrdoihanm8WNSQlj7CO/Qe6rnqs2E7By5H
         JsOJaWB2ANGsN5UMC8uMmqWr7rw50px9tdFMWZgUjff6x+VFk0ypZv/KVdnZwCZ7aKEG
         0LfL5822ExY75W1/Z/vxQ30gdTgZX4lQj6TLws+jb6yD6r1floWphXMgl0xfsMhIx8gS
         aXAmg74wdBBQK4oyF86Vgin53LO/Y9cNzAKp1O4U0oaDPRq1L68WpMhvmBGMv/GyXdu4
         dcIQ==
X-Gm-Message-State: APjAAAUB7t6UzKME2Q7l6uJ1RXgKnA0GwlJQ3yZZCvDvnultyd0Y/PwR
        68B8OAL/wsa+tmq5IwMde1mhrw==
X-Google-Smtp-Source: APXvYqxN3TkRCiZT8PqEEmsNnflpV0HPcbGEgUAH72LqLVmHdP3rEGoC9HcIGhc2yfu8Xn9lGntAOQ==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr23418467pgf.336.1553534697599;
        Mon, 25 Mar 2019 10:24:57 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c16sm209385pfb.102.2019.03.25.10.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:24:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Wenkai Du <wenkai.du@intel.com>,
        Justin TerAvest <teravest@chromium.org>
Subject: [PATCH] PM / wakeup: Use pm_pr_dbg() instead of pr_debug()
Date:   Mon, 25 Mar 2019 10:24:56 -0700
Message-Id: <20190325172456.227190-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These prints are useful if we're doing PM suspend debugging. Having them
at pr_debug() level means that we need to either enable DEBUG in this
file, or compile the kernel with dynamic debug capabilities. Both of
these options have drawbacks like custom compilation or opting into all
debug statements being included into the kernel image. Given that we
already have infrastructure to collect PM debugging information with
CONFIG_PM_DEBUG and friends, let's change the pr_debug usage here to be
pm_pr_dbg() instead so we can collect the wakeup information in the
kernel logs.

Cc: Wenkai Du <wenkai.du@intel.com>
Cc: Justin TerAvest <teravest@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/power/wakeup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index bb1ae175fae1..23c243a4c675 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -804,7 +804,7 @@ void pm_print_active_wakeup_sources(void)
 	srcuidx = srcu_read_lock(&wakeup_srcu);
 	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
 		if (ws->active) {
-			pr_debug("active wakeup source: %s\n", ws->name);
+			pm_pr_dbg("active wakeup source: %s\n", ws->name);
 			active = 1;
 		} else if (!active &&
 			   (!last_activity_ws ||
@@ -815,7 +815,7 @@ void pm_print_active_wakeup_sources(void)
 	}
 
 	if (!active && last_activity_ws)
-		pr_debug("last active wakeup source: %s\n",
+		pm_pr_dbg("last active wakeup source: %s\n",
 			last_activity_ws->name);
 	srcu_read_unlock(&wakeup_srcu, srcuidx);
 }
@@ -845,7 +845,7 @@ bool pm_wakeup_pending(void)
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 
 	if (ret) {
-		pr_debug("Wakeup pending, aborting suspend\n");
+		pm_pr_dbg("Wakeup pending, aborting suspend\n");
 		pm_print_active_wakeup_sources();
 	}
 
-- 
Sent by a computer through tubes

