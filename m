Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E20420708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPNZ3TFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKTBGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:06:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36718 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfKTBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:06:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so13323264pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CUFUdRWnKnM6bQsVtJfdZZf6wE8f8HKbQO0cl/4N/Js=;
        b=QPNZ3TFYMN2cyDfBdvY07DD5Qf553QuOH2y52Uwcvrqipiupi+07SzCncWmB4ompaa
         Sp+KugNpDIe0O6L+0QzSoa4zgNsRPXdvojFu1L2G6OGfQek8k6mLkB+UwWM1uFrTy2gS
         NyC4I93Ch4Jff4rMgtPSiWxg1V0Gf/SF4lmjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CUFUdRWnKnM6bQsVtJfdZZf6wE8f8HKbQO0cl/4N/Js=;
        b=U7Fb6N+MKFWQhmLKqP0TOT/ugckSJ5Gap+ehEdZxMN8NJq2gfnia7P94p2rQqdu9Rh
         0w1H7T2TktVyJ9B6/0Tfq9qCLINZH91YLJzdLA8G6wcQM9Ad1sv+LLmkDdRrA5OvdeGZ
         77XfaCq1cbNjE9F69ABYFJa5TIMOVJF71k1VzHnxvnHaxqurZen+cJHTs5CjRS4mP4mq
         HzDfla2+GZ05luykra1CiZRHX4Z601B9Q2RURyjxSkZTOP4ga+5CnJIIEo8j2+lkIZL9
         0cqUX9A2JwXvl5RXonQ7Hw0zm/JH3YXwELg2oNh1zG36X1JoDCqxxVeGVUc7am7syp/W
         ovbg==
X-Gm-Message-State: APjAAAVQ5ykYGTNPy9JYwMqQseUcTEeKdGEZtlLKPR1nwV+fm0AjcJFu
        F4uKIK4CxXHkJ7sYQE6MH4HKgA==
X-Google-Smtp-Source: APXvYqwryrV10zt9FpcokSWJA8ITt8y25QMJpvbarPp35S9IPnXIHn2OsUwTFiZFRGn4wDxNWoDbIA==
X-Received: by 2002:a62:ae17:: with SMTP id q23mr705132pff.2.1574212002529;
        Tue, 19 Nov 2019 17:06:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6sm24445726pfi.119.2019.11.19.17.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 17:06:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 0/3] ubsan: Split out bounds checker
Date:   Tue, 19 Nov 2019 17:06:33 -0800
Message-Id: <20191120010636.27368-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splits out the bounds checker so it can be individually used. This
is expected to be enabled in Android and hopefully for syzbot. Includes
LKDTM tests for behavioral corner-cases.

-Kees

Kees Cook (3):
  ubsan: Add trap instrumentation option
  ubsan: Split "bounds" checker from other options
  lkdtm/bugs: Add arithmetic overflow and array bounds checks

 drivers/misc/lkdtm/bugs.c  | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  3 ++
 drivers/misc/lkdtm/lkdtm.h |  3 ++
 lib/Kconfig.ubsan          | 34 ++++++++++++++++-
 lib/Makefile               |  2 +
 scripts/Makefile.ubsan     | 16 ++++++--
 6 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.17.1

