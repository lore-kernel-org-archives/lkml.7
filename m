Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDFFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EA62075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfECIzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:55:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:31447 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfECIzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:55:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="321087550"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2019 01:55:40 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 0/2] perf: Fix AUX software double buffering
Date:   Fri,  3 May 2019 11:55:34 +0300
Message-Id: <20190503085536.24119-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

There was a problem with 04fe30a61514 ("perf/ring_buffer: Use high order
allocations for AUX buffers optimistically") that made buffers that were
previously scattered across multiple pages into one large buffer, breaking
double buffering. In practice, this manifests easily for non-privileged
users, whose buffers are generally smaller than MAX_ORDER and would fit
into one high-order allocation. Root's default AUX buffer size is larger
and would get split, so they are less affected. The fix is trivial and
we also get rid of one PMU capability as a bonus.

Alexander Shishkin (2):
  perf: Fix AUX software double buffering
  perf, pt: Remove software double buffering PMU capability

 arch/x86/events/intel/pt.c  | 3 +--
 include/linux/perf_event.h  | 1 -
 kernel/events/ring_buffer.c | 3 +--
 3 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.20.1

