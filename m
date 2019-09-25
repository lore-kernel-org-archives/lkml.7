Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE3C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3721421D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7NBjARN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443268AbfIYUCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:02:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42456 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440129AbfIYUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:02:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so33347pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAwKOfkBAIB9WhQiaaLLy2L479R9P65WNB5nP2TJodw=;
        b=E7NBjARNhbdGyBXdEV8SyXfYFXQyEHoVKDUFATfGxCUW7CrsJ6l6NiTEHPv/xGeh0W
         BfaCeztNVfLgttNyC7QG1oPGJWoq+WBJLX1Yfnx/ZAwA0JU4ebpfWjQDrgQtfxGq10M0
         ovjSzK31JoYMMtGYyFANab+mXyrNWxh47wQig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAwKOfkBAIB9WhQiaaLLy2L479R9P65WNB5nP2TJodw=;
        b=eRho6Hy/e3Axc1Q/CvPAjKVeZmJs6KuZLXjnLltab0tv24raaKv2bTWvjdQ2jBX5JH
         WBVaNGTTuT6Pj2cxLjBBiP0aXhEx08ZLvahRxyQwBSu03HyDt/vI9JSESCGfQ1kHLrX4
         BGkCyDO6saxUJqnACHSfRF9rIJClwWOnpz798pWnWzn6B+C1VdELqXvnZ6dBrfCM2q6q
         hK3y3/ClTCUIuY/47Q69zrLS/YQMBguj8zavh/GWQKsiUc00KNJKpuSmKlb1aJJZqCeE
         yLbnM0qOr3sVCeNLJWaYO1OPUCF0vFoO8a9RLmHeMlJXz1tiAJj7dE66o2/PPFhN1X8S
         fNRg==
X-Gm-Message-State: APjAAAWvikw00+p+cvEAcSIveGOHzhYNCCZ3L0YaYdDdBoJZ1o6gZICA
        NlvNGvuJEV/W2Pov8O417egO9XlehIc=
X-Google-Smtp-Source: APXvYqwrbF0fnCNsefwBLmxVw3p+YzKu/TOroqO998JvI5nUXu99hXPkBBiV5cHhkxvVcrdR25vBvg==
X-Received: by 2002:a62:1888:: with SMTP id 130mr27979pfy.72.1569441770793;
        Wed, 25 Sep 2019 13:02:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d76sm458113pga.80.2019.09.25.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:02:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] kdb: Remove unused "argcount" param from kdb_bt1(); make btaprompt bool
Date:   Wed, 25 Sep 2019 13:02:18 -0700
Message-Id: <20190925125811.v3.2.Ibc2d4ec1b0e23dbf39dcd296e3c56d8520fbc144@changeid>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190925200220.157670-1-dianders@chromium.org>
References: <20190925200220.157670-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kdb_bt1() had a mysterious "argcount" parameter passed in (always
the number 5, by the way) and never used.  Presumably this is just old
cruft.  Remove it.  While at it, upgrade the btaprompt parameter to a
full fledged bool instead of an int.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Patch ("kdb: Remove unused "argcount" param from...") new for v3.

Changes in v2: None

 kernel/debug/kdb/kdb_bt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7e2379aa0a1e..120fc686c919 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -78,8 +78,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
  */
 
 static int
-kdb_bt1(struct task_struct *p, unsigned long mask,
-	int argcount, int btaprompt)
+kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
 {
 	char buffer[2];
 	if (kdb_getarea(buffer[0], (unsigned long)p) ||
@@ -106,7 +105,6 @@ int
 kdb_bt(int argc, const char **argv)
 {
 	int diag;
-	int argcount = 5;
 	int btaprompt = 1;
 	int nextarg;
 	unsigned long addr;
@@ -125,7 +123,7 @@ kdb_bt(int argc, const char **argv)
 		/* Run the active tasks first */
 		for_each_online_cpu(cpu) {
 			p = kdb_curr_task(cpu);
-			if (kdb_bt1(p, mask, argcount, btaprompt))
+			if (kdb_bt1(p, mask, btaprompt))
 				return 0;
 		}
 		/* Now the inactive tasks */
@@ -134,7 +132,7 @@ kdb_bt(int argc, const char **argv)
 				return 0;
 			if (task_curr(p))
 				continue;
-			if (kdb_bt1(p, mask, argcount, btaprompt))
+			if (kdb_bt1(p, mask, btaprompt))
 				return 0;
 		} kdb_while_each_thread(g, p);
 	} else if (strcmp(argv[0], "btp") == 0) {
@@ -148,7 +146,7 @@ kdb_bt(int argc, const char **argv)
 		p = find_task_by_pid_ns(pid, &init_pid_ns);
 		if (p) {
 			kdb_set_current_task(p);
-			return kdb_bt1(p, ~0UL, argcount, 0);
+			return kdb_bt1(p, ~0UL, false);
 		}
 		kdb_printf("No process with pid == %ld found\n", pid);
 		return 0;
@@ -159,7 +157,7 @@ kdb_bt(int argc, const char **argv)
 		if (diag)
 			return diag;
 		kdb_set_current_task((struct task_struct *)addr);
-		return kdb_bt1((struct task_struct *)addr, ~0UL, argcount, 0);
+		return kdb_bt1((struct task_struct *)addr, ~0UL, false);
 	} else if (strcmp(argv[0], "btc") == 0) {
 		unsigned long cpu = ~0;
 		struct task_struct *save_current_task = kdb_current_task;
@@ -211,7 +209,7 @@ kdb_bt(int argc, const char **argv)
 			kdb_show_stack(kdb_current_task, (void *)addr);
 			return 0;
 		} else {
-			return kdb_bt1(kdb_current_task, ~0UL, argcount, 0);
+			return kdb_bt1(kdb_current_task, ~0UL, false);
 		}
 	}
 
-- 
2.23.0.351.gc4317032e6-goog

