Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DCAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEE12089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fb/PZC7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfIIKYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:24:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54325 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390662AbfIIKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so1583016wmp.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu1wCZdYIYP1jJvk74CcBZj8+AFMfC/Evvd513Cb5Yg=;
        b=Fb/PZC7J5LnCdiTui3OYvoq5ZKTb0KInKov6ma1riHbkF7BSEr80N1Sof6/BZkmYBd
         oujqoQ9ATVhk8MujF+smYlsQEdOJxS/FxRBYkkd5iRgiNfUoSZrn0ZP3NtnOmly47Ijg
         GfoFBCjsBnidcfeejZKwNFneFR4jfSIwCC+ndnVgzl3mz0HhrcuzKdzYpT92oFxz+JVI
         bQYSvhA1EYI8GsCYuh6uufVHQ2YQQzJeha2PkjOGKtPGNxAnzImagdhYVHAsfwbo9Kgp
         /iiVNAF/n8D5AUMHwEh5Kse3uhCpYRvpPRujBc+bxCmKdWcX4GqKQBfH+ZsVpNPp8Kt0
         cAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu1wCZdYIYP1jJvk74CcBZj8+AFMfC/Evvd513Cb5Yg=;
        b=h3hAJP0dIffA3ehhqXsPEH8P0xLZJ5JuPH0JRz54zbwsktTd12L0UEMhPtUbKXO9+D
         tsBcmcm8w5sCLbigfYwnOFBpWICcClpuN/NokzHbMQF3+uVKLOxKmb89hVKQzC/M6tN0
         eehBgGORJZs7ikxaQ4YCXG3/nb3ae39gxuGc+fhzylTzjq+TCcY0jFTXCvuoOZiXsNmS
         4f3bZ6YuHx/Dn2tFCUE8HrzhD+Qz+tXpap+FHp9o9Gd8CGGT6XmT8vtmPMawudJVOLs9
         0OKmFhNsGe4JkwTdzcEpM1V18mZVcbycKrG7Nh8fxc65XIc5qlqD1Lme7VeAEabZzWj5
         cqEA==
X-Gm-Message-State: APjAAAUmy0FRKt+n26+lDdqCxkuoUbFNCzHtaSSV7OSBFjRJhhzJZOna
        FXsa3K3rlmdez6pKHaCwnRku2va8D/ekkg==
X-Google-Smtp-Source: APXvYqzLItSWebfZaJEphGQJBKCLGY7oWmQJ8incowXbvPbkOUINKisuMYaDsgYg+9c37v7q+MManw==
X-Received: by 2002:a1c:be12:: with SMTP id o18mr8864792wmf.128.1568024633598;
        Mon, 09 Sep 2019 03:23:53 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] select: Use ktime_t in do_sys_poll() and do_poll()
Date:   Mon,  9 Sep 2019 11:23:38 +0100
Message-Id: <20190909102340.8592-8-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plan is to store what's left of timeout in restart block as ktime_t
which will be used for futex() and nanosleep() timeouts too. That will
be a value to return with a new ptrace() request API.

Convert end_time argument of do_{sys_,}poll() functions to ktime_t as
a preparation ground for storing ktime_t inside restart_block.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 262300e58370..4af88feaa2fe 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -854,25 +854,22 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 }
 
 static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
-		   struct timespec64 *end_time)
+		   ktime_t end_time)
 {
 	poll_table* pt = &wait->pt;
-	ktime_t expire, *to = NULL;
+	ktime_t *to = NULL;
 	int timed_out = 0, count = 0;
 	u64 slack = 0;
 	__poll_t busy_flag = net_busy_loop_on() ? POLL_BUSY_LOOP : 0;
 	unsigned long busy_start = 0;
 
 	/* Optimise the no-wait case */
-	if (end_time && !end_time->tv_sec && !end_time->tv_nsec) {
+	if (ktime_compare(ktime_get(), end_time) >= 0) {
 		pt->_qproc = NULL;
 		timed_out = 1;
-	}
-
-	if (end_time && !timed_out) {
-		expire = timespec64_to_ktime(*end_time);
-		to = &expire;
-		slack = select_estimate_accuracy(expire);
+	} else {
+		to = &end_time;
+		slack = select_estimate_accuracy(end_time);
 	}
 
 	for (;;) {
@@ -936,7 +933,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			sizeof(struct pollfd))
 
 static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
-		struct timespec64 *end_time)
+		       ktime_t end_time)
 {
 	struct poll_wqueues table;
 	int err = -EFAULT, fdcount, len;
@@ -1004,16 +1001,15 @@ static long do_restart_poll(struct restart_block *restart_block)
 {
 	struct pollfd __user *ufds = restart_block->poll.ufds;
 	int nfds = restart_block->poll.nfds;
-	struct timespec64 *to = NULL, end_time;
+	ktime_t timeout = 0;
 	int ret;
 
 	if (restart_block->poll.has_timeout) {
-		end_time.tv_sec = restart_block->poll.tv_sec;
-		end_time.tv_nsec = restart_block->poll.tv_nsec;
-		to = &end_time;
+		timeout = ktime_set(restart_block->poll.tv_sec,
+				    restart_block->poll.tv_nsec);
 	}
 
-	ret = do_sys_poll(ufds, nfds, to);
+	ret = do_sys_poll(ufds, nfds, timeout);
 
 	if (ret == -ERESTARTNOHAND) {
 		restart_block->fn = do_restart_poll;
@@ -1025,16 +1021,17 @@ static long do_restart_poll(struct restart_block *restart_block)
 SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		int, timeout_msecs)
 {
-	struct timespec64 end_time, *to = NULL;
+	struct timespec64 end_time;
+	ktime_t timeout = 0;
 	int ret;
 
 	if (timeout_msecs >= 0) {
-		to = &end_time;
-		poll_select_set_timeout(to, timeout_msecs / MSEC_PER_SEC,
+		poll_select_set_timeout(&end_time, timeout_msecs / MSEC_PER_SEC,
 			NSEC_PER_MSEC * (timeout_msecs % MSEC_PER_SEC));
+		timeout = timespec64_to_ktime(end_time);
 	}
 
-	ret = do_sys_poll(ufds, nfds, to);
+	ret = do_sys_poll(ufds, nfds, timeout);
 
 	if (ret == -ERESTARTNOHAND) {
 		struct restart_block *restart_block;
@@ -1060,7 +1057,8 @@ static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 			void __user *tsp, const void __user *sigmask,
 			size_t sigsetsize, enum poll_time_type pt_type)
 {
-	struct timespec64 ts, end_time, *to = NULL;
+	struct timespec64 ts, *to = NULL;
+	ktime_t timeout = 0;
 	int ret;
 
 	if (tsp) {
@@ -1078,9 +1076,10 @@ static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 			return -ENOSYS;
 		}
 
-		to = &end_time;
-		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
+		to = &ts;
+		if (poll_select_set_timeout(&ts, ts.tv_sec, ts.tv_nsec))
 			return -EINVAL;
+		timeout = timespec64_to_ktime(ts);
 	}
 
 	if (!in_compat_syscall())
@@ -1091,8 +1090,8 @@ static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 	if (ret)
 		return ret;
 
-	ret = do_sys_poll(ufds, nfds, to);
-	return poll_select_finish(&end_time, tsp, pt_type, ret);
+	ret = do_sys_poll(ufds, nfds, timeout);
+	return poll_select_finish(to, tsp, pt_type, ret);
 }
 
 SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
-- 
2.23.0

