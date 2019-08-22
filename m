Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9AEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F6F233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507758;
	bh=IhjBSdqzHZKggaoDWjGrn9+s966ssh4ouaST3rNHfvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OIbgB9hLRNeIbPNNgcCzpVbRIcagQbA1c8W9ZDOl4fEcmiauagEF+7e7LnHXKe7Wv
	 7fUA/cILIq6fYhahtWtP3bEPvBkT4Eq1JAne6XYAnMtQflg7tV62iK+CpkPiyvQ61C
	 ulIqFAONVRJeF3afl9c9RkOmVo95lHskkNao/GPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393517AbfHVVCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388169AbfHVVCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:35 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D36F23405;
        Thu, 22 Aug 2019 21:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507754;
        bh=IhjBSdqzHZKggaoDWjGrn9+s966ssh4ouaST3rNHfvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZqKa/YZoi8kNphjATz+3iEe03MrBm7YyDllh4pRwhnXLQo6YbbXytkhET/NKztel
         do2kSl+HkBSIGKJV4XMA7mji5/urOjdgbX42sdOCX7UgCJNcdvxecUO52JZAgRmyts
         h+WZYfLdllS2RBM7yBJlXqEfElLR3Dw+PZ1JDr4I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 20/25] perf x86 kvm-stat: Add missing string.h header
Date:   Thu, 22 Aug 2019 18:00:55 -0300
Message-Id: <20190822210100.3461-21-acme@kernel.org>
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

It uses strcmp(), strstr() and was getting the required string.h header
by luck, from evsel.h -> cpumap.h -> debug.h -> string.h, add the
missing header.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qrz8hhvrhwnmt5ocfwk4br5d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 81b531a707bf..c0775c39227f 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <string.h>
 #include "../../../util/kvm-stat.h"
 #include "../../../util/evsel.h"
 #include <asm/svm.h>
-- 
2.21.0

