Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ED9C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1519725BCE
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfE3Ozb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:55:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726842AbfE3Oza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:55:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEptLX163915
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:55:29 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2stgm12dc1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 10:55:29 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 30 May 2019 15:55:28 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 15:55:23 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4UEtMR936896856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 14:55:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1807CB206C;
        Thu, 30 May 2019 14:55:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE37AB2066;
        Thu, 30 May 2019 14:55:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 14:55:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AB44A16C5D7E; Thu, 30 May 2019 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        jannh@google.com, "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/2] doc/rcuref: Document real world examples in kernel
Date:   Thu, 30 May 2019 07:55:21 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530145504.GA29820@linux.ibm.com>
References: <20190530145504.GA29820@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19053014-0064-0000-0000-000003E70DC6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011185; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210784; UDB=6.00636157; IPR=6.00991818;
 MB=3.00027120; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-30 14:55:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053014-0065-0000-0000-00003DAB994D
Message-Id: <20190530145522.30122-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=38 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Document similar real world examples in the kernel corresponding to the
second and third code snippets. Also correct an issue in
release_referenced() in the code snippet example.

Cc: oleg@redhat.com
Cc: jannh@google.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Do a bit of wordsmithing. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/rcuref.txt | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcuref.txt b/Documentation/RCU/rcuref.txt
index 613033ff2b9b..5e6429d66c24 100644
--- a/Documentation/RCU/rcuref.txt
+++ b/Documentation/RCU/rcuref.txt
@@ -12,6 +12,7 @@ please read on.
 Reference counting on elements of lists which are protected by traditional
 reader/writer spinlocks or semaphores are straightforward:
 
+CODE LISTING A:
 1.				2.
 add()				search_and_reference()
 {				{
@@ -28,7 +29,8 @@ add()				search_and_reference()
 release_referenced()			delete()
 {					{
     ...					    write_lock(&list_lock);
-    atomic_dec(&el->rc, relfunc)	    ...
+    if(atomic_dec_and_test(&el->rc))	    ...
+	kfree(el);
     ...					    remove_element
 }					    write_unlock(&list_lock);
  					    ...
@@ -44,6 +46,7 @@ search_and_reference() could potentially hold reference to an element which
 has already been deleted from the list/array.  Use atomic_inc_not_zero()
 in this scenario as follows:
 
+CODE LISTING B:
 1.					2.
 add()					search_and_reference()
 {					{
@@ -79,6 +82,7 @@ search_and_reference() code path.  In such cases, the
 atomic_dec_and_test() may be moved from delete() to el_free()
 as follows:
 
+CODE LISTING C:
 1.					2.
 add()					search_and_reference()
 {					{
@@ -114,6 +118,17 @@ element can therefore safely be freed.  This in turn guarantees that if
 any reader finds the element, that reader may safely acquire a reference
 without checking the value of the reference counter.
 
+A clear advantage of the RCU-based pattern in listing C over the one
+in listing B is that any call to search_and_reference() that locates
+a given object will succeed in obtaining a reference to that object,
+even given a concurrent invocation of delete() for that same object.
+Similarly, a clear advantage of both listings B and C over listing A is
+that a call to delete() is not delayed even if there are an arbitrarily
+large number of calls to search_and_reference() searching for the same
+object that delete() was invoked on.  Instead, all that is delayed is
+the eventual invocation of kfree(), which is usually not a problem on
+modern computer systems, even the small ones.
+
 In cases where delete() can sleep, synchronize_rcu() can be called from
 delete(), so that el_free() can be subsumed into delete as follows:
 
@@ -130,3 +145,7 @@ delete()
     	kfree(el);
     ...
 }
+
+As additional examples in the kernel, the pattern in listing C is used by
+reference counting of struct pid, while the pattern in listing B is used by
+struct posix_acl.
-- 
2.17.1

