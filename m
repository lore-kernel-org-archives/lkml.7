Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2978821880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXwWy+39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfGXXpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:45:13 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:55823 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbfGXXpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:45:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so29528733pfo.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MwRccX2MBD2s53mippQSnbtUA99Ul/BghITn/o0J/7s=;
        b=XXwWy+39F2zSYwp+44oymQtRU9nfFSYpzoyOW3zyX87oNyHUSpeayXgtkJDadzqAKj
         xw0YEiesKneQ/x27MqvOSqM81x/32LffuS8z8PQIT8CEilihzPKm1GoA052p698xdVrT
         iSkjwFx1v2YstV0a8sUkjWm9RLInR5TgKMcaIsMJcLLTXK7CkyBTMD4QhW9DxFfXjpxm
         WFn0xRaLgZlWqwKD1DVYu2wXEXaUpOzr85lYBz9Rtq/bk6M26ASqX0OWsGHsHpj8Vqz5
         3zHQ00GMq4GV4l7OmHFkZvtEW4COcOudGLDNFk6z1X+KmpmJJP22tRBq3LQHIO2D6rNz
         fxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MwRccX2MBD2s53mippQSnbtUA99Ul/BghITn/o0J/7s=;
        b=J5RcLSpb8q9wNcAkNM+pNNPaIE8WCBZhNoymRRAmJz/Ia9gMJ3MlGd/JYEMc5xAafj
         /oCkc8Od2BwJxoEavTqDFkJHwwJ5sjueBKvVG9KQo5Mi4f8qXt1MmxENxPaDerXteh8g
         FM61wwCL3JTXm6zy9zBg0x+JT+uZW0gPfGz/J59aJ/2In11eJ1RutRrItRvKV+VFaaBV
         QRWc9KZpoR0KwXToLLgZVK7aVsQYsWCuxcLkWBghqMkhU9s0Nv8Bxa8Q2JcS88damo7s
         VZhzdlZq0Uu61G8CpLqPmDVoDYqRtf0EYdBv5M2bs59u42+Ln3M/RK78WhbkelZyh9Xi
         svjQ==
X-Gm-Message-State: APjAAAVtuAi4WIA0fLVfPX9knjY0Oebx8SZQZuUvUfk68NyItiwwCQFN
        rBLnB64chYBYsuyZs7R3aV32P1Ip
X-Google-Smtp-Source: APXvYqyRcHTgXyIjEqH4UKcQSEn1sTT4owsSpoPJ1qS1eyz0030j9XqW5ri/juR5wOxZ4G4eZoOBhS/j
X-Received: by 2002:a65:57ca:: with SMTP id q10mr86291825pgr.52.1564011908747;
 Wed, 24 Jul 2019 16:45:08 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:44:59 -0700
In-Reply-To: <20190724234500.253358-1-nums@google.com>
Message-Id: <20190724234500.253358-3-nums@google.com>
Mime-Version: 1.0
References: <20190724234500.253358-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 2/3] Fix annotate.c use of uninitialized value error
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our local MSAN (Memory Sanitizer) build of perf throws a warning
that comes from the "dso__disassemble_filename" function in
"tools/perf/util/annotate.c" when running perf record.

The warning stems from the call to readlink, in which "build_id_path"
was being read into "linkname". Since readlink does not null terminate,
an uninitialized memory access would later occur when "linkname" is
passed into the strstr function. This is simply fixed by null-terminating
"linkname" after the call to readlink.

To reproduce this warning, build perf by running:
make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
 -fsanitize-memory-track-origins"

(Additionally, llvm might have to be installed and clang might have to
be specified as the compiler - export CC=/usr/bin/clang)

then running:
tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
 -i - --stdio

Please see the cover letter for why false positive warnings may be
generated.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/util/annotate.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..d8bfb561bc35 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1627,6 +1627,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	char *build_id_filename;
 	char *build_id_path = NULL;
 	char *pos;
+	int len;
 
 	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
 	    !dso__is_kcore(dso))
@@ -1655,10 +1656,16 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
 		dirname(build_id_path);
 
-	if (dso__is_kcore(dso) ||
-	    readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
-	    strstr(linkname, DSO__NAME_KALLSYMS) ||
-	    access(filename, R_OK)) {
+	if (dso__is_kcore(dso))
+		goto fallback;
+
+	len = readlink(build_id_path, linkname, sizeof(linkname));
+	if (len < 0)
+		goto fallback;
+
+	linkname[len] = '\0';
+	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
+		access(filename, R_OK)) {
 fallback:
 		/*
 		 * If we don't have build-ids or the build-id file isn't in the
-- 
2.22.0.657.g960e92d24f-goog

