Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554C6C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3724D22CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfH1GGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:06:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:22063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfH1GGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:06:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="210034522"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 23:06:37 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [RESEND [PATCH] 0/2] mm/mmap.c: reduce subtree gap propagation a little
Date:   Wed, 28 Aug 2019 14:06:12 +0800
Message-Id: <20190828060614.19535-1-richardw.yang@linux.intel.com>
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

After applying these two patches, test shows it reduce 0.3% function call for
vma_compute_subtree_gap.

BTW, this series is based on some un-merged cleanup patched.

---
This version is rebased on current linus tree, whose last commit is
commit 9e8312f5e160 ("Merge tag 'nfs-for-5.3-3' of
git://git.linux-nfs.org/projects/trondmy/linux-nfs").

Wei Yang (2):
  mm/mmap.c: update *next* gap after itself
  mm/mmap.c: unlink vma before rb_erase

 mm/mmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.17.1

