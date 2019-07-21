Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30566C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137102085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 23:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfGUXbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 19:31:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfGUXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 19:31:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6LNQn4K130606;
        Sun, 21 Jul 2019 19:31:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tvwrhpeyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 19:31:15 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6LNRNwd131517;
        Sun, 21 Jul 2019 19:31:14 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tvwrhpey6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 19:31:14 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6LNTNeM024749;
        Sun, 21 Jul 2019 23:31:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2tutk6b5gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jul 2019 23:31:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6LNVCoj48365900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Jul 2019 23:31:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4789B2064;
        Sun, 21 Jul 2019 23:31:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A620EB2065;
        Sun, 21 Jul 2019 23:31:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 21 Jul 2019 23:31:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 26BCD16C3838; Sun, 21 Jul 2019 16:31:13 -0700 (PDT)
Date:   Sun, 21 Jul 2019 16:31:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, aarcange@redhat.com,
        akpm@linux-foundation.org, christian@brauner.io,
        davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190721233113.GV14271@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721210837.GC363@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-21_17:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=916 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907210275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 02:08:37PM -0700, Matthew Wilcox wrote:
> On Sun, Jul 21, 2019 at 06:17:25AM -0700, Paul E. McKenney wrote:
> > Also, the overhead is important.  For example, as far as I know,
> > current RCU gracefully handles close(open(...)) in a tight userspace
> > loop.  But there might be trouble due to tight userspace loops around
> > lighter-weight operations.
> 
> I thought you believed that RCU was antifragile, in that it would scale
> better as it was used more heavily?

You are referring to this?  https://paulmck.livejournal.com/47933.html

If so, the last few paragraphs might be worth re-reading.   ;-)

And in this case, the heuristics RCU uses to decide when to schedule
invocation of the callbacks needs some help.  One component of that help
is a time-based limit to the number of consecutive callback invocations
(see my crude prototype and Eric Dumazet's more polished patch).  Another
component is an overload warning.

Why would an overload warning be needed if RCU's callback-invocation
scheduling heurisitics were upgraded?  Because someone could boot a
100-CPU system with the rcu_nocbs=0-99, bind all of the resulting
rcuo kthreads to (say) CPU 0, and then run a callback-heavy workload
on all of the CPUs.  Given the constraints, CPU 0 cannot keep up.

So warnings are required as well.

> Would it make sense to have call_rcu() check to see if there are many
> outstanding requests on this CPU and if so process them before returning?
> That would ensure that frequent callers usually ended up doing their
> own processing.

Unfortunately, no.  Here is a code fragment illustrating why:

	void my_cb(struct rcu_head *rhp)
	{
		unsigned long flags;

		spin_lock_irqsave(&my_lock, flags);
		handle_cb(rhp);
		spin_unlock_irqrestore(&my_lock, flags);
	}

	. . .

	spin_lock_irqsave(&my_lock, flags);
	p = look_something_up();
	remove_that_something(p);
	call_rcu(p, my_cb);
	spin_unlock_irqrestore(&my_lock, flags);

Invoking the extra callbacks directly from call_rcu() would thus result
in self-deadlock.  Documentation/RCU/UP.txt contains a few more examples
along these lines.
