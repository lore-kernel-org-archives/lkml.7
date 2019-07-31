Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB765C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B162089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQEb+Jko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGaAkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:40:37 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50695 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfGaAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:40:37 -0400
Received: by mail-vk1-f202.google.com with SMTP id p196so28658328vke.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BApBF9lDyDUHtKy92pMwude8bSQOUkXYIpIspp3IQpA=;
        b=EQEb+JkoCSxT4aLpwLuHjX/vwl8+Y5yqjAP9jWQbUxf5GHiW1S2JZvjEsZ10Q+eLOR
         5z29NQVjneEdlpoPyLpPkcqAl5p8cFacARBYXR1z8HOVLzX3dIete7sgazGKuXnoxB+h
         l3UT4vT6MgU4yQmQpKmSE7xRMogz+slMR76BWuiKwEa7QK3CSn2atU5JtacA6VGRAtWp
         1U1OoAXxfAFOc1j8QLZX0Reazdmj6mWykhiRlLBLDGIRE9EWXzUhdjXDqe6LpKfqwzaT
         VpMcFliKUFgSdABibDpwnSPEJ989GGLRuHH+LBYnGuW6ph4tPiCxHW7oriL4hHPd8gTG
         j4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BApBF9lDyDUHtKy92pMwude8bSQOUkXYIpIspp3IQpA=;
        b=sAO8oyMB2G4U88v4rPKZl+5XytaYm9pmR0aRQELp1BDGU5h5zIi92OPcqMHgPzNus/
         qMecDD36w0vnAASdWwdQF3nYd4x6Ck7ujHkMsdHSAexKNcg2NdrNAJ+l4xeUNbY6tcZG
         suw1BoYo4Jn7DEcbaX5XdmQRPBZtCaz+Ih4pDTvCrxs3qt/vwi21bXrs9AdyaLROZgYi
         zsydkVD8TDeWOBgfk4i20Hv8JGfjby8BP4DGOJ1sIBjJOH3qcUimPMpaE3sTJSNMS+h9
         aDEg0onWmeCMxqPDbKf4KG3rk5NswGEV6tdp9n6AYz9ChZvtqs30Z9zD1XbFroRosjBs
         mvIw==
X-Gm-Message-State: APjAAAVA1Axocz9Cr5XOLCXtSHm4+qpWJFCfdC6SQIApJt8DtDCbDgGy
        2tFkp1YWRlkBeLwr8WfvKt9Y3Os2
X-Google-Smtp-Source: APXvYqwTwkwL1hlmyLhTuy1zLhvS74jx8z9oxy/e1/EDzKMbe5NvoecvOF4q+3mKTl/fzNchnvONdgAF
X-Received: by 2002:a1f:f48f:: with SMTP id s137mr8990000vkh.10.1564533635841;
 Tue, 30 Jul 2019 17:40:35 -0700 (PDT)
Date:   Tue, 30 Jul 2019 17:40:32 -0700
In-Reply-To: <20190726192859.GG20482@kernel.org>
Message-Id: <20190731004032.74676-1-nums@google.com>
Mime-Version: 1.0
References: <20190726192859.GG20482@kernel.org>
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

