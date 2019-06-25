Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA47C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C12215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mPu5dVWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfFYIpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:45:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFYIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:45:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8gNT43533370
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:42:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8gNT43533370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452144;
        bh=cg42abpzc5s3kX2ncAxw3NJVpOj4sXnUSvXHK3AoXNE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mPu5dVWsn/LvBKEErWynIV6akZ5Le6T/2F0Ubd0wfbVYbefm0n+FWHwFKw9k4V2Ji
         BTf1NNeq5mAASAJzAVdAlh0lObkyBLU8F4wTvdqy8pfKq587v0fDrxwHWa7jrGMsxp
         TW5VS81oeBde/ESEBpRmjYRCd5+aK6uWpuDvw5a4tCmquL62gG741oc22PQSUaqc76
         8FiQ7DNddUIsC0X1kQaDa+YSLjDCCJKw+wTeHBBgHd/X4Lw27J4qodVTzsFoHNGbNL
         V1Tj3dawwemJWg6bKnh1dzuNzdCDEjczbhWa9evlYAsa5YGvsXqAOT75pAgEqSsaZa
         1ItejvuyXtBlQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8gMHA3533367;
        Tue, 25 Jun 2019 01:42:22 -0700
Date:   Tue, 25 Jun 2019 01:42:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5fc1bd84664a5152dcbdba0962c40a6a07fbd78b@git.kernel.org>
Cc:     bp@alien8.de, hpa@zytor.com, kan.liang@linux.intel.com,
        acme@kernel.org, torvalds@linux-foundation.org, luto@kernel.org,
        namhyung@kernel.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        eranian@google.com, tglx@linutronix.de
Reply-To: peterz@infradead.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, eranian@google.com, jolsa@redhat.com,
          mingo@kernel.org, namhyung@kernel.org, luto@kernel.org,
          torvalds@linux-foundation.org, vincent.weaver@maine.edu,
          gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
          bp@alien8.de, acme@kernel.org, hpa@zytor.com,
          kan.liang@linux.intel.com
In-Reply-To: <20190616140358.27799-8-jolsa@kernel.org>
References: <20190616140358.27799-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/rapl: Get attributes from new probe
 framework
Git-Commit-ID: 5fc1bd84664a5152dcbdba0962c40a6a07fbd78b
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

Commit-ID:  5fc1bd84664a5152dcbdba0962c40a6a07fbd78b
Gitweb:     https://git.kernel.org/tip/5fc1bd84664a5152dcbdba0962c40a6a07fbd78b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:57 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:35 +0200

perf/x86/rapl: Get attributes from new probe framework

We no longer need model specific attribute arrays,
because we get all this detected in rapl_events_attrs.

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
Link: https://lkml.kernel.org/r/20190616140358.27799-8-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/rapl.c | 89 --------------------------------------------
 1 file changed, 89 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 00b2b5d82d58..460196c02bae 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -416,87 +416,6 @@ RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
 
-static struct attribute *rapl_events_srv_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_ram),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_ram_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_cln_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_gpu),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_gpu_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_gpu_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_hsw_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_gpu),
-	EVENT_PTR(rapl_ram),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_gpu_unit),
-	EVENT_PTR(rapl_ram_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_gpu_scale),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_skl_attr[] = {
-	EVENT_PTR(rapl_cores),
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_gpu),
-	EVENT_PTR(rapl_ram),
-	EVENT_PTR(rapl_psys),
-
-	EVENT_PTR(rapl_cores_unit),
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_gpu_unit),
-	EVENT_PTR(rapl_ram_unit),
-	EVENT_PTR(rapl_psys_unit),
-
-	EVENT_PTR(rapl_cores_scale),
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_gpu_scale),
-	EVENT_PTR(rapl_ram_scale),
-	EVENT_PTR(rapl_psys_scale),
-	NULL,
-};
-
-static struct attribute *rapl_events_knl_attr[] = {
-	EVENT_PTR(rapl_pkg),
-	EVENT_PTR(rapl_ram),
-
-	EVENT_PTR(rapl_pkg_unit),
-	EVENT_PTR(rapl_ram_unit),
-
-	EVENT_PTR(rapl_pkg_scale),
-	EVENT_PTR(rapl_ram_scale),
-	NULL,
-};
-
 /*
  * There are no default events, but we need to create
  * "events" group (with empty attrs) before updating
@@ -754,37 +673,30 @@ static int __init init_rapl_pmus(void)
 
 struct intel_rapl_init_fun {
 	bool apply_quirk;
-	struct attribute **attrs;
 };
 
 static const struct intel_rapl_init_fun snb_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_cln_attr,
 };
 
 static const struct intel_rapl_init_fun hsx_rapl_init __initconst = {
 	.apply_quirk = true,
-	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun hsw_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_hsw_attr,
 };
 
 static const struct intel_rapl_init_fun snbep_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_srv_attr,
 };
 
 static const struct intel_rapl_init_fun knl_rapl_init __initconst = {
 	.apply_quirk = true,
-	.attrs = rapl_events_knl_attr,
 };
 
 static const struct intel_rapl_init_fun skl_rapl_init __initconst = {
 	.apply_quirk = false,
-	.attrs = rapl_events_skl_attr,
 };
 
 static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
@@ -923,7 +835,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_init = (struct intel_rapl_init_fun *)id->driver_data;
 	apply_quirk = rapl_init->apply_quirk;
-	rapl_pmu_events_group.attrs = rapl_init->attrs;
 
 	ret = rapl_check_hw_unit(apply_quirk);
 	if (ret)
