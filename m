Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A883BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7551121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qz+quXRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfDXXMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:12:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39184 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfDXXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id e92so8272330plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XNY7yvILZ/mReUfkQVV13kVtI29W9jkvFr1lkWc9JCQ=;
        b=Qz+quXRCJ5OD2ub/SSRZDu4LRm/DXnzA7t898qR6yeul7uWOamJCOroVor8XzbDmxQ
         aHBgg4fMXmjRY6Q9M5c80JX2Fe7V+z8wPv1ZaXqmUksQKcvq+ZNOfBeQIKUoE0RZSXsV
         S/6zTvJuR7oZlciZ0edI0P8IAKKVhpPB96Eck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XNY7yvILZ/mReUfkQVV13kVtI29W9jkvFr1lkWc9JCQ=;
        b=Co+LgHr1N77pkWhqfijZqjOhTFpzWnoH+6xlixJ7Cgll30cSPzW6SkQAGTvi25pKAg
         SpuPAYXxR2ypyRrFt3sJjN9OWIcOJfW13HKYVSAdRkMqd7tHp8+6L2UkS3sxYl2HfEHn
         GaSM6IMVN3hiVnvJkmKcCKoGxW9APcsOY833V4ASYE63yK8fc2m+od7VKPnrMchX+iQ1
         4GfKsvVj+Wp3IuTMqtuGsAJpyXJ9M0dKGI4btlcZFDdhywxxyFHpXyZqria4E3VB9CDT
         TOiG+vYe+rLxzhfG/eJWw/U1zHeeMM/R5Y10M88sx/tyzxCUnyOWSZLZ/tz3C0xm0NdX
         INVA==
X-Gm-Message-State: APjAAAUt50fsRRk/cN5L+EZYpZUDFWv1++g0gO6pxVe3JGV3ihQLely0
        LPZ2zXwQ6Ro165ZNLH6Yyjfv/A==
X-Google-Smtp-Source: APXvYqxqoOaKPTkuqPgHtqPhK+b1KxOySirLcm8Amno3smwiQ/9zyATGUaXnExsY6t0pS1YQA2JOLA==
X-Received: by 2002:a17:902:a50d:: with SMTP id s13mr35193645plq.58.1556147561953;
        Wed, 24 Apr 2019 16:12:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t21sm26664028pfe.22.2019.04.24.16.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:12:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] selftests: Move test output to diagnostic lines
Date:   Wed, 24 Apr 2019 16:12:29 -0700
Message-Id: <20190424231237.14776-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors the selftest Makefiles to extract the test running logic
to be reused between "run_tests" and "emit_tests", while also fixing
up the test output to be TAP version 13 compliant:
- added "plan" line
- fixed result line syntax
- moved all test output to be "# "-prefixed as TAP "diagnostic" lines

The prefixing code includes a fallback mode for limited execution
environments.

Additionally, the plan lines are fixed for all callers of kselftest.h.

-Kees

v2:
- fix external make variable "summary=1" through-out series (shuah)
- fix plan line output for all kselftest.h users

Kees Cook (8):
  selftests: Extract single-test shell logic from lib.mk
  selftests: Use runner.sh for emit targets
  selftests: Extract logic for multiple test runs
  selftests: Add plan line and fix result line syntax
  selftests: Distinguish between missing and non-executable
  selftests: Move test output to diagnostic lines
  selftests: Remove KSFT_TAP_LEVEL
  selftests: Add test plan API to kselftest.h and adjust callers

 tools/testing/selftests/.gitignore            |  1 -
 tools/testing/selftests/Makefile              | 24 ++----
 .../selftests/breakpoints/breakpoint_test.c   | 15 +++-
 .../breakpoints/breakpoint_test_arm64.c       |  3 +-
 .../breakpoints/step_after_suspend_test.c     |  8 ++
 .../selftests/capabilities/test_execve.c      |  6 +-
 .../futex/functional/futex_requeue_pi.c       |  1 +
 .../futex_requeue_pi_mismatched_ops.c         |  1 +
 .../futex_requeue_pi_signal_restart.c         |  1 +
 .../futex_wait_private_mapped_file.c          |  1 +
 .../futex/functional/futex_wait_timeout.c     |  1 +
 .../futex_wait_uninitialized_heap.c           |  1 +
 .../futex/functional/futex_wait_wouldblock.c  |  1 +
 tools/testing/selftests/kselftest.h           | 17 +++-
 tools/testing/selftests/kselftest/prefix.pl   | 23 +++++
 tools/testing/selftests/kselftest/runner.sh   | 86 +++++++++++++++++++
 tools/testing/selftests/lib.mk                | 64 +++-----------
 .../selftests/membarrier/membarrier_test.c    |  1 +
 tools/testing/selftests/pidfd/pidfd_test.c    |  1 +
 tools/testing/selftests/sigaltstack/sas.c     |  1 +
 tools/testing/selftests/sync/sync_test.c      |  1 +
 21 files changed, 178 insertions(+), 80 deletions(-)
 create mode 100755 tools/testing/selftests/kselftest/prefix.pl
 create mode 100644 tools/testing/selftests/kselftest/runner.sh

-- 
2.17.1

