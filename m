Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5BFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27FC20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232506;
	bh=VVtq+ZHdbjrlTwd/SCnm4uvq7L7ueujETZx9zl4iAGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z5IKb6mREesLLlMkDglEm0N2BEiSOSAJ3Am8cQQDQqpv0wLAcmehKgfHiRQaNeacl
	 CDuANPjoBYcnNnCWdcoWLtT+Wlz1i1cxrcr6BR/RLtmRYlFjOA//My3YzA6smhIobQ
	 uc4t6HObVb400srFskGfnmbZXEzQ0LuGAl4dm03w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfKHRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfKHRBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:43 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A5F21924;
        Fri,  8 Nov 2019 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232502;
        bh=VVtq+ZHdbjrlTwd/SCnm4uvq7L7ueujETZx9zl4iAGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUa1yoEc+Oh4+7c5Af2VchosNGv2bBcCTGJQqem5RTN2ec+m0vFv2pfV/XmoM+JOY
         bdqQi841G7zyMtYyjENHqVGoXCClsC/RUl4ZOihf2FqGe55wW8edq0ymGNm63qG2vm
         SP+GQB8maD3cEt16jtgShBi8H4QwIgsDxLQnWXVY=
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
Subject: [PATCH 04/13] vhost: Remove redundant use of read_barrier_depends() barrier
Date:   Fri,  8 Nov 2019 17:01:11 +0000
Message-Id: <20191108170120.22331-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 76ebbe78f739 ("locking/barriers: Add implicit
smp_read_barrier_depends() to READ_ONCE()"), there is no need to use
'smp_read_barrier_depends()' outside of the Alpha architecture code.

Unfortunately, there is precisely >one< user in the vhost code, and
there isn't an obvious 'READ_ONCE()' access making the barrier
redundant. However, on closer inspection (thanks, Jason), it appears
that vring synchronisation between the producer and consumer occurs via
the 'avail_idx' field, which is followed up by an 'rmb()' in
'vhost_get_vq_desc()', making the 'read_barrier_depends()' redundant on
Alpha.

Jason says:

  | I'm also confused about the barrier here, basically in driver side
  | we did:
  |
  | 1) allocate pages
  | 2) store pages in indirect->addr
  | 3) smp_wmb()
  | 4) increase the avail idx (somehow a tail pointer of vring)
  |
  | in vhost we did:
  |
  | 1) read avail idx
  | 2) smp_rmb()
  | 3) read indirect->addr
  | 4) read from indirect->addr
  |
  | It looks to me even the data dependency barrier is not necessary
  | since we have rmb() which is sufficient for us to the correct
  | indirect->addr and driver are not expected to do any writing to
  | indirect->addr after avail idx is increased

Remove the redundant barrier invocation.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/vhost/vhost.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 36ca2cf419bf..865bc91b783c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2128,11 +2128,6 @@ static int get_indirect(struct vhost_virtqueue *vq,
 		return ret;
 	}
 	iov_iter_init(&from, READ, vq->indirect, ret, len);
-
-	/* We will use the result as an address to read from, so most
-	 * architectures only need a compiler barrier here. */
-	read_barrier_depends();
-
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

