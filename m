Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25075C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E164626550
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559289795;
	bh=6hOtfuDExb5PDoLp9lxC1p8wLpTkDlqkAWi1NN98OBw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Lc0NxOfeFXEuuchgFRI8lE6YWkFcaYZmbPOKDilsGEVb5LJZ0u17U/TVY0ISZNtq7
	 yRcpxn3fpEo5THZxehA8DlgnbBCVcPa9gW9guex2wgqDiCLWpoSPOCeipkFlyGb7iy
	 a5aRZctvGZjo1BTY/LEP5MWp0PrIPoXw7sDVW/XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfEaIDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63629 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfEaIDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E3C83082E6A;
        Fri, 31 May 2019 08:03:11 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3E907C55C;
        Fri, 31 May 2019 08:03:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ben Gainey <ben.gainey@arm.com>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf jvmti: Fix gcc string overflow warning
Date:   Fri, 31 May 2019 10:03:07 +0200
Message-Id: <20190531080307.22628-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 31 May 2019 08:03:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

First I wanted to disable the check, but now I think the code
could be more straight forward. There's no need to check the
source size, strncpy will do that. We just need to make sure
the string is correctly terminated.

Cc: Ben Gainey <ben.gainey@arm.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-sve3b63c550wr907e6ui6gx5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/jvmti/libjvmti.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index aea7b1fe85aa..00fa0b7f1ad9 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -162,8 +162,8 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 		result[i] = '\0';
 	} else {
 		/* fallback case */
-		size_t file_name_len = strlen(file_name);
-		strncpy(result, file_name, file_name_len < max_length ? file_name_len : max_length);
+		strncpy(result, file_name, max_length - 1);
+		result[max_length - 1] = 0;
 	}
 }
 
-- 
2.21.0

