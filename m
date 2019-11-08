Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F73C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DED521848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232503;
	bh=kzlgTQkG1R1MYvXiLB+EEi+LR7BxeVnjf/aJMUBqADw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BRh0bHTcjEsw3CnMTdzX6jHogiZOmm29ZxH+neKgycREUTGnZmtaU9x1glKVDN39c
	 XR+2A4Uo1Wk8b9LVuMBGpm/bnA5Cd5pjArtFZxZ0KRhesmKUToJHhLl4xYb00wBaD4
	 EoJ6eA9ZI6zhZ1RYdVA8ltz84/iO4hDQBKDqPi+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfKHRBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfKHRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:39 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EB721D7E;
        Fri,  8 Nov 2019 17:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232499;
        bh=kzlgTQkG1R1MYvXiLB+EEi+LR7BxeVnjf/aJMUBqADw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VviKsmgq2Tt9rr+MDGQITpsAKGIPvYSnn9a1+KfqrGSBXH1Uj7H7EVsR3P9RoFLRH
         9VjGBZorIo9ijF2ERfJULRCDiDnSR39b39roKT4YooZqYfrBhM7dQWWId5lFyMSnod
         +RnYKmJxOvs9aNXG866OWneGK5uStUPHhLMIHYaQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 03/13] READ_ONCE: Allow __READ_ONCE_SIZE cases to be overridden by the architecture
Date:   Fri,  8 Nov 2019 17:01:10 +0000
Message-Id: <20191108170120.22331-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meat and potatoes of 'READ_ONCE()' is defined by the
'__READ_ONCE_SIZE()' macro, which uses volatile casts in an attempt to
avoid tearing of byte, halfword, word and double-word accesses. Allow
this to be overridden by the architecture code in the case that things
like memory barriers are also required.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index abf326634ecd..2c2ac0948c94 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -33,13 +33,29 @@
 
 #include <asm/barrier.h>
 
+#ifndef __read_once_size_1
+#define __read_once_size_1(p)	(*(volatile __u8 *)(p))
+#endif
+
+#ifndef __read_once_size_2
+#define __read_once_size_2(p)	(*(volatile __u16 *)(p))
+#endif
+
+#ifndef __read_once_size_4
+#define __read_once_size_4(p)	(*(volatile __u32 *)(p))
+#endif
+
+#ifndef __read_once_size_8
+#define __read_once_size_8(p)	(*(volatile __u64 *)(p))
+#endif
+
 #define __READ_ONCE_SIZE						\
 ({									\
 	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
+	case 1: *(__u8 *)res = __read_once_size_1(p); break;		\
+	case 2: *(__u16 *)res = __read_once_size_2(p); break;		\
+	case 4: *(__u32 *)res = __read_once_size_4(p); break;		\
+	case 8: *(__u64 *)res = __read_once_size_8(p); break;		\
 	default:							\
 		barrier();						\
 		__builtin_memcpy((void *)res, (const void *)p, size);	\
@@ -59,6 +75,10 @@ void __read_once_size_nocheck(const volatile void *p, void *res, int size)
 	__READ_ONCE_SIZE;
 }
 
+#undef __read_once_size_1
+#undef __read_once_size_2
+#undef __read_once_size_4
+#undef __read_once_size_8
 #undef __READ_ONCE_SIZE
 
 static __always_inline void __write_once_size(volatile void *p, void *res, int size)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

