Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E2204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567546387;
	bh=YymkVWftAdEAJTU7xDiFlJnp7pb87J6LdTVZ/0wWnrU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ShpcFpNzAzlXxvjX9hIh+85HKQpYeLX+hj/VgMLO/vkjuYFA5pZpqDwV7gT20khy6
	 T9Dwg7kLKLyKFOQ9GEPP6zsVPZZ5DnIHjhOnRzDx81KVeDKKjVrapwMuc9pJRj2+5C
	 0L4zoKIuTZB4pMXMuGNRomGuxJESahlUXJd5B1HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfICVdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:33:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbfICVdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:33:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83LRH0k075353;
        Tue, 3 Sep 2019 17:32:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usx8qbhgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 17:32:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x83LWC24088721;
        Tue, 3 Sep 2019 17:32:16 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usx8qbhgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 17:32:16 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x83LUYo4023918;
        Tue, 3 Sep 2019 21:32:14 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 2uqgh6w3jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 21:32:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x83LWEqi54395388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Sep 2019 21:32:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58BC9B2065;
        Tue,  3 Sep 2019 21:32:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38E9DB2064;
        Tue,  3 Sep 2019 21:32:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Sep 2019 21:32:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 76EE616C2133; Tue,  3 Sep 2019 14:32:18 -0700 (PDT)
Date:   Tue, 3 Sep 2019 14:32:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Message-ID: <20190903213218.GG4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net>
 <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
 <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
 <874l1tp7st.fsf@x220.int.ebiederm.org>
 <CAHk-=wjvyRJEdativFqqGGxzSgWnc-m7b+B04iQBMcZV4uM=hA@mail.gmail.com>
 <20190903200603.GW2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903200603.GW2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909030214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:06:03PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 03, 2019 at 12:18:47PM -0700, Linus Torvalds wrote:
> > Now, if you can point to some particular field where that ordering
> > makes sense for the particular case of "make it active on the
> > runqueue" vs "look up the task from the runqueue using RCU", then I do
> > think that the whole release->acquire consistency makes sense.
> > 
> > But it's not clear that such a field exists, particularly when this is
> > in no way the *common* way to even get a task pointer, and other paths
> > do *not* use the runqueue as the serialization point.
> 
> Even if we could find a case (and I'm not seeing one in a hurry), I
> would try really hard to avoid adding extra barriers here and instead
> make the consumer a little more complicated if at all possible.
> 
> The Power folks got rid of a SYNC (yes, more expensive than LWSYNC) from
> their __switch_to() implementation and that had a measurable impact.
> 
> 9145effd626d ("powerpc/64: Drop explicit hwsync in context switch")

The patch [1] looks good to me.  And yes, if the structure pointed to by
the second argument of rcu_assign_pointer() is already visible to readers,
it is OK to instead use RCU_INIT_POINTER().  Yes, this loses ordering.
But weren't these simple assignments before RCU got involved?

As a very rough rule of thumb, LWSYNC is about twice as fast as SYNC.
(Depends on workload, exact details of the hardware, timing, phase of
the moon, you name it.)  So removing the LWSYNC is likely to provide
measureable benefit, but I must defer to the powerpc maintainers.
To that end, I added Michael on CC.

							Thanx, Paul

[1] https://lore.kernel.org/lkml/878sr6t21a.fsf_-_@x220.int.ebiederm.org/
