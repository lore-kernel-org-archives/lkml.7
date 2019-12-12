Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480AAC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D1722527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFQgenFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfLLWfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:35:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730891AbfLLWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576190147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=flfcja9ktAAQYxaLDueb5EUmaBApPNlM9+Ny2elTPiw=;
        b=OFQgenFxiF5Saz5tcJkdy7sIcSLMbuvx1OzoQJkABghpjjCLpa9hIPyyJdO8Equyxnt6om
        BnZdMr1Nui7BP5gdfYgfFCM0wX//wViNdeJL9nTkeyqyYuVt9SjBtraBk6XKK+6H2O3dWP
        COO9wUawjfmWg9LHj/kWivkXrRu7MOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-nhIsWZIhMk2Q4FtMVFn9vg-1; Thu, 12 Dec 2019 17:35:43 -0500
X-MC-Unique: nhIsWZIhMk2Q4FtMVFn9vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8D3018557C0;
        Thu, 12 Dec 2019 22:35:41 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B210A60BF3;
        Thu, 12 Dec 2019 22:35:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] locking/lockdep: Reuse zapped chain_hlocks entries
Date:   Thu, 12 Dec 2019 17:35:20 -0500
Message-Id: <20191212223525.1652-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that when running a workload that kept on adding lock
classes and then zapping them repetitively, the system will eventually
running out of chain_hlocks[] entries even though there were still
plenty of other lockdep data buffers available.

  [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
  [ 4318.444809] turning off the locking correctness validator.

In order to fix this problem, we have to make chain_hlocks[] entries
reusable just like other lockdep arrays. Besides that, the patchset
also adds some zapped class and chain_hlocks counters to be tracked by
/proc/lockdep_stats. It also fixes leakage in the irq context counters.

Waiman Long (5):
  locking/lockdep: Track number of zapped classes
  locking/lockdep: Track leaked chain_hlocks entries
  locking/lockdep: Track number of zapped lock chains
  locking/lockdep: Reuse free chain_hlocks entries
  locking/lockdep: Decrement irq context counters when removing lock
    chain

 kernel/locking/lockdep.c           | 201 ++++++++++++++++++++++-------
 kernel/locking/lockdep_internals.h |  23 +++-
 kernel/locking/lockdep_proc.c      |  17 ++-
 3 files changed, 189 insertions(+), 52 deletions(-)

-- 
2.18.1

