Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F4C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9F7208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="CzGrhDeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfF0W17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:27:59 -0400
Received: from one.firstfloor.org ([193.170.194.197]:49284 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0W16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:27:58 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 18:27:57 EDT
Received: from firstfloor.org (c-71-238-43-142.hsd1.or.comcast.net [71.238.43.142])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by one.firstfloor.org (Postfix) with ESMTPSA id 1CBCF86712;
        Fri, 28 Jun 2019 00:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1561674026;
        bh=XoR8yTCqfAt67Rp1x+70ueZjQuZxGxj6NraAHdT9T4c=;
        h=From:To:Cc:Subject:Date:From;
        b=CzGrhDebeLcx+ftjos04x7Yk3/Mn/0Fgyw6VOBTCXxuDhUq3EBbeTMOO7DjHbmq0v
         B29hTrYmSipwXDgDlV/NMlWfpHIO11cAlGADaRWyZ7+UxIeXcbjPzrgiTWLHgZSSiR
         EFZ0F/YAZ3XqLYgRuvc7k5uiHPRt2WASw4OzJjBQ=
Received: by firstfloor.org (Postfix, from userid 1000)
        id 4DB7FA0B2E; Thu, 27 Jun 2019 15:20:22 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Fix bison warnings for pure parser
Date:   Thu, 27 Jun 2019 15:20:21 -0700
Message-Id: <20190627222021.14980-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

bison 3.4.1 complains during a perf build:

util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
    1 | %pure-parser
      | ^~~~~~~~~~~~
  CC       /home/andi/lsrc/obj-perf/ui/browsers/map.o
util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]

util/expr.y:13.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
   13 | %pure-parser
      | ^~~~~~~~~~~~
util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]

Change the declarations to %define api.pure

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/expr.y         | 2 +-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 432b8560cf51..803c0929c205 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -10,7 +10,7 @@
 #define MAXIDLEN 256
 %}
 
-%pure-parser
+%define api.pure
 %parse-param { double *final_val }
 %parse-param { struct parse_ctx *ctx }
 %parse-param { const char **pp }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 6ad8d4914969..4eb10c27c30f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -1,4 +1,4 @@
-%pure-parser
+%define api.pure
 %parse-param {void *_parse_state}
 %parse-param {void *scanner}
 %lex-param {void* scanner}
-- 
2.21.0

