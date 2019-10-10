Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8206DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CFC2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfJJTNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:13:14 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:37984 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbfJJTNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:13:14 -0400
Received: from [4.30.142.84] (helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1iIdWh-000a62-0M; Thu, 10 Oct 2019 14:51:03 -0400
Subject: [PATCH 2/3] tracing/hwlat: Don't ignore outer-loop duration when
 calculating max_latency
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     amakhalov@vmware.com, akaher@vmware.com, anishs@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu
Date:   Thu, 10 Oct 2019 11:51:01 -0700
Message-ID: <157073345463.17189.18124025522664682811.stgit@srivatsa-ubuntu>
In-Reply-To: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
References: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

max_latency is intended to record the maximum ever observed hardware
latency, which may occur in either part of the loop (inner/outer). So
we need to also consider the outer-loop sample when updating
max_latency.

Fixes: e7c15cd8a113 ("tracing: Added hardware latency tracer")
Cc: stable@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
---

 kernel/trace/trace_hwlat.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index a0251a7..862f4b0 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -256,6 +256,8 @@ static int get_sample(void)
 		/* Keep a running maximum ever recorded hardware latency */
 		if (sample > tr->max_latency)
 			tr->max_latency = sample;
+		if (outer_sample > tr->max_latency)
+			tr->max_latency = outer_sample;
 	}
 
 out:

