Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D490FC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B409A21993
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfGVQ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:26:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730931AbfGVQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:26:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MGLocj048425
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:26:01 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2twet6dvxa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:26:00 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 22 Jul 2019 17:25:59 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 22 Jul 2019 17:25:51 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6MGPogJ49349098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 16:25:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78428B2070;
        Mon, 22 Jul 2019 16:25:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FDD0B2065;
        Mon, 22 Jul 2019 16:25:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jul 2019 16:25:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B68CC16C29D7; Mon, 22 Jul 2019 09:25:51 -0700 (PDT)
Date:   Mon, 22 Jul 2019 09:25:51 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
References: <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
 <20190721210837.GC363@bombadil.infradead.org>
 <20190721233113.GV14271@linux.ibm.com>
 <20190722151439.GA247639@google.com>
 <20190722114612-mutt-send-email-mst@kernel.org>
 <20190722155534.GG14271@linux.ibm.com>
 <20190722120011-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722120011-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19072216-0064-0000-0000-00000401FECB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011475; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01235889; UDB=6.00651343; IPR=6.01017239;
 MB=3.00027839; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-22 16:25:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072216-0065-0000-0000-00003E5FF2DB
Message-Id: <20190722162551.GK14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 12:13:40PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 22, 2019 at 08:55:34AM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 22, 2019 at 11:47:24AM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Jul 22, 2019 at 11:14:39AM -0400, Joel Fernandes wrote:
> > > > [snip]
> > > > > > Would it make sense to have call_rcu() check to see if there are many
> > > > > > outstanding requests on this CPU and if so process them before returning?
> > > > > > That would ensure that frequent callers usually ended up doing their
> > > > > > own processing.
> > > > 
> > > > Other than what Paul already mentioned about deadlocks, I am not sure if this
> > > > would even work for all cases since call_rcu() has to wait for a grace
> > > > period.
> > > > 
> > > > So, if the number of outstanding requests are higher than a certain amount,
> > > > then you *still* have to wait for some RCU configurations for the grace
> > > > period duration and cannot just execute the callback in-line. Did I miss
> > > > something?
> > > > 
> > > > Can waiting in-line for a grace period duration be tolerated in the vhost case?
> > > > 
> > > > thanks,
> > > > 
> > > >  - Joel
> > > 
> > > No, but it has many other ways to recover (try again later, drop a
> > > packet, use a slower copy to/from user).
> > 
> > True enough!  And your idea of taking recovery action based on the number
> > of callbacks seems like a good one while we are getting RCU's callback
> > scheduling improved.
> > 
> > By the way, was this a real problem that you could make happen on real
> > hardware?
> 
> >  If not, I would suggest just letting RCU get improved over
> > the next couple of releases.
> 
> So basically use kfree_rcu but add a comment saying e.g. "WARNING:
> in the future callers of kfree_rcu might need to check that
> not too many callbacks get queued. In that case, we can
> disable the optimization, or recover in some other way.
> Watch this space."

That sounds fair.

> > If it is something that you actually made happen, please let me know
> > what (if anything) you need from me for your callback-counting EBUSY
> > scheme.
> > 
> > 							Thanx, Paul
> 
> If you mean kfree_rcu causing OOM then no, it's all theoretical.
> If you mean synchronize_rcu stalling to the point where guest will OOPs,
> then yes, that's not too hard to trigger.

Is synchronize_rcu() being stalled by the userspace loop that is invoking
your ioctl that does kfree_rcu()?  Or instead by the resulting callback
invocation?

							Thanx, Paul

