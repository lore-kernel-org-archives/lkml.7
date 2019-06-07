Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8376C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECAA21479
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559922552;
	bh=JwvSQ0W0IQqcM+2rYs9kJsFp6mVziXjD2/UTK4iOejY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OBf09RiaXF/GD+01pMKVioOPgRCRFjcmMqwbYdTQSdJFGRExTmrNvNn84AYZtYdTq
	 O68YmxDExmIxVrFuqhOcMCvopLOHbOwkJxof5ssWW1WIbC0nN+0MElwaopFzpzdkoN
	 ubmfIkSciLgg2sMNr1p6NEGd+qWn/TyREOpCdZ1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfFGPtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbfFGPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:49:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09DA20840;
        Fri,  7 Jun 2019 15:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559922542;
        bh=JwvSQ0W0IQqcM+2rYs9kJsFp6mVziXjD2/UTK4iOejY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mo5NH0hqCz+gFxl8WFzl+qGSpgMxDGTn/BO437djcc6UF8iEYAlOzAswlpNAICIwi
         NNFCRnDiOf7S1E0ioXs0MiD9Kc4NcSRS/XICSKr285eIpqGFJUGUADIVIjCX1NNRvM
         2q87mghnvqTM9uURqSNEO3ixSWU6TgR53ErkNKDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.1 50/85] kasan: initialize tag to 0xff in __kasan_kmalloc
Date:   Fri,  7 Jun 2019 17:39:35 +0200
Message-Id: <20190607153855.112480800@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607153849.101321647@linuxfoundation.org>
References: <20190607153849.101321647@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 0600597c854e53d2f9b7a6a718c1da2b8b4cb4db upstream.

When building with -Wuninitialized and CONFIG_KASAN_SW_TAGS unset, Clang
warns:

mm/kasan/common.c:484:40: warning: variable 'tag' is uninitialized when
used here [-Wuninitialized]
        kasan_unpoison_shadow(set_tag(object, tag), size);
                                              ^~~

set_tag ignores tag in this configuration but clang doesn't realize it at
this point in its pipeline, as it points to arch_kasan_set_tag as being
the point where it is used, which will later be expanded to (void
*)(object) without a use of tag.  Initialize tag to 0xff, as it removes
this warning and doesn't change the meaning of the code.

Link: https://github.com/ClangBuiltLinux/linux/issues/465
Link: http://lkml.kernel.org/r/20190502163057.6603-1-natechancellor@gmail.com
Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/kasan/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -472,7 +472,7 @@ static void *__kasan_kmalloc(struct kmem
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
-	u8 tag;
+	u8 tag = 0xff;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();


