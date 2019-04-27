Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9616C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9D206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfD0PPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60996 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0000zA-Jn; Sat, 27 Apr 2019 16:15:12 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004Uu-0Z; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Jane Chu" <jane.chu@oracle.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.544118127@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 084/202] mm: hwpoison: use do_send_sig_info() instead
 of force_sig()
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

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

commit 6376360ecbe525a9c17b3d081dfd88ba3e4ed65b upstream.

Currently memory_failure() is racy against process's exiting, which
results in kernel crash by null pointer dereference.

The root cause is that memory_failure() uses force_sig() to forcibly
kill asynchronous (meaning not in the current context) processes.  As
discussed in thread https://lkml.org/lkml/2010/6/8/236 years ago for OOM
fixes, this is not a right thing to do.  OOM solves this issue by using
do_send_sig_info() as done in commit d2d393099de2 ("signal:
oom_kill_task: use SEND_SIG_FORCED instead of force_sig()"), so this
patch is suggesting to do the same for hwpoison.  do_send_sig_info()
properly accesses to siglock with lock_task_sighand(), so is free from
the reported race.

I confirmed that the reported bug reproduces with inserting some delay
in kill_procs(), and it never reproduces with this patch.

Note that memory_failure() can send another type of signal using
force_sig_mceerr(), and the reported race shouldn't happen on it because
force_sig_mceerr() is called only for synchronous processes (i.e.
BUS_MCEERR_AR happens only when some process accesses to the corrupted
memory.)

Link: http://lkml.kernel.org/r/20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reported-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/memory-failure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -360,7 +360,8 @@ static void kill_procs(struct list_head
 				printk(KERN_ERR
 		"MCE %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 					pfn, tk->tsk->comm, tk->tsk->pid);
-				force_sig(SIGKILL, tk->tsk);
+				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
+						 tk->tsk, PIDTYPE_PID);
 			}
 
 			/*

