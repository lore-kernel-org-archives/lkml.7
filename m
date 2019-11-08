Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC2AFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB9E206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232550;
	bh=QmHkYOpw1KGgzE2tChTjH11DwvScC47O6EYYkdjmNZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWncPrVcEQ1qsuwbn1pfCfpEelbrS/m8dHVkUqMeMiquA3CsP6EuDXdGCkidOl1Zn
	 3s/MXMZBlWg4/Jpgtni0Vum35f9nZYe4iPrN0EXqJSEC+IS5OeM5g8rM7zQKv8r7Ac
	 gEqR2RcIAK4Tx5Tn46txkmEt6PO/tgPpKg54tix8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfKHRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730696AbfKHRBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:50 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DF1206BA;
        Fri,  8 Nov 2019 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232509;
        bh=QmHkYOpw1KGgzE2tChTjH11DwvScC47O6EYYkdjmNZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiUzlVfUY9/EMo4arLdR3YvvgWtVrcBioNWxyo4tDqVikPDfd/hMfuNPavpmeFf5b
         fiotcwLuwgXiNdGNjLCGDs4cH4YGNrU4D2GdrgLklRE5kQEyEWDKv6ShvlqifQtJp8
         C/qEBtT80YOw5LyKOpZZ03WsFbgZ4XIOvxTT9/+E=
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
Subject: [PATCH 06/13] READ_ONCE: Remove smp_read_barrier_depends() invocation
Date:   Fri,  8 Nov 2019 17:01:13 +0000
Message-Id: <20191108170120.22331-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha overrides '__read_once_size_n()' directly, so there's no need to
use 'smp_read_barrier_depends()' in the core code.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/rwonce.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 2c2ac0948c94..2e3289268a89 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -102,7 +102,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 		__read_once_size(&(x), __u.__c, sizeof(x));		\
 	else								\
 		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
-	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
 	__u.__val;							\
 })
 #define READ_ONCE(x) __READ_ONCE(x, 1)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

