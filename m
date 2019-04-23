Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB878C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D76208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="KkeAQpww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfDWQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:18:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34344 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbfDWQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:18:35 -0400
Received: by mail-io1-f67.google.com with SMTP id n11so13072862ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5YlqB4t5Oeylx2eqRPB5pvKArp3TlTYkhE9cZx8QlnU=;
        b=KkeAQpwwRNnbuzH4io511LGOK6N1BulJ8fFIKkva9ZNVsHZNLqei/b+UVXttC04Pf1
         5iYVSXOlAk9uItON67O5u27al8JPb7RUze7WEyvbLUSoGoVC34qwWU0NQ3OBNXl4XX1F
         TtM9L+ZvxvkWs5sCNC7fWfcbugt041wWIC6G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5YlqB4t5Oeylx2eqRPB5pvKArp3TlTYkhE9cZx8QlnU=;
        b=ds1vqf+DH17j10AFiguKl+l9WwHodmto6gYYb19SogsOwBrhG3DKFonX65SqAZ9SgM
         6PY5epItJ3SBcsMJAq+M2tBEYqIf1KZBkPLlznknZLlHgOBP01Svhapi6HwalzUJ9fQ8
         CsyF7idFAUy39isLgK08udsxG3JSmAP0oK9ou9gNGbkDMMnHOgog7EKwgTXMzIJNW9tk
         gzLubTla4UnR8VM6BOioQB4voRMEMCwJI+usV5PSa1OdZzw3MyErsHNIc9RIj54Vnyf9
         PUHQMK0ECgM3wiueoRolygrLs1Dgh82mIrppc2gKHUxEYg0bRwzM4EHWvX5iBWmq92xk
         5FSg==
X-Gm-Message-State: APjAAAW9rPFIINaXQT2lZIs1YRyTuyTH0jFBpiYNsb9/9XlO8nu/XL+2
        5FaLSMAu5vrSoxisItKlhYxN0Q==
X-Google-Smtp-Source: APXvYqxjsdfM2S9krMkqCadUbi2Pv31sOPfuWC26WqxnCQXt/MicPPEw65F/6dJJ6/bL3Y9pDiYrxQ==
X-Received: by 2002:a5d:8196:: with SMTP id u22mr16662558ion.202.1556036313802;
        Tue, 23 Apr 2019 09:18:33 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id f5sm2327578iob.58.2019.04.23.09.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:18:33 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/17] stop_machine: Fix stop_cpus_in_progress ordering
Date:   Tue, 23 Apr 2019 16:18:06 +0000
Message-Id: <c40cb6dd8fb9fcaa26734f85cde40bb2a6688758.1556025155.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1556025155.git.vpillai@digitalocean.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra (Intel) <peterz@infradead.org>

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

