Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7DC20863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d1h7Ey7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfFQTPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:15:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:15:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJFJCZ3559471
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:15:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJFJCZ3559471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798920;
        bh=7tzFtz6G+PCg1thVdzT2W//KHSiLckDHCY58x7A7UVQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=d1h7Ey7oSaApeln74n6D9i+un7TsMNrOWJfYjWjCJykRqMEc7Eb+1ypwz22QPg2WB
         eRAMBPlTueOQS65QSYR6E+2EbBXEbewbq9uRLf+66kZI/GaTaqR1bHbw5CqLS5D+iD
         qD+FuD0XGEcdg1OhTMMs535A0qsIS0vMGgLshHl+zCVms4owwV+K0chRvOSPi6DXQB
         VN9BgdhW6ZpFQAq2Ld9WfdEfHlxaYYrdQCFwzJM5YSucFlCWQtugZeKbWc75TYty5g
         bC5A7Lfw67iUZgl/76dfdTeQt/tYgszv4SEJw6kn4ARKaDh/J0wappKFEqoA78sso/
         gRjdS/IuYj8yA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJFJUu3559468;
        Mon, 17 Jun 2019 12:15:19 -0700
Date:   Mon, 17 Jun 2019 12:15:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-279ab04dbea1370d2eac0f854270369ccaef8a44@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
        eranian@google.com, hpa@zytor.com, ben.gainey@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com
Reply-To: jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
          eranian@google.com, hpa@zytor.com, ben.gainey@arm.com,
          namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com
In-Reply-To: <20190531131321.GB1281@krava>
References: <20190531131321.GB1281@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jvmti: Address gcc string overflow warning for
 strncpy()
Git-Commit-ID: 279ab04dbea1370d2eac0f854270369ccaef8a44
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  279ab04dbea1370d2eac0f854270369ccaef8a44
Gitweb:     https://git.kernel.org/tip/279ab04dbea1370d2eac0f854270369ccaef8a44
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 31 May 2019 15:13:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:51:26 -0300

perf jvmti: Address gcc string overflow warning for strncpy()

We are getting false positive gcc warning when we compile with gcc9 (9.1.1):

     CC       jvmti/libjvmti.o
   In file included from /usr/include/string.h:494,
                    from jvmti/libjvmti.c:5:
   In function ‘strncpy’,
       inlined from ‘copy_class_filename.constprop’ at jvmti/libjvmti.c:166:3:
   /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
     106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   jvmti/libjvmti.c: In function ‘copy_class_filename.constprop’:
   jvmti/libjvmti.c:165:26: note: length computed here
     165 |   size_t file_name_len = strlen(file_name);
         |                          ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

As per Arnaldo's suggestion use strlcpy(), which does the same thing and keeps
gcc silent.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190531131321.GB1281@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/jvmti/libjvmti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index aea7b1fe85aa..c441a34cb1c0 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <linux/string.h>
 #include <sys/types.h>
 #include <stdio.h>
 #include <string.h>
@@ -162,8 +163,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 		result[i] = '\0';
 	} else {
 		/* fallback case */
-		size_t file_name_len = strlen(file_name);
-		strncpy(result, file_name, file_name_len < max_length ? file_name_len : max_length);
+		strlcpy(result, file_name, max_length);
 	}
 }
 
