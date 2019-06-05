Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65168C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA222086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9jPeWqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfFENtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:49:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36023 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFENts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:49:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so16514674wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PS+SP8qKjNHVQq+aPqdJmHyqgZlHPN/YqkgQhNa5DEA=;
        b=u9jPeWqR0lwSManzDR+WTQ466I/ii45H2wQR8nPJcgYVoDJ7Y7VZrsVkkiJJBINMe4
         jPCUu3biGGvvtR5GIQYAUHJQhCsg6jfMSTTg3YW564OV7KAkkKoBHC58E57+SvG1zEVH
         BHdA1g1WMAUM89s+QR5jNs/QvmmbRB75nfEokQNAu0YIUicB4RCgd/Ye8ziupDfrXTmA
         5KTsvVxn3+rWWmsbyy/1S12Pt1otunQrAerFHgrygah9G/pxZPbsk7UIJ9GUrDNPfqgo
         8q65pjp8Ns/FR5jSeBqQOjZxqUoge9nqvfgfZ55N5XrMsRMRcF2+oTXhgOWdgVpQEhEW
         N/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PS+SP8qKjNHVQq+aPqdJmHyqgZlHPN/YqkgQhNa5DEA=;
        b=BLtd3xVHVzDwN/nJncT+B3GLxHM5HQ2itBSUiSqhbgwbaF6EWP2GydsYQffCVLw3Zg
         NDi37vqiCLKrUjpRRLATJC0j8v2S0yT4s0cwzz05laaoLKN5R4axrUSVuEdxWvsLexFI
         th3Dr8iRv5gcTSVOSg3AcOr544pF6+6GEN3RPO8Q4X2fHitxO/paPLqoUABRFg8mgKys
         Q6/F4BAASXjQZTJoJkOy8KtK0w7CUKt01BhwbnAihIXC9/aw6d7N6eUNX5TOuuv6mJD5
         7wFdv9oIU9/xWkzElgjQvxgZYxVfNMCYbEefJ4+1kMHZwXWgerqcX6M9lcsKp4AXyQDY
         ECUg==
X-Gm-Message-State: APjAAAWBk2YRKa110GUTDhNwStoGu4IH+OSkr3MecqfHiTMjokimlWRY
        T21cqx7+9/mU8B2xtj1uiNQ4DfIF
X-Google-Smtp-Source: APXvYqx1R2ddxjXl2YOzPr7tU7waVJgflYnjWmHroDaShEjCfEmRZikGcNyby1rISNrgfg3TmWlRsg==
X-Received: by 2002:adf:c606:: with SMTP id n6mr24719655wrg.62.1559742586743;
        Wed, 05 Jun 2019 06:49:46 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-134-229.088.067.pools.vodafone-ip.de. [88.67.134.229])
        by smtp.gmail.com with ESMTPSA id w14sm4912607wrt.59.2019.06.05.06.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 06:49:46 -0700 (PDT)
From:   Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@marvell.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: [PATCH] lockref: Limit number of cmpxchg loop retries
Date:   Wed,  5 Jun 2019 15:48:49 +0200
Message-Id: <20190605134849.28108-1-jglauber@marvell.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
References: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockref cmpxchg loop is unbound as long as the spinlock is not
taken. Depending on the hardware implementation of compare-and-swap
a high number of loop retries might happen.

Add an upper bound to the loop to force the fallback to spinlocks
after some time. A retry value of 100 should not impact any hardware
that does not have this issue.

With the retry limit the performance of an open-close testcase
improved between 60-70% on ThunderX2.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jan Glauber <jglauber@marvell.com>
---
 lib/lockref.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/lockref.c b/lib/lockref.c
index 3d468b53d4c9..5b34bbd3eba8 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -9,6 +9,7 @@
  * failure case.
  */
 #define CMPXCHG_LOOP(CODE, SUCCESS) do {					\
+	int retry = 100;							\
 	struct lockref old;							\
 	BUILD_BUG_ON(sizeof(old) != 8);						\
 	old.lock_count = READ_ONCE(lockref->lock_count);			\
@@ -21,6 +22,8 @@
 		if (likely(old.lock_count == prev.lock_count)) {		\
 			SUCCESS;						\
 		}								\
+		if (!--retry)							\
+			break;							\
 		cpu_relax();							\
 	}									\
 } while (0)
-- 
2.21.0

