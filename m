Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E586FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46FC2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbfHHK1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:27:39 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:41808 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389947AbfHHK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:27:39 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 8 Aug 2019 19:27:36 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 8 Aug 2019 19:27:36 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 8 Aug 2019 19:26:10 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808102610.GA7227@X58A-UD3R>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807094504.GB169551@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:45:04AM -0400, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 04:56:31PM -0700, Paul E. McKenney wrote:

[snip]

> > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > Of course, I am hoping that a later patch uses an array of pointers built
> > at kfree_rcu() time, similar to Rao's patch (with or without kfree_bulk)
> > in order to reduce per-object cache-miss overhead.  This would make it
> > easier for callback invocation to keep up with multi-CPU kfree_rcu()
> > floods.
> 
> I think Byungchul tried an experiment with array of pointers and wasn't
> immediately able to see a benefit. Perhaps his patch needs a bit more polish
> or another test-case needed to show benefit due to cache-misses, and the perf
> tool could be used to show if cache misses were reduced. For this initial
> pass, we decided to keep it without the array optimization.

I'm still seeing no improvement with kfree_bulk().

I've been thinking I could see improvement with kfree_bulk() because:

   1. As you guys said, the number of cache misses will be reduced.
   2. We can save (N - 1) irq-disable instructions while N kfrees.
   3. As Joel said, saving/restoring CPU status that kfree() does inside
      is not required.

But even with the following patch applied, the result was same as just
batching test. We might need to get kmalloc objects from random
addresses to maximize the result when using kfree_bulk() and this is
even closer to real practical world too.

And the second and third reasons doesn't seem to work as much as I
expected.

Do you have any idea? Or what do you think about it?

Thanks,
Byungchul

-----8<-----
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 988e1ae..6f2ab06 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -651,10 +651,10 @@ struct kfree_obj {
 				return -ENOMEM;
 		}
 
-		for (i = 0; i < kfree_alloc_num; i++) {
-			if (!kfree_no_batch) {
-				kfree_rcu(alloc_ptrs[i], rh);
-			} else {
+		if (!kfree_no_batch) {
+			kfree_bulk(kfree_alloc_num, (void **)alloc_ptrs);
+		} else {
+			for (i = 0; i < kfree_alloc_num; i++) {
 				rcu_callback_t cb;
 
 				cb = (rcu_callback_t)(unsigned long)offsetof(struct kfree_obj, rh);
