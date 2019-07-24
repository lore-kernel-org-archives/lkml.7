Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C87C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CEC2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2bsae63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfGXWt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:49:59 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54946 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGXWt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:49:59 -0400
Received: by mail-ua1-f74.google.com with SMTP id c21so4949894uao.21
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Fw1C3R9hSasyzIXJTKVtbRAdTF9SVma4v9C5XlFKOn4=;
        b=b2bsae63RuASUzg2AQusA3JyqxrpIjYnaeOjpr3pxHZPbr+hIn03dVK+6QWaRBfHPK
         W+oUJIyIc8N3a4ISX2sh+mTCuq2YEWdIy6iT7M8mmbY17kLJMfJiJPx1rZZeaXuViFj6
         ovilSncNgM5GrruY+Ayb9kScp2iCfPTpfKA4rCtdMdF/ugGF4uspobrE4XjE5CnTUGGg
         Cp+60mvb2FwRpq6Uno0154Lj/Og4+YhFxiWQQvEameLfEFfnQQGHQ5HIvCQKHfK9Ewsp
         SDFxsmszwGkP0AMHpLt8a2irpgcPVP6vjGTjDsERmsAlg+ip/7vTMIg0L+qC7BmRMeWN
         XP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Fw1C3R9hSasyzIXJTKVtbRAdTF9SVma4v9C5XlFKOn4=;
        b=UrsI1Go9iDFeqDVh9pcWFGMM84Yaj96Z8IDnzoo6P3+ngkQNW8EHfl4m3s8gAX+fW8
         YXcWkWBSUdxo5+C8IpMIEqrrIBuafNP9bB3rrBmPzFqPNU9nVszZEpX7+dutYQpoRQOD
         6J4V8l8f2ccAL8jgj/MeQGkLJbV52BVUmNvEuX/pKULNDFfe++/PNM+z/LuSoAmlh6ty
         Nc0d4G+O+ajiCVzRODU9FbpPqyqQrq2mWGgRBlqtKpr2uKdBvae5CJ/YiYyqGfKKwJvu
         bOjJkd50zoF9EpGobBVhCWykw8PVMB2OGDfaH5h1C7J3B7q5kZXCaJx8HoxZu8fDGFjt
         kRMA==
X-Gm-Message-State: APjAAAXgTjR9jhMCkIEhLVAkbBtngp8UDgZ+sPjpOT9mCkSJGvHUT8F2
        BGShk5Nn16Ou3rlpD/KisgKXzVmT
X-Google-Smtp-Source: APXvYqwZs2/0SU0N2Sm/CL0l7fjZm5niEN3hNW3PGTYwbQ1S2LcXZV96g8k74zDIWTQFR7c1gTBZv2EY
X-Received: by 2002:a1f:7383:: with SMTP id o125mr34463923vkc.6.1564008597898;
 Wed, 24 Jul 2019 15:49:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:49:52 -0700
Message-Id: <20190724224954.229540-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [RFC][PATCH 0/2] Perf misaligned address fixes
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

These patches are all errors found by running perf test with the
ubsan (undefined behavior sanitizer version of perf).

They are solutions to misaligned address errors caught by ubsan
but they would break compatibility between perf data files.

To build perf with ubsan run:
make -C tools/perf USE_CLANG=1 EXTRA_CFLAGS="-fsanitize=undefined"

Perf will throw errors that have been fixed in these patches
that have not yet been merged:

https://lore.kernel.org/patchwork/patch/1104065/
https://lore.kernel.org/patchwork/patch/1104066/

Please feel free to leave comments. 

Numfor Mbiziwo-Tiapo (2):
  Fix event.c misaligned address error
  Fix evsel.c misaligned address errors

 tools/perf/util/event.h |  1 +
 tools/perf/util/evsel.c | 28 ++++++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

