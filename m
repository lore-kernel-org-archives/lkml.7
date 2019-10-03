Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0736C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7D9222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570062414;
	bh=ludgvCY/xtZ3ETVPp+pgZvEQq7yeOgwxE3lquMw3mH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6vyzlUTVq8+9cEPYiK5IqeVBKZx2jvZKRK/125X2/Y9uko1JO1iEON/1H1HGm5/Z
	 viKFQYkGJYw1zLmZapwFNF5gQBMTWn/eFPK4GoIXHhbqBL2VLD5YBmUUPKr615ZG7d
	 mq+1/yhplYtvWEfzPQ1umgdvjjnPwIUoyye21dj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfJCA0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJCA0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D2BC222C0;
        Thu,  3 Oct 2019 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062412;
        bh=ludgvCY/xtZ3ETVPp+pgZvEQq7yeOgwxE3lquMw3mH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AsBgrw8ktvt+nup/CfvCT9ftouJLDFi20lZ/VCjK4+4nbKeYIBTfhkyKw6btF+6Z
         gXqCxHutjXdpPoNdsdnLDF5V8Qu/XUr3CVJ4t/JRgujP4nHniN8p2VHxf5CVFbuy3P
         WU6rfMhmYo8V699KEHAAqb6uFJw1fXPMztuAVotA=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 01/32] tools/memory-model: Fix data race detection for unordered store and load
Date:   Wed,  2 Oct 2019 17:26:19 -0700
Message-Id: <20191003002650.11249-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

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
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.cat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index ea2ff4b..2a9b4fe 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -197,7 +197,7 @@ empty (wr-incoh | rw-incoh | ww-incoh) as plain-coherence
 (* Actual races *)
 let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
 let ww-race = (pre-race & co) \ ww-nonrace
-let wr-race = (pre-race & (co? ; rf)) \ wr-vis
+let wr-race = (pre-race & (co? ; rf)) \ wr-vis \ rw-xbstar^-1
 let rw-race = (pre-race & fr) \ rw-xbstar
 
 flag ~empty (ww-race | wr-race | rw-race) as data-race
-- 
2.9.5

