Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A014CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80D12246E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408205AbfJRK4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:56:09 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:55518 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405188AbfJRK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:56:09 -0400
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 5DF5DD056D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:56:07 +0100 (IST)
Received: (qmail 30710 invoked from network); 18 Oct 2019 10:56:07 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPA; 18 Oct 2019 10:56:07 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/3] Recalculate per-cpu page allocator batch and high limits after deferred meminit
Date:   Fri, 18 Oct 2019 11:56:03 +0100
Message-Id: <20191018105606.3249-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A private report stated that system CPU usage was excessive on an AMD
EPYC 2 machine while building kernels with much longer build times than
expected. The issue is partially explained by high zone lock contention
due to the per-cpu page allocator batch and high limits being calculated
incorrectly. This series addresses a large chunk of the problem. Patch 1
is mostly cosmetic but prepares for patch 2 which is the real fix. Patch
3 is definiely cosmetic but was noticed while implementing the fix. Proper
details are in the changelog for patch 2.

 include/linux/mm.h |  3 ---
 mm/internal.h      |  3 +++
 mm/page_alloc.c    | 33 ++++++++++++++++++++-------------
 3 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.16.4

