Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AEFCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D5A2080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfKAH6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:58:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:16169 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfKAH6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:58:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 00:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; 
   d="scan'208";a="225962454"
Received: from yhuang-dev.sh.intel.com ([10.239.159.29])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2019 00:58:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: [RFC 00/10] autonuma: Optimize memory placement in memory tiering system
Date:   Fri,  1 Nov 2019 15:57:17 +0800
Message-Id: <20191101075727.26683-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

With the advent of various new memory types, there may be multiple
memory types in one machine, e.g. DRAM and PMEM (persistent memory).
Because the performance and cost of the different types of memory may
be different, the memory subsystem of the machine could be called
memory tiering system.

After commit c221c0b0308f ("device-dax: "Hotplug" persistent memory
for use like normal RAM"), the PMEM could be used as cost-effective
volatile memory in separate NUMA nodes.  In a typical memory tiering
system, there are CPUs, DRAM and PMEM in each physical NUMA node.  The
CPUs and the DRAM will be put in one logical node, while the PMEM will
be put in another (faked) logical node.

To optimize the system overall performance, the hot pages should be
placed in DRAM node.  To do that, we need to identify the hot pages in
the PMEM node and migrate them to DRAM node via NUMA migration.

While in autonuma, there are a set of existing mechanisms to identify
the pages recently accessed by the CPUs in a node and migrate the
pages to the node.  So we can reuse these mechanisms to build
mechanisms to optimize page placement in the memory tiering system.
This has been implemented in this patchset.

At the other hand, the cold pages should be placed in PMEM node.  So,
we also need to identify the cold pages in the DRAM node and migrate
them to PMEM node.

In the following patchset,

[PATCH 0/4] [RFC] Migrate Pages in lieu of discard
https://lore.kernel.org/linux-mm/20191016221148.F9CCD155@viggo.jf.intel.com/

A mechanism to demote the cold DRAM pages to PMEM node under memory
pressure is implemented.  Based on that, the cold DRAM pages can be
demoted to PMEM node proactively to free some memory space on DRAM
node, so that the hot PMEM pages can be migrated to the DRAM node.
This has been implemented in this patchset too.

The patchset is based on the following not-yet-merged patchset:

[PATCH 0/4] [RFC] Migrate Pages in lieu of discard
https://lore.kernel.org/linux-mm/20191016221148.F9CCD155@viggo.jf.intel.com/

This is part of a larger patch set.  If you want to apply these or
play with them, I'd suggest using the tree from here.

    http://lkml.kernel.org/r/c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com


With all above optimization, the score of pmbench memory accessing
benchmark with 80:20 read/write ratio and normal access address
distribution improves 116% on a 2 socket Intel server with Optane DC
Persistent Memory.

Best Regards,
Huang, Ying
