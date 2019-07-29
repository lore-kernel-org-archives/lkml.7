Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B265220657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBDPtnbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfG2U56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:57:58 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45284 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfG2U54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:57:56 -0400
Received: by mail-pl1-f202.google.com with SMTP id y9so33865104plp.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BApBF9lDyDUHtKy92pMwude8bSQOUkXYIpIspp3IQpA=;
        b=YBDPtnbLOaDIZ32zQrem6Tg6fvI9ktw3miPRNDTLwvUqYnnUr49flmT4t6947OxrnF
         67rOusbkgcVLnWu+Zo3pyV+f56esS7HKcDhmtASU3kei4n7q4vAdAco6TYgjDU2lpgKV
         18b6Or8UWO8gScO5qSzAPKiup/SzEeV5T8ENJXf6x/+oWa2zHJWiBjijX5LB3zx1W4k3
         jv0TIW1SWLiX+XTErkt3L7VaFh8h12/cNcdHb5zqS5FpaeNsHoZ1GzmO2z3qPAdPRxAD
         JCI3qE3hALJoWmD64vskGSnYlmk6USzDTpxegiLgRapxdsqRStbgmGJKTBHj70icp04V
         J/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BApBF9lDyDUHtKy92pMwude8bSQOUkXYIpIspp3IQpA=;
        b=aRUB9DQmn8VBIOblk/byi3WDC2tf5AhMXnXV/wP0NufsPpbFNVPKTye4tWENiRPjNy
         YPCQhQ5EfDUzPIkPiy8/rGtkSx7Eag4HnSf9S9fH7yZgY0AfTv/WYqac29g2Vg9uvqin
         IB6ff50NoNXJtKv7GCYyPLPShGzsfWmvy6BSq+75nh70n0CU8CdTnuUid2x9tt+N7jhX
         7LWhoCwxs/wuhzovmZi21x/+Gg8LvJbH11OQUn3zwEEPVLbI88kTYZDH3w97RfQquKaH
         8B+kkFek+uNcwvfwwn4DJ47AQ9U3oF400vB9qi+expgqDz+I97YfH9CBgXYN0IVwU54R
         Eu+A==
X-Gm-Message-State: APjAAAXPunMMUbxo2wM4Eb5Ylkq9b7Ug/qt21+Kx3BiV4h3NaDb2EZ/3
        Y2P20VdvKSItKSsyLG+9bAM3VP7I
X-Google-Smtp-Source: APXvYqxpU7HIKbLo26FiBb7vEN5Gw6pEK3HyNip6jO2J1tE5yUrNzkbW7tuCl6SZ1UyQNqzhJxbRE0Wp
X-Received: by 2002:a65:500a:: with SMTP id f10mr75139654pgo.105.1564433874773;
 Mon, 29 Jul 2019 13:57:54 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:57:50 -0700
In-Reply-To: <20190726194044.GC24867@kernel.org>
Message-Id: <20190729205750.193289-1-nums@google.com>
Mime-Version: 1.0
References: <20190726194044.GC24867@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2] Fix annotate.c use of uninitialized value error
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
index 70de8f6b3aee..e1b075b52dce 100644
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
+	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
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
2.22.0.709.g102302147b-goog

