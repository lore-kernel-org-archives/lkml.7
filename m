Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B8BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070C321019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e5mfFg12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfE1VWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:22:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfE1VWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:22:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLM1M72237976
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:22:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLM1M72237976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078521;
        bh=f+4W27vhUL8fo8dUsS4ywI0vLT6dsv+HxQ9U8CgAIPo=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=e5mfFg12ze1UtXTplLxWrlpGB60Pg4jCmpZ1CW/MxqRTKEggLM3b5Tj/O+UM0/STX
         5T9Xmt4xcx+dKN6HnRstDLZJWos0iwhyCkFPuk0wc/b3PxzdbjgSMjNgNPjXiNZVDs
         ZnaIK8iN6otkbOjl8vJAf/7QzQQ2l9w9pssOBbOZdXQZJdsMdOX6arfSBi4ROOuzUN
         tBSyqu8Hgdgx9OErFHSwJ9ByxPlTC/SVQh1UAbeVgQltXLB8L8DsLXqCPYsDxhvjug
         t9qMCJov21wQcOVPAnZnV1y0+jBnQ6N7rhXGXs/thAFAqa4oywwiwvcHfDoGO9sINK
         JwoxokTeO7JjA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLM0jo2237970;
        Tue, 28 May 2019 14:22:00 -0700
Date:   Tue, 28 May 2019 14:22:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shawn Landden <tipbot@zytor.com>
Message-ID: <tip-289f1jice17ta7tr3tstm9jm@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, shawn@git.icu, adrian.hunter@intel.com,
        namhyung@kernel.org, jolsa@redhat.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, shawn@git.icu, adrian.hunter@intel.com,
          namhyung@kernel.org, jolsa@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, acme@redhat.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Fix 'strncat may truncate' build
 failure with recent gcc
Git-Commit-ID: 97acec7df172cd1e450f81f5e293c0aa145a2797
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

Commit-ID:  97acec7df172cd1e450f81f5e293c0aa145a2797
Gitweb:     https://git.kernel.org/tip/97acec7df172cd1e450f81f5e293c0aa145a2797
Author:     Shawn Landden <shawn@git.icu>
AuthorDate: Sat, 18 May 2019 15:32:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

perf data: Fix 'strncat may truncate' build failure with recent gcc

This strncat() is safe because the buffer was allocated with zalloc(),
however gcc doesn't know that. Since the string always has 4 non-null
bytes, just use memcpy() here.

    CC       /home/shawn/linux/tools/perf/util/data-convert-bt.o
  In file included from /usr/include/string.h:494,
                   from /home/shawn/linux/tools/lib/traceevent/event-parse.h:27,
                   from util/data-convert-bt.c:22:
  In function ‘strncat’,
      inlined from ‘string_set_value’ at util/data-convert-bt.c:274:4:
  /usr/include/powerpc64le-linux-gnu/bits/string_fortified.h:136:10: error: ‘__builtin_strncat’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
    136 |   return __builtin___strncat_chk (__dest, __src, __len, __bos (__dest));
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shawn Landden <shawn@git.icu>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
LPU-Reference: 20190518183238.10954-1-shawn@git.icu
Link: https://lkml.kernel.org/n/tip-289f1jice17ta7tr3tstm9jm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index e0311c9750ad..9097543a818b 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -271,7 +271,7 @@ static int string_set_value(struct bt_ctf_field *field, const char *string)
 				if (i > 0)
 					strncpy(buffer, string, i);
 			}
-			strncat(buffer + p, numstr, 4);
+			memcpy(buffer + p, numstr, 4);
 			p += 3;
 		}
 	}
