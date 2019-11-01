Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC35421734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfKAPNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:13:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:32434 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfKAPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:13:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 08:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,256,1569308400"; 
   d="scan'208";a="231256033"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2019 08:13:04 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Fix the aux_output group inheritance fix
Date:   Fri,  1 Nov 2019 17:12:48 +0200
Message-Id: <20191101151248.47327-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  f733c6b508bc ("perf/core: Fix inheritance of aux_output groups")

adds a null pointer dereference in case inherit_group() races with
perf_release(), which causes the below.

> BUG: kernel NULL pointer dereference, address: 000000000000010b
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 3b203b067 P4D 3b203b067 PUD 3b2040067 PMD 0
> Oops: 0000 [#1] SMP KASAN
> CPU: 0 PID: 315 Comm: exclusive-group Tainted: G B 5.4.0-rc3-00181-g72e1839403cb-dirty #878
> RIP: 0010:perf_get_aux_event+0x86/0x270
> Call Trace:
>  ? __perf_read_group_add+0x3b0/0x3b0
>  ? __kasan_check_write+0x14/0x20
>  ? __perf_event_init_context+0x154/0x170
>  inherit_task_group.isra.0.part.0+0x14b/0x170
>  perf_event_init_task+0x296/0x4b0

Fix this by skipping over events that are getting closed, in the
inheritance path.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b1aa5237052b..8ff1218e91b1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12129,7 +12129,7 @@ static int inherit_group(struct perf_event *parent_event,
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 
-		if (sub->aux_event == parent_event &&
+		if (sub->aux_event == parent_event && child_ctr &&
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
-- 
2.24.0.rc1

