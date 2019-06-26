Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9453C217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFZRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:51:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:49814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZRvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:51:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 10:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="337288581"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 26 Jun 2019 10:51:07 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 00/10] x86/CPU and x86/resctrl: Support pseudo-lock regions spanning L2 and L3 cache
Date:   Wed, 26 Jun 2019 10:48:39 -0700
Message-Id: <cover.1561569068.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

Cache pseudo-locking involves preloading a region of physical memory into a
reserved portion of cache that no task or CPU can subsequently fill into and
from that point on will only serve cache hits. At this time it is only
possible to create cache pseudo-locked regions in either L2 or L3 cache,
supporting systems that support either L2 Cache Allocation Technology (CAT)
or L3 CAT because CAT is the mechanism used to manage reservations of cache
portions.

This series introduces support for cache pseudo-locked regions that can span
L2 and L3 cache in preparation for systems that may support CAT on L2 and
L3 cache. Only systems with L3 inclusive cache is supported at this time
because if the L3 cache is not inclusive then pseudo-locked memory within
the L3 cache would be evicted when migrated to L2. Because of this
constraint the first patch in this series introduces support in cacheinfo.c
for resctrl to discover if the L3 cache is inclusive. All other patches in
this series are to the resctrl subsystem.

In support of cache pseudo-locked regions spanning L2 and L3 cache the term
"cache pseudo-lock portion" is introduced. Each portion of a cache
pseudo-locked region spans one level of cache and a cache pseudo-locked
region can be made up of one or two cache pseudo-lock portions.

On systems supporting L2 and L3 CAT where L3 cache is inclusive it is
possible to create two types of pseudo-locked regions:
1) A pseudo-locked region spanning just L3 cache, consisting out of a
single pseudo-locked portion.
2) A pseudo-locked region spanning L2 and L3 cache, consisting out of two
pseudo-locked portions.

In an L3 inclusive cache system a L2 pseudo-locked portion is required to
be matched with an L3 pseudo-locked portion to prevent a cache line from
being evicted from L2 when it is evicted from L3.

Patches 2 to 8 to the resctrl subsystem are preparing for the new feature
and should result in no functional change, but some comments do refer to
the new feature. Support for pseudo-locked regions spanning L2 and L3 cache
is introduced in patches 9 and 10.

Your feedback will be greatly appreciated.

Regards,

Reinette

Reinette Chatre (10):
  x86/CPU: Expose if cache is inclusive of lower level caches
  x86/resctrl: Remove unnecessary size compute
  x86/resctrl: Constrain C-states during pseudo-lock region init
  x86/resctrl: Set cache line size using new utility
  x86/resctrl: Associate pseudo-locked region's cache instance by id
  x86/resctrl: Introduce utility to return pseudo-locked cache portion
  x86/resctrl: Remove unnecessary pointer to pseudo-locked region
  x86/resctrl: Support pseudo-lock regions spanning resources
  x86/resctrl: Pseudo-lock portions of multiple resources
  x86/resctrl: Only pseudo-lock L3 cache when inclusive

 arch/x86/kernel/cpu/cacheinfo.c           |  42 +-
 arch/x86/kernel/cpu/resctrl/core.c        |   7 -
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  37 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  39 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 444 +++++++++++++++++++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  61 ++-
 include/linux/cacheinfo.h                 |   4 +
 7 files changed, 512 insertions(+), 122 deletions(-)

-- 
2.17.2

