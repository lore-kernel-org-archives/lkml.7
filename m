Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB53C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EF1218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfGVPwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:52:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728596AbfGVPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:52:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MFq4D3091081
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:52:45 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tweg5dvau-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:52:45 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 22 Jul 2019 16:52:44 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Jul 2019 16:52:35 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MFqYJI47055222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 15:52:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90AB8B2068;
        Mon, 22 Jul 2019 15:52:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E140B205F;
        Mon, 22 Jul 2019 15:52:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jul 2019 15:52:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BB14116C9087; Mon, 22 Jul 2019 08:52:35 -0700 (PDT)
Date:   Mon, 22 Jul 2019 08:52:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, aarcange@redhat.com,
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
Reply-To: paulmck@linux.ibm.com
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
 <20190721233113.GV14271@linux.ibm.com>
 <20190722035042-mutt-send-email-mst@kernel.org>
 <20190722115149.GY14271@linux.ibm.com>
 <20190722134152.GA13013@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722134152.GA13013@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19072215-2213-0000-0000-000003B4493B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011475; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01235877; UDB=6.00651336; IPR=6.01017228;
 MB=3.00027839; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-22 15:52:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072215-2214-0000-0000-00005F585F3F
Message-Id: <20190722155235.GF14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=624 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:41:52AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 04:51:49AM -0700, Paul E. McKenney wrote:
> 
> > > > > Would it make sense to have call_rcu() check to see if there are many
> > > > > outstanding requests on this CPU and if so process them before returning?
> > > > > That would ensure that frequent callers usually ended up doing their
> > > > > own processing.
> > > > 
> > > > Unfortunately, no.  Here is a code fragment illustrating why:
> 
> That is only true in the general case though, kfree_rcu() doesn't have
> this problem since we know what the callback is doing. In general a
> caller of kfree_rcu() should not need to hold any locks while calling
> it.

Good point, at least as long as the slab allocators don't call kfree_rcu()
while holding any of the slab locks.

However, that would require a separate list for the kfree_rcu() callbacks,
and concurrent access to those lists of kfree_rcu() callbacks.  So this
might work, but would add some complexity and also yet another restriction
between RCU and another kernel subsystem.  So I would like to try the
other approaches first, for example, the time-based approach in my
prototype and Eric Dumazet's more polished patch.

But the immediate-invocation possibility is still there if needed.

> We could apply the same idea more generally and have some
> 'call_immediate_or_rcu()' which has restrictions on the caller's
> context.
> 
> I think if we have some kind of problem here it would be better to
> handle it inside the core code and only require that callers use the
> correct RCU API.

Agreed.  Especially given that there are a number of things that can
be done within RCU.

> I can think of many places where kfree_rcu() is being used under user
> control..

And same for call_rcu().

And this is not the first time we have run into this.  The last time
was about 15 years ago, if I remember correctly, and that one led to
some of the quiescent-state forcing and callback-invocation batch size
tricks still in use today.  My only real surprise is that it took so
long for this to come up again.  ;-)

Please note also that in the common case on default configurations,
callback invocation is done on the CPU that posted the callback.
This means that callback invocation normally applies backpressure
to the callback-happy workload.

So why then is there a problem?

The problem is not the lack of backpressure, but rather that the
scheduling of callback invocation needs to be a bit more considerate
of the needs of the rest of the system.  In the common case, that is.
Except that the uncommon case is real-time configurations, in which care
is needed anyway.  But I am in the midst of helping those out as well,
details on the "dev" branch of -rcu.

							Thanx, Paul

