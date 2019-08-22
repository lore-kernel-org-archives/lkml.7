Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC73C23404
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507716;
	bh=X1RUW1fiBbrXRp5X5BKboXThZUAmveW/FZ7QweUZlnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wo6FSFdG9gWWXdmkDHDPGVHnY8KOyKza5EnDmg/N8W7S1IOHKRA8ITpPw6q2iU4z5
	 BtLX27rj1qOMC/h8MqAvHkQO9hNeVqc5k92MH6gRCq8lepfXu4Ltu646zw105k1Yif
	 ybwqUKtXrpEVfnE3BiXgDwbo5LkmmTjjqFDbP3f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393395AbfHVVBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393383AbfHVVBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:53 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DCD233FC;
        Thu, 22 Aug 2019 21:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507712;
        bh=X1RUW1fiBbrXRp5X5BKboXThZUAmveW/FZ7QweUZlnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHkXOsqulyPol7UURxFFuqY7rHL6aAMGCSTVEglFOkkVYlbg/Sy51K1XFJPM7PhHP
         cftzhnbOS7XpDOiB3ya37CixxSh192j3rwqV1aPp3SDUdZr82gr+nCYpgLHA6gzven
         NlTfyCNCYbYMdl1hty8JIJl88qOqbBE4rlbBLwwY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/25] perf bpf: Add missing xyarray.h header
Date:   Thu, 22 Aug 2019 18:00:45 -0300
Message-Id: <20190822210100.3461-11-acme@kernel.org>
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

This was being obtained indirectly via evsel.h -> counts.h, since we
don't need xyarray in counts.h, we need to add it here explicitely
before removing it from counts.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-jirmxg527i82yz31bwad9we7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 9c219d413e57..e20d7c5e1925 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -26,6 +26,8 @@
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
 
+#include <internal/xyarray.h>
+
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
 			      const char *fmt, va_list args)
 {
-- 
2.21.0

