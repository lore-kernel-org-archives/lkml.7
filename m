Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5177C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9AE21920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfJJTMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:12:49 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:37943 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbfJJTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:12:47 -0400
X-Greylist: delayed 1315 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 15:12:46 EDT
Received: from [4.30.142.84] (helo=[127.0.1.1])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1iIdWT-000Zwa-C8; Thu, 10 Oct 2019 14:50:49 -0400
Subject: [PATCH 1/3] tracing/hwlat: Report total time spent in all NMIs
 during the sample
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     amakhalov@vmware.com, akaher@vmware.com, anishs@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu
Date:   Thu, 10 Oct 2019 11:50:46 -0700
Message-ID: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

nmi_total_ts is supposed to record the total time spent in *all* NMIs
that occur on the given CPU during the (active portion of the)
sampling window. However, the code seems to be overwriting this
variable for each NMI, thereby only recording the time spent in the
most recent NMI. Fix it by accumulating the duration instead.

Fixes: 7b2c86250122 ("tracing: Add NMI tracing in hwlat detector")
Cc: stable@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
---

 kernel/trace/trace_hwlat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index fa95139..a0251a7 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -150,7 +150,7 @@ void trace_hwlat_callback(bool enter)
 		if (enter)
 			nmi_ts_start = time_get();
 		else
-			nmi_total_ts = time_get() - nmi_ts_start;
+			nmi_total_ts += time_get() - nmi_ts_start;
 	}
 
 	if (enter)

