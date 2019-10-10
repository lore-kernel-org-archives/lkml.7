Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25C1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5711214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfJJT0Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:35454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726489AbfJJT0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C38CAB9B;
        Thu, 10 Oct 2019 19:26:22 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:25:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <longman@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        1vier1@web.de, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: wake_q memory ordering
Message-ID: <20191010192508.3yvpc5r6oqjq5tbr@linux-p48b>
References: <990690aa-8281-41da-4a46-99bb8f9fec31@colorfullife.com>
 <20191010114244.GS2311@hirez.programming.kicks-ass.net>
 <7af22b09-2ab9-78c9-3027-8281f020e2e8@colorfullife.com>
 <20191010123219.GO2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191010123219.GO2328@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019, Peter Zijlstra wrote:

>On Thu, Oct 10, 2019 at 02:13:47PM +0200, Manfred Spraul wrote:
>> Hi Peter,
>>
>> On 10/10/19 1:42 PM, Peter Zijlstra wrote:
>> > On Thu, Oct 10, 2019 at 12:41:11PM +0200, Manfred Spraul wrote:
>> > > Hi,
>> > >
>> > > Waiman Long noticed that the memory barriers in sem_lock() are not really
>> > > documented, and while adding documentation, I ended up with one case where
>> > > I'm not certain about the wake_q code:
>> > >
>> > > Questions:
>> > > - Does smp_mb__before_atomic() + a (failed) cmpxchg_relaxed provide an
>> > >    ordering guarantee?
>> > Yep. Either the atomic instruction implies ordering (eg. x86 LOCK
>> > prefix) or it doesn't (most RISC LL/SC), if it does,
>> > smp_mb__{before,after}_atomic() are a NO-OP and the ordering is
>> > unconditinoal, if it does not, then smp_mb__{before,after}_atomic() are
>> > unconditional barriers.
>>
>> And _relaxed() differs from "normal" cmpxchg only for LL/SC architectures,
>> correct?
>
>Indeed.
>
>> Therefore smp_mb__{before,after}_atomic() may be combined with
>> cmpxchg_relaxed, to form a full memory barrier, on all archs.
>
>Just so.

We might want something like this?

----8<---------------------------------------------------------

From: Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] Documentation/memory-barriers.txt: Mention smp_mb__{before,after}_atomic() and CAS

Explicitly mention possible usages to guarantee serialization even upon
failed cmpxchg (or similar) calls along with smp_mb__{before,after}_atomic().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 Documentation/memory-barriers.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..5d2873d4b442 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1890,6 +1890,18 @@ There are some more advanced barrier functions:
      This makes sure that the death mark on the object is perceived to be set
      *before* the reference counter is decremented.
 
+     Similarly, these barriers can be used to guarantee serialization for atomic
+     RMW calls on architectures which may not imply memory barriers upon failure.
+
+	obj->next = NULL;
+	smp_mb__before_atomic()
+	if (cmpxchg(&obj->ptr, NULL, val))
+		return;
+
+     This makes sure that the store to the next pointer always has smp_store_mb()
+     semantics. As such, smp_mb__{before,after}_atomic() calls allow optimizing
+     the barrier usage by finer grained serialization.
+
      See Documentation/atomic_{t,bitops}.txt for more information.
 
 
-- 
2.16.4
