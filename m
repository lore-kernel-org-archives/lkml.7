Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AFEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69E321019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbfCMXs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:48:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfCMXsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:48:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DNhefT104149
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:48:54 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r78s5f8mb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 19:48:54 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 13 Mar 2019 23:48:53 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 23:48:50 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DNmnkY22741178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 23:48:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D46EB205F;
        Wed, 13 Mar 2019 23:48:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E360CB206B;
        Wed, 13 Mar 2019 23:48:48 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 23:48:48 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 281D716C2F61; Wed, 13 Mar 2019 16:48:53 -0700 (PDT)
Date:   Wed, 13 Mar 2019 16:48:53 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     hch@infradead.org, Nikos Tsironis <ntsironis@arrikto.com>,
        agk@redhat.com, dm-devel@redhat.com, mpatocka@redhat.com,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind helpers
Reply-To: paulmck@linux.ibm.com
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228213201.GB23527@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031323-0068-0000-0000-000003A5324E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010753; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173982; UDB=6.00613848; IPR=6.00954645;
 MB=3.00025968; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-13 23:48:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031323-0069-0000-0000-000047CF7DF3
Message-Id: <20190313234853.GA7797@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> On Thu, Dec 20 2018 at  1:06pm -0500,
> Nikos Tsironis <ntsironis@arrikto.com> wrote:
> 
> > Add hlist_bl_add_before/behind helpers to add an element before/after an
> > existing element in a bl_list.
> > 
> > Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
> > Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
> > ---
> >  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> > index 3fc2cc57ba1b..2fd918e5fd48 100644
> > --- a/include/linux/list_bl.h
> > +++ b/include/linux/list_bl.h
> > @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
> >  	hlist_bl_set_first(h, n);
> >  }
> >  
> > +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
> > +				       struct hlist_bl_node *next)
> > +{
> > +	struct hlist_bl_node **pprev = next->pprev;
> > +
> > +	n->pprev = pprev;
> > +	n->next = next;
> > +	next->pprev = &n->next;
> > +
> > +	/* pprev may be `first`, so be careful not to lose the lock bit */
> > +	WRITE_ONCE(*pprev,
> > +		   (struct hlist_bl_node *)
> > +			((unsigned long)n |
> > +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));

A nit, but use of uintptr_t shrinks things a bit:

+		   (struct hlist_bl_node *)
+			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));

I am not too concerned about this, though.

The WRITE_ONCE() is to handle races with hlist_bl_empty() (which does contain
the corresponding READ_ONCE()) correct?

> > +}
> > +
> > +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> > +				       struct hlist_bl_node *prev)
> > +{
> > +	n->next = prev->next;
> > +	n->pprev = &prev->next;
> > +	WRITE_ONCE(prev->next, n);

I don't see what this WRITE_ONCE() is interacting with.  The traversals
use plain C-language reads, and hlist_bl_empty() can't get here.  All
uses of hlist_bl_for_each_entry() invoke hlist_bl_lock() before starting
the traversal, and hlist_bl_for_each_entry_safe() looks to be unused.
(Perhaps it should be removed?  Or is there some anticipated use?)

I don't believe that the WRITE_ONCE() is needed.  What am I missing?

Other than that, looks good.

							Thanx, Paul

> > +
> > +	if (n->next)
> > +		n->next->pprev = &n->next;
> > +}
> > +
> >  static inline void __hlist_bl_del(struct hlist_bl_node *n)
> >  {
> >  	struct hlist_bl_node *next = n->next;
> > -- 
> > 2.11.0
> 
> Hi Paul and Christoph,
> 
> You've added your Signed-off-by to include/linux/list_bl.h commits in
> the past.  I'm not sure how this proposed patch should be handled.
> 
> These new hlist_bl_add_{before,behind} changes are a prereq for
> dm-snapshot changes that Nikos has proposed, please see:
> https://patchwork.kernel.org/patch/10739265/
> 
> Any assistance/review you, or others on LKML, might be able to provide
> would be appreciated.
> 
> Thanks,
> Mike
> 

