Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A26FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D6820828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfH0Ogo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:36:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43960 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfH0Ogk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:36:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2caJ-0008Qw-4q; Tue, 27 Aug 2019 16:36:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9ACE21C07DC;
        Tue, 27 Aug 2019 16:36:34 +0200 (CEST)
Date:   Tue, 27 Aug 2019 14:36:34 -0000
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Improve __irq_build_affinity_masks()
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190816022849.14075-2-ming.lei@redhat.com>
References: <20190816022849.14075-2-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <156691659442.23585.17929718097373200199.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     53c1788b7d7720565214a466afffdc818d8c6e5f
Gitweb:        https://git.kernel.org/tip/53c1788b7d7720565214a466afffdc818d8c6e5f
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Fri, 16 Aug 2019 10:28:48 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Aug 2019 16:31:17 +02:00

genirq/affinity: Improve __irq_build_affinity_masks()

One invariant of __irq_build_affinity_masks() is that all CPUs in the
specified masks (cpu_mask AND node_to_cpumask for each node) should be
covered during the spread. Even though all requested vectors have been
reached, it's still required to spread vectors among remained CPUs. A
similar policy has been taken in case of 'numvecs <= nodes' already.

So remove the following check inside the loop:

	if (done >= numvecs)
		break;

Meantime assign at least 1 vector for remaining nodes if 'numvecs' vectors
have been handled already.

Also, if the specified cpumask for one numa node is empty, simply do not
spread vectors on this node.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190816022849.14075-2-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6fef480..c7cca94 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -129,14 +129,26 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	for_each_node_mask(n, nodemsk) {
 		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
 
-		/* Spread the vectors per node */
-		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
-
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-
-		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
+		if (!ncpus)
+			continue;
+
+		/*
+		 * Calculate the number of cpus per vector
+		 *
+		 * Spread the vectors evenly per node. If the requested
+		 * vector number has been reached, simply allocate one
+		 * vector for each remaining node so that all nodes can
+		 * be covered
+		 */
+		if (numvecs > done)
+			vecs_per_node = max_t(unsigned,
+					(numvecs - done) / nodes, 1);
+		else
+			vecs_per_node = 1;
+
 		vecs_to_assign = min(vecs_per_node, ncpus);
 
 		/* Account for rounding errors */
@@ -156,13 +168,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		}
 
 		done += v;
-		if (done >= numvecs)
-			break;
 		if (curvec >= last_affv)
 			curvec = firstvec;
 		--nodes;
 	}
-	return done;
+	return done < numvecs ? done : numvecs;
 }
 
 /*
