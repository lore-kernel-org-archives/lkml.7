Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B64C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B2820679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DFuAqy07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFWKWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 06:22:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWKWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 06:22:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NAMOV02589435
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 03:22:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NAMOV02589435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561285345;
        bh=fL//r75TyoOH12BOusdMff8Y1ddZJgL7vjP9d2f+UKs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DFuAqy07/H5VoPIWAKG0DcdQ51PjdgxOeRuhRho5zbpcz2HAVmU9RoeY1dDvE3/k9
         fVv0El+zOgyxzimj+5yJlYWoC4GMbrSQ+AuDx0z49bZAc12f6CBCDQHQz+KGfJizuy
         RerD05FE6yfMNzCNMmytgHJPO/WY2Do6jsqau0WabNxjmTpqDhx5bIvTVRJ+XBerUk
         cBCBLVO4iUH9H/NMpxrCzy7h2K45jYqW37E18WeywcRGqNF2id3Jdy+yBh9ehFEu5l
         zYY7jKpC8xe5kMc66d9Z0jedwPN+LD9H+fDJ/kaI8yK6HT++fnhfg+0cnlkSt4dq1e
         /YWTqyTD3CuKA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NAMODK2589431;
        Sun, 23 Jun 2019 03:22:24 -0700
Date:   Sun, 23 Jun 2019 03:22:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Huckleberry <tipbot@zytor.com>
Message-ID: <tip-a9314773a91a1d3b36270085246a6715a326ff00@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        ndesaulniers@google.com, hpa@zytor.com, nhuck@google.com
Reply-To: tglx@linutronix.de, nhuck@google.com, ndesaulniers@google.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190614181604.112297-1-nhuck@google.com>
References: <20190614181604.112297-1-nhuck@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer_list: Guard procfs specific code
Git-Commit-ID: a9314773a91a1d3b36270085246a6715a326ff00
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a9314773a91a1d3b36270085246a6715a326ff00
Gitweb:     https://git.kernel.org/tip/a9314773a91a1d3b36270085246a6715a326ff00
Author:     Nathan Huckleberry <nhuck@google.com>
AuthorDate: Fri, 14 Jun 2019 11:16:04 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 23 Jun 2019 00:08:52 +0200

timer_list: Guard procfs specific code

With CONFIG_PROC_FS=n the following warning is emitted:

kernel/time/timer_list.c:361:36: warning: unused variable
'timer_list_sops' [-Wunused-const-variable]
   static const struct seq_operations timer_list_sops = {

Add #ifdef guard around procfs specific code.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: john.stultz@linaro.org
Cc: sboyd@kernel.org
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/534
Link: https://lkml.kernel.org/r/20190614181604.112297-1-nhuck@google.com

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
