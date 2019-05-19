Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4AEC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FF620449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L5AIrXSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfESRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:50:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13421 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfESRuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:50:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce0f7df0001>; Sat, 18 May 2019 23:29:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 18 May 2019 23:29:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 18 May 2019 23:29:49 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 May
 2019 06:29:49 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 19 May
 2019 06:29:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 19 May 2019 06:29:48 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce0f7dc0002>; Sat, 18 May 2019 23:29:48 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] lockdep: fix warning: print_lock_trace defined but not used
Date:   Sat, 18 May 2019 23:29:46 -0700
Message-ID: <20190519062946.27040-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190519062946.27040-1-jhubbard@nvidia.com>
References: <20190519062946.27040-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558247391; bh=+mMeJXHl5ecrfmgXb1fLjcKTsuYCwxL+S6q5TJ9ck6o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=L5AIrXSZa1VcLK4AtyW/PdNDcLQCBig/gNswh+Nh+u5kvkf6mBf+g9RKmTJiLlJEx
         QqBR/tIPYNvLnjhgf7amcSVAQ5aiJYI+IoWdE2NVnjl+6p6ep+y6iPKcBSCsBc5ihB
         xPP6bBA7PEYDtIevnJBiHO/WrLQXThLrddKqb7q2sHY4gRx9R7h7MEJSLRhYpZA+Jd
         9nkDDjwwqbEq9T8evV1DXJp3Rkj5AafCEb51Z9RbYNZDRFZBhRZTpI33or+fybxxMF
         fTjxzDCBWBNt7Ym7lIFt+q6l04MeEtJxbsPRE8e6ba0EN2vz1R8hKG832F5v4qWrZe
         aE6vZwGWdFacw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside
CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING") moved the only usage of
print_lock_trace() that was originally outside of the CONFIG_PROVE_LOCKING
case. It moved that usage into a different case: CONFIG_PROVE_LOCKING &&
CONFIG_TRACE_IRQFLAGS. That leaves things not symmetrical, and as a result,
the following warning fires on my build, when I have

!CONFIG_TRACE_IRQFLAGS && !CONFIG_PROVE_LOCKING

set:

kernel/locking/lockdep.c:2821:13: warning: =E2=80=98print_lock_trace=E2=80=
=99 defined
    but not used [-Wunused-function]

Fix this by only defining print_lock_trace() in cases in which is it
called.

Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRA=
CE_IRQFLAGS && CONFIG_PROVE_LOCKING")
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 kernel/locking/lockdep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d06190fa5082..3065dc36c27a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2817,11 +2817,14 @@ static inline int validate_chain(struct task_struct=
 *curr,
 	return 1;
 }
=20
+#if defined(CONFIG_TRACE_IRQFLAGS)
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces=
)
 {
 }
 #endif
=20
+#endif
+
 /*
  * We are building curr_chain_key incrementally, so double-check
  * it from scratch, to make sure that it's done correctly:
--=20
2.21.0

