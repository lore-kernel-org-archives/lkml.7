Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85044C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5909821A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928372;
	bh=fBF0B/J7e2iMg/x2HR8lcQsoPlcwEjCZpamb3oGWUfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0LH6YrOYvUvJi/12vRpQi78qN6K8fpbSfh23r7Zq/KcKd9wXOXjaCICuE3Xf6drSx
	 yth2usw4KPf33Kz+O6frOd5qaUZraKYgIIX+U7UN5hwK9j8+6Ldpf4/tohXKJiZhY9
	 +aTUfNBjoJVf49xsJbB8VqHk9xdfKYgO6kh0d60E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfJALMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfJALMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:49 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB78821D71;
        Tue,  1 Oct 2019 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928368;
        bh=fBF0B/J7e2iMg/x2HR8lcQsoPlcwEjCZpamb3oGWUfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PGbQoRdeM0Q41cK6ZhnXYNU4PGHWqQkCECrj1MAFzahpgukwPJss0fsDb1bopHpkz
         q8BrtT6tOF1dF8v+cOISlltSHL5tD+u0Y7j/qo0ZCRSYkcH4DWE3rs+YG+akW7dCg+
         qDfgwjvBFY8JuxFi+QbNaxQYGfX7gxV0eecoDpg8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Minchan Kim <minchan@kernel.org>
Subject: [PATCH 05/24] tools headers uapi: Sync asm-generic/mman-common.h with the kernel
Date:   Tue,  1 Oct 2019 08:11:57 -0300
Message-Id: <20191001111216.7208-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
  9c276cc65a58 ("mm: introduce MADV_COLD")

That result in these changes in the tools:

  $ tools/perf/trace/beauty/madvise_behavior.sh > before
  $ cp include/uapi/asm-generic/mman-common.h tools/include/uapi/asm-generic/mman-common.h
  $ git diff
  diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
  index 63b1f506ea67..c160a5354eb6 100644
  --- a/tools/include/uapi/asm-generic/mman-common.h
  +++ b/tools/include/uapi/asm-generic/mman-common.h
  @@ -67,6 +67,9 @@
   #define MADV_WIPEONFORK 18             /* Zero memory on fork, child only */
   #define MADV_KEEPONFORK 19             /* Undo MADV_WIPEONFORK */

  +#define MADV_COLD      20              /* deactivate these pages */
  +#define MADV_PAGEOUT   21              /* reclaim these pages */
  +
   /* compatibility flags */
   #define MAP_FILE       0

  $ tools/perf/trace/beauty/madvise_behavior.sh > after
  $ diff -u before after
  --- before	2019-09-27 11:29:43.346320100 -0300
  +++ after	2019-09-27 11:30:03.838570439 -0300
  @@ -16,6 +16,8 @@
   	[17] = "DODUMP",
   	[18] = "WIPEONFORK",
   	[19] = "KEEPONFORK",
  +	[20] = "COLD",
  +	[21] = "PAGEOUT",
   	[100] = "HWPOISON",
   	[101] = "SOFT_OFFLINE",
   };
  $

I.e. now when madvise gets those behaviours as args, it will be able to
translate from the number to a human readable string.

This addresses the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-n40y6c4sa49p29q6sl8w3ufx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/mman-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 63b1f506ea67..c160a5354eb6 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -67,6 +67,9 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#define MADV_COLD	20		/* deactivate these pages */
+#define MADV_PAGEOUT	21		/* reclaim these pages */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
-- 
2.21.0

