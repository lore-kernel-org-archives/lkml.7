Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B7ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D758B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfJUJsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:48:12 -0400
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:41600 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbfJUJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:48:12 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 1EA9BB871A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:48:10 +0100 (IST)
Received: (qmail 32540 invoked from network); 21 Oct 2019 09:48:10 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 21 Oct 2019 09:48:09 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] Recalculate per-cpu page allocator batch and high limits after deferred meminit v2
Date:   Mon, 21 Oct 2019 10:48:05 +0100
Message-Id: <20191021094808.28824-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated series that addresses some review feedback and an
LKP warning.  I did not preserve Michal Hocko's ack for the fix as it
has changed.  This series replaces the following patches in mmotm

mm-pcp-share-common-code-between-memory-hotplug-and-percpu-sysctl-handler.patch
mm-meminit-recalculate-pcpu-batch-and-high-limits-after-init-completes.patch
mm-pcpu-make-zone-pcp-updates-and-reset-internal-to-the-mm.patch

Changelog since V1
o Fix a "might sleep" warning
o Reorder for easier backporting

A private report stated that system CPU usage was excessive on an AMD
EPYC 2 machine while building kernels with much longer build times than
expected. The issue is partially explained by high zone lock contention
due to the per-cpu page allocator batch and high limits being calculated
incorrectly. This series addresses a large chunk of the problem. Patch
1 is the real fix and the other two are cosmetic issues noticed while
implementing the fix.

 include/linux/mm.h |  3 ---
 mm/internal.h      |  3 +++
 mm/page_alloc.c    | 31 ++++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.16.4

