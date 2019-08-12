Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5294C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D392067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEJcf9Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfHLVwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:52:22 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35058 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfHLVwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:52:18 -0400
Received: by mail-qk1-f201.google.com with SMTP id z2so13792471qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CMqgCUm+GxLehEdw4ZyFc9UqjqXT2SeM4A16UJsbPIg=;
        b=cEJcf9Y0TRBDvUfh7MDfEoOyZM+EmdiGeHKpU+4TT2H8QHtoDwx47a0Bdkd4grgnck
         AgKdxC7cLoC0YgryFCmAsQacbbELc3GMXpyG5foU2D3IorLvYpb3u4LbP+EWBLb+ONZn
         xu7IiQg3HetB6nQuaBGNlxs7Sr7tIqxEFdlxTcoFSx9y/5H5DOJeHMZBNvraJK4HPofL
         RJsn+4usFleoPDE+Pi/F8rWyKd8I+I1beDSXDkW8gGxrBPE7i61Bujv42XuPx6GAgaek
         494TPvcDlGC6P/e5+FY8HYPsHRt/m6cIUbWe9gHGpZyW8mZYgRY00Km4Z+SYLP5VskTG
         2U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CMqgCUm+GxLehEdw4ZyFc9UqjqXT2SeM4A16UJsbPIg=;
        b=EqpQOsA7a1BwM1aQo6nXWM0m8jWHxDkP60+OnJC6hdNJvunV1eEEP7/Zq2XKsYM6Lx
         OMiO2akCY69CcDYMkSyRxDtVKOaU/pZrnNUEEkPtF4MtZ3thcbUe1hJFftxG1m8XCiRk
         r1rkctZFWPug8HH9P6GqVpvvHqHTSwTItVb0KtzrMnJEPbsANevoRPPocuvbTxVLDpRC
         0GkJNS2dNMDRqhltwVU80Y6NArlb/mASJgD2Rosvf3VYTfa8sFZNt/iBxhfXjfB0FHq/
         aQs7+pvWrzxGYnGWq7hvqly0usAHd4ytj5xHS8BlroZYZxHu45dtTklk+S8fhpdZ6yZz
         Owbw==
X-Gm-Message-State: APjAAAXGszIZJGzjcUyF74BQIkWqyv8BIV3s3WaDusChp6X/L4aAF8u/
        KxV4quAzOmbjeJDX2aEdgYHJNm+X0TmVzx4dUxo=
X-Google-Smtp-Source: APXvYqzQFJN/qlVvUNeiMuVCHF2UNgPcW3Ylev0M+rUpavcq5oQsKnHk5LDh1iN6YRuu2esK+vHi3t7qoB6T+Vrv3Xk=
X-Received: by 2002:ad4:54a1:: with SMTP id r1mr7354704qvy.213.1565646737123;
 Mon, 12 Aug 2019 14:52:17 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:42 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-9-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 09/16] sparc: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sparc/include/asm/cache.h | 2 +-
 arch/sparc/kernel/btext.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cache.h b/arch/sparc/include/asm/cache.h
index dcfd58118c11..9a9effdd01e2 100644
--- a/arch/sparc/include/asm/cache.h
+++ b/arch/sparc/include/asm/cache.h
@@ -21,6 +21,6 @@
 
 #define SMP_CACHE_BYTES (1 << SMP_CACHE_BYTES_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* !(_SPARC_CACHE_H) */
diff --git a/arch/sparc/kernel/btext.c b/arch/sparc/kernel/btext.c
index 5869773f3dc4..b2eff8f8f27b 100644
--- a/arch/sparc/kernel/btext.c
+++ b/arch/sparc/kernel/btext.c
@@ -24,7 +24,7 @@ static void draw_byte_32(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_16(unsigned char *bits, unsigned int *base, int rb);
 static void draw_byte_8(unsigned char *bits, unsigned int *base, int rb);
 
-#define __force_data __attribute__((__section__(".data")))
+#define __force_data __section(.data)
 
 static int g_loc_X __force_data;
 static int g_loc_Y __force_data;
-- 
2.23.0.rc1.153.gdeed80330f-goog

