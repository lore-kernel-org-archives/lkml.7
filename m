Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D44215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dHxvGk2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfFYIl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfFYIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8ep373532925
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:40:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8ep373532925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452052;
        bh=FrgwKzmsM6IhhVE+t3x4oMq8MwZv+4ZClD1H6nreggA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dHxvGk2ejC0SdYfrVafV60h65DPapT0B5ol9W+IvF3hv0ntPfvxHDQlyQwGOR1By2
         NgLKig7VNHCJS7dTiWert0wf4ACehJsv9a1ARhxoyITzQBkZarUJYXH5F0OnSj1uNo
         66P87ZaJTe3awQ893MkbtupTeuK8S03v/dPELEVzQ/ypAJf6zQRSujHDSDz6xyhlNu
         KJahMabHBpP3pz/4HVeLXvhvU0QDNJiCt+4Kbltg70dB7fKAA38DAAsQoSxn7IQgMD
         ArKwKEk+ZNGUX1NclvhLLdI/M2fv4TkvEMTFX+HYfSQHmDBCcB8SK7DZ4lLgE5ecWK
         bPx48nSKTlDQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8epoc3532922;
        Tue, 25 Jun 2019 01:40:51 -0700
Date:   Tue, 25 Jun 2019 01:40:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cd105aed1a9954605d693948efad86cd8e57cb1a@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, jolsa@redhat.com,
        acme@kernel.org, hpa@zytor.com, alexander.shishkin@linux.intel.com,
        luto@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, bp@alien8.de,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        eranian@google.com, vincent.weaver@maine.edu
Reply-To: hpa@zytor.com, acme@kernel.org, mingo@kernel.org,
          jolsa@redhat.com, namhyung@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, jolsa@kernel.org, luto@kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          vincent.weaver@maine.edu, gregkh@linuxfoundation.org,
          eranian@google.com, torvalds@linux-foundation.org, bp@alien8.de
In-Reply-To: <20190616140358.27799-6-jolsa@kernel.org>
References: <20190616140358.27799-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/rapl: Get rapl_cntr_mask from new probe
 framework
Git-Commit-ID: cd105aed1a9954605d693948efad86cd8e57cb1a
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

Commit-ID:  cd105aed1a9954605d693948efad86cd8e57cb1a
Gitweb:     https://git.kernel.org/tip/cd105aed1a9954605d693948efad86cd8e57cb1a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:55 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:34 +0200

perf/x86/rapl: Get rapl_cntr_mask from new probe framework

We get rapl_cntr_mask from perf_msr_probe call, as a replacement
for current intel_rapl_init_fun::cntr_mask value for each model.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan <kan.liang@linux.intel.com>
Cc: Liang
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190616140358.27799-6-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/rapl.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index fa6d8065db15..417de3fdde61 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -96,33 +96,6 @@ static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
 	"psys",
 };
 
-/* Clients have PP0, PKG */
-#define RAPL_IDX_CLN	(1<<RAPL_IDX_PP0_NRG_STAT|\
-			 1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_PP1_NRG_STAT)
-
-/* Servers have PP0, PKG, RAM */
-#define RAPL_IDX_SRV	(1<<RAPL_IDX_PP0_NRG_STAT|\
-			 1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_RAM_NRG_STAT)
-
-/* Servers have PP0, PKG, RAM, PP1 */
-#define RAPL_IDX_HSW	(1<<RAPL_IDX_PP0_NRG_STAT|\
-			 1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_RAM_NRG_STAT|\
-			 1<<RAPL_IDX_PP1_NRG_STAT)
-
-/* SKL clients have PP0, PKG, RAM, PP1, PSYS */
-#define RAPL_IDX_SKL_CLN (1<<RAPL_IDX_PP0_NRG_STAT|\
-			  1<<RAPL_IDX_PKG_NRG_STAT|\
-			  1<<RAPL_IDX_RAM_NRG_STAT|\
-			  1<<RAPL_IDX_PP1_NRG_STAT|\
-			  1<<RAPL_IDX_PSYS_NRG_STAT)
-
-/* Knights Landing has PKG, RAM */
-#define RAPL_IDX_KNL	(1<<RAPL_IDX_PKG_NRG_STAT|\
-			 1<<RAPL_IDX_RAM_NRG_STAT)
-
 /*
  * event code: LSB 8 bits, passed in attr->config
  * any other bit is reserved
@@ -812,43 +785,36 @@ static int __init init_rapl_pmus(void)
 
 struct intel_rapl_init_fun {
 	bool apply_quirk;
-	int cntr_mask;
 	struct attribute **attrs;
 };
 
 static const struct intel_rapl_init_fun snb_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_CLN,
 	.attrs = rapl_events_cln_attr,
 };
 
 static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
 	.apply_quirk = true,
-	.cntr_mask = RAPL_IDX_SRV,
 	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_HSW,
 	.attrs = rapl_events_hsw_attr,
 };
 
 static const struct intel_rapl_init_fun snbep_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_SRV,
 	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun knl_rapl_init __initconst = {
 	.apply_quirk = true,
-	.cntr_mask = RAPL_IDX_KNL,
 	.attrs = rapl_events_knl_attr,
 };
 
 static const struct intel_rapl_init_fun skl_rapl_init __initconst = {
 	.apply_quirk = false,
-	.cntr_mask = RAPL_IDX_SKL_CLN,
 	.attrs = rapl_events_skl_attr,
 };
 
@@ -979,7 +945,8 @@ static int __init rapl_pmu_init(void)
 		return -ENODEV;
 
 	rm = (struct rapl_model *) id->driver_data;
-	perf_msr_probe(rapl_msrs, PERF_RAPL_MAX, false, (void *) &rm->events);
+	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
+					false, (void *) &rm->events);
 
 	id = x86_match_cpu(rapl_cpu_match);
 	if (!id)
@@ -987,7 +954,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_cntr_mask = rapl_init->cntr_mask;
 	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
