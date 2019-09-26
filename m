Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF5BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D79C2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qm6Ka8XF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfIZWAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:00:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47756 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfIZWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:00:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id m8so358945plt.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bCbqqLM7S8rOLTcc9iCOHJKBH6aI/F5j7ap0NruyIMM=;
        b=qm6Ka8XFuzIrDtkzxAhNjGZiV6c3FEGaqpyDYDJDX7Ue4nFLiNFjTo+cAXEvk/y5em
         ILYPYGnHOeJ+34pTFhATMMXiKODqnyjFMbFG6WqO7+Ud/La2kTYxDQNtvPwdgAXcXpaB
         GrIQYOsArsm51VgMD9B6ckmT9EYnnGdqQFADHayw2SvkfLf38d3bJ95kM2DWh78HQk9y
         +VmOduGhimTDqPz2JYHb9Zay03+nXgWTaomUv4NXVAbJqXAGZz8g/TqbFzZAEg3VHJpZ
         rscLtG42teOI5HNsJntU9Y+b04+quwyNtH4xF+t1/R3Hnl+7kNyT0oFWH1mmPP/TnNBc
         6o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bCbqqLM7S8rOLTcc9iCOHJKBH6aI/F5j7ap0NruyIMM=;
        b=NfUG9EA6efsPIzp7zRRr3oho2TUU1ICzDEc3VIc2wHgz9ThZSNVpgUhTYTZrCa5ag2
         j63ia9YQ9P9uXPLHjVRDDoXZYmPREd0UdZL73Qp0SCUbmEFAXHdQk3vmcA9PVf60uMrP
         p+FcXkl8zKdb5WrkU+XWBlQNWjIsPe/fXq4lIFAK4RRuPP5bUhxmOaiY5LdkHqnLFLOU
         Tn4zVN35Xfm/T6CcoDf5OKDDs08hWbMpgTHlUHox7eWC5H8/g6nx966jY971byr+5qbE
         4cFLJ75TreTGOajBHASyEQlKrjheR05PCgaDtszS1CXCbOOi6xFaivs2UTamy7lOFS7Z
         SB/Q==
X-Gm-Message-State: APjAAAXaYntQRGOQdDDl/nwxmR6sKvmRffpJcrLQ8oWx0TGQ3MRl1ehV
        6mAuRa7x2rCx/Ie17iAc7uTj05x6SkPw
X-Google-Smtp-Source: APXvYqzF9ls9jFtPt4Bo8sqTqcF7pSvzqw37MtXIK4BA+opwK8Oul9GHpLeb9iuo0X9lM1ixzpj2kgeohBr2
X-Received: by 2002:a63:3c46:: with SMTP id i6mr5553457pgn.18.1569535229862;
 Thu, 26 Sep 2019 15:00:29 -0700 (PDT)
Date:   Thu, 26 Sep 2019 15:00:18 -0700
Message-Id: <20190926220018.25402-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH] perf llvm: don't access out-of-scope array
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_dir is assigned to the release array which is out-of-scope 3 lines
later. Extend the scope of the release array so that an out-of-scope
array isn't accessed.
Bug detected by clang's address sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 8d04e3d070b1..8b14e4a7f1dc 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -233,14 +233,14 @@ static int detect_kbuild_dir(char **kbuild_dir)
 	const char *prefix_dir = "";
 	const char *suffix_dir = "";
 
+	/* _UTSNAME_LENGTH is 65 */
+	char release[128];
+
 	char *autoconf_path;
 
 	int err;
 
 	if (!test_dir) {
-		/* _UTSNAME_LENGTH is 65 */
-		char release[128];
-
 		err = fetch_kernel_version(NULL, release,
 					   sizeof(release));
 		if (err)
-- 
2.23.0.444.g18eeb5a265-goog

