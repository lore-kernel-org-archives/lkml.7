Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C85C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDAD2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfHPKOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbfHPKOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:14:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AE0DAB9D;
        Fri, 16 Aug 2019 10:14:06 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/3] debug_pagealloc improvements through page_owner
Date:   Fri, 16 Aug 2019 12:13:58 +0200
Message-Id: <20190816101401.32382-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug_pagealloc functionality serves a similar purpose on the page
allocator level that slub_debug does on the kmalloc level, which is to detect
bad users. One notable feature that slub_debug has is storing stack traces of
who last allocated and freed the object. On page level we track allocations via
page_owner, but that info is discarded when freeing, and we don't track freeing
at all. This series improves those aspects. With both debug_pagealloc and
page_owner enabled, we can then get bug reports such as the example in Patch 3.

SLUB debug tracking additionaly stores cpu, pid and timestamp. This could be
added later, if deemed useful enough to justify the additional page_ext
structure size.

Vlastimil Babka (3):
  mm, page_owner: record page owner for each subpage
  mm, page_owner: keep owner info when freeing the page
  mm, page_owner, debug_pagealloc: save and dump freeing stack trace

 .../admin-guide/kernel-parameters.txt         |   2 +
 include/linux/page_ext.h                      |   1 +
 mm/Kconfig.debug                              |   4 +-
 mm/page_owner.c                               | 123 +++++++++++++-----
 4 files changed, 96 insertions(+), 34 deletions(-)

-- 
2.22.0

