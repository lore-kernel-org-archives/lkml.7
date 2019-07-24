Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B1DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358722189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJwrufS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfGXWuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:50:03 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42738 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGXWuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:50:01 -0400
Received: by mail-pf1-f202.google.com with SMTP id 21so29491564pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GB4nZVYWkx54T499tGW7LQ9xBxxyD8tkNT6QDgPsIdw=;
        b=qJwrufS35GNRyXEA4GiCT7sI3nbMEajGqcx0nM/PxQz7F3h0qKEUCBhoLp4B071vIK
         2ylNHen6c05PBxL+ThTJ6jeRLn9ELGca6EDaex1JP+RdJ+zC5gIWwydP5yN44RGO5c9r
         nULwodbf7xHJkbKr66uawpzSWLNXZwjObpsEtTJROUkT067SD4gfuPHRhIliSPDHeacA
         a1QeKOk1Yk+xDzPIXEHNvVOz1hxv5qN60VK1YtvlGG+yHyubKG32WB7ESu0yiky/a1Ua
         EHwuvOIEIIgMwTNCX6FpjdMj1C/n8tcYYp9keT7AmwMeXfuBGzVErEIwE2b//fcNerx7
         wYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GB4nZVYWkx54T499tGW7LQ9xBxxyD8tkNT6QDgPsIdw=;
        b=U/K6+GWkg9a71F97Lcd/D3a2oJZ4BbqZ+2tCz+x6iMaLxZdTSJm/XdhrN4lOV1JaUx
         hKSfcnfg+oWwa+r+44nbgY8mXDkvaF8MiVfJLJa8RJzTar5Dgz5Xmezaa3cNgiliBDQY
         j61yJOSUABxv+9U9xqDP+DyBtm6VTiU3pa0FzCI/gBuBSOw1FSrr+afZycSs54fl7BTg
         HfW6KsN5Hy9sNdNQihg9AJVLGhUBpaTx6RA3oLyI3QYm63+3MTquvnODq3+UkcgZ2mbD
         5HvJ7rfxbQizx6FVKMvyOVmtLOWE8/dZlSYMNoH/Lsv1G1cTlr0TH58q6MDnyDywRyE4
         ueIg==
X-Gm-Message-State: APjAAAVEHLAQJJmPSgOr3YOxbfoxGGLcNfE09f0oSRr/U4R8yGorhuiq
        4qG/E8MBXkRP6/eCndCMiYOrZKK5
X-Google-Smtp-Source: APXvYqxQ6wX0aAkyCpuXCZSxLubbYxjAgk0Kj5/3Zz2Ee5SBJulyugbbYzCrLoQ64PCzvzh9WINEIAMv
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr7868403pgi.100.1564008600166;
 Wed, 24 Jul 2019 15:50:00 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:49:53 -0700
In-Reply-To: <20190724224954.229540-1-nums@google.com>
Message-Id: <20190724224954.229540-2-nums@google.com>
Mime-Version: 1.0
References: <20190724224954.229540-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [RFC][PATCH 1/2] Fix event.c misaligned address error
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

The ubsan (undefined behavior sanitizer) build of perf throws an
error when the synthesize "Synthesize cpu map" function from
perf test is run.

This can be reproduced by running (from the tip directory):
make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"

(see cover letter for why perf may not build)

then running: tools/perf/perf test 44 -v

This bug occurs because the cpu_map_data__synthesize function in
event.c calls synthesize_mask, casting the 'data' variable
(of type cpu_map_data*) to a cpu_map_mask*. Since struct
cpu_map_data is 2 byte aligned and struct cpu_map_mask is 8 byte
aligned this causes memory alignment issues.

This is fixed by adding 6 bytes of padding to the struct cpu_map_data,
however, this will break compatibility between perf data files - a file
written by an old perf wouldn't work with a perf with this patch due
to event data alignment changing.

Comments?

Not-Quite-Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/util/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb95f3384958..82eaf06c2604 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -433,6 +433,7 @@ struct cpu_map_mask {
 
 struct cpu_map_data {
 	u16	type;
+	u8 pad[6];
 	char	data[];
 };
 
-- 
2.22.0.657.g960e92d24f-goog

