Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8F8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8EA206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=akdev.xyz header.i=alex@akdev.xyz header.b="A0Q4j9Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388095AbfIVRDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:03:15 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17518 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfIVRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 13:03:15 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Sep 2019 13:03:14 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1569170855; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=WFig74vLMu+XHYEloXsjvZ07TUJN+d/aOzKfALCgPi+pMOpWIEhcITAklpfc9JAosy/UUukTjM0lLhQen8b622sH53nZ8EY93BlKu/GnuWa3ls7RSCdJKZSLuuFDxBZS0Y9CdWFspAzSYjTnJMLvMWxQUC8QJfk6amLHHbmcRd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1569170855; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=ouXD4BPk46j/EG0Djm0iTXK1i7gnPkmpqq+yXhTdxOw=; 
        b=kQLE+z0y8j6r5+pomGL7XBahD3ZdnKpUPkeyCVuCo1qJIdfiiem9Rt0EnBMaat1XoRLT9rmvYwaeAH4q2PdYrdBr1+nSIpO73Mk4tere+hsNdTCJDKukdDXgw81u4h+SRNQrA3f4h/2+nMzYYqGIWhQDcKan5npjuQ6SEYrwFdg=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=akdev.xyz;
        spf=pass  smtp.mailfrom=alex@akdev.xyz;
        dmarc=pass header.from=<alex@akdev.xyz> header.from=<alex@akdev.xyz>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1569170855;
        s=akdev; d=akdev.xyz; i=alex@akdev.xyz;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        l=2765; bh=ouXD4BPk46j/EG0Djm0iTXK1i7gnPkmpqq+yXhTdxOw=;
        b=A0Q4j9Q/Boxhd/E8o8thpdDcFE9G98nLQ5ikSw8rNWg96rv7A/Wd+ar+gyV4vTMT
        Wn97lyS4sqyhz+JIZhXyZ2tvs2bB6eI7QRfuIFz0ZXd2WL3jlP02vzhSNWQ4QXp7OwQ
        V6smcStL5qyuLwzPKaTfZ8b8oQi2F5gpD/VLxZyU=
Received: from home0.donatello.akdev.xyz (toroon0628w-lp140-06-70-29-14-208.dsl.bell.ca [70.29.14.208]) by mx.zohomail.com
        with SMTPS id 1569170853302706.4286020481102; Sun, 22 Sep 2019 09:47:33 -0700 (PDT)
Date:   Sun, 22 Sep 2019 12:47:30 -0400
From:   Alex <alex@akdev.xyz>
To:     linux-kernel@vger.kernel.org
Cc:     namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, mingo@redhat.com, peterz@infradead.org
Subject: [PATCH] perf: save RAM when filtering events
Message-ID: <20190922164730.GA16336@home0.donatello.akdev.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code mentioned wanting to use an implementation of log10() in the dvb
drivers. I am not aware why that specific implementation is mentioned.
I used the implementation found in `math.h`.

I tested this patch passing 200 syscalls to filter on a `perf trace -e ${syscalls} ls`
call. You can see the commands used and a snipped of the valgrind results here:
https://termbin.com/k4of

Before: 61,910,110 bytes allocated
After:  61,907,045 bytes allocated

perf used to allocate space in excess to build the filtering expressions.
now perf only allocates the space necessary and not more.

Signed-off-by: Alex Diaz <alex@akdev.xyz>
---
 tools/perf/util/string.c  | 25 ++++++++++++++++++++-----
 tools/perf/util/string2.h |  2 ++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 52603876c548..4c3913a9e7e7 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <stdlib.h>
+#include <math.h>

 #include <linux/ctype.h>

@@ -209,15 +210,29 @@ int strtailcmp(const char *s1, const char *s2)
         return 0;
 }

-char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
+size_t calc_expr_buffer_size(const char *var, size_t nints, int *ints)
 {
         /*
-        * FIXME: replace this with an expression using log10() when we
-        * find a suitable implementation, maybe the one in the dvb drivers...
+        * Calculate the buffer for the expression:
          *
-        * "%s == %d || " = log10(MAXINT) * 2 + 8 chars for the operators
+        * "%s == %d || "
+        * length: strlen(var) + strlen(" == ") + log10(n) + strlen(" || ") + 1
          */
-       size_t size = nints * 28 + 1; /* \0 */
+       size_t size = 0;
+       size_t num_len = 0;
+       const size_t var_len = strlen(var);
+
+       for (size_t i = 0; i < nints; ++i) {
+               num_len = (ints[i] == 0) ? 1 : log10(ints[i]);
+               size += var_len + num_len + 9;
+       }
+
+       return size;
+}
+
+char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
+{
+       size_t size = calc_expr_buffer_size(var, nints, ints);
         size_t i, printed = 0;
         char *expr = malloc(size);

diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 708805f5573e..28fbc782ad54 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -20,6 +20,8 @@ static inline bool strisglob(const char *str)
 }
 int strtailcmp(const char *s1, const char *s2);

+size_t calc_expr_buffer_size(const char *var, size_t nints, int *ints);
+
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);

 static inline char *asprintf_expr_in_ints(const char *var, size_t nints, int *ints)
--
2.21.0


