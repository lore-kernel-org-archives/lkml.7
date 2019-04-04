Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE2CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F37206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfDDUuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:50:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731250AbfDDUue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:50:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34Km3cu041111
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 16:50:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rnpx2pf49-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 16:50:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 21:50:31 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 21:50:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34KoPxi18087942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 20:50:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5F10B2065;
        Thu,  4 Apr 2019 20:50:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A71C0B2066;
        Thu,  4 Apr 2019 20:50:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 20:50:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 939D316C32DA; Thu,  4 Apr 2019 13:50:27 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:50:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: Re: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for
 synchronize_srcu_expedited()
Reply-To: paulmck@linux.ibm.com
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-8-paulmck@linux.ibm.com>
 <20190402144911.GA10044@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402144911.GA10044@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040420-0072-0000-0000-00000415A73A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01184363; UDB=6.00620129; IPR=6.00965117;
 MB=3.00026298; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 20:50:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040420-0073-0000-0000-00004BB6725B
Message-Id: <20190404205027.GM14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 04:49:11PM +0200, Andrea Parri wrote:
> On Tue, Mar 26, 2019 at 04:41:20PM -0700, Paul E. McKenney wrote:
> > Given that synchronize_rcu_expedited() is supported, this commit adds
> > support for synchronize_srcu_expedited().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > ---
> >  tools/memory-model/linux-kernel.def | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > index 0c3f0ef486f4..551eeaa389d4 100644
> > --- a/tools/memory-model/linux-kernel.def
> > +++ b/tools/memory-model/linux-kernel.def
> > @@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> >  srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > +synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
> 
> This and the other patches from the series do not apply to "tip/core/rcu"

Ah, that is instead their hoped-for destination within the -tip tree.
They are included in -rcu branch "dev".

> (from the Subject), but this seems straightforward enough:
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Applied, thank you!

							Thanx, Paul

>   Andrea
> 
> 
> >  
> >  // Atomic
> >  atomic_read(X) READ_ONCE(*X)
> > -- 
> > 2.17.1
> > 
> 

