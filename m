Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F1217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfC2WbP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:31:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39635 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbfC2WbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:31:14 -0400
Received: from [IPv6:2607:fb90:3651:4373:48b0:1794:39b7:b336] ([IPv6:2607:fb90:3651:4373:48b0:1794:39b7:b336])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2TMV0Zx3975236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 29 Mar 2019 15:31:01 -0700
Date:   Fri, 29 Mar 2019 15:30:57 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190329220554.GD4102@linux.ibm.com>
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com> <20190328162222.GO4102@linux.ibm.com> <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com> <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com> <20190329210918.GZ4102@linux.ibm.com> <8092b8aa-bb1c-0266-b308-5cebfb25e2ef@zytor.com> <20190329220554.GD4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
To:     paulmck@linux.ibm.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
CC:     Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
From:   hpa@zytor.com
Message-ID: <CD3717A9-E52B-425C-99B4-96ABD942E626@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 29, 2019 3:05:54 PM PDT, "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
>On Fri, Mar 29, 2019 at 02:51:26PM -0700, H. Peter Anvin wrote:
>> On 3/29/19 2:09 PM, Paul E. McKenney wrote:
>> >>
>> >> Note: the atomic versions of these functions obviously need to
>have
>> >> "volatile" and the clobber anyway, as they are by definition
>barriers
>> >> and moving memory operations around them would be a very serious
>error.
>> > 
>> > The atomic functions that return void don't need to order anything
>except
>> > the input and output arguments.  The oddness with clear_bit() is
>that the
>> > memory changed isn't necessarily the quantity referenced by the
>argument,
>> > if the number of bits specified is large.
>> > 
>> > So (for example) atomic_inc() does not need a "memory" clobber,
>right?
>> 
>> I don't believe that is true: the code calling it has a reasonable
>> expectation that previous memory operations have finished and later
>> memory operations have not started from the point of view of another
>> processor. You are more of an expert on memory ordering than I am,
>but
>> I'm 89% sure that there is plenty of code in the kernel which makes
>that
>> assumption.
>
>From Documentation/core-api/atomic_ops.rst:
>
>------------------------------------------------------------------------
>	void atomic_add(int i, atomic_t *v);
>	void atomic_sub(int i, atomic_t *v);
>	void atomic_inc(atomic_t *v);
>	void atomic_dec(atomic_t *v);
>
>These four routines add and subtract integral values to/from the given
>atomic_t value.  The first two routines pass explicit integers by
>which to make the adjustment, whereas the latter two use an implicit
>adjustment value of "1".
>
>One very important aspect of these two routines is that they DO NOT
>require any explicit memory barriers.  They need only perform the
>atomic_t counter update in an SMP safe manner.
>------------------------------------------------------------------------
>
>So, no, these functions do not imply any ordering other than to the
>variable modified.  This one predates my joining the Linux kernel
>community.  ;-)  So any cases where someone is relying on atomic_inc()
>to provide ordering are bugs.
>
>Now for value-returning atomics, for example, atomic_inc_return(),
>full ordering is indeed required.
>
>							Thanx, Paul

Ok.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
