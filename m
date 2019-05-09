Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBBDC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993DB217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evtcUmo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEIVqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:46:10 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35832 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:46:09 -0400
Received: by mail-pl1-f202.google.com with SMTP id x5so2342067pll.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nL0d57hUSvuWMoFDn/5vE0YoiIh4JIjeGFoZupaY4Z0=;
        b=evtcUmo57VHXFRBIP0x3AWI/DRc3GoPZaqq5H22bjls+Q7ydyTuym6zn5aJsVRqI7b
         v/zJxW3n1+HyBoRCOg1Dy+7OAz/B2uwfI1yVI2zq3D43tv5+7W+hqrrGKqeLCNFi0PaY
         14tdO/vksvtSvUg7+DuJibE3hr4PABy6ftpf7prdfwTPOSL9AiA6QR53jppQyadCeITX
         XT8iPNt6mWYzunPDsy28D0PTr4eh4C5LozBF/jjeVLFOX4uoSIN6co5vlToN95JXg50v
         Tuw2aHRraWK8zsKaxkPMM7VWLwL+xpH5BGTP5rDbtCt6QLrT+9KxgDwEQgZFhJaNK5br
         N9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nL0d57hUSvuWMoFDn/5vE0YoiIh4JIjeGFoZupaY4Z0=;
        b=Nk0I2nS447fESeQy5tjupUgG590uyGpzJa0NbHPqiC8IqAY5/k3h2VpOqiJmxpQd0g
         bDOS1LPZkN9BDcfoIhXbKBrc4XffGMaAhTTbrqs5pl92Rcc4OuC4Gjx/s3gEMVyg4D8f
         0UsAeG8cot0956hcc/P5r4L24ZvQnp4xchRN2UZSoji1ThHnA34p5VjE2dqAADwS0S50
         WuJPU0mNCvfckSA/A5bR1UIjK9xJK9bXu7Jex3iRe8NBLdPyy4AupyGcZSSEuBXqvENU
         PwX/eox5rfHCEH5yFWaFpsF6kDI7CYLlN9iKvi33zzzp0KHFjYUqzccQHw+W7xyBgSRe
         aN/w==
X-Gm-Message-State: APjAAAWgs53iYwD1PXm1ZF2s/AclK1tsZo864HkvNA0IS4ThQX/0YKOP
        5Djbvt9JbcohdGAugqQgFGyeeDYgT/ep3lrl6R8VKxXse+GFp+pWjLIfXjUceFlN31TALSMsHRX
        bmIrecDPDfrY1FkimG7kuZArglkUFaJ7p3pKb9l/tXkwK/pAKKGggQBLJ5leiw7zC8Z0xZffz
X-Google-Smtp-Source: APXvYqz1G920x3hGqsde2xN9Ygj/66g/yIf33wS3jq0BN+yz6am8iegOFhahPeJmUmJ8Z6bNdggNXG2mTr71
X-Received: by 2002:a63:4a4f:: with SMTP id j15mr8738947pgl.338.1557438368607;
 Thu, 09 May 2019 14:46:08 -0700 (PDT)
Date:   Thu,  9 May 2019 14:45:56 -0700
Message-Id: <20190509214556.123493-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] perf/x86: fix INTEL_FLAGS_EVENT_CONSTRAINT* masking
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, ak@linux.intel.com, kan.liang@intel.com,
        mingo@elte.hu, jolsa@redhat.com, vincent.weaver@maine.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Westmere, a cmdline as follows:
$ perf record -e cpu/event=0xc4,umask=0x2,name=br_inst_retired.near_call/p ....

Was failing. Yet the event+ umask support PEBS.

It turns out this is due to a bug in the the PEBS event constraint table for
westmere. All forms of BR_INST_RETIRED.* support PEBS. Therefore the constraint
mask should ignore the umask. The name of the macro INTEL_FLAGS_EVENT_CONSTRAINT()
hint that this is the case but it was not. That macros was checking both the
event code and event umask. Therefore, it was only matching on 0x00c4.
There are code+umask macros, they all have *UEVENT*.

This bug fixes the issue by checking only the event code in the mask.
Both single and range version are modified.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 07fc84bb85c1..a6ac2f4f76fc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -394,10 +394,10 @@ struct cpu_hw_events {
 
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
-	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
 
 #define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
-	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+	EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
 
 /* Check only flags, but allow all event/umask */
 #define INTEL_ALL_EVENT_CONSTRAINT(code, n)	\
-- 
2.21.0.1020.gf2820cf01a-goog

