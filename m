Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93921C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682C723401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507755;
	bh=VOTSxvWqa4OxkqMIGguellO8+bwQRo05hpmS95ETkC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gl5cnYjYx6CirVDD3jsk6GK+jnOQpCfYitHXVau6p08PVHuGH5vcwcslahSkxiiaY
	 FkoO00JD1Hl04sGd86KB7zfPXd7Hh/1dmb+G8HOs7GZAu1aZCIcBG3kKZHZFX3RrBn
	 rY6CnHRAStAwWf3UEooJgxXrr2tBEAshGsJQ4k1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393507AbfHVVCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbfHVVCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:31 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E49233FC;
        Thu, 22 Aug 2019 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507750;
        bh=VOTSxvWqa4OxkqMIGguellO8+bwQRo05hpmS95ETkC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DI6++XrGZFV1KoNWrNoAgZY46b4f4ZI41EdLqvlIiiPYn8dzBFgmWwWkIstiGK+pL
         90YMP/JaM0yTNpBYCWJB24kJevspNTuVDPG7AN33FzjUP5T6i5XvtyyVEzEO2GZv74
         UU+ZpfcDqycVtrwEs3IB42UUBubGjlNmGIdDhz0A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 19/25] perf evsel: util/evsel.h needs stdio.h as it uses FILE
Date:   Thu, 22 Aug 2019 18:00:54 -0300
Message-Id: <20190822210100.3461-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And it was getting it by luck from util/cpumap.h that shouldn't be
included in util/evsel.h as it only needs what is in libperf, i.e.
struct cpu_map, that is in internal/cpumap.h, so add stdio.h before
we fix that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2ywx5sl031tj3zske7c7edgv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f749a783d8f..cd336cf2eaa9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -4,6 +4,7 @@
 
 #include <linux/list.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
 #include <internal/evsel.h>
-- 
2.21.0

