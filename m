Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18832089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfHUMsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:48:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:30844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfHUMsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:48:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 05:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="207724873"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2019 05:48:02 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v0 0/6] perf/x86/intel/pt: Misc updates
Date:   Wed, 21 Aug 2019 15:47:21 +0300
Message-Id: <20190821124727.73310-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Here are updates that I have for the PT driver. The biggest change is
6/6, it gets rid of the reverse lookup table that the driver uses to
find ToPA (SG) entries by the page offset. With the high order page
allocations in the AUX buffer, the cost of runtime lookup should be
minimal, and we get to free up some memory that the table occupies.
Plus, we get to allocate 2G (and up) PT buffers should we be so
inclined.

Others are small reworks and cleanups striving to make the code easier
on the eyes.

Alexander Shishkin (6):
  perf/x86/intel/pt: Clean up ToPA allocation path
  perf/x86/intel/pt: Use helpers to obtain ToPA entry size
  perf/x86/intel/pt: Use pointer arithmetics instead in ToPA entry
    calculation
  perf/x86/intel/pt: Split ToPA metadata and page layout
  perf/x86/intel/pt: Free up space in a ToPA descriptor
  perf/x86/intel/pt: Get rid of reverse lookup table for ToPA

 arch/x86/events/intel/pt.c | 325 +++++++++++++++++++++++--------------
 arch/x86/events/intel/pt.h |  12 +-
 2 files changed, 210 insertions(+), 127 deletions(-)

-- 
2.23.0.rc1

