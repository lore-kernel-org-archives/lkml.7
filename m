Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B1EC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA332173B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986707;
	bh=7G6E30ipzaiD4sGgTSxnOGoJLxeBUYFdLyM2zdaq9zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hNlagBZ6G2Vg652sX0OEIWDOxxRXEMEpYACtXoyrk372qRQgQfDwPX8wY57/Lsbd
	 u2rIgC7J0QNgxdht+HipVMjbjtiy1k2eeCnRzvQy4E2WAhgLLSHa6xSb2HcU4kJcQ+
	 DzpAlzFWdJGR9+1CrrRlnt/yV4SfD9cD6lxTfdMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfHPUS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfHPUSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:18:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E672133F;
        Fri, 16 Aug 2019 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986702;
        bh=7G6E30ipzaiD4sGgTSxnOGoJLxeBUYFdLyM2zdaq9zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xwcFf21bpz/pUHrL08u5z55jIlL4P14UPiJD1lmPVXW1WMHrINm/qZIrgxtaj59UZ
         OTytOZ6TxEHmII1rMkW81vXqWF5LHwxhNVlrkpjzFBVCG5B26fReMwvMKtqsxd7nnV
         rcZHDOZKXNMKkjomsTKJbLd4WE4V3DhU8hfl+xBk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Keeping <john@metanate.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/17] perf unwind: Remove unnecessary test
Date:   Fri, 16 Aug 2019 17:16:53 -0300
Message-Id: <20190816201653.19332-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

If dwarf_callchain_users is false, then unwind__prepare_access() will
not set unwind_libunwind_ops so the remaining test here is sufficient.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: john keeping <john@metanate.com>
Link: http://lkml.kernel.org/r/20190815100146.28842-3-john@metanate.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libunwind.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index b843f9d0a9ea..6499b22b158b 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -69,18 +69,12 @@ int unwind__prepare_access(struct map_groups *mg, struct map *map,
 
 void unwind__flush_access(struct map_groups *mg)
 {
-	if (!dwarf_callchain_users)
-		return;
-
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->flush_access(mg);
 }
 
 void unwind__finish_access(struct map_groups *mg)
 {
-	if (!dwarf_callchain_users)
-		return;
-
 	if (mg->unwind_libunwind_ops)
 		mg->unwind_libunwind_ops->finish_access(mg);
 }
-- 
2.21.0

