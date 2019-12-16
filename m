Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DE821775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529275;
	bh=vi8rVywZoEbgyuxBr7oB588A8LfyOxI2bbilVs9PiO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fUtlmPRkBfkbWUcDVi8uPKM49JHcULmH0FPDOEr6V4Asa2lMIv39oU1ALKUv3x3Us
	 7daNgphI+nZ2waww3XiW/0dMDJXyjRxHs5ekcRnOSltBwEoJxtCjFHQfgzx6HrO12a
	 Y3NMXdw9KUIsTpnABtbJ7m3PFlRor3o3cJs+cwzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLPUry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfLPUrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:47:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32C824650;
        Mon, 16 Dec 2019 20:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529272;
        bh=vi8rVywZoEbgyuxBr7oB588A8LfyOxI2bbilVs9PiO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jG6KOnISyG+f3VVO/s8Yfu1U53J+SXgOxjk+5z44F4V3RcYlML33KdunrLdWQ9/LJ
         147R/gS5iiYaluiDp51J6BQOTVlNWWgaGbLoocBUYtNgh3IRC/x3BjI3s89YNiCGNW
         0oEzlNuvBi9NW04eHT0RDNNQgq8UD+C6IVOwFAkI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/9] perf arch: Make the default get_cpuid() return compatible error
Date:   Mon, 16 Dec 2019 17:47:31 -0300
Message-Id: <20191216204738.12107-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some of the functions calling get_cpuid() propagate back the error it
returns, and all are using errno (positive) values, make the weak
default get_cpuid() function return ENOSYS to be consistent and to allow
checking if this is an arch not providing this function or if a provided
one is having trouble getting the cpuid, to decide if the warning should
be provided to the user or just a debug message should be emitted.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: John Garry <john.garry@huawei.com> # arm64
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index becc2d109423..4d39a75551a0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
  */
 int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
 {
-	return -1;
+	return ENOSYS; /* Not implemented */
 }
 
 static int write_cpuid(struct feat_fd *ff,
-- 
2.21.0

