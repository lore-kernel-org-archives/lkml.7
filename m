Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01799C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CD21882
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZzFmB7sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfKITSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:18:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46508 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfKITRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:17:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id r18so6290698pgu.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDlNx6EGMrp3vN/hMVd1kyT0CxIKEbIPYjtFrXlWFSw=;
        b=ZzFmB7sQK3gNmFEeDI9qpvLvJ1+N05YxWvEuumFV/BcGrWe9iFzRin5aqvjGTKaR9P
         jqm9KQ+kCcE6UAOTUuZCEzJ1Y28Zql+YlERBbd4b1VaF/hxXwZxAYXfL49v/4yFpClf7
         JONMJc6wtb1wy2WdlfJr4HYyIBX2UU49UcKYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDlNx6EGMrp3vN/hMVd1kyT0CxIKEbIPYjtFrXlWFSw=;
        b=qQYLzZKVLcA+EnHmRa0PRxsSF9WIqOz51p2Y7tsI4iRWuifqfigQ0xQO8ZRUbA8mf8
         ZKBwCDC4z+fObzSvB9N057wkdi+q/DR4OM927jEwN4XHKXJV8qJy/nOGxt1R43DTgZL3
         o6Tvp1eusRUcScVL035c0Pe9BnuqkyABrfsjyrc3jQ5Ti69/2cftOvTlbr2E9zPg+hFW
         wAola9VSf4PuE0ITmECku0EwnnKQGNz+vPbPRFdunBbRWQG86h6SxDzs1HaDi+Gv2ksG
         NUMlWXFMGBRWI4cMPm2CSyagDeH2/ERxrXrRGj5wcsy12E4NgFS/edehneap25mNi1Ja
         5f3A==
X-Gm-Message-State: APjAAAW+WP/NZ2xptPpq/nacVFnjOyazrqivmrRVAqoHnQriyn+QyGQo
        AcdVmCYOSpulaotRmQBBHUN9aA==
X-Google-Smtp-Source: APXvYqylPzIZ+Djw1JoI0Ai9UaxOOYX4sETzbck6F8sybWeqW/bp7Rd3HddEPdVW3U7hfLf/l1vWvw==
X-Received: by 2002:a63:7c10:: with SMTP id x16mr19430535pgc.176.1573327072998;
        Sat, 09 Nov 2019 11:17:52 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i11sm9193577pgd.7.2019.11.09.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 11:17:52 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     qiaochong@loongson.cn, kgdb-bugreport@lists.sourceforge.net,
        ralf@linux-mips.org, Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Will Deacon <will@kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4/5] kdb: Gid rid of implicit setting of the current task / regs
Date:   Sat,  9 Nov 2019 11:16:43 -0800
Message-Id: <20191109111624.4.Ibc3d982bbeb9e46872d43973ba808cd4c79537c7@changeid>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191109191644.191766-1-dianders@chromium.org>
References: <20191109191644.191766-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some (but not all?) of the kdb backtrace paths would cause the
kdb_current_task and kdb_current_regs to remain changed.  As discussed
in a review of a previous patch [1], this doesn't seem intuitive, so
let's fix that.

...but, it turns out that there's actually no longer any reason to set
the current task / current regs while backtracing anymore anyway.  As
of commit 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs
that aren't the master") if we're backtracing on a task running on a
CPU we ask that CPU to do the backtrace itself.  Linux can do that
without anything fancy.  If we're doing backtrace on a sleeping task
we can also do that fine without updating globals.  So this patch
mostly just turns into deleting a bunch of code.

[1] https://lore.kernel.org/r/20191010150735.dhrj3pbjgmjrdpwr@holly.lan

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_bt.c      | 8 +-------
 kernel/debug/kdb/kdb_main.c    | 2 +-
 kernel/debug/kdb/kdb_private.h | 1 -
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 4af48ac53625..3de0cc780c16 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -119,7 +119,6 @@ kdb_bt_cpu(unsigned long cpu)
 		return;
 	}
 
-	kdb_set_current_task(kdb_tsk);
 	kdb_bt1(kdb_tsk, ~0UL, false);
 }
 
@@ -166,10 +165,8 @@ kdb_bt(int argc, const char **argv)
 		if (diag)
 			return diag;
 		p = find_task_by_pid_ns(pid, &init_pid_ns);
-		if (p) {
-			kdb_set_current_task(p);
+		if (p)
 			return kdb_bt1(p, ~0UL, false);
-		}
 		kdb_printf("No process with pid == %ld found\n", pid);
 		return 0;
 	} else if (strcmp(argv[0], "btt") == 0) {
@@ -178,11 +175,9 @@ kdb_bt(int argc, const char **argv)
 		diag = kdbgetularg((char *)argv[1], &addr);
 		if (diag)
 			return diag;
-		kdb_set_current_task((struct task_struct *)addr);
 		return kdb_bt1((struct task_struct *)addr, ~0UL, false);
 	} else if (strcmp(argv[0], "btc") == 0) {
 		unsigned long cpu = ~0;
-		struct task_struct *save_current_task = kdb_current_task;
 		if (argc > 1)
 			return KDB_ARGCOUNT;
 		if (argc == 1) {
@@ -204,7 +199,6 @@ kdb_bt(int argc, const char **argv)
 				kdb_bt_cpu(cpu);
 				touch_nmi_watchdog();
 			}
-			kdb_set_current_task(save_current_task);
 		}
 		return 0;
 	} else {
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 4d44b3746836..ba12e9f4661e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1138,7 +1138,7 @@ static void kdb_dumpregs(struct pt_regs *regs)
 	console_loglevel = old_lvl;
 }
 
-void kdb_set_current_task(struct task_struct *p)
+static void kdb_set_current_task(struct task_struct *p)
 {
 	kdb_current_task = p;
 
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index e829b22f3946..2e296e4a234c 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -240,7 +240,6 @@ extern void *debug_kmalloc(size_t size, gfp_t flags);
 extern void debug_kfree(void *);
 extern void debug_kusage(void);
 
-extern void kdb_set_current_task(struct task_struct *);
 extern struct task_struct *kdb_current_task;
 extern struct pt_regs *kdb_current_regs;
 
-- 
2.24.0.432.g9d3f5f5b63-goog

