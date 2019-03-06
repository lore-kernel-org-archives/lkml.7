Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC6220663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="V6zDG2jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfCFUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:14:47 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46234 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfCFUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:14:45 -0500
Received: by mail-yw1-f66.google.com with SMTP id n12so11137454ywn.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55a6gCJDEclvsdzn2Vm2Gi8IIj39JbMXcsWZAnQ7VUg=;
        b=V6zDG2jFwkpeRLySlbw4QvWvf4M/hThcyCKA61yGrCvaviymXofsilEPzkLZ9UvCUb
         My25+3wNuO6bE0czrgNkv3ji0b9u9bNs1F45Go9RuUZQX7Jin9opHz+Rq4YILM4DjJHA
         RtDhjwvZ03bGFDVMsLYAHt9hWncGbK78NElk6Za+OdLbyVQ7yk5xMGQoK51vET874t0a
         TqTaytZte9BDz4WOvO+mZ3KuMe7jFRQKh5j9IV0Q9MgWD7jVpfWc/AFREK/tkeqwWFVF
         zNpPdNA+v8Nv4cqqOWkExpd31xQjyYdJvJEhZQ0N7DlPmEkSCajzPqJLxRIIU15Th3xc
         1N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55a6gCJDEclvsdzn2Vm2Gi8IIj39JbMXcsWZAnQ7VUg=;
        b=RW9F4V/Y323G1A3HkgbQuYH6xAuhEdSINCsuWKqHnlpCbInSPUNeqIJELPMBjjtz8k
         LkhxrU8YdUBDE6EGcIQSCb9zzWAV0kFwL8E9CqqapXgDhy1YekoVE3k5wIz0u4eri0o7
         kgmllA8Lh1Ay28I0Uq3H1wkZpDT+KEBholLn9YrUObljcdWBhCXVg4Ds8QrQ/kG6EOHD
         fsPJKKdg94z735OyyjjvoltrShc/stxCwEeJnLASOS3UPh+fPWgkhESwYo0wk4G+8/k2
         xU9xI5HXD2sBQjok2bRtfDLxjlEvAYjbk2QWGU6GrH7B/8/OfCAmnV1tTbrHGwOqeDs2
         XJOQ==
X-Gm-Message-State: APjAAAUn+oQw8RYj4K6dbYNXhwjZ7cuKobFY7E0/W4jGSn9uqVmuSH0W
        qH5xkJxelKr+jXsdPiCIHccpudsO8Pc=
X-Google-Smtp-Source: APXvYqxEM5LUQg+aGnD2TTUL9nv0i0ROjXBZnzytI/FJuhK9d1IiaHIDUYjGhRl2gOIp6rPX5SZKgA==
X-Received: by 2002:a25:7403:: with SMTP id p3mr8754164ybc.356.1551903284133;
        Wed, 06 Mar 2019 12:14:44 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id s5sm893015ywg.108.2019.03.06.12.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:14:43 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
Date:   Wed,  6 Mar 2019 13:14:13 -0700
Message-Id: <20190306201413.14153-2-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306201413.14153-1-tycho@tycho.ws>
References: <20190306201413.14153-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment notes, the return codes for TSYNC and NEW_LISTENER conflict,
because they both return positive values, one in the case of success and
one in the case of error. So, let's disallow both of these flags together.

While this is technically a userspace break, all the users I know of are
still waiting on me to land this feature in libseccomp, so I think it'll be
safe. Also, at present my use case doesn't require TSYNC at all, so this
isn't a big deal to disallow. If someone wanted to support this, a path
forward would be to add a new flag like
TSYNC_AND_LISTENER_YES_I_UNDERSTAND_THAT_TSYNC_WILL_JUST_RETURN_EAGAIN, but
the use cases are so different I don't see it really happening.

Finally, it's worth noting that this does actually fix a UAF issue: at the end
of seccomp_set_mode_filter(), we have:

        if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
                if (ret < 0) {
                        listener_f->private_data = NULL;
                        fput(listener_f);
                        put_unused_fd(listener);
                } else {
                        fd_install(listener, listener_f);
                        ret = listener;
                }
        }
out_free:
        seccomp_filter_free(prepared);

But if ret > 0 because TSYNC raced, we'll install the listener fd and then free
the filter out from underneath it, causing a UAF when the task closes it or
dies. This patch also switches the condition to be simply if (ret), so that
if someone does add the flag mentioned above, they won't have to remember
to fix this too.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
CC: stable@vger.kernel.org # v5.0+
---
 kernel/seccomp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d0d355ded2f4..79bada51091b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -500,7 +500,10 @@ seccomp_prepare_user_filter(const char __user *user_filter)
  *
  * Caller must be holding current->sighand->siglock lock.
  *
- * Returns 0 on success, -ve on error.
+ * Returns 0 on success, -ve on error, or
+ *   - in TSYNC mode: the pid of a thread which was either not in the correct
+ *     seccomp mode or did not have an ancestral seccomp filter
+ *   - in NEW_LISTENER mode: the fd of the new listener
  */
 static long seccomp_attach_filter(unsigned int flags,
 				  struct seccomp_filter *filter)
@@ -1256,6 +1259,16 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	if (flags & ~SECCOMP_FILTER_FLAG_MASK)
 		return -EINVAL;
 
+	/*
+	 * In the successful case, NEW_LISTENER returns the new listener fd.
+	 * But in the failure case, TSYNC returns the thread that died. If you
+	 * combine these two flags, there's no way to tell whether something
+	 * succeded or failed. So, let's disallow this combination.
+	 */
+	if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
+	    (flags && SECCOMP_FILTER_FLAG_NEW_LISTENER))
+		return -EINVAL;
+
 	/* Prepare the new filter before holding any locks. */
 	prepared = seccomp_prepare_user_filter(filter);
 	if (IS_ERR(prepared))
@@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		mutex_unlock(&current->signal->cred_guard_mutex);
 out_put_fd:
 	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
-		if (ret < 0) {
+		if (ret) {
 			listener_f->private_data = NULL;
 			fput(listener_f);
 			put_unused_fd(listener);
-- 
2.19.1

