Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D7C004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA3520844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ogx19RZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfGILeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:34:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGILeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:34:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BXadQ1893442
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:33:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BXadQ1893442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562672017;
        bh=3H3cDTlCH4TY9KiGzd57F33WCbQ+/Vikpi7l9koU8x8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ogx19RZ3P0e34lSqwcUq+trL1Mlp/M0QHfk7MFlPfK4M7DTZoxAmEOjL9wlO3GoMN
         aarV2qM8ERdbi2drX3arMzvg/Lx28WDiUrYdiW1GSFbZJKsyCCyIym53ZY1w5zH5P+
         6Wd/5qGPxb13dux2PwDGz0oVc9kxAjx/WMGrKbXu5ALt7YlZ/RJg+i14QBBcI6CBCt
         n6b3QaL2QVuMqYF6rSBkztxQhm4D3FwMM6VusD6AW7HvZ61LLEMGMcvy7tnnC4G0wM
         w/QucgXkkKdORx10g3hLpEf32Haor98SCakTeg3pLugwUi7pzk2OGvAvx2lXPhzMp0
         T4q5Ao0AxuxDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BXZO61893435;
        Tue, 9 Jul 2019 04:33:35 -0700
Date:   Tue, 9 Jul 2019 04:33:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-dab0f4ebb22ee6d16051011d624cff79a99baa8a@git.kernel.org>
Cc:     ben.gainey@arm.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        jolsa@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, acme@redhat.com, ben.gainey@arm.com,
          peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, eranian@google.com,
          namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190531131321.GB1281@krava>
References: <20190531131321.GB1281@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jvmti: Address gcc string overflow warning for
 strncpy()
Git-Commit-ID: dab0f4ebb22ee6d16051011d624cff79a99baa8a
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

Commit-ID:  dab0f4ebb22ee6d16051011d624cff79a99baa8a
Gitweb:     https://git.kernel.org/tip/dab0f4ebb22ee6d16051011d624cff79a99baa8a
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 31 May 2019 15:13:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sun, 7 Jul 2019 12:33:32 -0300

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
 
