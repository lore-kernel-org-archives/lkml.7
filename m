Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CCC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C170022AEC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997672;
	bh=MSwQBVTCOe5B6DG8UTRH4Sdv8vFnvmQYi7k+BBbW9OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wu9OQvjZtxHoAW/k0EMDTCDkdu9Z2iKrYdLrAqwc6bC3wq51UZd1iCSsQWeTH4muh
	 OyBXz57uSCcEV6/0zdatMK4DBD3Xj03gsoRiiL1r0x20fRDdRPrejImAf1wjUGeM7O
	 so+ynTwnw+n8fFnnEzMQGHObbo20aIEpht2l8IkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbfGXTru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391270AbfGXTrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:47:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C1920659;
        Wed, 24 Jul 2019 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997666;
        bh=MSwQBVTCOe5B6DG8UTRH4Sdv8vFnvmQYi7k+BBbW9OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAChM6sxrE1eGhA7t0xS8FfcpNh27/V0we2LShj5xZPv3Q3bR7CBNJbFkvU4yXGNr
         2OsCU7Vss7TwuRK7W5/Sng/KcoaIIRrL+qljyoC35meEHBRd+lVwRdddL8U4L0jBer
         jqnhMcwgeAPN0FFT1pCAM/Tuvv6eKsFMpBSCvDNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Vaden <tom.vaden@hpe.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Liang Kan <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 102/371] perf/x86/intel: Disable check_msr for real HW
Date:   Wed, 24 Jul 2019 21:17:34 +0200
Message-Id: <20190724191732.516555170@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d0e1a507bdc761a14906f03399d933ea639a1756 ]

Tom Vaden reported false failure of the check_msr() function, because
some servers can do POST tracing and enable LBR tracing during
bootup.

Kan confirmed that check_msr patch was to fix a bug report in
guest, so it's ok to disable it for real HW.

Reported-by: Tom Vaden <tom.vaden@hpe.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tom Vaden <tom.vaden@hpe.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Liang Kan <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190616141313.GD2500@krava
[ Readability edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 82dad001d1ea..a50e182c38b6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -19,6 +19,7 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -3927,6 +3928,13 @@ static bool check_msr(unsigned long msr, u64 mask)
 {
 	u64 val_old, val_new, val_tmp;
 
+	/*
+	 * Disable the check for real HW, so we don't
+	 * mess with potentionaly enabled registers:
+	 */
+	if (hypervisor_is_type(X86_HYPER_NATIVE))
+		return true;
+
 	/*
 	 * Read the current value, change it and read it back to see if it
 	 * matches, this is needed to detect certain hardware emulators
-- 
2.20.1



