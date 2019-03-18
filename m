Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07902133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcUsFJxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfCRVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:10:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40426 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfCRVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:10:06 -0400
Received: by mail-yw1-f66.google.com with SMTP id p64so10834039ywg.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=1OBzRxbq45MhxmYJZgYt4Mvsa34RcIxjDNusHwtkkv0=;
        b=gcUsFJxTSM1wKN21LmYugvJKSXvsGO5kOXoF8UyH9gG9jiVeZvgktr5r0B0xuI8pvf
         SMUxPMiZGYVFYZ48uLsUMb92HLyvrTFy+XxwfCeJLqPPeAlKP7A58vaMgYjQW7ccQKBr
         5oamPVbuWwgmWJo9sap5tdjsQKQFHABCSR9Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=1OBzRxbq45MhxmYJZgYt4Mvsa34RcIxjDNusHwtkkv0=;
        b=ElbEGYi6EQIbvY6fGvl+SI2rZdL0vq/Kf6jRKdILyI0zajthf/u2nxX41jls6vJ/zl
         e2vO5ReO0dsn2fN7gTRx3kMlsNdWfuaJQUQ1cH2ROJ4n23VFTABb3RKe7kfJhSyNzvZv
         rWryqIyMs2/AzhKK1mIdr8Ru3LER2L+fMl/rvOmn2rtf850y19JZAXhMF88g3Vfp7CYB
         +Hf8mA/6OCQK5J/yeWwV05LXOeF272oAzxlRei8ooH/Ms5GF4r35Uz/RyhmNVJ2BstUK
         Uz2mWUKMpvqw7KTMCkfapSkAc6b0z8zb0yQCGWX2piPWxQx1zXOPwfqdwgDluxD4NuMe
         A5fg==
X-Gm-Message-State: APjAAAUxobhgHAQYWQwQ7ZeJ4c7Al/dzx5jlEMs5dGQrp7SvdOpFxeym
        erV9aa/+kqjL8iSeOrR+zie6YErfwKwOipcyJG3wQwMC
X-Google-Smtp-Source: APXvYqzlMa55s7tT1p3mN2NmihYAypU7eFmPj9padX14399ugbtVzb1L0yI11z4Ojbcz+Yc1otPAME21+5AaQpN+Zx8=
X-Received: by 2002:a81:32c3:: with SMTP id y186mr15873975ywy.144.1552943406087;
 Mon, 18 Mar 2019 14:10:06 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Mar 2019 17:10:05 -0400
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Date:   Mon, 18 Mar 2019 17:10:05 -0400
Message-ID: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com>
Subject: [PATCH] Revert "kbuild: use -Oz instead of -Os when using clang"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Behan Webster <behanw@converseincode.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang option -Oz enables *aggressive* optimization for size,
which doesn't necessarily result in smaller images, but can have
negative impact on performance. Switch back to the less aggressive
-Os.

This reverts commit 6748cb3c299de1ffbe56733647b01dbcc398c419.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9ef547fc7ffe..191f3ce3cb5e 100644
--- a/Makefile
+++ b/Makefile
@@ -667,7 +667,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)

 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
+KBUILD_CFLAGS	+= -Os
 else
 KBUILD_CFLAGS   += -O2
 endif
-- 
2.21.0.225.g810b269d1ac-goog
