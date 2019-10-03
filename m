Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C38C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36E22054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119576;
	bh=ta+KEqzYSHy/qTopfT8NAaQJ7lpEpvgFviApnhGf4yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nysynmKNb04ZJ9hyJXjYdlUXajyIW+1AOwZNxlS9sk+7/p4FvB62VClBMfg+nUSXI
	 rEu/1mePXWD/sYCSknMOn8NA/KKii8bA/GzBTQDHnwrZglt/4ooBdyCbc4gd4nxnVr
	 J1r3VxNweszcM9inNvlI3gfeFNHvKdF82FK5Vu3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfJCQTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388246AbfJCQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:19:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2144222BE;
        Thu,  3 Oct 2019 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119566;
        bh=ta+KEqzYSHy/qTopfT8NAaQJ7lpEpvgFviApnhGf4yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODKimWk/ICOv7RyNGPn3vuFy00hO7ZYg8z5WPCeBn+1sQXhwQ66a3PdFIXfv8Ygdo
         /ZpqABZYzK/Epp5kCwSnA2Q2tbwuG5Dxfv18sam95EHnR9qJByzjTrkZhoYLMFoYDy
         TBcgVwTyr+VWBV/ZEStUGdfQ11SeT2i64C7ewL08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/211] x86/mm/pti: Do not invoke PTI functions when PTI is disabled
Date:   Thu,  3 Oct 2019 17:52:56 +0200
Message-Id: <20191003154512.509163128@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 990784b57731192b7d90c8d4049e6318d81e887d ]

When PTI is disabled at boot time either because the CPU is not affected or
PTI has been disabled on the command line, the boot code still calls into
pti_finalize() which then unconditionally invokes:

     pti_clone_entry_text()
     pti_clone_kernel_text()

pti_clone_kernel_text() was called unconditionally before the 32bit support
was added and 32bit added the call to pti_clone_entry_text().

The call has no side effects as cloning the page tables into the available
second one, which was allocated for PTI does not create damage. But it does
not make sense either and in case that this functionality would be extended
later this might actually lead to hard to diagnose issues.

Neither function should be called when PTI is runtime disabled. Make the
invocation conditional.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190828143124.063353972@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/pti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4df3e5c89d57c..c1ba376484a5b 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -643,6 +643,8 @@ void __init pti_init(void)
  */
 void pti_finalize(void)
 {
+	if (!boot_cpu_has(X86_FEATURE_PTI))
+		return;
 	/*
 	 * We need to clone everything (again) that maps parts of the
 	 * kernel image.
-- 
2.20.1



