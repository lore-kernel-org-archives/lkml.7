Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BFCC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8007220874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfHZHbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:31:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:50867 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfHZHbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:31:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 00:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="191648428"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2019 00:31:39 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 0/2] mm/mmap.c: reduce subtree gap propagation a little
Date:   Mon, 26 Aug 2019 15:31:04 +0800
Message-Id: <20190826073106.29971-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When insert and delete a vma, it will compute and propagate related subtree
gap. After some investigation, we can reduce subtree gap propagation a little.

[1]: This one reduce the propagation by update *next* gap after itself, since
     *next* must be a parent in this case.
[2]: This one achieve this by unlinking vma from list.

After applying these two patches, test shows it reduce 0.4% function all for
vma_compute_subtree_gap.

Wei Yang (2):
  mm/mmap.c: update *next* gap after itself
  mm/mmap.c: unlink vma before rb_erase

 mm/mmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.17.1

