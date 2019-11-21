Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69D2206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNFMoCf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKUSPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:15:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41077 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfKUSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so2102890pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kx15nKFaa57ikxrtvnW6LLNF2Gic9naPHUcFWTG+liE=;
        b=XNFMoCf8caSloMiiaa3BQ/ZV8ZEBK+ZOhENo9k1BFP7v6quOgxxTr8whsADIHvCl8D
         cmUrVFP0xX24EIIH24q0gHu7kjpr6B0HgYd4vzppozIj7jlmxpQdl5dVlpj5mcxyLzDa
         Ug4UbzyQbWAv7s6t+60ZgMgTOkgfQeIeauWZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kx15nKFaa57ikxrtvnW6LLNF2Gic9naPHUcFWTG+liE=;
        b=rejzvgPH/F7UipD4ovB7vRbQ1YkzXPP6uqhLNFvjFSRoNmu4xmi5DyDdVeNdSVf1cx
         5bybiwqKk4GlFA1OPhYL+ToQxAHizzZuZ5xwEJLfkzGiuf6qQ46wZzeeQ06BZxaA2ZR1
         wt7HlQN+YtdgdQLhZJZfol+xc7skwAvHGc50ssywl+3CuyyibYgzZByMoWxxjkEjU7Le
         br/WwuEuxINRpj6h8XlbLDXoCsgAFOWAKvh+yjJ3RHS6Z4ViTGUf4rItG+4MUzHHxSp+
         PAAmAjlo9H4B9DOSvMgJJJBSIaSa0HHCu3nYNpIzq/QZ3GekDsPWaXpYtcDTMOfW+GQL
         ilxA==
X-Gm-Message-State: APjAAAXC8VYIyMT0d3S9+zzealt+Tuco7P6kU4rCRAzwb2IOfQymUl4Y
        UvDLMYNgxumA+9JrsTslNmurhw==
X-Google-Smtp-Source: APXvYqy83nVTZOGjht16O1ra3uJKFrh9BgqquW4E25Tl7E1W4RGlNYIlQIfT7/HaPmqgf5SNpIzhMA==
X-Received: by 2002:a63:8f46:: with SMTP id r6mr11009780pgn.51.1574360129345;
        Thu, 21 Nov 2019 10:15:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h9sm236306pjh.8.2019.11.21.10.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:15:28 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 0/3] ubsan: Split out bounds checker
Date:   Thu, 21 Nov 2019 10:15:16 -0800
Message-Id: <20191121181519.28637-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
    - clarify Kconfig help text (aryabinin)
    - add reviewed-by
    - aim series at akpm, which seems to be where ubsan goes through?
v1: https://lore.kernel.org/lkml/20191120010636.27368-1-keescook@chromium.org

This splits out the bounds checker so it can be individually used. This
is expected to be enabled in Android and hopefully for syzbot. Includes
LKDTM tests for behavioral corner-cases (beyond just the bounds checker).

-Kees

Kees Cook (3):
  ubsan: Add trap instrumentation option
  ubsan: Split "bounds" checker from other options
  lkdtm/bugs: Add arithmetic overflow and array bounds checks

 drivers/misc/lkdtm/bugs.c  | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  3 ++
 drivers/misc/lkdtm/lkdtm.h |  3 ++
 lib/Kconfig.ubsan          | 42 +++++++++++++++++++--
 lib/Makefile               |  2 +
 scripts/Makefile.ubsan     | 16 ++++++--
 6 files changed, 134 insertions(+), 7 deletions(-)

-- 
2.17.1

