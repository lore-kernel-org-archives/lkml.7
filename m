Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4598C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27B020665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHLQGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:06:47 -0400
Received: from foss.arm.com ([217.140.110.172]:52290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHLQGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:06:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED1F515A2;
        Mon, 12 Aug 2019 09:06:46 -0700 (PDT)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDF7B3F718;
        Mon, 12 Aug 2019 09:06:45 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: [PATCH v3 0/3] mm: kmemleak: Use a memory pool for kmemleak object allocations
Date:   Mon, 12 Aug 2019 17:06:39 +0100
Message-Id: <20190812160642.52134-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the discussions on v2 of this patch(set) [1], this series
takes slightly different approach:

- it implements its own simple memory pool that does not rely on the
  slab allocator

- drops the early log buffer logic entirely since it can now allocate
  metadata from the memory pool directly before kmemleak is fully
  initialised

- CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE option is renamed to
  CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE

- moves the kmemleak_init() call earlier (mm_init())

- to avoid a separate memory pool for struct scan_area, it makes the
  tool robust when such allocations fail as scan areas are rather an
  optimisation

[1] http://lkml.kernel.org/r/20190727132334.9184-1-catalin.marinas@arm.com

Catalin Marinas (3):
  mm: kmemleak: Make the tool tolerant to struct scan_area allocation
    failures
  mm: kmemleak: Simple memory allocation pool for kmemleak objects
  mm: kmemleak: Use the memory pool for early allocations

 init/main.c       |   2 +-
 lib/Kconfig.debug |  11 +-
 mm/kmemleak.c     | 325 ++++++++++++----------------------------------
 3 files changed, 91 insertions(+), 247 deletions(-)

