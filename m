Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C356DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330F218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6bI5OiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfC2PVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:21:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41586 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbfC2PVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:21:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TFJ4fY067511;
        Fri, 29 Mar 2019 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=IMtDqAH2twqsgBmdTxAqOxDa88lzTPiRojEqy8McD1o=;
 b=Y6bI5OiXTxZWHsAl1RtL8fqUbudJDsKyh2vifrTwcb2/8wIF6yBqzBYR0kPL8WPFJzwE
 tK4vZUH0Me5XyFcXYB58enM/A2RgNOrKGBesu35xTsEeA4+hhfYTkKvBA51xN8Ph9d9y
 LFY8/BRgPJ5CTDAWEeXKeILl+CqikZJVmBPogCc5U+9H7ynvdtKMkKEXIZgTvO8h5UuZ
 xhxZD7/z1FtJkavGPH8EhW7WHmqCyjHRdjceRQbQekNRZNCelDsGck7IZvmvKCHDMzfP
 KsiC9CmhXkV+AOhbrxd8f7EOzVkuTGL2oS2yJKe5LeXC0fqNkmaorLkGlqcqBuiisdou Tw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g1d3g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKNgx011769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:20:23 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TFKM49017790;
        Fri, 29 Mar 2019 15:20:22 GMT
Received: from ol-bur-x5-4.us.oracle.com (/10.152.128.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 08:20:21 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v2 5/5] locking/qspinlock: Introduce the shuffle reduction optimization into CNA
Date:   Fri, 29 Mar 2019 11:20:06 -0400
Message-Id: <20190329152006.110370-6-alex.kogan@oracle.com>
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

This optimization reduces the probability threads will be shuffled between
the main and secondary queues when the secondary queue is empty.
It is helpful when the lock is only lightly contended.

Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 kernel/locking/qspinlock_cna.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 5addf6439326..29941677a6e1 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -41,6 +41,15 @@ static DEFINE_PER_CPU(u32, seed);
  */
 #define INTRA_NODE_HANDOFF_PROB_ARG 0x10000
 
+/*
+ * Controls the probability for enabling the scan of the main queue when
+ * the secondary queue is empty. The chosen value reduces the amount of
+ * unnecessary shuffling of threads between the two waiting queues when
+ * the contention is low, while responding fast enough and enabling
+ * the shuffling when the contention is high.
+ */
+#define SHUFFLE_REDUCTION_PROB_ARG  0x80
+
 static inline __pure int decode_numa_node(u32 node_and_count)
 {
 	int node = (node_and_count >> _Q_NODE_OFFSET) - 1;
@@ -197,6 +206,18 @@ static inline void pass_mcs_lock(struct mcs_spinlock *node,
 	struct mcs_spinlock *succ = NULL;
 
 	/*
+	 * Limit thread shuffling when the secondary queue is empty.
+	 * This copes with the overhead the shuffling creates when the
+	 * lock is only lightly contended, and threads do not stay
+	 * in the secondary queue long enough to reap the benefit of moving
+	 * them there.
+	 */
+	if (node->locked == 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) {
+		arch_mcs_spin_unlock_contended(&next->locked, 1);
+		return;
+	}
+
+	/*
 	 * Try to pass the lock to a thread running on the same node.
 	 * For long-term fairness, search for such a thread with high
 	 * probability rather than always.
-- 
2.11.0 (Apple Git-81)

