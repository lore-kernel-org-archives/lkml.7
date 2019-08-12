Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF5EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81162067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5dGVSJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfHLVwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:52:12 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53429 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfHLVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:52:10 -0400
Received: by mail-yw1-f73.google.com with SMTP id c199so1744139ywb.20
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q0pM2ZOzYJiqEFARYUko9qZH/ZZGqfD1MaH3ngq3us8=;
        b=I5dGVSJwg+v5RyOEC5gi6oytJS0yW4Mmt+c5xThJQxWY5OwURmEGt6K8eSF+EP+4xu
         GWwPrzEgPlmom5u3yG+mZn+HMrBWpuoLnyRNOlMaBcSAQVMFjL1WwGTWu+h7UCq/edOu
         IPYgNr5h5jsFfbpOYcOPgU3hxgjjymdwaD1Os4IRGlzRO5zwXEbOr/J2EEIZ56I/YU9r
         66AwX7+wwFlPujGUTM80/eieOR0jQG+KnscBiHOUapeinqDEidNrRFDbQmV1qSYPXlBt
         x2wzJDK4lftnnSeYI2g4mn2UraIxEOp9NQ2HP3bcmiyvE5m6RB2vrwSKVpQ9zn9XKLzZ
         2IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q0pM2ZOzYJiqEFARYUko9qZH/ZZGqfD1MaH3ngq3us8=;
        b=PjC5ZPb0o4u56leIx2Q9rtlJtbLf8ras09E0eyh+5+qGBABf3Guf1iRQ7uMCEdC6O2
         hh6w3BaZT5sA+JGZQZaBXNWm4vLzu3arZK8BbEgnidz2Ytk/zq9qq9EKup6Z+OczLH0G
         6DQ0NH8OPUhEmEtBTwWs17JZMwo1M43Bi1ulx7KfCqW+OfCdIDXB7qIHOLnhuriYN28t
         HTP9hPW+to9RQ/7LONUAVeSpx/ZoDc6SsNQ9GEwOVT2WuJJXubzguvY0VK1HgZpMVDq4
         y9qqYIW4U5tOFi2jUu2HhpzK5OUisegP5M97pofqTWzHL4m5qdY6XzkQCU5T5h5tuJEX
         jzng==
X-Gm-Message-State: APjAAAVITlWZHHmT+AY1mNsuEl1HGeuoiUVxqe2lDtyrmErSUOIvptP9
        E6HhA9/Rl4OIg8wPw90fDEXlA+KavBSobv6oFSg=
X-Google-Smtp-Source: APXvYqxHC7+rS2qjpS3IPZOB5pIRQxGdfIUG5M/NEIEtRIJhLY8Opqpv36wf9jko8QIKzBKhKeboh5I3CYvreDjxFhQ=
X-Received: by 2002:a0d:d807:: with SMTP id a7mr4425576ywe.112.1565646729583;
 Mon, 12 Aug 2019 14:52:09 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:41 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-8-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 08/16] mips: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, linux-mips@vger.kernel.org,
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
 arch/mips/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cache.h b/arch/mips/include/asm/cache.h
index 8b14c2706aa5..af2d943580ee 100644
--- a/arch/mips/include/asm/cache.h
+++ b/arch/mips/include/asm/cache.h
@@ -14,6 +14,6 @@
 #define L1_CACHE_SHIFT		CONFIG_MIPS_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 #endif /* _ASM_CACHE_H */
-- 
2.23.0.rc1.153.gdeed80330f-goog

