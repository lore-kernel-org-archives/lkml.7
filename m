Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA24C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96DC22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfHUMs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:48:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:30850 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbfHUMsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:48:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207724904"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 05:48:07 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 3/6] perf/x86/intel/pt: Use pointer arithmetics instead in ToPA entry calculation
Date:   Wed, 21 Aug 2019 15:47:24 +0300
Message-Id: <20190821124727.73310-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
References: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, pt_buffer_reset_offsets() calculates the current ToPA entry by
casting pointers to addresses and performing ungainly subtractions and
divisions instead of a simpler pointer arithmetic, which would be perfectly
applicable in that case. Fix that.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/pt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 831163a1b41a..15e7c11e3460 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1030,8 +1030,7 @@ static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 	pg = pt_topa_next_entry(buf, pg);
 
 	buf->cur = (struct topa *)((unsigned long)buf->topa_index[pg] & PAGE_MASK);
-	buf->cur_idx = ((unsigned long)buf->topa_index[pg] -
-			(unsigned long)buf->cur) / sizeof(struct topa_entry);
+	buf->cur_idx = buf->topa_index[pg] - TOPA_ENTRY(buf->cur, 0);
 	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
 
 	local64_set(&buf->head, head);
-- 
2.23.0.rc1

