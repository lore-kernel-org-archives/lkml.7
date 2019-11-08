Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2673FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993FA21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232490;
	bh=HTcHAMijQqVgRO6zCy9ZrheDnl8HQLiX8Rjta3usTZ0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ozyOxoZYqbadvkWrPEbiKsyGOleVHzgYBpC2MTf6ZoUmpFfdVJt6ocvOkEZNOaI8+
	 fJs3+Tz9XVgLufrH8BCBBmHHDrKFB158S/S/U5iS4bh2aeob7mga5TBTFtiUYpbQ7v
	 ZfNisg5aVn8XlDPnWNvBkYP9yINEg8xeagyeilmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfKHRB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfKHRB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:29 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F381821848;
        Fri,  8 Nov 2019 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232488;
        bh=HTcHAMijQqVgRO6zCy9ZrheDnl8HQLiX8Rjta3usTZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZnWS1X2b0PUCeQpWpi2502WQVdkfXFyqK1xdBOQWZhgk7zTcKcKSAZL/qE4C3Q06o
         rkWqf8YjsJ+izdbJEavvUi+ZRPkK1LjbvsGyHiO1nEhJnG1ewGF22bNKulG62FV4/N
         vsurK/YtoTCaD5wquc8vQ05h7NCU1xoFxOK2VWag=
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
Subject: [PATCH 00/13] Finish off [smp_]read_barrier_depends()
Date:   Fri,  8 Nov 2019 17:01:07 +0000
Message-Id: <20191108170120.22331-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Although [smp_]read_barrier_depends() became part of READ_ONCE() in
commit 76ebbe78f739 ("locking/barriers: Add implicit
smp_read_barrier_depends() to READ_ONCE()"), it still limps on in the
Linux memory model with the sinister hope of attracting innocent new
users so that it becomes impossible to remove altogether.

Let's strike before it's too late: there's only one user outside of
arch/alpha/ and that lives in the vhost code which I don't think you
can actually compile for Alpha. Even if you could, it appears to be
redundant. The rest of these patches remove any mention of the barrier
from Documentation and comments, as well as removing its use from the
Alpha backend and finally dropping it from the memory model completely.

After this series, there are still two places where it is mentioned:

  1. The Korean translation of memory-barriers.txt. I'd appreciate some
     help fixing this because it's not entirely a straightforward
     deletion.

  2. The virtio vring tests under tools/. This is userspace code so I'm
     not too fussed about it.

There's a chunk of header reshuffling at the start of the series so that
READ_ONCE() can sensibly be overridden by arch code.

Feedback welcome.

Cheers,

Will

Cc: Yunjae Lee <lyj7694@gmail.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org

--->8

Will Deacon (13):
  compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
  READ_ONCE: Undefine internal __READ_ONCE_SIZE macro after use
  READ_ONCE: Allow __READ_ONCE_SIZE cases to be overridden by the
    architecture
  vhost: Remove redundant use of read_barrier_depends() barrier
  alpha: Override READ_ONCE() with barriered implementation
  READ_ONCE: Remove smp_read_barrier_depends() invocation
  alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
  locking/barriers: Remove definitions for [smp_]read_barrier_depends()
  Documentation/barriers: Remove references to
    [smp_]read_barrier_depends()
  tools/memory-model: Remove smp_read_barrier_depends() from informal
    doc
  powerpc: Remove comment about read_barrier_depends()
  include/linux: Remove smp_read_barrier_depends() from comments
  checkpatch: Remove checks relating to [smp_]read_barrier_depends()

 .../RCU/Design/Requirements/Requirements.html |  11 +-
 Documentation/memory-barriers.txt             | 156 +-----------------
 arch/alpha/include/asm/atomic.h               |  16 +-
 arch/alpha/include/asm/barrier.h              |  61 +------
 arch/alpha/include/asm/pgtable.h              |  10 +-
 arch/alpha/include/asm/rwonce.h               |  22 +++
 arch/powerpc/include/asm/barrier.h            |   2 -
 drivers/vhost/vhost.c                         |   5 -
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/barrier.h                 |  17 --
 include/asm-generic/rwonce.h                  | 131 +++++++++++++++
 include/linux/compiler.h                      | 114 +------------
 include/linux/compiler_attributes.h           |  12 ++
 include/linux/percpu-refcount.h               |   2 +-
 include/linux/ptr_ring.h                      |   2 +-
 mm/memory.c                                   |   2 +-
 scripts/checkpatch.pl                         |   9 +-
 .../Documentation/explanation.txt             |  26 ++-
 18 files changed, 217 insertions(+), 382 deletions(-)
 create mode 100644 arch/alpha/include/asm/rwonce.h
 create mode 100644 include/asm-generic/rwonce.h

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

