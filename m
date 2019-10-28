Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C1CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A0321721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZIWictY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfJ1Uom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:44:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37997 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfJ1Uom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:44:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id e2so1324041qkn.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jCeXW/iQVileFnjio6pHN19c+809WESUARAGyyHFMiw=;
        b=ZIWictY08313cWqh5rWJ0/Q79pOhAgqgJu9Wv5RPOkOyjHvbbsWC93irpJkneqcJGf
         EU++BTh/VNla43NivG90yKxl/Dx0DZoFa7R1vGPRBDnogAkfWYnCJGb4uXGrZc+1wuIB
         knwNWyw470r3PbNPA+Nq8NU8Z7IgmPh2oC8SHqqcjw3ihFnC/kn8WSvzoTgVwKCqjsR7
         zLWlZy0vdyV8FH9P/gtZ0ha0x/Xd6YfUKXwFEXPWQI4xknUpsJWzq55ZhlDrLLegZy4H
         VZyg9qf16H1oGqBGMS6MZXnUx2pl9/+IghjX63BuOIN4BDzQ4SZnOSD5ik/v8pWoejKQ
         4EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jCeXW/iQVileFnjio6pHN19c+809WESUARAGyyHFMiw=;
        b=cyDaUEadKCXukA8W3kY2F6hVPeG5QSq+rws0xAKSjtdBUFZSnp4lcZ3jQFkm4sNV7+
         +UFWdy3xwUioXaBrqkSsTxT8jcB3277JPr5lYtcqqkMf7uJ2ZPvPdVNTT6wne2I/GKFd
         B+9DKU2EezqC2o6j6GKEz6lQIn9027MEF4gxbuJ2rmThu5A5IWRb9hLVGnLmYr15pakh
         wA6evRGcPcqStBry1dxOPT8IdTaIxu9s2rK71ctwkUQjtg1LjLucOc/8axzaz1eINcC7
         C+jmfKxx8Fin2ZTF9SV8DO/XbW8LFRQNsb2YpUNACRAMuaYM59GyOKblOEfz441q3Ggo
         ycLw==
X-Gm-Message-State: APjAAAU+tThBvFMBLv9xDhaKnzp6Fhp/B0vTubRxHw1/dFtrqwLJnAmC
        NMc/evcmtM8PYlPht1tT7AssRA==
X-Google-Smtp-Source: APXvYqzYpIGH4S94deT2nN70Tmize13/ElVqKsLU5ZvrP/dWPuIIZ4r+5OAFvpHgH0uuEwvdpsHpaA==
X-Received: by 2002:a37:2ec5:: with SMTP id u188mr17969151qkh.94.1572295480832;
        Mon, 28 Oct 2019 13:44:40 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m25sm8972825qtc.0.2019.10.28.13.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 13:44:40 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     peterz@infradead.org, paulmck@linux.ibm.com, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/powernv/smp: fix a warning at CPU hotplug
Date:   Mon, 28 Oct 2019 16:44:27 -0400
Message-Id: <1572295467-14686-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e78a7614f387 ("idle: Prevent late-arriving interrupts from
disrupting offline") introduced a warning on powerpc with CPU hotplug,

WARNING: CPU: 1 PID: 0 at arch/powerpc/platforms/powernv/smp.c:160
pnv_smp_cpu_kill_self+0x5c/0x330
Call Trace:
 cpu_die+0x48/0x64
 arch_cpu_idle_dead+0x30/0x50
 do_idle+0x2e4/0x460
 cpu_startup_entry+0x3c/0x40
 start_secondary+0x7a8/0xa80
 start_secondary_resume+0x10/0x14

because it calls local_irq_disable() before arch_cpu_idle_dead().

Fixes: e78a7614f387 ("idle: Prevent late-arriving interrupts from disrupting offline")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/powernv/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index fbd6e6b7bbf2..51f4e07b9168 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -157,7 +157,6 @@ static void pnv_smp_cpu_kill_self(void)
 	 * This hard disables local interurpts, ensuring we have no lazy
 	 * irqs pending.
 	 */
-	WARN_ON(irqs_disabled());
 	hard_irq_disable();
 	WARN_ON(lazy_irq_pending());
 
-- 
1.8.3.1

