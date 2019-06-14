Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AEBC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F762177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCEDsL+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFNSQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:16:15 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40891 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:16:15 -0400
Received: by mail-pf1-f201.google.com with SMTP id z1so2336848pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b6DNMW7ju1QuwEJuOCkPftjguZ67YDFfeRj9euEw5FE=;
        b=LCEDsL+9tDZLeLXZyYDgO0JsGOheHPdb/buNpwapdVddiULtuK0nXPOeoapk2O9gkc
         G0sDsCwj2k2OI6hJF2dsHVyqSlb+jA7LDSKjohVLMRozw/am+gzYMKgWhRwjaAcSyuXD
         YvkOvIbImpSyMq8RncfaghH5wqZXyRXGFy/x+yNoyZn1LQpPKpJTiwj5Xao/bp/9zD09
         2eywAq5r+jzWCNtCvjJRL7Us7KLhM4xuxerC5FNdyLQn37DSgJpQnvFtN3oWsBzhoFKi
         6n2bBQWsr+TGzssntlByzgT0PmsmiPKd/8gmgUeNabokjzvgrlRy/xGBrgHSTbu3TzqI
         1C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b6DNMW7ju1QuwEJuOCkPftjguZ67YDFfeRj9euEw5FE=;
        b=ZjwsKh742bEZjezPpxb7EeYZBt15wjefXZLC9wfW4FvSrRpzilom62He/SSCwJs1oH
         Si/sWqvShA4ha5r8LK1wcBpztdDiA1HKE9wmIPNZ2dc9vdk5JkT16YUeMseKyjOwMjDr
         Bvwn+a+jmocouUxhWBP/TKRCtwy8fF0akZBSUoSSEXhyrm1jl07Ap/xL/Epj829DzQjX
         HQ0f2+MUXgFSJ5prIZBFPFTaLV4UTdB6JqqwRX7DRowBwqsCmu1iDGpqTDGFquAxIPt1
         04ExEwJmo3nMj2y0wZ0kWj1dRf2BuPSkefXmz0Ryrs3J+d0BmRwUG6NJzVjmIQbi1UfW
         DYVw==
X-Gm-Message-State: APjAAAViNgwTPZkOAZ0UuyQv78CkmMlsZxPxutKuj+1B18pso6PZfUQR
        o/Sq+DiquqCzH4k0BUndb+PyPdXYzQ==
X-Google-Smtp-Source: APXvYqz+I33l4X0PevCoKdBcBkV/EBnsh8yHM+WYyAtKrJaIyDH6vB/8SfzS97i5346++HiloYuetB88QQ==
X-Received: by 2002:a63:d512:: with SMTP id c18mr15175899pgg.239.1560536174587;
 Fri, 14 Jun 2019 11:16:14 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:16:04 -0700
Message-Id: <20190614181604.112297-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] timer_list: Fix Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produced the following warning when using allnoconfig

kernel/time/timer_list.c:361:36: warning: unused variable
'timer_list_sops' [-Wunused-const-variable]
   static const struct seq_operations timer_list_sops = {

Code reliant on CONFIG_PROC_FS is not in ifdef guard.
Created ifdef guard around proc_fs specific code.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/534
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 kernel/time/timer_list.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 98ba50dcb1b2..acb326f5f50a 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -282,23 +282,6 @@ static inline void timer_list_header(struct seq_file *m, u64 now)
 	SEQ_printf(m, "\n");
 }
 
-static int timer_list_show(struct seq_file *m, void *v)
-{
-	struct timer_list_iter *iter = v;
-
-	if (iter->cpu == -1 && !iter->second_pass)
-		timer_list_header(m, iter->now);
-	else if (!iter->second_pass)
-		print_cpu(m, iter->cpu, iter->now);
-#ifdef CONFIG_GENERIC_CLOCKEVENTS
-	else if (iter->cpu == -1 && iter->second_pass)
-		timer_list_show_tickdevices_header(m);
-	else
-		print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
-#endif
-	return 0;
-}
-
 void sysrq_timer_list_show(void)
 {
 	u64 now = ktime_to_ns(ktime_get());
@@ -317,6 +300,24 @@ void sysrq_timer_list_show(void)
 	return;
 }
 
+#ifdef CONFIG_PROC_FS
+static int timer_list_show(struct seq_file *m, void *v)
+{
+	struct timer_list_iter *iter = v;
+
+	if (iter->cpu == -1 && !iter->second_pass)
+		timer_list_header(m, iter->now);
+	else if (!iter->second_pass)
+		print_cpu(m, iter->cpu, iter->now);
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	else if (iter->cpu == -1 && iter->second_pass)
+		timer_list_show_tickdevices_header(m);
+	else
+		print_tickdevice(m, tick_get_device(iter->cpu), iter->cpu);
+#endif
+	return 0;
+}
+
 static void *move_iter(struct timer_list_iter *iter, loff_t offset)
 {
 	for (; offset; offset--) {
@@ -376,3 +377,4 @@ static int __init init_timer_list_procfs(void)
 	return 0;
 }
 __initcall(init_timer_list_procfs);
+#endif
-- 
2.22.0.410.gd8fdbe21b5-goog

