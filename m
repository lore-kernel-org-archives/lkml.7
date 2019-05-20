Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF6C21479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfETXjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:39:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:25217 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfETXjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:39:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 16:39:04 -0700
X-ExtLoop1: 1
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO localhost.intel.com) ([10.254.114.95])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2019 16:39:03 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, luto@amacapital.net
Cc:     dave.hansen@intel.com, namit@vmware.com, davem@davemloft.net,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 0/2] Fix issues with vmalloc flush flag
Date:   Mon, 20 May 2019 16:38:39 -0700
Message-Id: <20190520233841.17194-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches address issues with the recently added
VM_FLUSH_RESET_PERMS vmalloc flag. It is now split into two patches, which
made sense to me, but can split it further if desired.

Patch 1 is the most critical and addresses an issue that could cause a
crash on x86.

Patch 2 is to try to reduce the work done in the free operation to push
it to allocation time where it would be more expected. This shouldn't be
a big issue most of the time, but I thought it was slightly better.

v2->v3:
 - Split into two patches

v1->v2:
 - Update commit message with more detail
 - Fix flush end range on !CONFIG_ARCH_HAS_SET_DIRECT_MAP case

Rick Edgecombe (2):
  vmalloc: Fix calculation of direct map addr range
  vmalloc: Remove work as from vfree path

 mm/vmalloc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.20.1

