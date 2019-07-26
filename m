Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50A2C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C657218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5wATKxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGZQVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:21:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57124 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfGZQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4LGgb/RxBmRsu5tQu/73IdPkxohqI9VwMtm6mMA9Uf0=; b=r5wATKxZkFwgTqzrQPtB6UV33n
        prUfoOnj40W0xggTXD0EN4WC01PLcUPi00DY+OUWq7oEJNYODx9OtpjNydn5iSXbdt77LYu3mRxRB
        a3oeDTXWc6r2M4otFj5RsRKI6i0kqZMntTH/vwHzG/Zww8/XWyGR2ja5AaliB3/vsvMA6+Cl4iZPc
        oPqRW3tRxLI2fBJvCRuz03TFJfjQKEeyuzhawa1V32+lpS7hVIqAGKofLnhcBkguvonkk+UtUalQl
        TNVUclUlewYgLnNUnZAPepXLD2qvPqfu3LcI2k6wZt6OgCsiwdi/MwxxJrcFKzf/r8pwFaAkd7C9D
        SuIPvK+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr2wy-00066T-3D; Fri, 26 Jul 2019 16:20:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 41BED2022974D; Fri, 26 Jul 2019 18:20:05 +0200 (CEST)
Message-Id: <20190726161357.455421817@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 16:54:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aaron Lu <aaron.lwe@gmail.com>, keescook@chromium.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Phil Auld <pauld@redhat.com>, torvalds@linux-foundation.org,
        Tim Chen <tim.c.chen@linux.intel.com>, fweisbec@gmail.com,
        subhra.mazumdar@oracle.com,
        Julien Desfossez <jdesfossez@digitalocean.com>, pjt@google.com,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>, kerrnel@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [RFC][PATCH 02/13] stop_machine: Fix stop_cpus_in_progress ordering
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure the entire for loop has stop_cpus_in_progress set.

Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Aaron Lu <aaron.lwe@gmail.com>
Cc: keescook@chromium.org
Cc: mingo@kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: torvalds@linux-foundation.org
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: fweisbec@gmail.com
Cc: subhra.mazumdar@oracle.com
Cc: tglx@linutronix.de
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: pjt@google.com
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Aubrey Li <aubrey.intel@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: kerrnel@google.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com
---
 kernel/stop_machine.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -383,6 +383,7 @@ static bool queue_stop_cpus_work(const s
 	 */
 	preempt_disable();
 	stop_cpus_in_progress = true;
+	barrier();
 	for_each_cpu(cpu, cpumask) {
 		work = &per_cpu(cpu_stopper.stop_work, cpu);
 		work->fn = fn;
@@ -391,6 +392,7 @@ static bool queue_stop_cpus_work(const s
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
+	barrier();
 	stop_cpus_in_progress = false;
 	preempt_enable();
 


