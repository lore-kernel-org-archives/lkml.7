Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0713C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DB321920
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391522AbfIFU5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:57:23 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:41592 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387949AbfIFU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:57:23 -0400
Received: (qmail 6367 invoked by uid 2102); 6 Sep 2019 16:57:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2019 16:57:22 -0400
Date:   Fri, 6 Sep 2019 16:57:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] tools/memory-model: Fix data race detection for unordered
 store and load
Message-ID: <Pine.LNX.4.44L0.1909061649430.1627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Linux Kernel Memory Model gives an incorrect response
for the following litmus test:

C plain-WWC

{}

P0(int *x)
{
	WRITE_ONCE(*x, 2);
}

P1(int *x, int *y)
{
	int r1;
	int r2;
	int r3;

	r1 = READ_ONCE(*x);
	if (r1 == 2) {
		smp_rmb();
		r2 = *x;
	}
	smp_rmb();
	r3 = READ_ONCE(*x);
	WRITE_ONCE(*y, r3 - 1);
}

P2(int *x, int *y)
{
	int r4;

	r4 = READ_ONCE(*y);
	if (r4 > 0)
		WRITE_ONCE(*x, 1);
}

exists (x=2 /\ 1:r2=2 /\ 2:r4=1)

The memory model says that the plain read of *x in P1 races with the
WRITE_ONCE(*x) in P2.

The problem is that we have a write W and a read R related by neither
fre or rfe, but rather W ->coe W' ->rfe R, where W' is an intermediate
write (the WRITE_ONCE() in P0).  In this situation there is no
particular ordering between W and R, so either a wr-vis link from W to
R or an rw-xbstar link from R to W would prove that the accesses
aren't concurrent.

But the LKMM only looks for a wr-vis link, which is equivalent to
assuming that W must execute before R.  This is not necessarily true
on non-multicopy-atomic systems, as the WWC pattern demonstrates.

This patch changes the LKMM to accept either a wr-vis or a reverse
rw-xbstar link as a proof of non-concurrency.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 tools/memory-model/linux-kernel.cat |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -197,7 +197,7 @@ empty (wr-incoh | rw-incoh | ww-incoh) a
 (* Actual races *)
 let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
 let ww-race = (pre-race & co) \ ww-nonrace
-let wr-race = (pre-race & (co? ; rf)) \ wr-vis
+let wr-race = (pre-race & (co? ; rf)) \ wr-vis \ rw-xbstar^-1
 let rw-race = (pre-race & fr) \ rw-xbstar
 
 flag ~empty (ww-race | wr-race | rw-race) as data-race

