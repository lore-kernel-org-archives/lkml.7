Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D7F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfHMPYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:24:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729802AbfHMPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:24:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DFCRXn034039;
        Tue, 13 Aug 2019 11:23:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubwm473au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 11:23:52 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7DFCbCe034743;
        Tue, 13 Aug 2019 11:23:51 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubwm4739x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 11:23:51 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7DFFRw7002546;
        Tue, 13 Aug 2019 15:23:50 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2u9nj6pj94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 15:23:50 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7DFNnJ255312662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 15:23:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BDDDB2067;
        Tue, 13 Aug 2019 15:23:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EB14B205F;
        Tue, 13 Aug 2019 15:23:49 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 15:23:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5FC1F16C1057; Tue, 13 Aug 2019 08:23:50 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:23:50 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: rcu/nocb: Add bypass callback queueing, bug report
Message-ID: <20190813152350.GC28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <e89f5af3-dcf3-986f-828f-14e10cef9915@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89f5af3-dcf3-986f-828f-14e10cef9915@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:34:02PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis on linux-next today found an issue in the following commit:
> 
> commit 1afc4b18724f8f7b7a21fdf66cd43cc4a932812d
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Tue Jul 2 16:03:33 2019 -0700
> 
>     rcu/nocb: Add bypass callback queueing
> 
> 
> The coverity report is as follows:
> 
> 1783        // If we have advanced to a new jiffy, reset counts to allow
> 1784        // moving back from ->nocb_bypass to ->cblist.
> 1785        if (j == rdp->nocb_nobypass_last) {
> 1786                c = rdp->nocb_nobypass_count + 1;
> 1787        } else {
> 1788                WRITE_ONCE(rdp->nocb_nobypass_last, j);
> 1789                c = rdp->nocb_nobypass_count -
> nocb_nobypass_lim_per_jiffy;
> 1790                if (c > nocb_nobypass_lim_per_jiffy)
> 1791                        c = nocb_nobypass_lim_per_jiffy;
> 
> CID 85141 (#1 of 1): Unsigned compared against 0
> unsigned_compare: This less-than-zero comparison of an unsigned value is
> never true. c < 0UL.
> 
> 1792                else if (c < 0)
> 1793                        c = 0;
> 
> Variable c is an unsigned long so the c < 0 check is never true. I'm not
> sure what the ramifications are if c is made a signed long instead, so
> I'm not fixing this and reporting this issue.

Good catch!!!

How about the alleged fix shown below?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 91cefa3bf943..2defc7fe74c3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1787,10 +1787,11 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	} else {
 		WRITE_ONCE(rdp->nocb_nobypass_last, j);
 		c = rdp->nocb_nobypass_count - nocb_nobypass_lim_per_jiffy;
-		if (c > nocb_nobypass_lim_per_jiffy)
-			c = nocb_nobypass_lim_per_jiffy;
-		else if (c < 0)
+		if (ULONG_CMP_LT(rdp->nocb_nobypass_count,
+				 nocb_nobypass_lim_per_jiffy))
 			c = 0;
+		else if (c > nocb_nobypass_lim_per_jiffy)
+			c = nocb_nobypass_lim_per_jiffy;
 	}
 	WRITE_ONCE(rdp->nocb_nobypass_count, c);
 
