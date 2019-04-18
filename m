Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2972120675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611280;
	bh=pj6N8vdzpjJMU5Uwd3puO4kVlKg6z/6NSKsMWc1MAZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFAcJt/ClrHTLtiaUHtFQMLJXKm+uD3NOd9REwklepeWD96Koo1sBxmBztgzQvciu
	 9aH+UXRpY/ZgIzaYhW3gicm7A+fNc1PAW0NOaMEDh2KEWhuQg9ME9ayo2+nDGbQ5D7
	 wV8Ijwx29J4jJypllEZBvSaxAFxmK9qWodhSyXSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbfDRSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404126AbfDRSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD3820652;
        Thu, 18 Apr 2019 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611163;
        bh=pj6N8vdzpjJMU5Uwd3puO4kVlKg6z/6NSKsMWc1MAZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XL4alU1MBb1SRvlcFiHUvnRcg7aUuxqZCEYG8jJXv1EfE1nAMurRVHrzzB4+C/hD+
         OwTK89oYXF67RQt3UZPWwZikhD8B4UE1Hs+r42Vs0pMqb+RBVKqcnz39PHDWi+ixi8
         8UOFVpTgVNmShZORCME/S2YHA7dTLXA5bp6GSGnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Shi <yang.shi@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 82/93] ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t
Date:   Thu, 18 Apr 2019 19:58:00 +0200
Message-Id: <20190418160445.257712043@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 143c2a89e0e5fda6c6fd08d7bc1126438c19ae90 ]

When running kprobe on -rt kernel, the below bug is caught:

|BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:931
|in_atomic(): 1, irqs_disabled(): 128, pid: 14, name: migration/0
|Preemption disabled at:[<802f2b98>] cpu_stopper_thread+0xc0/0x140
|CPU: 0 PID: 14 Comm: migration/0 Tainted: G O 4.8.3-rt2 #1
|Hardware name: Freescale LS1021A
|[<8025a43c>] (___might_sleep)
|[<80b5b324>] (rt_spin_lock)
|[<80b5c31c>] (__patch_text_real)
|[<80b5c3ac>] (patch_text_stop_machine)
|[<802f2920>] (multi_cpu_stop)

Since patch_text_stop_machine() is called in stop_machine() which
disables IRQ, sleepable lock should be not used in this atomic context,
 so replace patch_lock to raw lock.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/patch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index a50dc00d79a2..d0a05a3bdb96 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -16,7 +16,7 @@ struct patch {
 	unsigned int insn;
 };
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	__acquires(&patch_lock)
@@ -33,7 +33,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 		return addr;
 
 	if (flags)
-		spin_lock_irqsave(&patch_lock, *flags);
+		raw_spin_lock_irqsave(&patch_lock, *flags);
 	else
 		__acquire(&patch_lock);
 
@@ -48,7 +48,7 @@ static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	clear_fixmap(fixmap);
 
 	if (flags)
-		spin_unlock_irqrestore(&patch_lock, *flags);
+		raw_spin_unlock_irqrestore(&patch_lock, *flags);
 	else
 		__release(&patch_lock);
 }
-- 
2.19.1



