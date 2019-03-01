Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97090C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABCB218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfCAJlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:41:05 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:49980 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733133AbfCAJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:41:04 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id iZgv1z00T3XaVaC01Zgvc3; Fri, 01 Mar 2019 10:41:02 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gzef1-0005Ll-Hl; Fri, 01 Mar 2019 10:40:55 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gzef1-0002xE-EK; Fri, 01 Mar 2019 10:40:55 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] Documentation/locking/lockdep: Drop last two chars of sample states
Date:   Fri,  1 Mar 2019 10:40:52 +0100
Message-Id: <20190301094052.11288-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the removal of FS_RECLAIM annotations, lockdep states contain four
characters, not six.

Fixes: e5684bbfc3f03480 ("Documentation/locking/lockdep: Update info about states")
Fixes: d92a8cfcb37ecd13 ("locking/lockdep: Rework FS_RECLAIM annotation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix silly before/after inversion in patch description.
---
 Documentation/RCU/lockdep-splat.txt      | 6 +++---
 Documentation/locking/lockdep-design.txt | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/lockdep-splat.txt b/Documentation/RCU/lockdep-splat.txt
index 238e9f61352f6187..9423b633526d14df 100644
--- a/Documentation/RCU/lockdep-splat.txt
+++ b/Documentation/RCU/lockdep-splat.txt
@@ -24,11 +24,11 @@ other info that might help us debug this:
 
 rcu_scheduler_active = 1, debug_locks = 0
 3 locks held by scsi_scan_6/1552:
- #0:  (&shost->scan_mutex){+.+.+.}, at: [<ffffffff8145efca>]
+ #0:  (&shost->scan_mutex){+.+.}, at: [<ffffffff8145efca>]
 scsi_scan_host_selected+0x5a/0x150
- #1:  (&eq->sysfs_lock){+.+...}, at: [<ffffffff812a5032>]
+ #1:  (&eq->sysfs_lock){+.+.}, at: [<ffffffff812a5032>]
 elevator_exit+0x22/0x60
- #2:  (&(&q->__queue_lock)->rlock){-.-...}, at: [<ffffffff812b6233>]
+ #2:  (&(&q->__queue_lock)->rlock){-.-.}, at: [<ffffffff812b6233>]
 cfq_exit_queue+0x43/0x190
 
 stack backtrace:
diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 49f58a07ee7b19c8..39fae143c9cbf5ff 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -45,10 +45,10 @@ When locking rules are violated, these state bits are presented in the
 locking error messages, inside curlies. A contrived example:
 
    modprobe/2287 is trying to acquire lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
    but task is already holding lock:
-    (&sio_locks[i].lock){-.-...}, at: [<c02867fd>] mutex_lock+0x21/0x24
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
 The bit position indicates STATE, STATE-read, for each of the states listed
-- 
2.17.1

