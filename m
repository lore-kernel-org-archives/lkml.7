Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961F2C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E520640
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BBRlV88b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392709AbfIYUC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:02:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440130AbfIYUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:02:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so542615pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQLYUORcfotgaKqy5gkXc5kVZJb5dGrYga+46jw612E=;
        b=BBRlV88bVISU676nmRF0kHVZdbXHig0dn9rIjsZ8a0RiJ8C7mEzWYP6UYHuj4l6KeY
         M8EMwHVLwnCKr6L4uqSHsH4P7cYEucUlq4v1CPfV7QjSl0nBvxmnM5Hr3knERGUN+v+T
         iDStwC0hgjriwDEOj/1GoS+dVq0GqUviNbZq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQLYUORcfotgaKqy5gkXc5kVZJb5dGrYga+46jw612E=;
        b=Y2ME0yMJ5Yy1cZBd1pfyRy4KQGp0D0KXnYaXFWauNggZuLgud+BK1J6WUg3KjxC2mh
         DRn2l2rdt1Oybcoo/6iljVuNLWsUJT0iaZL09ftApOkiyNO3PZ/IeiJlbchQA1dbcyyd
         XoxWno7giB5IDHKBePUfJGpbDnfNCOr9ROZMtdbLYpuONtDLrTmHguvIrfRcRQZunapm
         61jJK+TwJBIzYzRYKQVyJDM9frhGeHTymJUMIkAWz4m9q1IWR42XX29qAvUd0IcHDNDu
         hMJTA3vpo5mgoUKNxVoKP44Mkd/hg+PUqh9LgLRIWzHNtBcy05amiV6jpMbKVocOG3XC
         KHng==
X-Gm-Message-State: APjAAAXD3p0fq+1lIriwH6mIyXiGKAe+wjUduZNYzUQSuSqxnYYoHiEy
        HqfKaakNQKFPBn4+M2RBtpgxhg==
X-Google-Smtp-Source: APXvYqwJ6pHdDAlsDr5RKFXS0cDGb0ZF1UKcTlt+5NRLmu4on6vgnFNUO2amx7Cb+kq88ANcYDP1LQ==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr317726pfd.209.1569441771927;
        Wed, 25 Sep 2019 13:02:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d76sm458113pga.80.2019.09.25.13.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:02:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] kdb: Fix "btc <cpu>" crash if the CPU didn't round up
Date:   Wed, 25 Sep 2019 13:02:19 -0700
Message-Id: <20190925125811.v3.3.Id33c06cbd1516b49820faccd80da01c7c4bf15c7@changeid>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190925200220.157670-1-dianders@chromium.org>
References: <20190925200220.157670-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that when I did "btc <cpu>" and the CPU I passed in hadn't
rounded up that I'd crash.  I was going to copy the same fix from
commit 162bc7f5afd7 ("kdb: Don't back trace on a cpu that didn't round
up") into the "not all the CPUs" case, but decided it'd be better to
clean things up a little bit.

This consolidates the two code paths.  It is _slightly_ wasteful in in
that the checks for "cpu" being too small or being offline isn't
really needed when we're iterating over all online CPUs, but that
really shouldn't hurt.  Better to have the same code path.

While at it, eliminate at least one slightly ugly (and totally
needless) recursive use of kdb_parse().

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Patch ("kdb: Fix "btc <cpu>" crash if the CPU...") new for v3.

Changes in v2: None

 kernel/debug/kdb/kdb_bt.c | 61 ++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 120fc686c919..d9af139f9a31 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -101,6 +101,27 @@ kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
 	return 0;
 }
 
+static void
+kdb_bt_cpu(unsigned long cpu)
+{
+	struct task_struct *kdb_tsk;
+
+	if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
+		kdb_printf("WARNING: no process for cpu %ld\n", cpu);
+		return;
+	}
+
+	/* If a CPU failed to round up we could be here */
+	kdb_tsk = KDB_TSK(cpu);
+	if (!kdb_tsk) {
+		kdb_printf("WARNING: no task for cpu %ld\n", cpu);
+		return;
+	}
+
+	kdb_set_current_task(kdb_tsk);
+	kdb_bt1(kdb_tsk, ~0UL, false);
+}
+
 int
 kdb_bt(int argc, const char **argv)
 {
@@ -161,7 +182,6 @@ kdb_bt(int argc, const char **argv)
 	} else if (strcmp(argv[0], "btc") == 0) {
 		unsigned long cpu = ~0;
 		struct task_struct *save_current_task = kdb_current_task;
-		char buf[80];
 		if (argc > 1)
 			return KDB_ARGCOUNT;
 		if (argc == 1) {
@@ -169,35 +189,22 @@ kdb_bt(int argc, const char **argv)
 			if (diag)
 				return diag;
 		}
-		/* Recursive use of kdb_parse, do not use argv after
-		 * this point */
-		argv = NULL;
 		if (cpu != ~0) {
-			if (cpu >= num_possible_cpus() || !cpu_online(cpu)) {
-				kdb_printf("no process for cpu %ld\n", cpu);
-				return 0;
-			}
-			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
-			kdb_parse(buf);
-			return 0;
-		}
-		kdb_printf("btc: cpu status: ");
-		kdb_parse("cpu\n");
-		for_each_online_cpu(cpu) {
-			void *kdb_tsk = KDB_TSK(cpu);
-
-			/* If a CPU failed to round up we could be here */
-			if (!kdb_tsk) {
-				kdb_printf("WARNING: no task for cpu %ld\n",
-					   cpu);
-				continue;
+			kdb_bt_cpu(cpu);
+		} else {
+			/*
+			 * Recursive use of kdb_parse, do not use argv after
+			 * this point.
+			 */
+			argv = NULL;
+			kdb_printf("btc: cpu status: ");
+			kdb_parse("cpu\n");
+			for_each_online_cpu(cpu) {
+				kdb_bt_cpu(cpu);
+				touch_nmi_watchdog();
 			}
-
-			sprintf(buf, "btt 0x%px\n", kdb_tsk);
-			kdb_parse(buf);
-			touch_nmi_watchdog();
+			kdb_set_current_task(save_current_task);
 		}
-		kdb_set_current_task(save_current_task);
 		return 0;
 	} else {
 		if (argc) {
-- 
2.23.0.351.gc4317032e6-goog

