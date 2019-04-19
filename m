Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E4C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC91F20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UwqqPr41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfDSSho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfDSShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIacsU384682
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:36:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIacsU384682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699000;
        bh=bk/Xvo46egf4v/i6cOk0a61d+qBWf/xv2B0IzVZZhuU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UwqqPr41LfVkhSNxjzEBZXvXVxHJpKDhlL3i08FbjtfdoopbiPlhIs+XDOqErbn3e
         Msmb/jxQrEeQci2AyoO+LF4naMDqj076VQ0721nC0mBBIOaHoddgBDDCmXuv443s8Q
         4aX9LcxgmIn2K8OnRVbgdPelU5e5Mfj+pR58x+0x1bQQkGSxnqY/VqDEuJp5OpN/t7
         Q5yHqz+SlC0A/BlxSLDy2ghz6Tp4EsIvv8IqBrZt1RQjkUUJJlYiYcOULbBZUvsv70
         tQ2YWfLg4rEPETGLq3/0VfRSAnCboeKkS1vDyG4+JrILo5yCPAWMfMLMWXUpqKvi8O
         J7Kx8jBKGcODQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIabWq384679;
        Fri, 19 Apr 2019 11:36:37 -0700
Date:   Fri, 19 Apr 2019 11:36:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-b1b944f7230f4101b5a293d5ac3b7a9627ed5e6f@git.kernel.org>
Cc:     brgerst@gmail.com, jkosina@suse.cz, mingo@kernel.org,
        jbaron@akamai.com, gregkh@linuxfoundation.org, hpa@zytor.com,
        bristot@redhat.com, peterz@infradead.org, jolsa@redhat.com,
        mtosatti@redhat.com, rostedt@goodmis.org,
        alexander.shishkin@linux.intel.com, dvlasenk@redhat.com,
        mhiramat@kernel.org, williams@redhat.com, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de, tglx@linutronix.de,
        acme@redhat.com, crecklin@redhat.com, linux-kernel@vger.kernel.org,
        swood@redhat.com, luto@kernel.org
Reply-To: mingo@kernel.org, gregkh@linuxfoundation.org, hpa@zytor.com,
          jbaron@akamai.com, brgerst@gmail.com, jkosina@suse.cz,
          jolsa@redhat.com, bristot@redhat.com, peterz@infradead.org,
          rostedt@goodmis.org, mtosatti@redhat.com, dvlasenk@redhat.com,
          williams@redhat.com, mhiramat@kernel.org,
          alexander.shishkin@linux.intel.com, jpoimboe@redhat.com,
          crecklin@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          acme@redhat.com, luto@kernel.org, swood@redhat.com
In-Reply-To: <206640539a01e31b6f4ef4ef74962b1394e2f930.1545228276.git.bristot@redhat.com>
References: <206640539a01e31b6f4ef4ef74962b1394e2f930.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] jump_label: Add for_each_label_entry helper
Git-Commit-ID: b1b944f7230f4101b5a293d5ac3b7a9627ed5e6f
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

Commit-ID:  b1b944f7230f4101b5a293d5ac3b7a9627ed5e6f
Gitweb:     https://git.kernel.org/tip/b1b944f7230f4101b5a293d5ac3b7a9627ed5e6f
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:26 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:34 +0200

jump_label: Add for_each_label_entry helper

Add a helper macro to make jump entry iteration code more readable.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/206640539a01e31b6f4ef4ef74962b1394e2f930.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/jump_label.h | 3 +++
 kernel/jump_label.c        | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3e113a1fa0f1..7e91af98bbb1 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -227,6 +227,9 @@ extern void static_key_disable(struct static_key *key);
 extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
 
+#define for_each_label_entry(key, entry, stop)				  \
+	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
+
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
  * the inclusion of atomic.h is problematic for inclusion of jump_label.h
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bad96b476eb6..288d630da22d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -379,7 +379,7 @@ static void __jump_label_update(struct static_key *key,
 				struct jump_entry *stop,
 				bool init)
 {
-	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
+	for_each_label_entry(key, entry, stop) {
 		/*
 		 * An entry->code of 0 indicates an entry which has been
 		 * disabled because it was in an init text area.
