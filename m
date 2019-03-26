Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F10FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B91F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbfCZXEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:04:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732240AbfCZXEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:04:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QN4RQh054616
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:04:39 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rftk1pgjg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:04:39 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:04:38 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:04:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QN4W7G6815960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:04:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E3F6B2068;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FD6AB2064;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 26D2616C60F8; Tue, 26 Mar 2019 16:04:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/4] doc: Describe choice of rcu_dereference() APIs and __rcu usage
Date:   Tue, 26 Mar 2019 16:04:31 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230408.GA17069@linux.ibm.com>
References: <20190326230408.GA17069@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0072-0000-0000-00000410BA0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180130; UDB=6.00617570; IPR=6.00960845;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:04:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0073-0000-0000-00004B9D528F
Message-Id: <20190326230432.17963-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/rcu_dereference.txt | 103 ++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/RCU/rcu_dereference.txt b/Documentation/RCU/rcu_dereference.txt
index ab96227bad42..bf699e8cfc75 100644
--- a/Documentation/RCU/rcu_dereference.txt
+++ b/Documentation/RCU/rcu_dereference.txt
@@ -351,3 +351,106 @@ garbage values.
 
 In short, rcu_dereference() is -not- optional when you are going to
 dereference the resulting pointer.
+
+
+WHICH MEMBER OF THE rcu_dereference() FAMILY SHOULD YOU USE?
+
+First, please avoid using rcu_dereference_raw() and also please avoid
+using rcu_dereference_check() and rcu_dereference_protected() with a
+second argument with a constant value of 1 (or true, for that matter).
+With that caution out of the way, here is some guidance for which
+member of the rcu_dereference() to use in various situations:
+
+1.	If the access needs to be within an RCU read-side critical
+	section, use rcu_dereference().  With the new consolidated
+	RCU flavors, an RCU read-side critical section is entered
+	using rcu_read_lock(), anything that disables bottom halves,
+	anything that disables interrupts, or anything that disables
+	preemption.
+
+2.	If the access might be within an RCU read-side critical section
+	on the one hand, or protected by (say) my_lock on the other,
+	use rcu_dereference_check(), for example:
+
+		p1 = rcu_dereference_check(p->rcu_protected_pointer,
+					   lockdep_is_held(&my_lock));
+
+
+3.	If the access might be within an RCU read-side critical section
+	on the one hand, or protected by either my_lock or your_lock on
+	the other, again use rcu_dereference_check(), for example:
+
+		p1 = rcu_dereference_check(p->rcu_protected_pointer,
+					   lockdep_is_held(&my_lock) ||
+					   lockdep_is_held(&your_lock));
+
+4.	If the access is on the update side, so that it is always protected
+	by my_lock, use rcu_dereference_protected():
+
+		p1 = rcu_dereference_protected(p->rcu_protected_pointer,
+					       lockdep_is_held(&my_lock));
+
+	This can be extended to handle multiple locks as in #3 above,
+	and both can be extended to check other conditions as well.
+
+5.	If the protection is supplied by the caller, and is thus unknown
+	to this code, that is the rare case when rcu_dereference_raw()
+	is appropriate.  In addition, rcu_dereference_raw() might be
+	appropriate when the lockdep expression would be excessively
+	complex, except that a better approach in that case might be to
+	take a long hard look at your synchronization design.  Still,
+	there are data-locking cases where any one of a very large number
+	of locks or reference counters suffices to protect the pointer,
+	so rcu_dereference_raw() does have its place.
+
+	However, its place is probably quite a bit smaller than one
+	might expect given the number of uses in the current kernel.
+	Ditto for its synonym, rcu_dereference_check( ... , 1), and
+	its close relative, rcu_dereference_protected(... , 1).
+
+
+SPARSE CHECKING OF RCU-PROTECTED POINTERS
+
+The sparse static-analysis tool checks for direct access to RCU-protected
+pointers, which can result in "interesting" bugs due to compiler
+optimizations involving invented loads and perhaps also load tearing.
+For example, suppose someone mistakenly does something like this:
+
+	p = q->rcu_protected_pointer;
+	do_something_with(p->a);
+	do_something_else_with(p->b);
+
+If register pressure is high, the compiler might optimize "p" out
+of existence, transforming the code to something like this:
+
+	do_something_with(q->rcu_protected_pointer->a);
+	do_something_else_with(q->rcu_protected_pointer->b);
+
+This could fatally disappoint your code if q->rcu_protected_pointer
+changed in the meantime.  Nor is this a theoretical problem:  Exactly
+this sort of bug cost Paul E. McKenney (and several of his innocent
+colleagues) a three-day weekend back in the early 1990s.
+
+Load tearing could of course result in dereferencing a mashup of a pair
+of pointers, which also might fatally disappoint your code.
+
+These problems could have been avoided simply by making the code instead
+read as follows:
+
+	p = rcu_dereference(q->rcu_protected_pointer);
+	do_something_with(p->a);
+	do_something_else_with(p->b);
+
+Unfortunately, these sorts of bugs can be extremely hard to spot during
+review.  This is where the sparse tool comes into play, along with the
+"__rcu" marker.  If you mark a pointer declaration, whether in a structure
+or as a formal parameter, with "__rcu", which tells sparse to complain if
+this pointer is accessed directly.  It will also cause sparse to complain
+if a pointer not marked with "__rcu" is accessed using rcu_dereference()
+and friends.  For example, ->rcu_protected_pointer might be declared as
+follows:
+
+	struct foo __rcu *rcu_protected_pointer;
+
+Use of "__rcu" is opt-in.  If you choose not to use it, then you should
+ignore the sparse warnings.
-- 
2.17.1

