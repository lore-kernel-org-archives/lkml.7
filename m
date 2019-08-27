Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390EC3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB9D21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869810;
	bh=d01dVqPf1/V7Uck1NEX43UuENsm/9P2DE8gPqoWasSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3Sf316JE6Y5QsBtewfdDz1wIe3p8ykv0nU8GpSl2DFRwfssZWJ7EoLRFs7roecnn
	 moL3+RSsqBaZ0PeBomMKR5Wd/GluXIDH0+BpmhNBaecN8Z5ci6Ubj43V65BgGPrI2t
	 HSWs1kaw/fH+ZgJliW8N6a4gvUQlYW20Mj6qXmUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfH0Bgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfH0Bgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E1B21848;
        Tue, 27 Aug 2019 01:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869806;
        bh=d01dVqPf1/V7Uck1NEX43UuENsm/9P2DE8gPqoWasSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzH+XJLy5wSxY8LXO4YfaTzWoS8HbtFKngwOhhu7/+09uwrYz4U8r8gW6Vb9c+Rph
         C0OCmK8RZraR1QO7ItxHKZ56GHX2rxOoxrlST0dBU7ay6TokYNgQnm5SYw4R+lh2x4
         eLiBo8XtweLGgYFUbFkTH/aARtFAFurj/+Kopu7c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/33] perf cpumap: No need to include perf.h, ditch it
Date:   Mon, 26 Aug 2019 22:36:02 -0300
Message-Id: <20190827013634.3173-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From a quick look this was never needed and just polluted the build,
needlessly making things including cpumap.h to be rebuild if perf.h or
anything it includes gets changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x10p8slllqkn3fc3bntjx3n0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index d0c5bbfd91af..c2519e7ea958 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -7,8 +7,6 @@
 #include <internal/cpumap.h>
 #include <perf/cpumap.h>
 
-#include "perf.h"
-
 struct cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-- 
2.21.0

