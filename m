Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C72220851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980707;
	bh=FFHhtE/QOj4jLD0+pxtFygkemoB2wCWfQxac3K+/t/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqpe7yESUhfUKa361Ru/7PhmlS0vhGFGYgWakMMvULPCdk+CLSalWF6ZWKSMIEo76
	 ZMeT/fPulIpNCvgWDa041oOJaz1pxfYBdtDJlgsWgLGm8LjFa8K8oyrLmc5Huk3LDi
	 1F1SRNAWe253Xh9rndMJ4OU4FNJOJPEnleIx7Vw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCGRpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfCGRpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:04 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D99C2087C;
        Thu,  7 Mar 2019 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980703;
        bh=FFHhtE/QOj4jLD0+pxtFygkemoB2wCWfQxac3K+/t/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDgOls/aQQvQo7DkHWn5tGhYpIwrLJ4Bw1ytFv/DyP95GnOx9mrVfNoet89+9SeSp
         OQDNDrByN9p7svDjvmcOBqGeCcW5W8KuACVUqYhTv1pTIbfkDyZ1EagNCYPeqRkwOP
         tRb8f4zmbKwokRl6ZpqMuulaCIbiTJjAK+oJrKk4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kees Kook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/35] perf: Mark expected switch fall-through
Date:   Thu,  7 Mar 2019 14:44:02 -0300
Message-Id: <20190307174433.28819-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

  kernel/events/core.c: In function ‘perf_event_parse_addr_filter’:
  kernel/events/core.c:9154:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
      kernel = 1;
      ~~~~~~~^~~
  kernel/events/core.c:9156:3: note: here
     case IF_SRC_FILEADDR:
     ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190212205430.GA8446@embeddedor
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd9698ad3d66..6fb27b564730 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9175,6 +9175,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
+			/* fall through */
 
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
-- 
2.20.1

