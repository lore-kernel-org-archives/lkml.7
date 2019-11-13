Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE3CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EAF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573609953;
	bh=ZYrFksE4yNjkyeNCuIbjQzFI5EWbnQ4cFzJZE5BH2JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCnzdx+UedkScEPIHargVjsOHFjgGwdZkB7ANAOXTzeIZiww+bmXmQRWyog4BRikv
	 yAp2Bs+IlUvtm5DGQM7vAZKXMEA2k31j2gRhX2EZg2P+uixP06xW47do200nXyeuP7
	 QxECcjcZtvZDX+pSdY1vPTS97c8+OY4AXK0qg7SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfKMBwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbfKMBw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9A2222CA;
        Wed, 13 Nov 2019 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609945;
        bh=ZYrFksE4yNjkyeNCuIbjQzFI5EWbnQ4cFzJZE5BH2JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8n2omzpd5LitsKMCeJQBzflXWT2hakmJreUveR3h+oENbalhrP/RL3h5oXjRpzjc
         VY/gtjnvz9kqjjG22v1qNTcR08musC95/v5Maabxb2zY0zMNrgeBnzXTQv4NteQhMJ
         3EJoAr29uJuhKZ+t4ze3ON/qWAmVlI0yMaXEpLTA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 084/209] powerpc/time: Use clockevents_register_device(), fixing an issue with large decrementer
Date:   Tue, 12 Nov 2019 20:48:20 -0500
Message-Id: <20191113015025.9685-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@ozlabs.org>

[ Upstream commit 8b78fdb045de60a4eb35460092bbd3cffa925353 ]

We currently cap the decrementer clockevent at 4 seconds, even on systems
with large decrementer support. Fix this by converting the code to use
clockevents_register_device() which calculates the upper bound based on
the max_delta passed in.

Signed-off-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/time.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 70f145e024877..6a1f0a084ca35 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -984,10 +984,10 @@ static void register_decrementer_clockevent(int cpu)
 	*dec = decrementer_clockevent;
 	dec->cpumask = cpumask_of(cpu);
 
+	clockevents_config_and_register(dec, ppc_tb_freq, 2, decrementer_max);
+
 	printk_once(KERN_DEBUG "clockevent: %s mult[%x] shift[%d] cpu[%d]\n",
 		    dec->name, dec->mult, dec->shift, cpu);
-
-	clockevents_register_device(dec);
 }
 
 static void enable_large_decrementer(void)
@@ -1035,18 +1035,7 @@ static void __init set_decrementer_max(void)
 
 static void __init init_decrementer_clockevent(void)
 {
-	int cpu = smp_processor_id();
-
-	clockevents_calc_mult_shift(&decrementer_clockevent, ppc_tb_freq, 4);
-
-	decrementer_clockevent.max_delta_ns =
-		clockevent_delta2ns(decrementer_max, &decrementer_clockevent);
-	decrementer_clockevent.max_delta_ticks = decrementer_max;
-	decrementer_clockevent.min_delta_ns =
-		clockevent_delta2ns(2, &decrementer_clockevent);
-	decrementer_clockevent.min_delta_ticks = 2;
-
-	register_decrementer_clockevent(cpu);
+	register_decrementer_clockevent(smp_processor_id());
 }
 
 void secondary_cpu_time_init(void)
-- 
2.20.1

