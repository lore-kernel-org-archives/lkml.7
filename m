Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C943C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DC2208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfJ1HH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:07:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:19783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732264AbfJ1HHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:07:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 00:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; 
   d="scan'208";a="205111242"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 00:07:20 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL 4/7] intel_th: msu: Fix overflow in shift of an unsigned int
Date:   Mon, 28 Oct 2019 09:06:48 +0200
Message-Id: <20191028070651.9770-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
References: <20191028070651.9770-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shift of the unsigned int win->nr_blocks by PAGE_SHIFT may
potentially overflow. Note that the intended return of this shift
is expected to be a size_t however the shift is being performed as
an unsigned int.  Fix this by casting win->nr_blocks to a size_t
before performing the shift.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 615c164da0eb ("intel_th: msu: Introduce buffer interface")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/lkml/20190726113151.8967-1-colin.king@canonical.com/
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 201a166fdff5..9dc9ae87b5e5 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -327,7 +327,7 @@ static size_t msc_win_total_sz(struct msc_window *win)
 		struct msc_block_desc *bdesc = sg_virt(sg);
 
 		if (msc_block_wrapped(bdesc))
-			return win->nr_blocks << PAGE_SHIFT;
+			return (size_t)win->nr_blocks << PAGE_SHIFT;
 
 		size += msc_total_sz(bdesc);
 		if (msc_block_last_written(bdesc))
-- 
2.23.0

