Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E1AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6822190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194334;
	bh=T2x9bULEg/34mUj2gefO5cvDfoOHE4ZTRJwwRe6QpvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mbg5+YSnwhgLkdMFlhBfDTB7QS78mbooI+91us5LM7YsWqi6hXx7MHEO5R4Hzobg9
	 EbdZ7L6J+e7B9Uh4Cut3kXsqVb1zPFFnFKnqLW2gyzqPfxDsLwQfo1rofAbqlA2lCH
	 xHeRWSEox1zK7HViBct36irjQeTPaX2H6Szw5C+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfCUSwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfCUSwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:52:12 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBD32190A;
        Thu, 21 Mar 2019 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194331;
        bh=T2x9bULEg/34mUj2gefO5cvDfoOHE4ZTRJwwRe6QpvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQCYJ+lLrr1iLH+p2kGylovxaZXMOMqxIj4u5ODIJtZpdvb6zX9RSEHUC7k9RTRwu
         +g4MehGl56wekp+/hy2+qEkYjmChnIJASQYF915SNMqDIV0Z0QysR0LnvXQymJtnpZ
         zz47KAbOB3AFl5iMFK5VE1FrZcnJL0FVv/bWNfjc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/44] perf report: Indicate JITed code better in report
Date:   Thu, 21 Mar 2019 15:51:03 -0300
Message-Id: <20190321185142.11441-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Print [TID] tid %d instead of the crypted /tmp/perf-%d.map default.

% cat >loop.java
  public class loop {
          public static void main(String[] args)
          {
                  for (;;);
          }
  }
  ^D
  % javac loop.java
  % perf record java loop
  ^C

Before:

  % perf report --stdio
  ...
      56.09%  java     perf-34724.map      [.] 0x00007fd5bd021896
      19.12%  java     perf-34724.map      [.] 0x00007fd5bd021887
       9.79%  java     perf-34724.map      [.] 0x00007fd5bd021783
       8.97%  java     perf-34724.map      [.] 0x00007fd5bd02175b

After:

  % perf report --stdio
  ...
      56.09%  java     [JIT] tid 34724     [.] 0x00007fd5bd021896
      19.12%  java     [JIT] tid 34724     [.] 0x00007fd5bd021887
       9.79%  java     [JIT] tid 34724     [.] 0x00007fd5bd021783
       8.97%  java     [JIT] tid 34724     [.] 0x00007fd5bd02175b

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
LPU-Reference: 20190314225002.30108-7-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-r17l6py9g0sezb7mi1f286gt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ba58ba603b69..ab8a455d2283 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1141,28 +1141,34 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 
 static void dso__set_basename(struct dso *dso)
 {
-       /*
-        * basename() may modify path buffer, so we must pass
-        * a copy.
-        */
-       char *base, *lname = strdup(dso->long_name);
+	char *base, *lname;
+	int tid;
 
-       if (!lname)
-               return;
-
-       /*
-        * basename() may return a pointer to internal
-        * storage which is reused in subsequent calls
-        * so copy the result.
-        */
-       base = strdup(basename(lname));
+	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
+			return;
+	} else {
+	      /*
+	       * basename() may modify path buffer, so we must pass
+               * a copy.
+               */
+		lname = strdup(dso->long_name);
+		if (!lname)
+			return;
 
-       free(lname);
+		/*
+		 * basename() may return a pointer to internal
+		 * storage which is reused in subsequent calls
+		 * so copy the result.
+		 */
+		base = strdup(basename(lname));
 
-       if (!base)
-               return;
+		free(lname);
 
-       dso__set_short_name(dso, base, true);
+		if (!base)
+			return;
+	}
+	dso__set_short_name(dso, base, true);
 }
 
 int dso__name_len(const struct dso *dso)
-- 
2.20.1

