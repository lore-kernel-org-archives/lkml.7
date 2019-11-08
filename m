Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9193DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DC321848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232534;
	bh=3vyc12aQ3fu+SeD0lMTSciNswbsRVeXAHiot9IWqGvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=owq+zEMMi73R8uU1poM5jwdQWLQHt/mqB2dqfcCqa0PHN3Qi6T49nK8GHEgfMOLDC
	 RG1xra7UsgxZ04zs3FQZMooxoelLjysi9F0xAegwYGGGXR3OFPuy9jeQm5So4jZO4N
	 B8q+/vJ7MrS11gh1Vl5dMALmF9HnxdisfyP31adk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfKHRCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731291AbfKHRCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:02:11 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5295D206BA;
        Fri,  8 Nov 2019 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232531;
        bh=3vyc12aQ3fu+SeD0lMTSciNswbsRVeXAHiot9IWqGvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdlo0cliQszCKc4t2Mqmv07gu/EtjmdGujKRlItYZPNKg7PznL/g9yalSAA460MAC
         Rrb/XY6LYdnuqxsYmZj0Y8oX/tdSwW7+d9hctGkzw+BBZIWkq1qy0GW+/mjSNw94uT
         i0yQNpHPqpmEP485MUsSL0DX//7r8gbAGUzSnxdU=
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
Subject: [PATCH 12/13] include/linux: Remove smp_read_barrier_depends() from comments
Date:   Fri,  8 Nov 2019 17:01:19 +0000
Message-Id: <20191108170120.22331-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'smp_read_barrier_depends()' doesn't exist any more, so reword the two
comments that mention it to refer to "dependency ordering" instead.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/percpu-refcount.h | 2 +-
 include/linux/ptr_ring.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 7aef0abc194a..246760b93715 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -155,7 +155,7 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
 	 * between contaminating the pointer value, meaning that
 	 * READ_ONCE() is required when fetching it.
 	 *
-	 * The smp_read_barrier_depends() implied by READ_ONCE() pairs
+	 * The dependency ordering from the READ_ONCE() pairs
 	 * with smp_store_release() in __percpu_ref_switch_to_percpu().
 	 */
 	percpu_ptr = READ_ONCE(ref->percpu_count_ptr);
diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 0abe9a4fc842..b6e94b60fc12 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -106,7 +106,7 @@ static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 		return -ENOSPC;
 
 	/* Make sure the pointer we are storing points to a valid data. */
-	/* Pairs with smp_read_barrier_depends in __ptr_ring_consume. */
+	/* Pairs with the dependency ordering in __ptr_ring_consume. */
 	smp_wmb();
 
 	WRITE_ONCE(r->queue[r->producer++], ptr);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

