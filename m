Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FEBC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C8D21880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1lXYQsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfGXXpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:45:05 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42089 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfGXXpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:45:05 -0400
Received: by mail-pf1-f202.google.com with SMTP id 21so29577427pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GsusRCebKftTZon46v3ZWIHJN0uYkKUK209eUAX0ooM=;
        b=B1lXYQsc/LR94o2K8zpnGLTTgfWtDcLlDAn0OQ7TSesRexUMZCK2ldktGPUDi3v24L
         UQKCPpY38Wwesil6AX13EJvvDVC2l1UFjEmMIw70UEZ+DcN5s2p2/mPTT+nI+XlrbwV0
         uU8i6zW0eTXqSpG9fMwKuChsZHG/ghe+h1Tn7JO4noRWe9LQse+7A2GLxBPLPs8MuVcS
         XaXNlQdg5SgrUyRsYwN+2GJm/OrOJv0zU70rPQvwTsR9yeInU2S2S2MsGt7vJIzFBoai
         KekF9eidTCSCWbLBuCBwIbLe58ePuTZjAcefIqkXirP4P6dD8f6wl1btQg8Wf2pWngc4
         1enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GsusRCebKftTZon46v3ZWIHJN0uYkKUK209eUAX0ooM=;
        b=dUeQ/1w9QUZvvHV2vg4R8djq8aOpdhq5tMxXrNCSPB9tO+tIDYsif36Roh2WoRBz8R
         Eml7JpzaIohXvZtbrjMLxtlwKezx6BulVzAZ60G1QGridBvXSvFkRdwB378m5hs7fEQa
         YMtP9s9i9dIMCnsXtUm4Z/Oyc+wVrTZ8fpg95GPOtqkjub1xl473EXXOUO1v3VQpGHPd
         Gth5ei7NyIVJJ8Ny1bb440Eo60K75o9j14HioCg1d8cvcLSmZxFaVBQfa30N2Sz18EfK
         iT6LLsk+WJv1kT0yuotpGVFsgo5tRDezq0MmxFDniMv5QQEcKEFgEIrjIETumkfxZfBd
         iTPQ==
X-Gm-Message-State: APjAAAUdYQR5foe5FvA1LBvaorniqwzjgSOeYTau0FfHrjJlk3To2E8u
        21WuXFjkCoC387wycfA9HdgOZx1n
X-Google-Smtp-Source: APXvYqw6hUOHUkcFR49i4DzhDdF0tm+5r6GTEibaj0QMkvIZmrIIcmwscukh0UoEEARYZzwvJttkwEWy
X-Received: by 2002:a63:7a06:: with SMTP id v6mr84513475pgc.115.1564011904078;
 Wed, 24 Jul 2019 16:45:04 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:44:57 -0700
Message-Id: <20190724234500.253358-1-nums@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 0/3] Perf uninitialized value fixes
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

These patches are all warnings that the MSAN (Memory Sanitizer) build
of perf has caught.

To build perf with MSAN enabled run:
make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
 -fsanitize-memory-track-origins"

(The -fsanitizer-memory-track-origins makes the bugs clearer but
isn't strictly necessary.)

(Additionally, llvm might have to be installed and clang might have to
be specified as the compiler - export CC=/usr/bin/clang).

The patches "Fix util.c use of uninitialized value warning" and "Fix 
annotate.c use of uninitialized value error" build on top of each other
(the changes in Fix util.c use of uninitialized value warning must be
made first).

When running the commands provided in the repro instructions, MSAN will
generate false positive uninitialized memory errors. This is happening
because libc is not MSAN-instrumented. Finding a way to build libc with
MSAN will get rid of these false positives and allow the real warnings
mentioned in the patches to be shown. 

Numfor Mbiziwo-Tiapo (3):
  Fix util.c use of uninitialized value warning
  Fix annotate.c use of uninitialized value error
  Fix sched-messaging.c use of uninitialized value errors

 tools/perf/bench/sched-messaging.c |  3 ++-
 tools/perf/util/annotate.c         | 15 +++++++++++----
 tools/perf/util/header.c           |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog

