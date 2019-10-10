Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488B821929
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697262;
	bh=kgzfr/vRrO0hm5BZsVAdICd2cayTt5lbLSD11QS0AvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M+yFrSGBb1rK81fKrnwYvkBx2RvIkDHtQNkvoJeaaidZu3FP5FPihiHaOrf/0fr2p
	 MheEjqYgTxdNnvObW39Wb3RURh+Z5+wwNo7EY4zCUd7AvB0u5UkHZGy5QW3ORojjfs
	 v3kXiGot8MB+pU/T72SEu6jrNrOyZ3XoKLKAFcTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfJJIrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388546AbfJJIrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:47:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C042245A;
        Thu, 10 Oct 2019 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697258;
        bh=kgzfr/vRrO0hm5BZsVAdICd2cayTt5lbLSD11QS0AvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13mKZFxWLHEL0aZD3rqNSTFOFTySIZNsKy0vTWMH0j7W2VkbZi+ogxiQiu1syurvN
         P9EjQ2vGBJHI3Q6uHgxAm1FKqxaeze40c3Ccyr8/s7D4JeIioT5E0MVwP4cajflaSL
         QiyTQnv07MPgYRb2wboH6TLYq8LobN/ZCBJUd7EE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/114] perf unwind: Fix libunwind build failure on i386 systems
Date:   Thu, 10 Oct 2019 10:36:22 +0200
Message-Id: <20191010083611.905436286@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 26acf400d2dcc72c7e713e1f55db47ad92010cc2 ]

Naresh Kamboju reported, that on the i386 build pr_err()
doesn't get defined properly due to header ordering:

  perf-in.o: In function `libunwind__x86_reg_id':
  tools/perf/util/libunwind/../../arch/x86/util/unwind-libunwind.c:109:
  undefined reference to `pr_err'

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/unwind-libunwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/unwind-libunwind.c b/tools/perf/arch/x86/util/unwind-libunwind.c
index 05920e3edf7a7..47357973b55b2 100644
--- a/tools/perf/arch/x86/util/unwind-libunwind.c
+++ b/tools/perf/arch/x86/util/unwind-libunwind.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <errno.h>
+#include "../../util/debug.h"
 #ifndef REMOTE_UNWIND_LIBUNWIND
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
-#include "../../util/debug.h"
 #endif
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
-- 
2.20.1



