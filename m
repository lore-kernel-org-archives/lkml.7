Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF477206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567716989;
	bh=Or5bJlXC2nnmuPyZDVUHypUeIJoY+oR4Y16dikDXeVQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PaguHSh6yPHuT5TiXbIH5Cu8D6fU1hE5iHTaEabTF6G3P1+rpeJ8wTFJMX8XPAfg3
	 KAoCKxGbI8aVnVBJk4+DDmBjLG1FIcsCJc+OgzKSNwgFbW6LjklpOVD6wPzMhZ37A9
	 SHbnvcASiX/Cvhl32IfdxvhvSo0MNoRIkQfnXIa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbfIEU41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:56:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbfIEU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:56:27 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85KqKVN038447;
        Thu, 5 Sep 2019 16:55:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uu91rsmgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 16:55:57 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x85Ks8kU042905;
        Thu, 5 Sep 2019 16:55:57 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uu91rsmg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 16:55:57 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x85KtSq2016460;
        Thu, 5 Sep 2019 20:55:56 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2uqgh7ncwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Sep 2019 20:55:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x85KttTQ53805434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 20:55:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CEBEB2068;
        Thu,  5 Sep 2019 20:55:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E20B8B205F;
        Thu,  5 Sep 2019 20:55:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 20:55:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 64EB116C2C84; Thu,  5 Sep 2019 13:55:56 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:55:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190905205556.GB4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net>
 <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
 <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
 <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
 <20190903200603.GW2349@hirez.programming.kicks-ass.net>
 <20190903213218.GG4125@linux.ibm.com>
 <87r24umryu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r24umryu.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:02:49PM -0500, Eric W. Biederman wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Tue, Sep 03, 2019 at 10:06:03PM +0200, Peter Zijlstra wrote:
> >> On Tue, Sep 03, 2019 at 12:18:47PM -0700, Linus Torvalds wrote:
> >> > Now, if you can point to some particular field where that ordering
> >> > makes sense for the particular case of "make it active on the
> >> > runqueue" vs "look up the task from the runqueue using RCU", then I do
> >> > think that the whole release->acquire consistency makes sense.
> >> > 
> >> > But it's not clear that such a field exists, particularly when this is
> >> > in no way the *common* way to even get a task pointer, and other paths
> >> > do *not* use the runqueue as the serialization point.
> >> 
> >> Even if we could find a case (and I'm not seeing one in a hurry), I
> >> would try really hard to avoid adding extra barriers here and instead
> >> make the consumer a little more complicated if at all possible.
> >> 
> >> The Power folks got rid of a SYNC (yes, more expensive than LWSYNC) from
> >> their __switch_to() implementation and that had a measurable impact.
> >> 
> >> 9145effd626d ("powerpc/64: Drop explicit hwsync in context switch")
> >
> > The patch [1] looks good to me.  And yes, if the structure pointed to by
> > the second argument of rcu_assign_pointer() is already visible to readers,
> > it is OK to instead use RCU_INIT_POINTER().  Yes, this loses ordering.
> > But weren't these simple assignments before RCU got involved?
> >
> > As a very rough rule of thumb, LWSYNC is about twice as fast as SYNC.
> > (Depends on workload, exact details of the hardware, timing, phase of
> > the moon, you name it.)  So removing the LWSYNC is likely to provide
> > measureable benefit, but I must defer to the powerpc maintainers.
> > To that end, I added Michael on CC.
> >
> > [1] https://lore.kernel.org/lkml/878sr6t21a.fsf_-_@x220.int.ebiederm.org/
> 
> Paul, what is the purpose of the barrier in rcu_assign_pointer?
> 
> My intuition says it is the assignment half of rcu_dereference, and that
> anything that rcu_dereference does not need is too strong.
> 
> My basic understanding is that only alpha ever has the memory ordering
> issue that rcu_dereference deals with.  So I am a bit surprised that
> this is anything other than a noop for anything except alpha.

Yes, only Alpha needs an actual memory-barrier instruction in
rcu_dereference().  And it is the only one that gets one.

> In my patch I used rcu_assign_pointer because that is the canonically
> correct way to do things.  Peter makes a good case that adding an extra
> barrier in ___schedule could be detrimental to system performance.
> At the same time if there is a correctness issue on alpha that we have
> been overlooking because of low testing volume on alpha I don't want to
> just let this slide and have very subtle bugs.

But rcu_assign_pointer() needs a memory-barrier instruction on the
weakly ordered architectures: ARM, powerpc, Itanium, and so on.

> The practical concern is that people have been really wanting to do
> lockless and rcu operations on tasks in the runqueue for a while and
> there are several very clever pieces of code doing that now.  By
> changing the location of the rcu put I am trying to make these uses
> ordinary rcu uses.
> 
> The uses in question are the pieces of code I update in:
> https://lore.kernel.org/lkml/8736het20c.fsf_-_@x220.int.ebiederm.org/

The rcu_assign_pointer() at the end of rcuwait_wait_event(), right?

> In short.  Why is rcu_assign_pointer() more than WRITE_ONCE() on
> anything but alpha?  Do other architectures need more?  Is the trade off
> worth it if we avoid using rcu_assign_pointer on performance critical
> paths.

Note the difference between the read-side rcu_dereference(), which
does not require any memory-barrier instructions except on Alpha,
and the update-side rcu_assign_pointer() which does require a
memory-barrier instruction on quite a few architectures.  Even on
the strongly ordered architectures (x86, s390, ...) a compiler
barrier() is required for rcu_assign_pointer().

Except note the exceptional cases where RCU_INIT_POINTER() may be
used in place of rcu_assign_pointer(), which are called out in
RCU_INIT_POINTER()'s header comment:

 * Initialize an RCU-protected pointer in special cases where readers
 * do not need ordering constraints on the CPU or the compiler.  These
 * special cases are:
 *
 * 1.	This use of RCU_INIT_POINTER() is NULLing out the pointer *or*
 * 2.	The caller has taken whatever steps are required to prevent
 *	RCU readers from concurrently accessing this pointer *or*
 * 3.	The referenced data structure has already been exposed to
 *	readers either at compile time or via rcu_assign_pointer() *and*
 *
 *	a.	You have not made *any* reader-visible changes to
 *		this structure since then *or*
 *	b.	It is OK for readers accessing this structure from its
 *		new location to see the old state of the structure.  (For
 *		example, the changes were to statistical counters or to
 *		other state where exact synchronization is not required.)
 *
 * Failure to follow these rules governing use of RCU_INIT_POINTER() will
 * result in impossible-to-diagnose memory corruption.  As in the structures
 * will look OK in crash dumps, but any concurrent RCU readers might
 * see pre-initialized values of the referenced data structure.  So
 * please be very careful how you use RCU_INIT_POINTER()!!!

If current is already visible (which it should be unless
rcuwait_wait_event() is invoked at task-creation time), then
RCU_INIT_POINTER() could be used in rcuwait_wait_event().

> Eric
> 
> p.s. I am being slow at working through all of this as I am dealing
>      with my young baby son, and busy packing for the conference.

Congratulations on the baby son!!!  I remember those times well, but
they were more than three decades ago for my oldest.  ;-)

>      I might not be able to get back to this discussion until after
>      I have landed in Lisbon on Saturday night.

Looking forward to it!

							Thanx, Paul
