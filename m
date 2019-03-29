Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E8F21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2j9X3OHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfC2PVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC2PVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TFJH30063321;
        Fri, 29 Mar 2019 15:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=t63sWks0idVUCh6w9abOQ5uoAGN+aV2nYum8doIOZV0=;
 b=2j9X3OHhNrZTTTqeP/QqXNVkXbvgOAa1K9LtxZT273Uh55KGjy4AcyG9s4hy9e1Y16JV
 Nq/7fe08FA63+z9ZFzF5diHguMR1ptT+2yJUVCXK89m51CWUDsYKNQrvOMoPEjNrxtny
 FuEOgWOvD1NSxV03WhzMIW0S6k7vO5BIVQ1KxV5AciuhIQs7mxb3yPb1Ap9NBDwIGPdY
 XU4exAq34q6zHkIUF9vcJWoZSUDfvXKOctdEnu4XRjHWtdVUQBywLrq4lGQJeoWwjh3H
 iNrYb+fFFBiwh+uMzKKC4Miia8qDTuklkadJfHDRXIAjxp5MfT+pXYVINYmmqy8V/FFr ww== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2re6g1n247-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKML5002058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:22 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKGb2026907;
        Fri, 29 Mar 2019 15:20:16 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 08:20:16 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v2 1/5] locking/qspinlock: Make arch_mcs_spin_unlock_contended more generic
Date:   Fri, 29 Mar 2019 11:20:02 -0400
Message-Id: <20190329152006.110370-2-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329152006.110370-1-alex.kogan@oracle.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch_mcs_spin_unlock_contended macro should accept the value to be
stored into the lock argument as another argument. This allows using the
same macro in cases where the value to be stored is different from 1.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 arch/arm/include/asm/mcs_spinlock.h | 4 ++--
 kernel/locking/mcs_spinlock.h       | 6 +++---
 kernel/locking/qspinlock.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
index 529d2cf4d06f..ae6d763477f4 100644
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ b/arch/arm/include/asm/mcs_spinlock.h
@@ -14,9 +14,9 @@ do {									\
 		wfe();							\
 } while (0)								\
 
-#define arch_mcs_spin_unlock_contended(lock)				\
+#define arch_mcs_spin_unlock_contended(lock, val)			\
 do {									\
-	smp_store_release(lock, 1);					\
+	smp_store_release(lock, (val));					\
 	dsb_sev();							\
 } while (0)
 
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 5e10153b4d3c..bc6d3244e1af 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -41,8 +41,8 @@ do {									\
  * operations in the critical section has been completed before
  * unlocking.
  */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
+#define arch_mcs_spin_unlock_contended(l, val)				\
+	smp_store_release((l), (val))
 #endif
 
 /*
@@ -115,7 +115,7 @@ void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
 	}
 
 	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
 }
 
 #endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5e9247dc2515..5941ce3527ce 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -558,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	arch_mcs_spin_unlock_contended(&next->locked, 1);
 	pv_kick_node(lock, next);
 
 release:
-- 
2.11.0 (Apple Git-81)

