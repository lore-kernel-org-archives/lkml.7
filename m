Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23432087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfJaGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:32:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:59022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfJaGcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:32:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 23:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="230739282"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2019 23:31:59 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/2] perf: Disallow aux_output for kernel events
In-Reply-To: <20191030134731.5437-3-alexander.shishkin@linux.intel.com>
References: <20191030134731.5437-1-alexander.shishkin@linux.intel.com> <20191030134731.5437-3-alexander.shishkin@linux.intel.com>
Date:   Thu, 31 Oct 2019 08:31:59 +0200
Message-ID: <87h83pfmsg.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> +	/*
> +	 * Grouping is not supported for kernel events, neither is 'AUX',
> +	 * make sure the caller's intentions are adjusted.
> +	 */
> +	if (attr->aux_output)
> +		return -EINVAL;

Should have been ERR_PTR(-EINVAL).

From 72e1839403cb10da589873e1e529778e1f087b96 Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Wed, 30 Oct 2019 15:27:35 +0200
Subject: [PATCH] perf: Disallow aux_output for kernel events

Commit

  ab43762ef0109 ("perf: Allow normal events to output AUX data")

added 'aux_output' bit to the attribute structure, which relies on AUX
events and grouping, neither of which is supported for the kernel events.
This notwithstanding, attempts have been made to use it in the kernel
code, suggesting the necessity of an explicit hard -EINVAL.

Fix this by rejecting attributes with aux_output set for kernel events.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d0d4b14f11c..b1aa5237052b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11555,6 +11555,13 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	struct perf_event *event;
 	int err;
 
+	/*
+	 * Grouping is not supported for kernel events, neither is 'AUX',
+	 * make sure the caller's intentions are adjusted.
+	 */
+	if (attr->aux_output)
+		return ERR_PTR(-EINVAL);
+
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
 				 overflow_handler, context, -1);
 	if (IS_ERR(event)) {
-- 
2.24.0.rc1

