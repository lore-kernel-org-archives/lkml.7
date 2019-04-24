Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD002183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbfDXS4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:56:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729758AbfDXS4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:56:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OIt6MH128125
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:56:48 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s2u1by73b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:56:47 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 24 Apr 2019 19:56:47 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Apr 2019 19:56:44 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3OIuhv921626904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 18:56:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DF12B206A;
        Wed, 24 Apr 2019 18:56:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74192B205F;
        Wed, 24 Apr 2019 18:56:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.231.45])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Apr 2019 18:56:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E4FDA16C2664; Wed, 24 Apr 2019 11:56:42 -0700 (PDT)
Date:   Wed, 24 Apr 2019 11:56:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/sync: kill rcu_sync_type/gp_type
Reply-To: paulmck@linux.ibm.com
References: <20190423120724.GA6132@redhat.com>
 <20190423193306.GU3923@linux.ibm.com>
 <20190424113704.GB16167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424113704.GB16167@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042418-2213-0000-0000-0000037F4456
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010988; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193820; UDB=6.00625857; IPR=6.00974644;
 MB=3.00026579; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 18:56:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042418-2214-0000-0000-00005E277F72
Message-Id: <20190424185642.GS3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904240136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:37:04PM +0200, Oleg Nesterov wrote:
> On 04/23, Paul E. McKenney wrote:
> >
> > I wordsmithed the commit log and merged in the RCU-bh and RCU checks
> > to rcu_sync_is_idle(), with the result shown below.  Does that work
> > OK, or did I mess something up?
> 
> Yes, thanks!
> 
> the additional RCU-bh and RCU checks matches the "or introduce rcu_read_lock_any_held()"
> note from the changelog, perhaps it makes some sense...
> 
> Just one nit below,
> 
> > - * Must be invoked within an RCU read-side critical section whose
> > - * flavor matches that of the rcu_sync struture.
> > + * Must be invoked within an RCU-sched read-side critical section.
>                                 ^^^^^^^^^
> 
> Given that the actual code:
> 
> >  static inline bool rcu_sync_is_idle(struct rcu_sync *rsp)
> >  {
> > -#ifdef CONFIG_PROVE_RCU
> > -	rcu_sync_lockdep_assert(rsp);
> > -#endif
> > +	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
> > +			 !rcu_read_lock_bh_held() &&
> > +			 !rcu_read_lock_sched_held(),
> > +			 "suspicious rcu_sync_is_idle() usage");
> 
> does RCU_LOCKDEP_WARN(!rcu_read_lock_any()) the comment should say
> 
> 	Must be invoked within an RCU read-side critical section of
> 	any flavor

Good catch, thank you!  I went with this:

* Must be invoked within some flavor of RCU read-side critical section.

Does that work for you?

							Thanx, Paul

