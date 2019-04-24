Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4F7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BBF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKNPpcuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfDXQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:38:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41866 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732591AbfDXQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:38:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so9632736pgs.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PO8cqNNrsc0erE2qFybiWt9ZeKPOIyq2aL7nG116E4=;
        b=lKNPpcuRi/jRmdBX5Un4UMoF9evOPzRrfzwK/AP3gJqsY1umqamPoaG6/MpT9jgXgL
         CrgNPHJUsLzhAZiAhiHCvJtf21B0JouJPSD21ExLQPJmu4nu6AQS/j+fsZPdnJ09YX/C
         nps/moWtLTGWg3c+gBXol4F31ZKIA9SeJ4eNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PO8cqNNrsc0erE2qFybiWt9ZeKPOIyq2aL7nG116E4=;
        b=MDb6o0ASSHweX6JlowjJ4Jt1Zf4+oVbh2CzV6mQwgTfPmDwt/3NtV7dA27TM2vjmOZ
         IR+FLQpLu8X1bIS95HNHVhbzf4jsoPIEHYzJzJuCL6qqlillTuL5LaQD690OimzIFAlc
         i/LbxGVFqB8GugsRPeXg8UCrZXOm+w2m5q204WcepfRBV+0aQc6wZapt/bRp+G1PWPWR
         a2oW40DktN9Yr65b8uKg+nJhZfaqndnD5ZeHG7Y/N530k6w5T32fVAtR1E6oymgvwiXT
         7tVAsLoZsxJu0z1C6RQ0ef8T9TjI+zV6BVOnP+cAcREXoQWhZWCZ1VX/eE916tkZNtQJ
         m4gg==
X-Gm-Message-State: APjAAAWoW6DRoowGPGIAhufg4bYK7Ia0J2omi8rVzHa8BkL3CoNe39+v
        3aPb8ZnLvbAMlOWKmGRU8DdNVovu3+k=
X-Google-Smtp-Source: APXvYqw+WRueRcdgaAkh3mJqglMzdxBa+Azdx/uYhSx50VoUTeBsE10FaDB+/ehC5KQ8hMhj2SXAKQ==
X-Received: by 2002:a65:4343:: with SMTP id k3mr160190pgq.384.1556123886584;
        Wed, 24 Apr 2019 09:38:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b7sm38220062pfj.67.2019.04.24.09.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 09:38:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] seccomp: Make NEW_LISTENER and TSYNC flags exclusive
Date:   Wed, 24 Apr 2019 09:37:56 -0700
Message-Id: <20190424163756.40001-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424163756.40001-1-keescook@chromium.org>
References: <20190424163756.40001-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tycho@tycho.ws>

As the comment notes, the return codes for TSYNC and NEW_LISTENER
conflict, because they both return positive values, one in the case of
success and one in the case of error. So, let's disallow both of these
flags together.

While this is technically a userspace break, all the users I know
of are still waiting on me to land this feature in libseccomp, so I
think it'll be safe. Also, at present my use case doesn't require
TSYNC at all, so this isn't a big deal to disallow. If someone
wanted to support this, a path forward would be to add a new flag like
TSYNC_AND_LISTENER_YES_I_UNDERSTAND_THAT_TSYNC_WILL_JUST_RETURN_EAGAIN,
but the use cases are so different I don't see it really happening.

Finally, it's worth noting that this does actually fix a UAF issue: at the
end of seccomp_set_mode_filter(), we have:

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

But if ret > 0 because TSYNC raced, we'll install the listener fd and then
free the filter out from underneath it, causing a UAF when the task closes
it or dies. This patch also switches the condition to be simply if (ret),
so that if someone does add the flag mentioned above, they won't have to
remember to fix this too.

Reported-by: syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
CC: stable@vger.kernel.org # v5.0+
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index df27e499956a..3582eeb59893 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -502,7 +502,10 @@ seccomp_prepare_user_filter(const char __user *user_filter)
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
@@ -1258,6 +1261,16 @@ static long seccomp_set_mode_filter(unsigned int flags,
 	if (flags & ~SECCOMP_FILTER_FLAG_MASK)
 		return -EINVAL;
 
+	/*
+	 * In the successful case, NEW_LISTENER returns the new listener fd.
+	 * But in the failure case, TSYNC returns the thread that died. If you
+	 * combine these two flags, there's no way to tell whether something
+	 * succeeded or failed. So, let's disallow this combination.
+	 */
+	if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
+	    (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER))
+		return -EINVAL;
+
 	/* Prepare the new filter before holding any locks. */
 	prepared = seccomp_prepare_user_filter(filter);
 	if (IS_ERR(prepared))
@@ -1304,7 +1317,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 		mutex_unlock(&current->signal->cred_guard_mutex);
 out_put_fd:
 	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
-		if (ret < 0) {
+		if (ret) {
 			listener_f->private_data = NULL;
 			fput(listener_f);
 			put_unused_fd(listener);
-- 
2.17.1

