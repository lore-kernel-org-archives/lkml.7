Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84035C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F60121841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 06:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Oihx0T8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbfEXGqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 02:46:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39105 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXGqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 02:46:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4O6kD6T090193
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 23:46:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4O6kD6T090193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558680373;
        bh=wc1+IzGBXjSlKyiEF2EG/p9DuhVje39Ra/j9+xCcNBQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Oihx0T8q57KddQG4Lkf/jnWQHIMq8okl3rNBDnuD2kR4jBUc7VDNXD/nKtrOjUrtK
         gt87dOps4u4XBK24rrfiB+8U4wmLVAKVEqu984mzPOsDGWPYlBtzkO/f8jHAU+8SPZ
         y3etBXKk3mJs4YX5ktbn8H9SSbt6vZo+BNhcdcKLbef1OGsa6DqRMrcF305mKGl4nY
         K+rBtngxVi60D6aYWmB2Su5sHRAEzxyPMSYikbmgr7hARcOtZMYDsU6gxEBhlx/ZYX
         U5ZyHtHV3BMmm2wecwq2IbfhtWPRWuYnCVnCdXiTgAU6A0luieh3FKit0Ljn+nDsrI
         QFKOfWuzDxcJg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4O6kCfO090190;
        Thu, 23 May 2019 23:46:12 -0700
Date:   Thu, 23 May 2019 23:46:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-978315462d3ea3cf6cfacd34c563ec1eb02a3aa5@git.kernel.org>
Cc:     will.deacon@arm.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, bigeasy@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: will.deacon@arm.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, bigeasy@linutronix.de,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190517212234.32611-1-bigeasy@linutronix.de>
References: <20190517212234.32611-1-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Don't complain about incorrect
 name for no validate class
Git-Commit-ID: 978315462d3ea3cf6cfacd34c563ec1eb02a3aa5
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

Commit-ID:  978315462d3ea3cf6cfacd34c563ec1eb02a3aa5
Gitweb:     https://git.kernel.org/tip/978315462d3ea3cf6cfacd34c563ec1eb02a3aa5
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 17 May 2019 23:22:34 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 24 May 2019 08:41:59 +0200

locking/lockdep: Don't complain about incorrect name for no validate class

It is possible to ignore the validation for a certain lock by using:

	lockdep_set_novalidate_class()

on it. Each invocation will assign a new name to the class it created
for created __lockdep_no_validate__. That means that once
lockdep_set_novalidate_class() has been used on two locks then
class->name won't match lock->name for the first lock triggering the
warning.

So ignore changed non-matching ->name pointer for the special
__lockdep_no_validate__ class.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20190517212234.32611-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c47788fa85f9..6b283b4f87aa 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -732,7 +732,8 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 			 * Huh! same key, different name? Did someone trample
 			 * on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE(class->name != lock->name &&
+				     lock->key != &__lockdep_no_validate__);
 			return class;
 		}
 	}
