Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF40C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8442173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfH1KWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:22:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46526 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1KWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:22:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v68-0000p7-54; Wed, 28 Aug 2019 12:22:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDCCA1C07D2;
        Wed, 28 Aug 2019 12:22:39 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:22:39 -0000
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Remove const qualifier from
 node_to_cpumask argument
Cc:     kbuild test robot <lkp@intel.com>, Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828085815.19931-1-ming.lei@redhat.com>
References: <20190828085815.19931-1-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <156698775955.6413.14282501548633391814.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     101f85b56d03b36418bbf867f67d81710839b0ec
Gitweb:        https://git.kernel.org/tip/101f85b56d03b36418bbf867f67d81710839b0ec
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Wed, 28 Aug 2019 16:58:15 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 12:20:43 +02:00

genirq/affinity: Remove const qualifier from node_to_cpumask argument

When CONFIG_CPUMASK_OFFSTACK isn't enabled, 'cpumask_var_t' is as

'typedef struct cpumask cpumask_var_t[1]',

so the argument 'node_to_cpumask' alloc_nodes_vectors() can't be declared
as 'const cpumask_var_t *'

Fixes the following warning:

   kernel/irq/affinity.c: In function '__irq_build_affinity_masks':
     alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
                                  ^
   kernel/irq/affinity.c:128:13: note: expected 'const struct cpumask (*)[1]' but argument is of type 'struct cpumask (*)[1]'
    static void alloc_nodes_vectors(unsigned int numvecs,
                ^
Fixes: b1a5a73e64e9 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190828085815.19931-1-ming.lei@redhat.com

---
 kernel/irq/affinity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d905e84..4d89ad4 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -126,7 +126,7 @@ static int ncpus_cmp_func(const void *l, const void *r)
  * for each node.
  */
 static void alloc_nodes_vectors(unsigned int numvecs,
-				const cpumask_var_t *node_to_cpumask,
+				cpumask_var_t *node_to_cpumask,
 				const struct cpumask *cpu_mask,
 				const nodemask_t nodemsk,
 				struct cpumask *nmsk,
