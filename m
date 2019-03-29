Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA6218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfC2V1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:27:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730137AbfC2V1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:27:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TLOLlX028637
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:27:06 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rht8q2gk9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:27:06 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 29 Mar 2019 21:27:05 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 21:27:01 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TLR0h724248334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 21:27:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DF07B2066;
        Fri, 29 Mar 2019 21:27:00 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80659B2064;
        Fri, 29 Mar 2019 21:27:00 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 21:27:00 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DC5C416C170A; Fri, 29 Mar 2019 14:27:02 -0700 (PDT)
Date:   Fri, 29 Mar 2019 14:27:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: tree_plugin: Dump specified number of blocked tasks
Reply-To: paulmck@linux.ibm.com
References: <1553853352-14253-1-git-send-email-neeraju@codeaurora.org>
 <35a95581-138d-b047-b809-aff803287a23@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a95581-138d-b047-b809-aff803287a23@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032921-0064-0000-0000-000003C2AE37
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010836; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181531; UDB=6.00618415; IPR=6.00962251;
 MB=3.00026215; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-29 21:27:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032921-0065-0000-0000-00003CE178B4
Message-Id: <20190329212702.GA4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:42:44PM +0530, Mukesh Ojha wrote:
> 
> On 3/29/2019 3:25 PM, Neeraj Upadhyay wrote:
> >dump_blkd_tasks() uses 10 as the max number of blocked
> >tasks, which are printed. However, it has an argument
> >which provides that number. So, use the argument value
> >instead. As all callers currently pass 10 as the number,
> >there isn't any impact.
> >
> >Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> Looks good to me.
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied, thank you both!

							Thanx, Paul

> Cheers,
> -Mukesh
> 
> >---
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >index 3960294..08bcd87 100644
> >--- a/kernel/rcu/tree_plugin.h
> >+++ b/kernel/rcu/tree_plugin.h
> >@@ -740,7 +740,7 @@ void exit_rcu(void)
> >  	i = 0;
> >  	list_for_each(lhp, &rnp->blkd_tasks) {
> >  		pr_cont(" %p", lhp);
> >-		if (++i >= 10)
> >+		if (++i >= ncheck)
> >  			break;
> >  	}
> >  	pr_cont("\n");
> 

