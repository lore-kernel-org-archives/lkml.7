Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77952085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCNGHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:07:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:25931 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfCNGHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:07:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 23:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,477,1544515200"; 
   d="scan'208";a="154884939"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2019 23:07:19 -0700
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
To:     Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net>
 <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com>
 <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
 <CAERHkrvjOfVz9xGWZOTGvcUcMETyBdQ2NPj-0USQNU1QTDXR3Q@mail.gmail.com>
 <CAERHkrvgMNf2rmQ_pF5S7Wq64fnkW4HzP_VYPL4vQWyKgHPgxA@mail.gmail.com>
 <8098aac2-60f7-6fe9-2a3a-2fe2e1b49bde@linux.intel.com>
 <CAERHkrvFe-s=_SD2WO0yuYiQ3JxY22=pSrM4UE-BWpbPD8iiCA@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <5f9b9e7b-3e6f-6f72-77ac-64117cf6002b@linux.intel.com>
Date:   Thu, 14 Mar 2019 14:07:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAERHkrvFe-s=_SD2WO0yuYiQ3JxY22=pSrM4UE-BWpbPD8iiCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original patch seems missing the following change for 32bit.

Thanks,
-Aubrey

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 9fbb10383434..78de28ebc45d 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -111,7 +111,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	/*
 	 * Take rq->lock to make 64-bit read safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	if (index == CPUACCT_STAT_NSTATS) {
@@ -125,7 +125,7 @@ static u64 cpuacct_cpuusage_read(struct cpuacct *ca, int cpu,
 	}
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	return data;
@@ -140,14 +140,14 @@ static void cpuacct_cpuusage_write(struct cpuacct *ca, int cpu, u64 val)
 	/*
 	 * Take rq->lock to make 64-bit write safe on 32-bit platforms.
 	 */
-	raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 	for (i = 0; i < CPUACCT_STAT_NSTATS; i++)
 		cpuusage->usages[i] = val;
 
 #ifndef CONFIG_64BIT
-	raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+	raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 }
 
@@ -252,13 +252,13 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 			 * Take rq->lock to make 64-bit read safe on 32-bit
 			 * platforms.
 			 */
-			raw_spin_lock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_lock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 
 			seq_printf(m, " %llu", cpuusage->usages[index]);
 
 #ifndef CONFIG_64BIT
-			raw_spin_unlock_irq(&cpu_rq(cpu)->lock);
+			raw_spin_unlock_irq(rq_lockp(cpu_rq(cpu)));
 #endif
 		}
 		seq_puts(m, "\n");
