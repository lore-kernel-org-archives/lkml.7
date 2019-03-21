Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD541C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E7321939
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfCUUC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:02:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:5164 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbfCUUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 13:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309246228"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 13:02:55 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/5] Page demotion for memory reclaim
Date:   Thu, 21 Mar 2019 14:01:52 -0600
Message-Id: <20190321200157.29678-1-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has recently added support for using persistent memory as
normal RAM:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4

The persistent memory is hot added to nodes separate from other memory
types, which makes it convenient to make node based memory policies.

When persistent memory provides a larger and cheaper address space, but
with slower access characteristics than system RAM, we'd like the kernel
to make use of these memory-only nodes as a migration tier for pages
that would normally be discared during memory reclaim. This is faster
than doing IO for swap or page cache, and makes better utilization of
available physical address space.

The feature is not enabled by default. The user must opt-in to kernel
managed page migration by defining the demotion path. In the future,
we may want to have the kernel automatically create this based on
heterogeneous memory attributes and CPU locality.

Keith Busch (5):
  node: Define and export memory migration path
  mm: Split handling old page for migration
  mm: Attempt to migrate page in lieu of discard
  mm: Consider anonymous pages without swap
  mm/migrate: Add page movement trace event

 Documentation/ABI/stable/sysfs-devices-node |  11 +-
 drivers/base/node.c                         |  73 +++++++++++++
 include/linux/migrate.h                     |   6 ++
 include/linux/node.h                        |   6 ++
 include/linux/swap.h                        |  20 ++++
 include/trace/events/migrate.h              |  29 ++++-
 mm/debug.c                                  |   1 +
 mm/migrate.c                                | 161 ++++++++++++++++++----------
 mm/vmscan.c                                 |  25 ++++-
 9 files changed, 271 insertions(+), 61 deletions(-)

-- 
2.14.4

