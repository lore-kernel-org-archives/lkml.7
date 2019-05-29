Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E08DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664BC24177
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fuh0Wd+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfE2UhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:37:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55794 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfE2Ug7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:36:59 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so6235390iti.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=i9u6VHWW3afjnCOMoNc95nC4T3wZam37RatzS70qNxg=;
        b=fuh0Wd+FcHdwZa+R9oeIqWNDEtcL99azHHKi53RKIewMK6Ac98II3TJHHrwiYLJuYn
         PV4RpKg0GW0j7iW9tcob4LXKlgsZMsJ7eqGeWgZA9BOcvp5s9aRTKUiV3vtZFRmALokf
         MCg/glaIwQgO4UGF7UWSeSUGtrRtJmJ4pSxQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=i9u6VHWW3afjnCOMoNc95nC4T3wZam37RatzS70qNxg=;
        b=tOqoWyRdDIuTDeRzhOHk0QE8sm35kzdLWi90cgE8+pXIjMK6YtouKMmsds+hAxS5Le
         M2sNbGt3xnVjh1N+nwJejU62ydQUv6rxsohT6J3WfaxLlh+kCYBPW9QDBF+hWeKULQjf
         wGl5pfu9CBAZD1qQapYvbBe276ZnPDn6yWim9nGYd9WAKvE2sJRPtrMJwkI/T25sPJ1Q
         2cnOEkdThuDwTgn1bgS4FY3xBB+lAkKk4muW0qnllAkzqvfo73jlDWmadqpQAjCARc4y
         qfPu7kwHRgJJ8NKI10iz+/OHz/rq14C3OwZEoDrkvHK2QIII5m6DCb+a/uIfccT0VJ7e
         WRYQ==
X-Gm-Message-State: APjAAAWFnJieISlRic7e5S8mw80r7uw7q6HDkkCq5+t2kLemZP8k17pM
        QTefsFcqeH4BcceesQZguF4+Fg==
X-Google-Smtp-Source: APXvYqzBPnidyGrEle1CnwytGLYUAa8ffokB1gphgArlufGGIrqmzILTn4aW7KVObRObI9LQxXIOtQ==
X-Received: by 2002:a02:a806:: with SMTP id f6mr1470858jaj.74.1559162218281;
        Wed, 29 May 2019 13:36:58 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id s2sm181921ioj.8.2019.05.29.13.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:36:57 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 01/16] stop_machine: Fix stop_cpus_in_progress ordering
Date:   Wed, 29 May 2019 20:36:37 +0000
Message-Id: <0fd8fd4b99b9b9aa88d8b2dff897f7fd0d88f72c.1559129225.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
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
index 067cb83f37ea..583119e0c51c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -375,6 +375,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 	 */
 	preempt_disable();
 	stop_cpus_in_progress = true;
+	barrier();
 	for_each_cpu(cpu, cpumask) {
 		work = &per_cpu(cpu_stopper.stop_work, cpu);
 		work->fn = fn;
@@ -383,6 +384,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
+	barrier();
 	stop_cpus_in_progress = false;
 	preempt_enable();
 
-- 
2.17.1

