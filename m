Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0AC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D6225AF0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191959;
	bh=QVNWfYZwzxl9bw2yAAO6T7NG2zjG5e8grcLVRUtlrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drPSi7nY5LxDGSdmDHHs16BHeiBwp//8f/wy7RLarrZtBetWHY23M68q/6YTPl79B
	 eF8YmmPgcwHMNZ+Lb6R5FAKsSyKehIe0SJqvKZfxdjhtKFZpbyNtkvi1Et1SeVs9e1
	 aB7qq7HAK5sIB5JzF6a4wIh1fZJ0lJil+wjvhqog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfE3Ewi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728232AbfE3DKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:49 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1403F2447F;
        Thu, 30 May 2019 03:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185848;
        bh=QVNWfYZwzxl9bw2yAAO6T7NG2zjG5e8grcLVRUtlrrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WuQ6PRafi1LkXoxtMN+K+c7/FtxUZZJsSvKNKLBCfO+Nvxx2NTCQn3+l8bF1niqc7
         TEWzvUCH4FFf6KqURqavp5d40stiTv/du8HGsGGDeTrTH9ZI68N7k+SaoNq/abcprQ
         8VCBPym+4q/5XBrwDZTiXVQkR3HC1S9gJMpH1AiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 169/405] sched/rt: Check integer overflow at usec to nsec conversion
Date:   Wed, 29 May 2019 20:02:47 -0700
Message-Id: <20190530030549.678437762@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1a010e29cfa00fee2888fd2fd4983f848cbafb58 ]

Example of unhandled overflows:

 # echo 18446744073709651 > cpu.rt_runtime_us
 # cat cpu.rt_runtime_us
 99

 # echo 18446744073709900 > cpu.rt_period_us
 # cat cpu.rt_period_us
 348

After this patch they will fail with -EINVAL.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/155125501739.293431.5252197504404771496.stgit@buzz
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/rt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 90fa23d36565d..1e6b909dca367 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2555,6 +2555,8 @@ int sched_group_set_rt_runtime(struct task_group *tg, long rt_runtime_us)
 	rt_runtime = (u64)rt_runtime_us * NSEC_PER_USEC;
 	if (rt_runtime_us < 0)
 		rt_runtime = RUNTIME_INF;
+	else if ((u64)rt_runtime_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
 
 	return tg_set_rt_bandwidth(tg, rt_period, rt_runtime);
 }
@@ -2575,6 +2577,9 @@ int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us)
 {
 	u64 rt_runtime, rt_period;
 
+	if (rt_period_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
 	rt_period = rt_period_us * NSEC_PER_USEC;
 	rt_runtime = tg->rt_bandwidth.rt_runtime;
 
-- 
2.20.1



