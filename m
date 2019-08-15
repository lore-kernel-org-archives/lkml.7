Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E1C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C782171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="uAt7OOD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfHOKCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:02:11 -0400
Received: from dougal.metanate.com ([90.155.101.14]:7993 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730464AbfHOKCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UoFEzh3ATL6zXQ0dPZbMp5klVXEtsjWzHvPOLWEvEVA=; b=uAt7OOD4L7Y2WSX/PwXhrB5ihM
        MlKsYtdssp9YDXiMwp5Tk/ne6mc8VT4FWrxwkVfXvONuuvsHkkEff6iaN4gbkuJLDSO5NysqQ7DhJ
        +mIpAhqjUxA4wokFHA+mh9Y5sVDG6Jld70quKN0z6zYPgAl5d+ZmUfBWCKFBZejOVIglSSt7DQBIZ
        FRz+8k/V8Itpv4v5UQU3evTDcG1SpuULp+Oy2wdF54M8KImm4t9dZaQ86eoRQWkOcaLtLlYJ5NHPh
        dSiCHxRQ8Cj7xmfhMguc9WGKPni/4Tgk3Xt6ie6o4urqUV35Oy+x1ORLs5xqeeRhbZ5LIFPNgTkmH
        6Y2+ZVTA==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1hyCZv-0001ER-N6; Thu, 15 Aug 2019 11:01:55 +0100
From:   John Keeping <john@metanate.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 3/3] perf unwind: remove unnecessary test
Date:   Thu, 15 Aug 2019 11:01:46 +0100
Message-Id: <20190815100146.28842-3-john@metanate.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190815100146.28842-1-john@metanate.com>
References: <20190804124434.204da4ac.john@metanate.com>
 <20190815100146.28842-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dwarf_callchain_users is false, then unwind__prepare_access() will
not set unwind_libunwind_ops so the remaining test here is sufficient.

Signed-off-by: John Keeping <john@metanate.com>
---
v2: new patch split out from patch 2
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
2.22.0

