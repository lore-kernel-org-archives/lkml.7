Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B975C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C751420449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J04pm3ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfEBPgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:36:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfEBPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:36:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so179230edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeCbek7GxN78jmKl6HDSULctY9a079sA8sLhO9KSXCE=;
        b=J04pm3uinBZj07mQUc20QoDfp+OQk/UzptzIcSRRvJQ+i19xBQyz7UfnOlAK1p63BP
         0hBiwZvxaaLGWRcC+VrF0LkpwlOR1UA1i2R3snOKvD7L2UbudEv8MjBkKgtRLhI5AK64
         +ajHM23pkTed/0m9GmNqamhAvr7SzAISWxzAKDHmUrK7V7yni2jLai0IAq33C+iJDI5n
         vys9SsRMh2mmR4MMQ4o/E9FfPT9tqsg1pQgNNbAYJbopon/cuMATXAkju4JdqQI80A8U
         lE4FFPwdswVeraFDpUWin5auZ+HT9MMpiC8xpByUz81NDaAJFOqUD+QQqbi6NYSx46e+
         Ns1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IeCbek7GxN78jmKl6HDSULctY9a079sA8sLhO9KSXCE=;
        b=XyK0qIn7ohpy0aWCZp/EDVGa5Kx7kl1UWHeqNuThe0natSz7GH+eJtmEwLSfqOhZnq
         3g6oSt1wPPOnCfpBC1b+0Pm76NFFiSVL0M/qrAhBcCQ3TmIbCy8xsW7hqbGmC+xQchHi
         dLcAWvjxYqbbJWOLrfM7LSJs8Um1EkqcAegn3wsVVYQ5+YXCwSvZC4NIfwoniJJXme5P
         b1Xj9Al+itYOWl1l8RcpheW2iYC+ZU5M8So1maAnGDyHL25tBlqTVWF5vdChZbXArXus
         +LgdV9Ebpzl54U1rH4vgp1/eJ0rKSzMicUH66XPJ5dq1T/eH0o9zwouMe4RonX6zbTp1
         qMiA==
X-Gm-Message-State: APjAAAXeIcbvxaOTaKLPft4gKLPVKnK7TyfEFR6P++5sRYsqp93Qv1uG
        6tF2F8fNHZ58d1BbbMs34sk=
X-Google-Smtp-Source: APXvYqx2dUlDAJbP5jPeB6xQOpTTqQTTzZYY1NEWzH8taBIya6BsF/hTANqdbRNRRF/OpyE8xQJ/mg==
X-Received: by 2002:a50:be01:: with SMTP id a1mr3094467edi.12.1556811365468;
        Thu, 02 May 2019 08:36:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id e18sm7386693ejf.77.2019.05.02.08.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 08:36:04 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] kasan: Zero initialize tag in __kasan_kmalloc
Date:   Thu,  2 May 2019 08:35:38 -0700
Message-Id: <20190502153538.2326-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wuninitialized and CONFIG_KASAN_SW_TAGS unset, Clang
warns:

mm/kasan/common.c:484:40: warning: variable 'tag' is uninitialized when
used here [-Wuninitialized]
        kasan_unpoison_shadow(set_tag(object, tag), size);
                                              ^~~

set_tag ignores tag in this configuration but clang doesn't realize it
at this point in its pipeline, as it points to arch_kasan_set_tag as
being the point where it is used, which will later be expanded to
(void *)(object) without a use of tag. Just zero initialize tag, as it
removes this warning and doesn't change the meaning of the code.

Link: https://github.com/ClangBuiltLinux/linux/issues/465
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 36afcf64e016..4c5af68f2a8b 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -464,7 +464,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
-	u8 tag;
+	u8 tag = 0;
 
 	if (gfpflags_allow_blocking(flags))
 		quarantine_reduce();
-- 
2.21.0

