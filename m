Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CFFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9F2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfDDVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:08:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729116AbfDDVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:08:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34L3iu1174640
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 17:08:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rnsa40n0h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 17:08:01 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 22:08:01 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 22:07:57 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34L7uAA19595392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 21:07:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C4B2B2064;
        Thu,  4 Apr 2019 21:07:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2D3FB205F;
        Thu,  4 Apr 2019 21:07:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 21:07:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D9FD616C5F74; Thu,  4 Apr 2019 14:07:57 -0700 (PDT)
Date:   Thu, 4 Apr 2019 14:07:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     Mukesh Ojha <mojha@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: tree_stall: Correctly unlock root node in
 rcu_check_gp_start_stall
Reply-To: paulmck@linux.ibm.com
References: <1553858828-23097-1-git-send-email-neeraju@codeaurora.org>
 <7a9eed5a-9bcf-460c-abb9-1e9bd6eae102@codeaurora.org>
 <2a8057f7-0704-5e8f-423e-e56a91a9b448@codeaurora.org>
 <20190329212755.GB4102@linux.ibm.com>
 <10b7ba19-9184-a4aa-d609-a644fcbe0503@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10b7ba19-9184-a4aa-d609-a644fcbe0503@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040421-0072-0000-0000-00000415A8C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01184369; UDB=6.00620132; IPR=6.00965122;
 MB=3.00026298; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 21:08:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040421-0073-0000-0000-00004BB67CDA
Message-Id: <20190404210757.GO14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 09:14:36AM +0530, Neeraj Upadhyay wrote:
> On 3/30/19 2:57 AM, Paul E. McKenney wrote:
> >On Fri, Mar 29, 2019 at 07:52:15PM +0530, Neeraj Upadhyay wrote:
> >>
> >>
> >>On 3/29/19 6:58 PM, Mukesh Ojha wrote:
> >>>
> >>>On 3/29/2019 4:57 PM, Neeraj Upadhyay wrote:
> >>>>Only unlock the root node, if current node (rnp) is not
> >>>>root node.
> >>>>
> >>>>Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> >>>
> >>>
> >>>
> >>>>---
> >>>>   kernel/rcu/tree_stall.h | 4 +++-
> >>>>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>>diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >>>>index f65a73a..0651833 100644
> >>>>--- a/kernel/rcu/tree_stall.h
> >>>>+++ b/kernel/rcu/tree_stall.h
> >>>
> >>>
> >>>why this is showing as under tree_stall.h while it is under
> >>>"kernel/rcu/tree.c"
> >>
> >>It's moved in https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=10462d6f58fb6dbde7563e9343505d98d5bfba3d
> >>
> >>Please see linux-rcu dev tree for other changes, which moves code to
> >>this file.
> >>
> >>
> >>Thanks
> >>Neeraj
> >>
> >>>
> >>>>@@ -630,7 +630,9 @@ static void rcu_check_gp_start_stall(struct
> >>>>rcu_node *rnp, struct rcu_data *rdp,
> >>>>           time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
> >>>>           time_before(j, rcu_state.gp_activity + gpssdelay) ||
> >>>>           atomic_xchg(&warned, 1)) {
> >>>>-        raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
> >>>>+        if (rnp_root != rnp)
> >>>>+            /* irqs remain disabled. */
> >>>>+            raw_spin_unlock_rcu_node(rnp_root);
> >>>
> >>>Looks good as it will balance the lock .if it is the root_node,
> >>>which was not there earlier, and unlock was happening without any
> >>>lock on root.
> >>>
> >>>Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> >
> >Applied, again thank you both!
> >
> >In both cases, I updated the commit log, so please check to make sure
> >that I didn't mess anything up.
> >
> >							Thanx, Paul
> >
> 
> Thanks Paul. One minor comment on https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=ec6530e763046b6bb1f4c2c2aed49ebc68aae2a0
> 
> 
> "it clearly does not make sense to release
> both rnp->lock and rnp->lock"
> 
> should be rnp->lock and rnp_root->lock

Good eyes, fixed, thank you!

							Thanx, Paul

> Thanks
> Neeraj
> 
> >>>Cheers,
> >>>-Mukesh
> >>>
> >>>>           raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >>>>           return;
> >>>>       }
> >>
> >>-- 
> >>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> >>member of the Code Aurora Forum, hosted by The Linux Foundation
> >>
> >
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

