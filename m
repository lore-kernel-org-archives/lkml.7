Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E296F20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdJlw2y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfCFTuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:50:52 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50316 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfCFTuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:50:52 -0500
Received: by mail-pf1-f201.google.com with SMTP id q21so14664829pfi.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G630ddU/pY4PPGElv4ZfTutalcdCfH9uZUVNLNV6Hyo=;
        b=HdJlw2y67wxuXfUIAW9ScYFSFVngUueWCIvkH/pxxF2omBI1i7CwMUqPK+dQSu6NEG
         8+R+ZU/6GZ7/1LroBNv+u+VMt6GWj90J0w6AF9rbCJJa08od0AEyfO1BqhZu/j5wQBVz
         wZwzZap9aGj6rE7no84WLW0DeXtOEIx8brhik8wjp9Mlwdb5zi1K8QdqRcjRhgsYyn1+
         3/Xtu5iXYeYGFZ7v+PYG+9bjGttyLsuQe/PihtFrp97ebNAFkrNInm2NFIfaEHfUYTh0
         8PZupbbiEfOc7XgDUDtdnDb4XnbIPgoW1NsW+Nuer29vQ5VA6uJymIfWoQDXZJNCt0Wz
         ueSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G630ddU/pY4PPGElv4ZfTutalcdCfH9uZUVNLNV6Hyo=;
        b=mW4tITD2/9pICcL6WvegUd4oDsskhh4w9yNFdcpMsrV9Xs66jbEjyFnvK01+lxjzqv
         OO7RHyHNtd/2OuzV3IZkdbPfZbz0uMYg/fVJbx2BQ76yfGvYVOg7TFzmJX2qflAfqvZ9
         rmL68vyUoLnMZkpycXSe/sn+eG/eWxnSIsgRsobWgKFqJNOyBNn6Nxn3O5h+0OtofN3+
         wWAdErg9MGx12Ii04wnRAsoEm9kOOUGlyRngb8RYHvlWXqq2CzeJ5fOER4PPwtILqYXf
         BSbS51VgNCUVW/AIXsqBt4zPnK0q8Gb845ka4M72NMbFxnzILXrNOUqgUpcgHy2Y1Lqs
         bVcA==
X-Gm-Message-State: APjAAAWgL9ruAk4s51MPsbvbi9C9IoKj2Zh01DKbop16gVk6S19MCkTw
        EZz1mLdFoDg5lmGffwmNScv1UlYB01I4DtkjceVyLu0tmPlPEWG2QxRe33j5vX7e7TPJl/tWdlA
        NXc5IP99LBx1qDPUcwnWBF0VvpncGYyB9perbC5zVnVIzU1GrXZV4yR3u07UjPaHvvg9IAJWl
X-Google-Smtp-Source: APXvYqyRuCQwAhJ9rukGjtfBJlV8bpVNNlWFJe5WNihW173QPZ2ycm2jA/bjWqbjZzYuhJoAWkTDW3RTAJ/t
X-Received: by 2002:aa7:8512:: with SMTP id v18mr3471213pfn.41.1551901851301;
 Wed, 06 Mar 2019 11:50:51 -0800 (PST)
Date:   Wed,  6 Mar 2019 11:50:48 -0800
Message-Id: <20190306195048.189514-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH] perf/x86/intel: fix handling of wakeup_events for multi-entry PEBS
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, kan.liang@intel.com, peterz@infradead.org,
        mingo@elte.hu, acme@redhat.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an event is programmed with attr.wakeup_events=N (N>0), it means
the caller is interested in getting a user level notification after
N samples have been recorded in the kernel sampling buffer.

With precise events on Intel processors, the kernel uses PEBS.
The kernel tries minimize sampling overhead by verifying
if the event configuration is compatible with multi-entry PEBS mode.
If so, the kernel is notified only when the buffer has reached its threshold.
Other PEBS operates in single-entry mode, the kenrel is notified for each
PEBS sample.

The problem is that the current implementation look at frequency
mode and event sample_type but ignores the wakeup_events field. Thus,
it may not be possible to receive a notification after each precise event.

This patch fixes this problem by disabling multi-entry PEBS if wakeup_events
is non-zero.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7ec265b..13d7167 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3143,7 +3143,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		return ret;
 
 	if (event->attr.precise_ip) {
-		if (!event->attr.freq) {
+		if (!(event->attr.freq || event->attr.wakeup_events)) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
 			      ~intel_pmu_large_pebs_flags(event)))
-- 
2.7.4

