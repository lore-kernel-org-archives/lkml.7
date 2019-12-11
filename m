Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D4CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFF82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmpM1xf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLKVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:32:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbfLKVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576099919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=3FnPwmNds/u/TeXMNMaPJsBPMZEuhSPsR/k9U7fQvVk=;
        b=XmpM1xf3CuPfwNl1sm45t/WiR2JLCm1xkoETGVLZPQk8waS43b/uM1d+G4aGSM05BynrR+
        qSFztP+1vJff3DVBr0/CG6KMoC+MxfSIeJmxWZN40varbrbgqQRe7+wfvvtxBvsxl2kogS
        QmMJb6cdqNLWXnoeoCkjkt1cgvKeLko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-QTtJxGm7PUexTJQwztviFw-1; Wed, 11 Dec 2019 16:31:56 -0500
X-MC-Unique: QTtJxGm7PUexTJQwztviFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB63A100551A;
        Wed, 11 Dec 2019 21:31:54 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2A2860BE2;
        Wed, 11 Dec 2019 21:31:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/lockdep: Fix lockdep_stats indentation problem
Date:   Wed, 11 Dec 2019 16:31:39 -0500
Message-Id: <20191211213139.29934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that two lines in the output of /proc/lockdep_stats have
indentation problem:

  # cat /proc/lockdep_stats
     :
   in-process chains:                   25057
   stack-trace entries:                137827 [max: 524288]
   number of stack traces:        7973
   number of stack hash chains:   6355
   combined max dependencies:      1356414598
   hardirq-safe locks:                     57
   hardirq-unsafe locks:                 1286
     :

All the numbers displayed in /proc/lockdep_stats except the two stack
trace numbers are formatted with a field with of 11. To properly align
all the numbers, a field width of 11 is now added to the two stack
trace numbers.

Fixes: 8c779229d0f4 ("locking/lockdep: Report more stack trace statistics")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index dadb7b7fba37..9bb6d2497b04 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -286,9 +286,9 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, " stack-trace entries:           %11lu [max: %lu]\n",
 			nr_stack_trace_entries, MAX_STACK_TRACE_ENTRIES);
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
-	seq_printf(m, " number of stack traces:        %llu\n",
+	seq_printf(m, " number of stack traces:        %11llu\n",
 		   lockdep_stack_trace_count());
-	seq_printf(m, " number of stack hash chains:   %llu\n",
+	seq_printf(m, " number of stack hash chains:   %11llu\n",
 		   lockdep_stack_hash_count());
 #endif
 	seq_printf(m, " combined max dependencies:     %11u\n",
-- 
2.18.1

