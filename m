Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF01C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C647206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJMkGBP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfLPPPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:15:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728008AbfLPPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576509345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=BvI38nn62y0QPeeuO8GUcr47gIJ63ANDcE8jfHhEwT4=;
        b=NJMkGBP7wefFxZtfR+w0w6sJxEa8YKGKZKkoxt7sura8lwwrEaZT+8JttdK7/3Cp/a3Eus
        Q/NSk3sQatfJgH1Hc2cmjsvDWi2IbC9wwtF8a7FGLcUFILA1peGnmB2KXQGKBHdT91dOqh
        38A/rujpymT0PFcPlCEBVpzVeiadamA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-zppxyPVuPKmCHdpIW09lxQ-1; Mon, 16 Dec 2019 10:15:41 -0500
X-MC-Unique: zppxyPVuPKmCHdpIW09lxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2BD107ACC4;
        Mon, 16 Dec 2019 15:15:40 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1E9960BF4;
        Mon, 16 Dec 2019 15:15:37 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/6] locking/lockdep: Reuse zapped chain_hlocks entries
Date:   Mon, 16 Dec 2019 10:15:11 -0500
Message-Id: <20191216151517.7060-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v2:
  - Revamp the chain_hlocks reuse patch to store the freed chain_hlocks
    information in the chain_hlocks entries themselves avoiding the
    need of a separate set of tracking structures. This, however,
    requires a minimum allocation size of at least 2. Thanks to PeterZ
    for his review and inspiring this change.
  - Remove the leakage counter as it is no longer applicable.
  - Add patch 6 to make the output of /proc/lockdep_chains more readable.

It was found that when running a workload that kept on adding lock
classes and then zapping them repetitively, the system will eventually
run out of chain_hlocks[] entries even though there were still plenty
of other lockdep data buffers available.

  [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
  [ 4318.444809] turning off the locking correctness validator.

In order to fix this problem, we have to make chain_hlocks[] entries
reusable just like other lockdep arrays. Besides that, the patchset
also adds some zapped class and chain_hlocks counters to be tracked by
/proc/lockdep_stats. It also fixes leakage in the irq context counters
and makes the output of /proc/lockdep_chains more readable.

Waiman Long (6):
  locking/lockdep: Track number of zapped classes
  locking/lockdep: Throw away all lock chains with zapped class
  locking/lockdep: Track number of zapped lock chains
  locking/lockdep: Reuse freed chain_hlocks entries
  locking/lockdep: Decrement irq context counters when removing lock
    chain
  locking/lockdep: Display irq_context names in /proc/lockdep_chains

 kernel/locking/lockdep.c           | 307 +++++++++++++++++++++++------
 kernel/locking/lockdep_internals.h |  14 +-
 kernel/locking/lockdep_proc.c      |  26 ++-
 3 files changed, 282 insertions(+), 65 deletions(-)

-- 
2.18.1

