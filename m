Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383F0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F512084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFTPzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:55:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44850 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726551AbfFTPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:55:37 -0400
Received: (qmail 4690 invoked by uid 2102); 20 Jun 2019 11:55:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jun 2019 11:55:36 -0400
Date:   Thu, 20 Jun 2019 11:55:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] tools: memory-model: Expand definition of barrier
Message-ID: <Pine.LNX.4.44L0.1906201151210.1512-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66be4e66a7f4 ("rcu: locking and unlocking need to always be at
least barriers") added compiler barriers back into rcu_read_lock() and
rcu_read_unlock().  Furthermore, srcu_read_lock() and
srcu_read_unlock() have always contained compiler barriers.

The Linux Kernel Memory Model ought to know about these barriers.
This patch adds them into the memory model.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.cat |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -47,7 +47,8 @@ let strong-fence = mb | gp
 let nonrw-fence = strong-fence | po-rel | acq-po
 let fence = nonrw-fence | wmb | rmb
 let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
-		Before-atomic | After-atomic | Acquire | Release) |
+		Before-atomic | After-atomic | Acquire | Release |
+		Rcu-lock | Rcu-unlock | Srcu-lock | Srcu-unlock) |
 	(po ; [Release]) | ([Acquire] ; po)
 
 (**********************************)

