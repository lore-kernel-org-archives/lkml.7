Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B940C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F642070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCNOHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:07:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727569AbfCNOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:07:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EE2QPf100770
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:07:11 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r7rcar8rv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 10:07:10 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Mar 2019 14:07:10 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 14:07:05 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EE740n20054082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 14:07:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1D74B205F;
        Thu, 14 Mar 2019 14:07:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4F6CB2064;
        Thu, 14 Mar 2019 14:07:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 14:07:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2E5E016C32A0; Thu, 14 Mar 2019 07:07:50 -0700 (PDT)
Date:   Thu, 14 Mar 2019 07:07:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nikos Tsironis <ntsironis@arrikto.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, hch@infradead.org,
        agk@redhat.com, dm-devel@redhat.com, mpatocka@redhat.com,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind
 helpers
Reply-To: paulmck@linux.ibm.com
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com>
 <20190313234853.GA7797@linux.ibm.com>
 <20190314003027.GE4202@redhat.com>
 <f70ea4c9-658d-5770-be7f-a1a97bb67643@arrikto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70ea4c9-658d-5770-be7f-a1a97bb67643@arrikto.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031414-0060-0000-0000-0000031C5B50
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010757; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01174264; UDB=6.00614020; IPR=6.00954929;
 MB=3.00025978; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-14 14:07:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031414-0061-0000-0000-0000489B8D96
Message-Id: <20190314140750.GB4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 03:28:23PM +0200, Nikos Tsironis wrote:
> On 3/14/19 2:30 AM, Mike Snitzer wrote:
> > On Wed, Mar 13 2019 at  7:48pm -0400,
> > Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > 
> Hi Paul,
> 
> Thanks a lot for your feedback!

NP, and apologies for the delay.

> >> On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
> >>> On Thu, Dec 20 2018 at  1:06pm -0500,
> >>> Nikos Tsironis <ntsironis@arrikto.com> wrote:
> >>>
> >>>> Add hlist_bl_add_before/behind helpers to add an element before/after an
> >>>> existing element in a bl_list.
> >>>>
> >>>> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
> >>>> Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
> >>>> ---
> >>>>  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
> >>>>  1 file changed, 27 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> >>>> index 3fc2cc57ba1b..2fd918e5fd48 100644
> >>>> --- a/include/linux/list_bl.h
> >>>> +++ b/include/linux/list_bl.h
> >>>> @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
> >>>>  	hlist_bl_set_first(h, n);
> >>>>  }
> >>>>  
> >>>> +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
> >>>> +				       struct hlist_bl_node *next)
> >>>> +{
> >>>> +	struct hlist_bl_node **pprev = next->pprev;
> >>>> +
> >>>> +	n->pprev = pprev;
> >>>> +	n->next = next;
> >>>> +	next->pprev = &n->next;
> >>>> +
> >>>> +	/* pprev may be `first`, so be careful not to lose the lock bit */
> >>>> +	WRITE_ONCE(*pprev,
> >>>> +		   (struct hlist_bl_node *)
> >>>> +			((unsigned long)n |
> >>>> +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
> >>
> >> A nit, but use of uintptr_t shrinks things a bit:
> >>
> >> +		   (struct hlist_bl_node *)
> >> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
> >>
> >> I am not too concerned about this, though.
> > 
> > I'm fine with folding in your suggestion.
> 
> Indeed, this looks better.
> 
> >> The WRITE_ONCE() is to handle races with hlist_bl_empty() (which does contain
> >> the corresponding READ_ONCE()) correct?
> > 
> > Correct.
> 
> Yes that's correct.
> 
> >>>> +}
> >>>> +
> >>>> +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> >>>> +				       struct hlist_bl_node *prev)
> >>>> +{
> >>>> +	n->next = prev->next;
> >>>> +	n->pprev = &prev->next;
> >>>> +	WRITE_ONCE(prev->next, n);
> >>
> >> I don't see what this WRITE_ONCE() is interacting with.  The traversals
> >> use plain C-language reads, and hlist_bl_empty() can't get here.  All
> >> uses of hlist_bl_for_each_entry() invoke hlist_bl_lock() before starting
> >> the traversal, and hlist_bl_for_each_entry_safe() looks to be unused.
> >> (Perhaps it should be removed?  Or is there some anticipated use?)
> 
> I am using hlist_bl_for_each_entry_safe() in this proposed patch for
> dm-snapshot: https://patchwork.kernel.org/patch/10835709/

Probably should keep it, then.  ;-)

> >>
> >> I don't believe that the WRITE_ONCE() is needed.  What am I missing?
> >>
> >> Other than that, looks good.
> >>
> >> 							Thanx, Paul
> >>
> > 
> > I'd imagine it was just born out of symmetry with hlist_bl_add_before()
> > and/or caution.  But let's see what Nikos has to say.
> 
> I also don't believe that this WRITE_SAME() is needed. But, looking at
> hlist_add_behind() in include/linux/list.h, which, if I am not missing
> something, is used in the same way as hlist_bl_add_behind(), it also
> uses WRITE_ONCE() to update prev->next:
> 
> static inline void hlist_add_behind(struct hlist_node *n,
> 				    struct hlist_node *prev)
> {
> 	n->next = prev->next;
> 	WRITE_ONCE(prev->next, n);
> 	n->pprev = &prev->next;
> 
> 	if (n->next)
> 		n->next->pprev  = &n->next;
> }
> 
> Could it be the case that the WRITE_ONCE() in hlist_add_behind() is also
> not needed? This WRITE_ONCE() was introduced by commit 1c97be677f72b3
> ("list: Use WRITE_ONCE() when adding to lists and hlists").

Looks like I have no one to blame but myself!

Would you like to remove that as part of your patch series?

> But, since I am not an expert in lockless programming, I opted to be on
> the safe side and followed the example of hlist_add_behind().
> 
> That said, I will follow up with a new version of the patch removing the
> WRITE_ONCE() and using uintptr_t instead of unsigned long.

Sounds good!

							Thanx, Paul

