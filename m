Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71254C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447E72053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200682;
	bh=+Vx+aQZxwNOf7O7y0gWpquwyZqoLawXINtRoybUO530=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYdCAoGGxnky6kxKFDLgf+h85RGQRhlkednEsWlDEzA9x7H6M0dHh7D4/xwMOn7Eu
	 uRma4ncPhkIxJkDSPODAxenaMiBs5VDV3Qx2SBsHmnpNAIYp30FgfooRA57KdVFV2W
	 7XEYQX+9fOsUp/YdB8BrPcDE17Ik8OU/KKbDwSOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbfGOOYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390945AbfGOOYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:24:38 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBABB2053B;
        Mon, 15 Jul 2019 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200678;
        bh=+Vx+aQZxwNOf7O7y0gWpquwyZqoLawXINtRoybUO530=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkVgrvu/LGbRpZthrvfKgYCaFEzOGB9oDpkG5GWKUuVSxIiwHkkUsAGGjvd2CvHNy
         rzwq6KoWT6IAgTXkiC9fu3wa9C1Fjdq5g9uPt/gGRNPhqqKxA1I9X8BSEi1OnmmKRq
         EEn30UhHJDtt5hOgZyAbwIuhMEpI6AHWQTEAruZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kyle Meyer <kyle.meyer@hpe.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 110/158] perf tools: Increase MAX_NR_CPUS and MAX_CACHES
Date:   Mon, 15 Jul 2019 10:17:21 -0400
Message-Id: <20190715141809.8445-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <kyle.meyer@hpe.com>

[ Upstream commit 9f94c7f947e919c343b30f080285af53d0fa9902 ]

Attempting to profile 1024 or more CPUs with perf causes two errors:

  perf record -a
  [ perf record: Woken up X times to write data ]
  way too many cpu caches..
  [ perf record: Captured and wrote X MB perf.data (X samples) ]

  perf report -C 1024
  Error: failed to set  cpu bitmap
  Requested CPU 1024 too large. Consider raising MAX_NR_CPUS

  Increasing MAX_NR_CPUS from 1024 to 2048 and redefining MAX_CACHES as
  MAX_NR_CPUS * 4 returns normal functionality to perf:

  perf record -a
  [ perf record: Woken up X times to write data ]
  [ perf record: Captured and wrote X MB perf.data (X samples) ]

  perf report -C 1024
  ...

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190620193630.154025-1-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/perf.h        | 2 +-
 tools/perf/util/header.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..19d435a9623b 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -26,7 +26,7 @@ static inline unsigned long long rdclock(void)
 }
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			1024
+#define MAX_NR_CPUS			2048
 #endif
 
 extern const char *input_name;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b9a82598e2ac..7f2e3b1c746c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1173,7 +1173,7 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES 2000
+#define MAX_CACHES (MAX_NR_CPUS * 4)
 
 static int write_cache(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
-- 
2.20.1

