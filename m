Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B54DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F46204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497922;
	bh=s8LjOJRbFWTjFJU8PunCvZmgxtsSf2yjWOf9YJFE/nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FdYsb4p1CPrCmUskWZyfLKNCW2OX8Su9syUh7EDST4dsMuoJaY5VHDEWEjRWG3+Xu
	 JVB4VkaLWbxnezJxVOE6MlEKoaD3fs0EX60AFc2TLCoo76dttcVbaAmS+Rqpv/1EoD
	 ZEXlN8lVin+2NrdZ54/tIAmd/Z+scqblkaQ366IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfKKSpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729835AbfKKSpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:45:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C52521783;
        Mon, 11 Nov 2019 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497917;
        bh=s8LjOJRbFWTjFJU8PunCvZmgxtsSf2yjWOf9YJFE/nI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GibbU1+Bv4hZfyxnOUdEWQvJ076saXI6TQtYu7xSPf0hLoMkceUINh1Rm4ktw8FB/
         Odx9liHsq3oBCglicvVM8kHKGRUmVX1gKjK0J76af97iwJiOXMF+HWfWvQPg7XmyyB
         rRGGkKkMwElvPkthMlIMdugGLor36QHzazjKFaPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/125] perf/x86/amd/ibs: Handle erratum #420 only on the affected CPU family (10h)
Date:   Mon, 11 Nov 2019 19:28:55 +0100
Message-Id: <20191111181452.639310015@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

[ Upstream commit e431e79b60603079d269e0c2a5177943b95fa4b6 ]

This saves us writing the IBS control MSR twice when disabling the
event.

I searched revision guides for all families since 10h, and did not
find occurrence of erratum #420, nor anything remotely similar:
so we isolate the secondary MSR write to family 10h only.

Also unconditionally update the count mask for IBS Op implementations
that have read & writeable current count (CurCnt) fields in addition
to the MaxCnt field.  These bits were reserved on prior
implementations, and therefore shouldn't have negative impact.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: c9574fe0bdb9 ("perf/x86-ibs: Implement workaround for IBS erratum #420")
Link: https://lkml.kernel.org/r/20191023150955.30292-2-kim.phillips@amd.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/ibs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index fac0867907d4d..07bf5517d9d8b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -389,7 +389,8 @@ static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
 	config &= ~perf_ibs->cnt_mask;
-	wrmsrl(hwc->config_base, config);
+	if (boot_cpu_data.x86 == 0x10)
+		wrmsrl(hwc->config_base, config);
 	config &= ~perf_ibs->enable_mask;
 	wrmsrl(hwc->config_base, config);
 }
@@ -564,7 +565,8 @@ static struct perf_ibs perf_ibs_op = {
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_CONFIG_MASK,
-	.cnt_mask		= IBS_OP_MAX_CNT,
+	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
+				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
 	.max_period		= IBS_OP_MAX_CNT << 4,
-- 
2.20.1



