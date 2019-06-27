Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC9DC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455E02086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF0WnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:43:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbfF0WnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:43:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RMgA3I089488;
        Thu, 27 Jun 2019 18:42:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td6e30ux4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 18:42:23 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5RMgN29089882;
        Thu, 27 Jun 2019 18:42:23 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2td6e30uwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 18:42:23 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5RMdvid032307;
        Thu, 27 Jun 2019 22:42:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 2t9by7hcg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 22:42:22 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RMgLUr47579548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 22:42:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96D3DB2065;
        Thu, 27 Jun 2019 22:42:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D4CB2064;
        Thu, 27 Jun 2019 22:42:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 22:42:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B3F5F16C6AC1; Thu, 27 Jun 2019 15:42:23 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:42:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jiunn Chang <c0d1n61at3@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH] doc: RCU callback locks need only
 _bh, not necessarily _irq
Message-ID: <20190627224223.GJ26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190627210147.19510-1-c0d1n61at3@gmail.com>
 <bc2ce605-56ab-33aa-c94d-d7774e6ce8cd@linuxfoundation.org>
 <20190627221045.GH26519@linux.ibm.com>
 <20190627182938.306ab9d9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182938.306ab9d9@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 06:29:38PM -0400, Steven Rostedt wrote:
> On Thu, 27 Jun 2019 15:10:45 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > On Thu, Jun 27, 2019 at 04:01:35PM -0600, Shuah Khan wrote:
> > > On 6/27/19 3:01 PM, Jiunn Chang wrote:  
> > > >The UP.rst file calls for locks acquired within RCU callback functions
> > > >to use _irq variants (spin_lock_irqsave() or similar), which does work,
> > > >but can be overkill.  This commit therefore instead calls for _bh variants
> > > >(spin_lock_bh() or similar), while noting that _irq does work.
> > > >
> > > >Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>  
> > > 
> > > Should this by Suggested-by?  
> > 
> > I wrote it and Jiunn converted my change to .rst, so I believe that
> > this is correct as is.
> 
> Note, you did send Jiunn an explicit Signed-off-by when you wrote it,
> correct? As Signed-off-by is equivalent to a signature.

Indeed I did, but I now see that it was via private email.  Here it is
again for public consumption, and Jiunn's patch is based on this one,
just translated to .rst.  I once again verified that the Jiunn's version
is word-for-word identical to mine, so Jiunn's patch should be good.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit a293734a310b463a0dba68409943a4e6065cd39d
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Jun 26 10:16:19 2019 -0700

    doc: RCU callback locks need only _bh, not necessarily _irq
    
    The UP.txt file calls for locks acquired within RCU callback functions
    to use _irq variants (spin_lock_irqsave() or similar), which does work,
    but can be overkill.  This commit therefore instead calls for _bh variants
    (spin_lock_bh() or similar), while noting that _irq does work.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.txt
index 53bde717017b..0edd8c5af0b5 100644
--- a/Documentation/RCU/UP.txt
+++ b/Documentation/RCU/UP.txt
@@ -104,12 +104,13 @@ Answer to Quick Quiz #1:
 Answer to Quick Quiz #2:
 	What locking restriction must RCU callbacks respect?
 
-	Any lock that is acquired within an RCU callback must be
-	acquired elsewhere using an _irq variant of the spinlock
-	primitive.  For example, if "mylock" is acquired by an
-	RCU callback, then a process-context acquisition of this
-	lock must use something like spin_lock_irqsave() to
-	acquire the lock.
+	Any lock that is acquired within an RCU callback must be acquired
+	elsewhere using an _bh variant of the spinlock primitive.
+	For example, if "mylock" is acquired by an RCU callback, then
+	a process-context acquisition of this lock must use something
+	like spin_lock_bh() to acquire the lock.  Please note that
+	it is also OK to use _irq variants of spinlocks, for example,
+	spin_lock_irqsave().
 
 	If the process-context code were to simply use spin_lock(),
 	then, since RCU callbacks can be invoked from softirq context,
