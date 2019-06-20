Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D9DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8DA20673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmC9UxSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfFTATM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 20:19:12 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:42340 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFTATM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:19:12 -0400
Received: by mail-vk1-f201.google.com with SMTP id y198so513299vky.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 17:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aTGhJgb4vxuKf0M//GIyEALWsDaETb7RxGinNOSV0SE=;
        b=JmC9UxSvfUzWjHLQGaR/g4PDfW9KxeAFlp0ho6nJqN12Zqh9udFPRuIl2tmsV8qIft
         ZxAkmsHeYKo3uksMr5aPgAZtOfnx5ZFr/P4wTxe4F+GWd5/IwqkT/TFlhlvLSwZFdSRS
         j9tNUNGr9kSknnBxDhA2RAoLZ6Radpb/M8SONUWt5zUKdlRgHv91zesOYDaAcYWMXOeT
         8K5lVAZ/PSWfQPmEZNxl0KdKo/KfTEf0SB7JLxrn7yi3m1JhMO6R61QD1DE5mBN1iwQd
         SNuPkm2mt+yB0AfT8VQVPGrYapTZz90KYzvTwZ8pEqObj4YUxBUEQbXmg5Xfv3CItlaR
         lhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aTGhJgb4vxuKf0M//GIyEALWsDaETb7RxGinNOSV0SE=;
        b=N8t0VETPGZ956y9YfYW5tB38zV+eO3j1uoXpOWOfOUyPEAt6QmmpDXDP1X+3zzWbDW
         nOnSYVBk9TwB7jO+Skb3xsbaMnjsWkeUlneq14jxXDX5hXYHESBZy8TAtmOttY45nE0i
         5XVuf0C0X2I8MNzpcMoiftIxWliCq1oKd2CgWsASVHx9uyWd8EWxfUYXIu+m+pXIy8X6
         Oz09R5p5lHZqmR/ASyraZonQsYPst30d0kCCGFnhdyj4nTjBvhcXIyTcE6RlFYK8Nsia
         zuTvLsy6VcvpKbMleXG9/sZxrCd3R2WtK32rTGs/xKJD9P3e05MlJCiQeAHclaMt0Fsq
         E3aQ==
X-Gm-Message-State: APjAAAVNNgoeEoHVfLZVbrrUSkPqKSvIyocMF5cVqAS6gcfFFPohB8R0
        PyHo24HdV1Brqvux8awhncBYaHGU1MQFebAJD/U=
X-Google-Smtp-Source: APXvYqwclDrJ7Q77uAqrIO5hmAITjLAd6TTmY6zYRakDTcX1idFj2kX+WQKfUkL7bD5YzbLYjJqdm8gyKAh+12mxzOA=
X-Received: by 2002:a1f:50c1:: with SMTP id e184mr6033451vkb.86.1560989951279;
 Wed, 19 Jun 2019 17:19:11 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:19:07 -0700
In-Reply-To: <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
Message-Id: <20190620001907.255803-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     clang-built-linux@googlegroups.com, joe@perches.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add keyword support so that our mailing list gets cc'ed for clang/llvm
patches. We're pretty active on our mailing list so far as code review.
There are numerous Googlers like myself that are paid to support
building the Linux kernel with Clang and LLVM.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1 -> V2:
- tabs vs spaces as per Joe Perches

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef58d9a881ee..f92432452f46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3940,6 +3940,14 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
 F:	.clang-format
 
+CLANG/LLVM BUILD SUPPORT
+L:	clang-built-linux@googlegroups.com
+W:	https://clangbuiltlinux.github.io/
+B:	https://github.com/ClangBuiltLinux/linux/issues
+C:	irc://chat.freenode.net/clangbuiltlinux
+S:	Supported
+K:	\b(?i:clang|llvm)\b
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
-- 
2.22.0.410.gd8fdbe21b5-goog

