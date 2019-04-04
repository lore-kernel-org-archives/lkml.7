Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089ECC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F5C20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfDDRoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfDDRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:43:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1835F307D973;
        Thu,  4 Apr 2019 17:43:39 +0000 (UTC)
Received: from llong.com (dhcp-17-19.bos.redhat.com [10.18.17.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5783162671;
        Thu,  4 Apr 2019 17:43:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v4 00/11] locking/rwsem: Rwsem rearchitecture part 1
Date:   Thu,  4 Apr 2019 13:43:09 -0400
Message-Id: <20190404174320.22416-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 04 Apr 2019 17:43:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v4:
  - Update the DEBUG_RWSEMS_WARN_ON() macro in patch 6 to call
    debug_locks_off().
  - Update commit log of patch 11 to include benchmark data.

 v3:
  - Add patch 11 to move count and owner together as suggested by Linus.
  - Reword the commit log of patch 2 to clarify the intent of that patch.

 v2:
  - Sync up to v4 of the part 0 patch.
  - Remove the rwsem.h->rwsem-xadd.h renaming patch & change patches
    to modify rwsem.h instead of rwsem-xadd.h.
  - Add a new patch to micro-optimize rwsem_try_read_lock_unqueued().

This is part 1 of a 3-part (0/1/2) series to rearchitect the internal
operation of rwsem.

This part lays the foundation for part 2 without making any functional
changes. This part includes the following changes:

 1) Move code around and micro-optimize rwsem_try_read_lock_unqueued()
    (patches 1-4).
 2) Enhance the DEBUG_RWSEMS_WARN_ON() macro to provide more information
    and add additional checks (patches 5 & 6).
 3) Make the core qspinlock_stat.h code generic (lock event counting)
    so that it can be used by all the architectures as well as other
    locking subsystems such as rwsem (patches 7-10). Lock event
    counting help us visualize how frequently a code path is being
    used as well as spotting abnormal behavior due to bugs in the code
    without noticeably affecting kernel performance and hence behavior.
 4) Reorganize rwsem structure to optimize for the uncontended case.

Both (2) and (3) are useful debugging aids.

Waiman Long (11):
  locking/rwsem: Relocate rwsem_down_read_failed()
  locking/rwsem: Move owner setting code from rwsem.c to rwsem.h
  locking/rwsem: Move rwsem internal function declarations to
    rwsem-xadd.h
  locking/rwsem: Micro-optimize rwsem_try_read_lock_unqueued()
  locking/rwsem: Add debug check for __down_read*()
  locking/rwsem: Enhance DEBUG_RWSEMS_WARN_ON() macro
  locking/qspinlock_stat: Introduce a generic lockevent counting APIs
  locking/lock_events: Make lock_events available for all archs & other
    locks
  locking/lock_events: Don't show pvqspinlock events on bare metal
  locking/rwsem: Enable lock event counting
  locking/rwsem: Optimize rwsem structure for uncontended lock
    acquisition

 arch/Kconfig                        |   9 ++
 arch/x86/Kconfig                    |   8 -
 include/linux/rwsem.h               |  28 ++--
 kernel/locking/Makefile             |   1 +
 kernel/locking/lock_events.c        | 179 ++++++++++++++++++++
 kernel/locking/lock_events.h        |  59 +++++++
 kernel/locking/lock_events_list.h   |  67 ++++++++
 kernel/locking/qspinlock.c          |   8 +-
 kernel/locking/qspinlock_paravirt.h |  19 +--
 kernel/locking/qspinlock_stat.h     | 242 +++++-----------------------
 kernel/locking/rwsem-xadd.c         | 204 +++++++++++------------
 kernel/locking/rwsem.c              |  25 +--
 kernel/locking/rwsem.h              |  49 +++++-
 13 files changed, 540 insertions(+), 358 deletions(-)
 create mode 100644 kernel/locking/lock_events.c
 create mode 100644 kernel/locking/lock_events.h
 create mode 100644 kernel/locking/lock_events_list.h

-- 
2.18.1

