Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98212CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 04:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6AC21D7F
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 04:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuXXaXhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJZD4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 23:56:50 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53877 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfJZD4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 23:56:49 -0400
Received: by mail-pg1-f202.google.com with SMTP id r25so3304169pga.20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b8LgIDS8uYjP7Q7TgawjsrLFtXCRjRoP6jkAJEh906U=;
        b=JuXXaXhXi+nTGs7zojcMItpPlj49E0LFJQLKeN1yOcaR7vz5g8dsTeMg9BgpBWUoIr
         u7cOunX1hTpkI877x2ozjmFSBInn+9P4xHvBtxutgJX+tCm+8T33NDevMD9NvSkeaqnZ
         hkw22b/iTEpegxUYXDqkatzCgVNoYQrdl38bmcQfHJtPuZPicejyiRLy7OJpINQVVqiU
         4IkGJQwVY4J3E9XfdBeyb95jUc1b43VpJ7/nFMiQbEdUDIOUNruBJ4lFGipoQWAb270l
         CW/fIVe7BTSRvInBVpBfvckchZZCRfIvjMXKSYgG4UAh5CphaPqNY9i6P/6GSx7ki3sM
         2j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b8LgIDS8uYjP7Q7TgawjsrLFtXCRjRoP6jkAJEh906U=;
        b=Gfgfxu9MUkS1OJGIuGka3g5i2/5UgyJ5X8qZDEqqBO4OF+6ZSN5VmO33hUiYYhK3sr
         sjEjKL21kPCBr4uRJoQrXWP7f1u37sKHvnVoqHXlbwMmHU/94gR+BOTO/I3ROCFvvx3Z
         STZZbu3tzKh2rbMCXqaqFprG6l6XJsM97Yr3QbqlP2oEW4aWq05VtFVfQ1NR7fZhRgVo
         dnvKP838u0MeDT9Ob0q4VkgiUWzHeo21mFth+4CgXcYF4xnuVw0S+k3p6ZZCtFwzd/fm
         bAiaHJQu063lS75eQ0/LnCJ2oanGjM1TndGwEv8VFM968W9jlRezU23JebkWSMWKGCS2
         PgTA==
X-Gm-Message-State: APjAAAXtUiJpva5x+5DfMQZA11Yg6KzjZOV6dXLwlKyoMvblZ+QBnsKH
        8S9Rtgh09WI2jh34+Ce+xeQ7xCaH6J2k
X-Google-Smtp-Source: APXvYqx1yy33o8DVIsHjxflPNZrSq5klgCFfoDCd6f3P7ruCHL+9fxCmvf16XQozmxgneRc9zEgPh0Ancsbw
X-Received: by 2002:a63:1a51:: with SMTP id a17mr8083130pgm.449.1572062208614;
 Fri, 25 Oct 2019 20:56:48 -0700 (PDT)
Date:   Fri, 25 Oct 2019 20:56:44 -0700
Message-Id: <20191026035644.217548-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH] perf annotate: fix heap overflow
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix expand_tabs that copies the source lines '\0' and then appends
another '\0' at a potentially out of bounds address.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ef1866a902c4..bee0fee122f8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1892,7 +1892,7 @@ static char *expand_tabs(char *line, char **storage, size_t *storage_len)
 	}
 
 	/* Expand the last region. */
-	len = line_len + 1 - src;
+	len = line_len - src;
 	memcpy(&new_line[dst], &line[src], len);
 	dst += len;
 	new_line[dst] = '\0';
-- 
2.24.0.rc0.303.g954a862665-goog

