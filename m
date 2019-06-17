Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA4C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9C20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pn46uxJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfFQOli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:41:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:41:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEfC8s3459686
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:41:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEfC8s3459686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782473;
        bh=UT+BHqdc16tCET8VK/b3ynxDCIkB4l744Y6wG/KJW+c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pn46uxJvT+RdbGZDVmAy07PavRhrToRL6kdvyRCgBuzBEFnZy/2TjCRUxmU3jcDfj
         fkjItZrm+8wL76mUES/X3LkR42cJ+8ZdRQP1RK+8T4EMOylVbDVAnqiZ4lLcZrM5yN
         YjTeHG7A+mNJtFAfCowOCyC2g/RrDtnkWW1cBpvb57KY2FagccJEh3cL9a1ZXAn5GZ
         d6LpQKieQa1uO2zYVzmLtG0aH2NruOazsUDG5r4Ms5qzJcxOk9i0EgSmhOzMDdiurp
         VgfdIdwEEUFOBtRi+eZMgazZZMWxS44KyJ/17//MX2mDxyhkG52JXhhVoRkFz4YM5s
         jyWJ47vgwfxtA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEfCeD3459683;
        Mon, 17 Jun 2019 07:41:12 -0700
Date:   Mon, 17 Jun 2019 07:41:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d0e1a507bdc761a14906f03399d933ea639a1756@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, kan.liang@linux.intel.com, peterz@infradead.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, jolsa@kernel.org, tom.vaden@hpe.com,
        hpa@zytor.com, namhyung@kernel.org, tglx@linutronix.de
Reply-To: acme@kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, kan.liang@linux.intel.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, tom.vaden@hpe.com, jolsa@redhat.com,
          jolsa@kernel.org
In-Reply-To: <20190616141313.GD2500@krava>
References: <20190616141313.GD2500@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Disable check_msr for real HW
Git-Commit-ID: d0e1a507bdc761a14906f03399d933ea639a1756
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d0e1a507bdc761a14906f03399d933ea639a1756
Gitweb:     https://git.kernel.org/tip/d0e1a507bdc761a14906f03399d933ea639a1756
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Sun, 16 Jun 2019 16:13:13 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:24 +0200

perf/x86/intel: Disable check_msr for real HW

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
---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5e6ae481dee7..bda450ff51ee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -20,6 +20,7 @@
 #include <asm/intel-family.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -4050,6 +4051,13 @@ static bool check_msr(unsigned long msr, u64 mask)
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
