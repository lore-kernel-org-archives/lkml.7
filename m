Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CA6C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329BB21841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 17:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HRQVheon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfGQRVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 13:21:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35162 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQRVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:21:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so5170954pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iX1wftE5Aqgtgj+nGNer/hw/V9PAwsfP++ET+7am9rU=;
        b=HRQVheonDQr8B9B6F0GQNx/ySkrc3u72V+igTa8ElldPlOlzxJvFRR57GLMrAYz3mY
         imK5rGkWSJ605HsPuSQ0rogb0jaQMqwT3fbt8L/z2YDmA/PdskqVBuZgZFqUl45wbDDb
         3ln+xNw8a3r/ABjC5qqyBBe9Kz94J9V8zij3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iX1wftE5Aqgtgj+nGNer/hw/V9PAwsfP++ET+7am9rU=;
        b=ZZa8FVD5wzh+j4pIiD8tYD0MnEAi42EwOkXGDHyPVNy2xc2A/qU5/76CK+rhH/gJTZ
         6OmxopW2qkQMTnSCB5Siz/iaYb6pZ0LHR3mXM4EP9LJV6RvKhT6HctedLF4na79i7ydT
         b2Hs3Qttw5RtLA/JNBpkTCoGxrrciSUKkO4960XygrJp0Pg4eFAdohGzZbOZzS5hhmhN
         tHRYu7p/YTz2d1CEUHWamtES/UIjgkcI5Ri2HWnPF9Gy2wPPfvMdMyus31a6RYZTh4YC
         oNCcEIkNjytXbZPbfmMMLdjNTjM7pjwX5da8MWbngR9xdSLDO4lcWCTPb41NXDDCcdbQ
         qYbg==
X-Gm-Message-State: APjAAAWu7TEMxWyVghlQmXCNz6XZaeIXt+PSq0MtnSsZ6wBE7vssbE1S
        a4UtSEYXEDvqjZEJL+QEWVogKjDb
X-Google-Smtp-Source: APXvYqxWxl2bGR4dH0M+I2nha6OcTiJqIwwpb5dgj1wfx9kugj0hPDhAFZ2u7N7017Rtt3m1A2SBXQ==
X-Received: by 2002:a63:205f:: with SMTP id r31mr42551949pgm.159.1563384067498;
        Wed, 17 Jul 2019 10:21:07 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v4sm21679110pgf.20.2019.07.17.10.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 10:21:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd polling
Date:   Wed, 17 Jul 2019 13:21:00 -0400
Message-Id: <20190717172100.261204-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

There is a race between reading task->exit_state in pidfd_poll and writing
it after do_notify_parent calls do_notify_pidfd. Expected sequence of
events is:

CPU 0                            CPU 1
------------------------------------------------
exit_notify
  do_notify_parent
    do_notify_pidfd
  tsk->exit_state = EXIT_DEAD
                                  pidfd_poll
                                     if (tsk->exit_state)

However nothing prevents the following sequence:

CPU 0                            CPU 1
------------------------------------------------
exit_notify
  do_notify_parent
    do_notify_pidfd
                                   pidfd_poll
                                      if (tsk->exit_state)
  tsk->exit_state = EXIT_DEAD

This causes a polling task to wait forever, since poll blocks because
exit_state is 0 and the waiting task is not notified again. A stress
test continuously doing pidfd poll and process exits uncovered this bug,
and the below patch fixes it.

To fix this, we set tsk->exit_state before calling do_notify_pidfd.

Cc: kernel-team@android.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/exit.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index a75b6a7f458a..740ceacb4b76 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -720,6 +720,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	if (group_dead)
 		kill_orphaned_pgrp(tsk->group_leader, NULL);
 
+	tsk->exit_state = EXIT_ZOMBIE;
 	if (unlikely(tsk->ptrace)) {
 		int sig = thread_group_leader(tsk) &&
 				thread_group_empty(tsk) &&
@@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		ptrace_unlink(p);
 
 		/* If parent wants a zombie, don't release it now */
-		state = EXIT_ZOMBIE;
+		p->exit_state = EXIT_ZOMBIE;
 		if (do_notify_parent(p, p->exit_signal))
-			state = EXIT_DEAD;
-		p->exit_state = state;
+			p->exit_state = EXIT_DEAD;
+
+		state = p->exit_state;
 		write_unlock_irq(&tasklist_lock);
 	}
 	if (state == EXIT_DEAD)
-- 
2.22.0.657.g960e92d24f-goog

