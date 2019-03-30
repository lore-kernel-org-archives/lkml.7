Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFE7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C374218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909541;
	bh=qN3KnGaB8wvJhtu8jmZUjEjkwWAMS5KCHp6eMLgDUQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P6xPJaKcf8hU3L6Ix4wz9W9Fvv+PJDqNNUKM0oksjbcxdikJctjccIscwJnu8ytzz
	 6UJ5/5jYqpkAAKJ4pPGvVlqDPZcMfmu5wavpl+cPZd0I9fM6imD/5EmemIbWy5WIxJ
	 IJVbx8O4QDaA2iAVzLmmdDrFHkNZd6BDPZTLLEaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbfC3BcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732309AbfC3BcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:32:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E6E21773;
        Sat, 30 Mar 2019 01:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909536;
        bh=qN3KnGaB8wvJhtu8jmZUjEjkwWAMS5KCHp6eMLgDUQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH7w8D0e2OPZ5bIIGnop5byhlOKRMpFU55/SSfv3tEtuHhoeijOQJQTepgMB90V9F
         Qa/ymyZpvtIGDpHBL5dPN9is6HjzauR8PWg7t+bHCKEv5LyEQnNt7X3KFMsGgXL5zo
         DlSTYjLGl8zXoaPtzCdM4grYROeUjqrATpRQrgio=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Shi <yang.shi@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 13/16] ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t
Date:   Fri, 29 Mar 2019 21:31:57 -0400
Message-Id: <20190330013200.1130-13-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013200.1130-1-sashal@kernel.org>
References: <20190330013200.1130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <yang.shi@linaro.org>

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
index 69bda1a5707e..1f665acaa6a9 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -15,7 +15,7 @@ struct patch {
 	unsigned int insn;
 };
 
-static DEFINE_SPINLOCK(patch_lock);
+static DEFINE_RAW_SPINLOCK(patch_lock);
 
 static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 	__acquires(&patch_lock)
@@ -32,7 +32,7 @@ static void __kprobes *patch_map(void *addr, int fixmap, unsigned long *flags)
 		return addr;
 
 	if (flags)
-		spin_lock_irqsave(&patch_lock, *flags);
+		raw_spin_lock_irqsave(&patch_lock, *flags);
 	else
 		__acquire(&patch_lock);
 
@@ -47,7 +47,7 @@ static void __kprobes patch_unmap(int fixmap, unsigned long *flags)
 	clear_fixmap(fixmap);
 
 	if (flags)
-		spin_unlock_irqrestore(&patch_lock, *flags);
+		raw_spin_unlock_irqrestore(&patch_lock, *flags);
 	else
 		__release(&patch_lock);
 }
-- 
2.19.1

