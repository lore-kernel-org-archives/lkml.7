Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8593C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0BF22DA7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMeKccAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfHSXlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:41:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39315 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfHSXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:41:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so2125327pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbeJELJt4yIGEhE/X9GRRM8X1m9EGNSNDo3EW/BYEes=;
        b=fMeKccAI6lBQNvCfoQV4v6qBvMdAH0T9g8CjKXNIx1cPaQ4rQ+1Kq2Ut+2C4eSadkD
         VUEdvlPJgcmSvF73Z2OB3ZJzh7zLPiZYxPE3eJvCrn7y8Gz8iRR9f8hwnM7a04jlBxbP
         +qX9jkeutY2O8jjNHf8HVe/7o5331zFJnqeL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbeJELJt4yIGEhE/X9GRRM8X1m9EGNSNDo3EW/BYEes=;
        b=eIEquQWNE83g9PxtYdYovG0AUWLbEOfJ7NBd6SPxAAMU/2YJysWPko3090pPqrk14T
         6uAnYC/I5gLY06mJbazqdnF0a+JpTeI5s4D8FZPKJBEw7/RQKyQttee1nLqXD7j4TujH
         5OJ7O6hjVqiBeya5U+Nqryxfc1ObDQ51ORpNwhxZ/wsiNyx7LI4UwrhWM1pXLtDLzR26
         dqLLh96WLmFI1ttKSrzehcRIbsE7VROiC8PbVvQZw+RSUBmRfyEtEvnT+cUTAAqgDgLt
         AvdvfbGuzLCDbvuKJvOAHNjuzYeQQ+cpbjk/PpjwDUmFkZmjsllW/s3ZN6PN4KvFv8CG
         vk3Q==
X-Gm-Message-State: APjAAAU7ZFIlzB9ozo+gqXyJQcqyQEfrmSjdzwSc1wZlw9xLtVTqeHJ8
        7/6MYCCyTtQ3VFxNUATkJ12vdg==
X-Google-Smtp-Source: APXvYqzsFtbJdhYh/+Iruj5b5YlJcm3VFKU+IRNlxr49ybr/vufBEOgAKggdIWnSj76CjWchhxCTgQ==
X-Received: by 2002:a65:518a:: with SMTP id h10mr20084317pgq.117.1566258078186;
        Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s16sm18169083pfs.6.2019.08.19.16.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 16:41:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Drew Davenport <ddavenport@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] bug: Lift "cut here" out of __warn()
Date:   Mon, 19 Aug 2019 16:41:08 -0700
Message-Id: <20190819234111.9019-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for cleaning up "cut here", move the "cut here" logic
up out of __warn() and into callers that pass non-NULL args. For anyone
looking closely, there are two callers that pass NULL args: one already
explicitly prints "cut here". The remaining case is covered by how a
WARN is built, which will be cleaned up in the next patch.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/panic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 51efdeb2558e..dc2243429903 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -551,9 +551,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 {
 	disable_trace_on_warning();
 
-	if (args)
-		pr_warn(CUT_HERE);
-
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
 			raw_smp_processor_id(), current->pid, file, line,
@@ -597,8 +594,9 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 {
 	struct warn_args args;
 
+	pr_warn(CUT_HERE);
+
 	if (!fmt) {
-		pr_warn(CUT_HERE);
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
 		return;
-- 
2.17.1

