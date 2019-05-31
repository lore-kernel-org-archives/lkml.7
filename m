Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4C3265BA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfEaNNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfEaNNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:13:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E0EA30C1214;
        Fri, 31 May 2019 13:13:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5E75DA34;
        Fri, 31 May 2019 13:13:22 +0000 (UTC)
Date:   Fri, 31 May 2019 15:13:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ben Gainey <ben.gainey@arm.com>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2] perf jvmti: Fix gcc string overflow warning
Message-ID: <20190531131321.GB1281@krava>
References: <20190531080307.22628-1-jolsa@kernel.org>
 <20190531120530.GB17152@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531120530.GB17152@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 31 May 2019 13:13:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 09:05:30AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> The kernel folks moved beyond that and in lib/string.c we have:
> 
> /**
>  * strscpy - Copy a C-string into a sized buffer
>  * @dest: Where to copy the string to
>  * @src: Where to copy the string from
>  * @count: Size of destination buffer
>  *
>  * Copy the string, or as much of it as fits, into the dest buffer.  The
>  * behavior is undefined if the string buffers overlap.  The destination
>  * buffer is always NUL terminated, unless it's zero-sized.
>  *
>  * Preferred to strlcpy() since the API doesn't require reading memory
>  * from the src string beyond the specified "count" bytes, and since
>  * the return value is easier to error-check than strlcpy()'s.
>  * In addition, the implementation is robust to the string changing out
>  * from underneath it, unlike the current strlcpy() implementation.
>  *
>  * Preferred to strncpy() since it always returns a valid string, and
>  * doesn't unnecessarily force the tail of the destination buffer to be
>  * zeroed.  If zeroing is desired please use strscpy_pad().
>  *
>  * Return: The number of characters copied (not including the trailing
>  *         %NUL) or -E2BIG if the destination buffer wasn't big enough.
>  */
> ssize_t strscpy(char *dest, const char *src, size_t count)
> 
> 
> 
> I think for these needs flipping that 'n' into a 'l' is good enough.

ok, I forgot there's strlcpy.. v2 attached

thanks,
jirka


---
We are getting fake gcc warning when we compile with gcc9 (9.1.1):

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

As per Arnaldo's suggestion using strlcpy, which does
the same thing and keeps gcc silent.

Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Stephane Eranian <eranian@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/n/tip-sve3b63c550wr907e6ui6gx5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
 
-- 
2.21.0

