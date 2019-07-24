Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A7C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C4021880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nm8Sm35W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbfGXXpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:45:10 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:34597 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfGXXpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:45:07 -0400
Received: by mail-vk1-f202.google.com with SMTP id g68so17754612vkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fusILKOLmxx77CwhoKkqEXw680POTmXlnL5bfavBpig=;
        b=nm8Sm35Wuj9GgaNhssIt+yIV7CWagKfpNNEb4SzzakBwRekGAqxrjYZx3fFRUtpPuI
         uu04M2hSUulDXjHYLoA6oAuNmAWTT8StE8xjpTg4E4V3O57H+FtJLbbad3H5aAsKWn6O
         7VtFi/wfaygew9Ni77sRRK9asQhzRwa4l/8lUf1OLwLnrQaAOSpX71N47ezsXgavUn2G
         sEdp7IlTeJ92OfMJWQY3uyDss/RSNdYKDrx36ihUeOPgZGeQ9HUACb6qTiT1drIKFx1A
         gmTHanGNbbKG/5TiGqFF0KDkWMlb95X5T1Ugsasp6VbIE3xU10NQslK0OWZTi2EHWLby
         5w0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fusILKOLmxx77CwhoKkqEXw680POTmXlnL5bfavBpig=;
        b=Ma4fwvzJEwRkB9f9Ut7iaXS+v1YHHa7ZcVhtzpfUBPyK9WWcRVUB/9ceapaOP+wVyi
         bf+cH+h8KMiVCmCXFTVQDb5aIU9FQvnq9lXqcs19pQrdCcDJettn+xy+GZqGmHES9mic
         ZDqbE+z5kZcT002/4QDB4BDRcLNbGv2KYVDXiee+ZBrbMrjrDym0KlKe83USzCmeSvtX
         eS8FFS5L1MnroQ4q/1+CLtGDlVlpvZcv9aENMTp+L7KYGMidnxT58EZRm6zs+w06ae9p
         oHvoAKOdjDTY6k3XOFG2YD8jvuzY7wg5OsujHHyPOAWq2g9vet1OipwDTM0u+r9sReh+
         s9cw==
X-Gm-Message-State: APjAAAWWnmz7GiS8guYZzr95EvEY5oYERP1i5IU1a9gbyFzOh3+aJPLo
        eC5R1OUPw9oESJTH//dQ69kDSRNA
X-Google-Smtp-Source: APXvYqwTAcCTJZUoDGOnxC/GWgsUF79qOLZvdB7JPxRH3YIU4xKd6bdMNBd/be9QlRC+NvJ3MwsYVLba
X-Received: by 2002:a1f:19ce:: with SMTP id 197mr33942308vkz.60.1564011906611;
 Wed, 24 Jul 2019 16:45:06 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:44:58 -0700
In-Reply-To: <20190724234500.253358-1-nums@google.com>
Message-Id: <20190724234500.253358-2-nums@google.com>
Mime-Version: 1.0
References: <20190724234500.253358-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 1/3] Fix util.c use of unitialized value warning
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

When building our local version of perf with MSAN (Memory Sanitizer)
and running the perf record command, MSAN throws a use of uninitialized
value warning in "tools/perf/util/util.c:333:6".

This warning stems from the "buf" variable being passed into "write".
It originated as the variable "ev" with the type union perf_event*
defined in the "perf_event__synthesize_attr" function in
"tools/perf/util/header.c".

In the "perf_event__synthesize_attr" function they allocate space with
a malloc call using ev, then go on to only assign some of the member
variables before passing "ev" on as a parameter to the "process" function
therefore "ev" contains uninitialized memory. Changing the malloc call
to calloc initializes all the members of "ev" which gets rid of the
warning.

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
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..b9c71fc45ac1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3427,7 +3427,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 	size += sizeof(struct perf_event_header);
 	size += ids * sizeof(u64);
 
-	ev = malloc(size);
+	ev = calloc(1, size);
 
 	if (ev == NULL)
 		return -ENOMEM;
-- 
2.22.0.657.g960e92d24f-goog

