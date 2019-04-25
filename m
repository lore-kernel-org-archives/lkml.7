Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04909C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CED206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfDYBmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:42:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:25341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387460AbfDYBmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:42:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="152134204"
Received: from zz23f_aep_wp03.sh.intel.com ([10.239.85.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2019 18:42:40 -0700
From:   Fan Du <fan.du@intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory system
Date:   Thu, 25 Apr 2019 09:21:30 +0800
Message-Id: <1556155295-77723-1-git-send-email-fan.du@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another approach of building zonelist based on patch #10 of
patchset[1].

For systems with heterogeneous DRAM and PMEM (persistent memory),

1) change ZONELIST_FALLBACK to first fallback to same type nodes,
   then the other types

2) add ZONELIST_FALLBACK_SAME_TYPE to fallback only same type nodes.
   To be explicitly selected by __GFP_SAME_NODE_TYPE.

For example, a 2S DRAM+PMEM system may have NUMA distances:
node   0   1   2   3 
  0:  10  21  17  28 
  1:  21  10  28  17 
  2:  17  28  10  28 
  3:  28  17  28  10

Node 0,1 are DRAM nodes, node 2, 3 are PMEM nodes.

ZONELIST_FALLBACK
=================
Current zoned fallback lists are based on numa distance only,
which means page allocation request from node 0 will iterate zone order
like: DRAM node 0 -> PMEM node 2 -> DRAM node 1 -> PMEM node 3.

However PMEM has different characteristics from DRAM,
the more reasonable or desirable fallback style would be:
DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3.
When DRAM is exhausted, try PMEM then. 

ZONELIST_FALLBACK_SAME_TYPE
===========================
Some cases are more suitable to fit PMEM characteristics, like page is
read more frequently than written. Other cases may prefer DRAM only.
It doesn't matter page is from local node, or remote.

Create __GFP_SAME_NODE_TYPE to request page of same node type,
either we got DRAM(from node 0, 1) or PMEM (from node 2, 3), it's kind
of extension to the nofallback list, but with the same node type. 

This patchset is self-contained, and based on Linux 5.1-rc6.

[1]:
https://lkml.org/lkml/2018/12/26/138

Fan Du (5):
  acpi/numa: memorize NUMA node type from SRAT table
  mmzone: new pgdat flags for DRAM and PMEM
  x86,numa: update numa node type
  mm, page alloc: build fallback list on per node type basis
  mm, page_alloc: Introduce ZONELIST_FALLBACK_SAME_TYPE fallback list

 arch/x86/include/asm/numa.h |  2 ++
 arch/x86/mm/numa.c          |  3 +++
 drivers/acpi/numa.c         |  5 ++++
 include/linux/gfp.h         |  7 ++++++
 include/linux/mmzone.h      | 35 ++++++++++++++++++++++++++++
 mm/page_alloc.c             | 57 ++++++++++++++++++++++++++++++++-------------
 6 files changed, 93 insertions(+), 16 deletions(-)

-- 
1.8.3.1

