Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D9BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F116C20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="UqN/glHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJ3Sd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:33:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43408 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfJ3Sd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:33:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id g77so1179344ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UAcDNxbsHyp6817IEPmuzBCq+EObPVndn4RGShy3l04=;
        b=UqN/glHb2+oS0U30aEukrVIc5WYNVKImT1rr2eKuX4KJSu9753FFW2yorN8CpQidy1
         UtF40MQzG0X/XWKez440BeIWKreETp4ifFuRwAU51XX9zoug0JC18+YV1VIa2ALvLU3F
         odmg8GPx2g2O5GL/lmw/wQ5MY2+Fc6uAz32ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UAcDNxbsHyp6817IEPmuzBCq+EObPVndn4RGShy3l04=;
        b=F3pyPrMasqMNsibpo9iIMu5Sbd9q/r2bkfBC3izIdW3mZ9id+HedRF6qU36ltPFVTT
         +DcJoz/FHOTB0hvOlSMDqFdaWvxVDQIXLPpqO5SWLm8fr9ATOhEN6AX8RdI/m8kT3Iau
         ItjTwBQhC8yD1I2LF/zQXNPxaJUbIvf5Qx8ujT4U4M4JQqH5EVRyUoS4tT0J/yOHtbog
         bGSqaqzApSDkKiHywwpyPBScXifJxzVVHRETGYMITYdth51Nmt/C0gWjaqfKBkgP6zvO
         BquPsNBFNlulxA+dS1fPiEFwT27OBvOwVAlyrBe+EO7SHrscjAIG9fw5mev4J1Us29JF
         os5A==
X-Gm-Message-State: APjAAAWdI8Pa/IqUNeX//D+qKzbxIZzCBQPNibaSmIjn+KUz8cGLnRg/
        zqw3HJStglrqC2CusXmA9tsNvA==
X-Google-Smtp-Source: APXvYqxg1WBHKIOCPQIO3byf2GcNUlQMjVSDhq+KH/Ms4EsgjokOfR7HAe7t88TWkDOmRjeJ3eEIIg==
X-Received: by 2002:a81:5ed4:: with SMTP id s203mr882046ywb.340.1572460436197;
        Wed, 30 Oct 2019 11:33:56 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id u7sm1020549ywu.45.2019.10.30.11.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 11:33:55 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 01/19] stop_machine: Fix stop_cpus_in_progress ordering
Date:   Wed, 30 Oct 2019 18:33:14 +0000
Message-Id: <94254706c6b697b6351d604642c404ace101d3fb.1572437285.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Make sure the entire for loop has stop_cpus_in_progress set.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/stop_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b4f83f7bdf86..c7031a22aa7b 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -383,6 +383,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 	 */
 	preempt_disable();
 	stop_cpus_in_progress = true;
+	barrier();
 	for_each_cpu(cpu, cpumask) {
 		work = &per_cpu(cpu_stopper.stop_work, cpu);
 		work->fn = fn;
@@ -391,6 +392,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
+	barrier();
 	stop_cpus_in_progress = false;
 	preempt_enable();
 
-- 
2.17.1

