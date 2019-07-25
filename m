Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B47C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E15621734
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TuB6h/cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbfGYQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:06:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbfGYQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:06:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG6NO71073442
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:06:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG6NO71073442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070784;
        bh=mfjusjIAMDresxCsLNGATat7D/iNdClmjfR+p1J/358=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TuB6h/cvBgsXtCT3haZKXQtHH/sgYlLTzdzpGc6YqlM7J/3P12OkJOu8AIqghjFXO
         23q4d7q9O3a9PB5AGNP5oRU29AnGJzzPs5SBY2kK1r1fks1Y4f/wEMnxi2oPkBbehe
         m0UtkCUp5+cXFM32s9fo4zacZqvdE4ZhSgAeNrVlThYpUpBS/Av6Soq5uWnOPGm/iq
         t5lANfT1+wjKOtClkhfEb+hVwoSuerxIBKwNxdgl2C756Pjb4E3Nux0yDLmQ+2FMpl
         WTjLKhafuSwTz6B/tJQAQ1jYhdKef4Dc0sKVSXd9og3qyBsA01ErLlBvG+s7jLzQU+
         l8DZMnIzcnmfQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG6NvH1073439;
        Thu, 25 Jul 2019 09:06:23 -0700
Date:   Thu, 25 Jul 2019 09:06:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yunying Sun <tipbot@zytor.com>
Message-ID: <tip-3b238a64c3009fed36eaea1af629d9377759d87d@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, yunying.sun@intel.com, hpa@zytor.com,
        kan.liang@linux.intel.com, torvalds@linux-foundation.org
Reply-To: yunying.sun@intel.com, hpa@zytor.com, kan.liang@linux.intel.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190724082932.12833-1-yunying.sun@intel.com>
References: <20190724082932.12833-1-yunying.sun@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix invalid Bit 13 for Icelake
 MSR_OFFCORE_RSP_x register
Git-Commit-ID: 3b238a64c3009fed36eaea1af629d9377759d87d
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

Commit-ID:  3b238a64c3009fed36eaea1af629d9377759d87d
Gitweb:     https://git.kernel.org/tip/3b238a64c3009fed36eaea1af629d9377759d87d
Author:     Yunying Sun <yunying.sun@intel.com>
AuthorDate: Wed, 24 Jul 2019 16:29:32 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:41:30 +0200

perf/x86/intel: Fix invalid Bit 13 for Icelake MSR_OFFCORE_RSP_x register

The Intel SDM states that bit 13 of Icelake's MSR_OFFCORE_RSP_x
register is valid, and used for counting hardware generated prefetches
of L3 cache. Update the bitmask to allow bit 13.

Before:
$ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
 Performance counter stats for 'sleep 3':
   <not supported>      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u

After:
$ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
 Performance counter stats for 'sleep 3':
             9,293      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u

Signed-off-by: Yunying Sun <yunying.sun@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: jolsa@redhat.com
Cc: namhyung@kernel.org
Link: https://lkml.kernel.org/r/20190724082932.12833-1-yunying.sun@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e911a96972b..b35519cbc8b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -263,8 +263,8 @@ static struct event_constraint intel_icl_event_constraints[] = {
 };
 
 static struct extra_reg intel_icl_extra_regs[] __read_mostly = {
-	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffff9fffull, RSP_0),
-	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffff9fffull, RSP_1),
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffbfffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x01bb, MSR_OFFCORE_RSP_1, 0x3fffffbfffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
 	INTEL_UEVENT_EXTRA_REG(0x01c6, MSR_PEBS_FRONTEND, 0x7fff17, FE),
 	EVENT_EXTRA_END
