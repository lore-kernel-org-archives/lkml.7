Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347E6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F3E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfDOU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfDOU6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:58:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 390E23082E24;
        Mon, 15 Apr 2019 20:58:55 +0000 (UTC)
Received: from llong.com (ovpn-122-46.rdu2.redhat.com [10.10.122.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7669C19C6A;
        Mon, 15 Apr 2019 20:58:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 0/2] locking/rwsem: Rwsem rearchitecture part 2 follow-up patches
Date:   Mon, 15 Apr 2019 16:58:27 -0400
Message-Id: <20190415205829.32707-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 15 Apr 2019 20:58:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contain 2 follow-up patches to alleviate the performance
regression found in the page_fault1 test of the will-it-scale benchmark.
This does not recover all the lost performance, but reclaim a sizeable
portion of it.

The regression was found on an Intel system. I have run the test on
an AMD system. The regression wasn't seen there.  There are only minor
variations in performance. Perhaps the page fault path is quite different
between Intel and AMD systems.

Waiman Long (2):
  locking/rwsem: Clarify usage of owner's nonspinaable bit
  locking/rwsem: Adaptive disabling of reader optimistic spinning

 include/linux/rwsem.h             |   2 +-
 kernel/locking/lock_events_list.h |   9 +-
 kernel/locking/rwsem.c            | 178 +++++++++++++++++++++---------
 3 files changed, 131 insertions(+), 58 deletions(-)

-- 
2.18.1

