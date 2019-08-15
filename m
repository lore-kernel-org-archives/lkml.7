Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A3C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C660C2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+oh9EMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbfHOW7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:59:11 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54846 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732541AbfHOW7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:59:10 -0400
Received: by mail-pl1-f201.google.com with SMTP id g9so2138198plo.21
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bsc+oL3W9Qap3NqyiuNHWglQP2bNTVPp35x6p7f/ATk=;
        b=D+oh9EMlMt/QrNGNxmKtbHKxtThq4UQj8l+9apxFZP4dZXqtTpOJs9bJLmToApG59S
         GaOY6ObFUzKYpVIG9qdvaiG0+kZuwnpwJw8LK23gCHiVWgXJtibE17rzKZox21eWijh2
         ciaSQNYIJbqYg7VZa9USfTiUlCTe26mCTeT/9e40VkPiYHibcjbOvK4BJCgdic37Nebe
         xOvvGO9Ob0Advw2z3JY/EUdh+RhFtDLU6IhE7uGqF84dsk7ImMtLOvuZPmQ0LhNJfki5
         eyi5ukjCrDZC8GDJxetUCfuWb6/MWSKsotN7XWqqukpiQJqO9StPF50y0Dg/Hc9+jJeO
         2rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bsc+oL3W9Qap3NqyiuNHWglQP2bNTVPp35x6p7f/ATk=;
        b=J4kX8M8STsd83Bo5OVpg57qRiqP+M4vr5XWqyfaBg5kkU82Geb89O5PObUg8Fe8Unj
         gb/fSPIjru9a/YKot+TdynveZoOuyxvwl5eZGF4lRou1QNt8wpp10/i32mQxzJ8QgjBy
         dDO35IppR6pM2tDoDAQImpMSwqFhtjm1bdACQmD4LYbnc3CuHQhLOJaH5OqUco9LHzNi
         Fch2FmlEC0qwffI2SS3tk/Fk9UpccuM8lJnKrKGo/rZqcjSgaBjzM28dMhQ0gLIdcc7h
         fOQ4pVM8aw03vVBp4DsGTqLyufcFLKr9qVsCUHpT0XBpi9SCS2Uhky1fw2qJG4oF2Tj6
         3n4A==
X-Gm-Message-State: APjAAAVvozkw+1kjxafpZTiGiQ1JxvWEsU+sclK9QBrT7o5cZnJNGv6M
        T+m4zvrocY7pgA95ZnDtJrH1S2DC4Q==
X-Google-Smtp-Source: APXvYqxXDHy3HLU992MgApTbMZ1Xyyi/HhIlYlYEpdvdMcL06xUXNlzd8fHMXPFb5Ux6ET2bsEqM0hMy0g==
X-Received: by 2002:a63:c442:: with SMTP id m2mr5399788pgg.286.1565909949663;
 Thu, 15 Aug 2019 15:59:09 -0700 (PDT)
Date:   Thu, 15 Aug 2019 15:58:44 -0700
In-Reply-To: <CAKwvOdk+NQCKZ4EXAukaKYK4R9CDaNWVY_aDxXaeQrLfo_Z=nw@mail.gmail.com>
Message-Id: <20190815225844.145726-1-nhuck@google.com>
Mime-Version: 1.0
References: <CAKwvOdk+NQCKZ4EXAukaKYK4R9CDaNWVY_aDxXaeQrLfo_Z=nw@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2] kbuild: Require W=1 for -Wimplicit-fallthrough with clang
From:   Nathan Huckleberry <nhuck@google.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        joe@perches.com, miguel.ojeda.sandonis@gmail.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Huckleberry <nhuck@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang is updating to support -Wimplicit-fallthrough on C
https://reviews.llvm.org/D64838. Since clang does not
support the comment version of fallthrough annotations
this update causes an additional 50k warnings. Most
of these warnings (>49k) are duplicates from header files.

This patch is intended to be reverted after the warnings
have been cleaned up.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
---
Changes v1->v2
* Move code to preexisting ifdef
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index a74ce2e3c33e..95973a1ee999 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -70,5 +70,6 @@ KBUILD_CFLAGS += -Wno-initializer-overrides
 KBUILD_CFLAGS += -Wno-format
 KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-format-zero-length
+KBUILD_CFLAGS += $(call cc-option,-Wno-implicit-fallthrough)
 endif
 endif
-- 
2.23.0.rc1.153.gdeed80330f-goog

