Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7793EC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55492208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF0WKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:10:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbfF0WKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:10:50 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RM6p92008074
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 18:10:49 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td45hdgd9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 18:10:49 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 23:10:48 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 23:10:44 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RMAh2010748580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 22:10:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B85C2B2095;
        Thu, 27 Jun 2019 22:10:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AEF3B2094;
        Thu, 27 Jun 2019 22:10:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 22:10:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DBE6216C5D5C; Thu, 27 Jun 2019 15:10:45 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:10:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only
 _bh, not necessarily _irq
Reply-To: paulmck@linux.ibm.com
References: <20190627210147.19510-1-c0d1n61at3@gmail.com>
 <bc2ce605-56ab-33aa-c94d-d7774e6ce8cd@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc2ce605-56ab-33aa-c94d-d7774e6ce8cd@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062722-0060-0000-0000-0000035662CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011343; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224188; UDB=6.00644298; IPR=6.01005376;
 MB=3.00027497; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 22:10:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062722-0061-0000-0000-000049EE81F9
Message-Id: <20190627221045.GH26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 04:01:35PM -0600, Shuah Khan wrote:
> On 6/27/19 3:01 PM, Jiunn Chang wrote:
> >The UP.rst file calls for locks acquired within RCU callback functions
> >to use _irq variants (spin_lock_irqsave() or similar), which does work,
> >but can be overkill.  This commit therefore instead calls for _bh variants
> >(spin_lock_bh() or similar), while noting that _irq does work.
> >
> >Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> Should this by Suggested-by?

I wrote it and Jiunn converted my change to .rst, so I believe that
this is correct as is.

							Thanx, Paul

> >Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> >---
> >  Documentation/RCU/UP.rst | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> >diff --git a/Documentation/RCU/UP.rst b/Documentation/RCU/UP.rst
> >index 67715a47ae89..e26dda27430c 100644
> >--- a/Documentation/RCU/UP.rst
> >+++ b/Documentation/RCU/UP.rst
> >@@ -113,12 +113,13 @@ Answer to Quick Quiz #1:
> >  Answer to Quick Quiz #2:
> >  	What locking restriction must RCU callbacks respect?
> >-	Any lock that is acquired within an RCU callback must be
> >-	acquired elsewhere using an _irq variant of the spinlock
> >-	primitive.  For example, if "mylock" is acquired by an
> >-	RCU callback, then a process-context acquisition of this
> >-	lock must use something like spin_lock_irqsave() to
> >-	acquire the lock.
> >+	Any lock that is acquired within an RCU callback must be acquired
> >+	elsewhere using an _bh variant of the spinlock primitive.
> >+	For example, if "mylock" is acquired by an RCU callback, then
> >+	a process-context acquisition of this lock must use something
> >+	like spin_lock_bh() to acquire the lock.  Please note that
> >+	it is also OK to use _irq variants of spinlocks, for example,
> >+	spin_lock_irqsave().
> >  	If the process-context code were to simply use spin_lock(),
> >  	then, since RCU callbacks can be invoked from softirq context,
> >
> 
> thanks,
> -- Shuah
> 

