Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B002C218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfCVPuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:50:19 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbfCVPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:50:17 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MbRbr-1gaEfE3zyb-00bqAN; Fri, 22 Mar 2019 16:49:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Florian La Roche <florian.laroche@googlemail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 24/25] lib/int_sqrt: optimize small argument
Date:   Fri, 22 Mar 2019 16:44:15 +0100
Message-Id: <20190322154425.3852517-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ihhiFo5aEMgWh25D9Bhc7/1vpeO4x1oikMd7eBfRIzsE2G0q9Gr
 hIr6QmP9RMez6Ix4DFFMIQDzR3YaedPi3Pz/K1W8ErI+BdhZVywglbZcwR6f+6SJT27oNm8
 g1lGrthhnwWUDhmA10q3KnEkYDrWCtlwdZ320LWQYbCb/IEQT/+zYeBzFZsmA/cbli652aU
 JgBDPkDU+yn7METUKJ6wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qJH3pP5UbgI=:5C8uo+IYJWNbuNNH4ebN7V
 n+nS75jqFZYRqIoFCQJuhd0TKUszs2S1oxLhtAZZ2qw1FAGKe+PHCsAUkAj+pWLRZbwTy9oMO
 1zjhMB6R4xJ27YZ+aiMCGtzxKTsu/hvRCKdfPQhq83Sj2ruvf6VmWAqypgwwolJDxWRXzi3QZ
 0nz6xh65GlJfbrNJSbYL764ctj/c1X9NtyW/OUcqlxWWMGOPL67fErX6VNiQSpv1Q7VwnzSse
 pBodOqvkkOiNKioaSB3+SERQyrEAzMFI7VVA1vAoo5Mb2CGpkpM6dyX7DcaAk1FsbcDZHLum/
 5eHtD3DIDfsQDyXg63QDDIt+cBdFqFt8OBi/rZSAmotk700OJP3NmWnEtGJZl7P6vHW9dOeDC
 XBgDvomnu0vW2pmAwKle5/xZz2R/jlwBthWjnqXhpm2QPud/mMtvs2hX6zvuuFwew7+SAFI6a
 gGHNijLlQjhb6lC6QYRKaSSmt+Q7s6yMbcvrCO4lUA5QMhkfVMz086ERooqoCqc9GyG6xk6+F
 6GmbJoOrolBgua1CPxiKQMtqUUiV7bkjrTXWXadJNkK+B+W8FrSUITKfmLH5BcIp7cREVQeLT
 HMc2bKZCYn8/b/7OJ/bcZaBbUurg+tg5pMDvBM90HjS+zPez3e2RkwUxcJSjm6jpsh/Eh2QCr
 aHhlGBFFYreiAceCa3bQBzjSYHbM3A7yHLqFWHaquOAXJK0FvtylFK0poLwjwGimBcYPOEiTZ
 Jq1hnSGHJTGHTBpUP3EVCwv+7F0ytysK1XPMZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

The current int_sqrt() computation is sub-optimal for the case of small
@x.  Which is the interesting case when we're going to do cumulative
distribution functions on idle times, which we assume to be a random
variable, where the target residency of the deepest idle state gives an
upper bound on the variable (5e6ns on recent Intel chips).

In the case of small @x, the compute loop:

	while (m != 0) {
		b = y + m;
		y >>= 1;

		if (x >= b) {
			x -= b;
			y += m;
		}
		m >>= 2;
	}

can be reduced to:

	while (m > x)
		m >>= 2;

Because y==0, b==m and until x>=m y will remain 0.

And while this is computationally equivalent, it runs much faster
because there's less code, in particular less branches.

      cycles:                 branches:              branch-misses:

OLD:

hot:   45.109444 +- 0.044117  44.333392 +- 0.002254  0.018723 +- 0.000593
cold: 187.737379 +- 0.156678  44.333407 +- 0.002254  6.272844 +- 0.004305

PRE:

hot:   67.937492 +- 0.064124  66.999535 +- 0.000488  0.066720 +- 0.001113
cold: 232.004379 +- 0.332811  66.999527 +- 0.000488  6.914634 +- 0.006568

POST:

hot:   43.633557 +- 0.034373  45.333132 +- 0.002277  0.023529 +- 0.000681
cold: 207.438411 +- 0.125840  45.333132 +- 0.002277  6.976486 +- 0.004219

Averages computed over all values <128k using a LFSR to generate order.
Cold numbers have a LFSR based branch trace buffer 'confuser' ran between
each int_sqrt() invocation.

Link: http://lkml.kernel.org/r/20171020164644.876503355@infradead.org
Fixes: 30493cc9dddb ("lib/int_sqrt.c: optimize square root algorithm")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Suggested-by: Anshul Garg <aksgarg1989@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joe Perches <joe@perches.com>
Cc: David Miller <davem@davemloft.net>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Davidson <md@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 3f3295709edea6268ff1609855f498035286af73)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/int_sqrt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc344977..1afb545a37c5 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -22,6 +22,9 @@ unsigned long int_sqrt(unsigned long x)
 		return x;
 
 	m = 1UL << (BITS_PER_LONG - 2);
+	while (m > x)
+		m >>= 2;
+
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
-- 
2.20.0

