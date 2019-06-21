Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CBC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7162420821
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 23:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfFUXzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 19:55:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfFUXzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:55:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LNpkXB089236;
        Fri, 21 Jun 2019 19:54:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t94whgmbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 19:54:40 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5LNqFEX093738;
        Fri, 21 Jun 2019 19:54:40 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t94whgmb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 19:54:40 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5LNj2XO007339;
        Fri, 21 Jun 2019 23:54:39 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2t8hrnygx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 23:54:39 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LNscP339846354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:54:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B414B205F;
        Fri, 21 Jun 2019 23:54:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D356B2064;
        Fri, 21 Jun 2019 23:54:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jun 2019 23:54:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A736816C2FA6; Fri, 21 Jun 2019 16:54:39 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:54:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
Message-ID: <20190621235439.GJ26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190621084129.GA6827@andrea>
 <Pine.LNX.4.44L0.1906211023040.1471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906211023040.1471-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
> On Fri, 21 Jun 2019, Andrea Parri wrote:
> 
> > On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> > > Herbert Xu recently reported a problem concerning RCU and compiler
> > > barriers.  In the course of discussing the problem, he put forth a
> > > litmus test which illustrated a serious defect in the Linux Kernel
> > > Memory Model's data-race-detection code.
> > > 
> > > The defect was that the LKMM assumed visibility and executes-before
> > > ordering of plain accesses had to be mediated by marked accesses.  In
> > > Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
> > > test was allowed and contained a data race although neither is true.
> > > 
> > > In fact, plain accesses can be ordered by fences even in the absence
> > > of marked accesses.  In most cases this doesn't matter, because most
> > > fences only order accesses within a single thread.  But the rcu-fence
> > > relation is different; it can order (and induce visibility between)
> > > accesses in different threads -- events which otherwise might be
> > > concurrent.  This makes it relevant to data-race detection.
> > > 
> > > This patch makes two changes to the memory model to incorporate the
> > > new insight:
> > > 
> > > 	If a store is separated by a fence from another access,
> > > 	the store is necessarily visible to the other access (as
> > > 	reflected in the ww-vis and wr-vis relations).  Similarly,
> > > 	if a load is separated by a fence from another access then
> > > 	the load necessarily executes before the other access (as
> > > 	reflected in the rw-xbstar relation).
> > > 
> > > 	If a store is separated by a strong fence from a marked access
> > > 	then it is necessarily visible to any access that executes
> > > 	after the marked access (as reflected in the ww-vis and wr-vis
> > > 	relations).
> > > 
> > > With these changes, the LKMM gives the desired result for Herbert's
> > > litmus test and other related ones.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> > 
> > For the entire series:
> > 
> > Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > 
> > Two nits, but up to Paul AFAIAC:
> > 
> >  - This is a first time for "tools: memory-model:" in Subject; we were
> >    kind of converging to "tools/memory-model:"...
> 
> Yeah, sure.  That's the sort of detail I have a hard time remembering.
> 
> >  - The report preceded the patch; we might as well reflect this in the
> >    order of the tags.
> 
> Either way is okay with me.

I applied Andrea's acks and edited as called out above, thank you both!

						Thanx, Paul
