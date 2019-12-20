Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5823C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9124A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLTOES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:04:18 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:9856 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:04:18 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 47fVq35p0ZzQlBr;
        Fri, 20 Dec 2019 15:04:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id UobXaQH75WdR; Fri, 20 Dec 2019 15:04:12 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] openat2: minor uapi cleanups
Date:   Sat, 21 Dec 2019 01:03:26 +1100
Message-Id: <20191220140328.20907-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch changelog:
  v2:
   * Add include <linux/types.h> to openat2.h. [Florian Weimer]
   * Move OPEN_HOW_SIZE_* constants out of UAPI. [Florian Weimer]
   * Switch from __aligned_u64 to __u64 since it isn't necessary.
     [David Laight]
  v1: <https://lore.kernel.org/lkml/20191219105533.12508-1-cyphar@cyphar.com/>

While openat2(2) is still not yet in Linus's tree, we can take this
opportunity to iron out some small warts that weren't noticed earlier:

  * A fix was suggested by Florian Weimer, to separate the openat2
    definitions so glibc can use the header directly. I've put the
    maintainership under VFS but let me know if you'd prefer it belong
    ot the fcntl folks.

  * Having heterogenous field sizes in an extensible struct results in
    "padding hole" problems when adding new fields (in addition the
    correct error to use for non-zero padding isn't entirely clear ).
    The simplest solution is to just copy clone(3)'s model -- always use
    u64s. It will waste a little more space in the struct, but it
    removes a possible future headache.

Aleksa Sarai (2):
  openat2: drop open_how->__padding field
  uapi: split openat2(2) definitions from fcntl.h

 MAINTAINERS                                   |  1 +
 fs/open.c                                     |  2 -
 include/linux/fcntl.h                         |  4 ++
 include/uapi/linux/fcntl.h                    | 37 +-----------------
 include/uapi/linux/openat2.h                  | 39 +++++++++++++++++++
 tools/testing/selftests/openat2/helpers.h     |  7 ++--
 .../testing/selftests/openat2/openat2_test.c  | 24 ++++--------
 7 files changed, 56 insertions(+), 58 deletions(-)
 create mode 100644 include/uapi/linux/openat2.h


base-commit: 912dfe068c43fa13c587b8d30e73d335c5ba7d44
-- 
2.24.0

