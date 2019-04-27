Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2D1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1CC208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfD0PZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:25:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34782 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbfD0PZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:25:45 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zP-IT; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004RL-Dc; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "James Morris" <james.morris@microsoft.com>,
        syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com,
        "Kees Cook" <keescook@chromium.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.886211100@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 047/202] Yama: Check for pid death before checking
 ancestry
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 9474f4e7cd71a633fa1ef93b7daefd44bbdfd482 upstream.

It's possible that a pid has died before we take the rcu lock, in which
case we can't walk the ancestry list as it may be detached. Instead, check
for death first before doing the walk.

Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com
Fixes: 2d514487faf1 ("security: Yama LSM")
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/yama/yama_lsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -299,7 +299,9 @@ int yama_ptrace_access_check(struct task
 			break;
 		case YAMA_SCOPE_RELATIONAL:
 			rcu_read_lock();
-			if (!task_is_descendant(current, child) &&
+			if (!pid_alive(child))
+				rc = -EPERM;
+			if (!rc && !task_is_descendant(current, child) &&
 			    !ptracer_exception_found(current, child) &&
 			    !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
 				rc = -EPERM;

