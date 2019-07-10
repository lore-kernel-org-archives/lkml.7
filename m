Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD4CC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C92F20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y78Fo7bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfGJJKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:10:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfGJJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:10:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6A9A3im2347178
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 02:10:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6A9A3im2347178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562749803;
        bh=Ga0hiwpxMHtqeVSBV5pF7381TYukT9gg0R4ViGA1Xg0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y78Fo7bq1O9t95W7mewQpMsZ6ep4h0TBL5kJBV4Va6Y7i6tqYPDbwL7DHCpC49QKd
         unLP514zp9GNPzfuVNC6DbMjNF3qITePICgiFOLtD//xYiJKFrZPYVMqvWAQfEYgMA
         qct90F745yOZYm+sx+e2Hrms+HffMO1+7rG/kVxFvlSFFseAN+7bIq0KWOwyV6Se/U
         Y02NszqmIfi3vbs6ZI20kOafN3MzkkgpfAy17TG5tC6w/0vTvhrdvmL3ea6lp/Pqne
         xfD2F8N+SQYNpvFBxISSmz63Jv+7DInk1tXBSkLSmWQhvg7OR99xrN27bkTrue+dOy
         NslTpXv49hGFA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6A9A2022347175;
        Wed, 10 Jul 2019 02:10:02 -0700
Date:   Wed, 10 Jul 2019 02:10:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joe Perches <tipbot@zytor.com>
Message-ID: <tip-9bdd7bb3a8447fe841cd37ddd9e0a6974b06a0bb@git.kernel.org>
Cc:     joe@perches.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, joe@perches.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <d6a9d49c9837d38816b71d783f5aed7235e8ca94.1562734889.git.joe@perches.com>
References: <d6a9d49c9837d38816b71d783f5aed7235e8ca94.1562734889.git.joe@perches.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/npcm: Fix misuse of GENMASK
 macro
Git-Commit-ID: 9bdd7bb3a8447fe841cd37ddd9e0a6974b06a0bb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9bdd7bb3a8447fe841cd37ddd9e0a6974b06a0bb
Gitweb:     https://git.kernel.org/tip/9bdd7bb3a8447fe841cd37ddd9e0a6974b06a0bb
Author:     Joe Perches <joe@perches.com>
AuthorDate: Tue, 9 Jul 2019 22:04:15 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 10 Jul 2019 11:05:26 +0200

clocksource/drivers/npcm: Fix misuse of GENMASK macro

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/d6a9d49c9837d38816b71d783f5aed7235e8ca94.1562734889.git.joe@perches.com

---
 drivers/clocksource/timer-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index 7a9bb5532d99..8a30da7f083b 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN		BIT(29)
 #define NPCM7XX_Tx_COUNTEN		BIT(30)
 #define NPCM7XX_Tx_ONESHOT		0x0
-#define NPCM7XX_Tx_OPER			GENMASK(3, 27)
+#define NPCM7XX_Tx_OPER			GENMASK(27, 3)
 #define NPCM7XX_Tx_MIN_PRESCALE		0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS	24
 #define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
