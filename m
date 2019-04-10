Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D31BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195392082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BBz++SQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDJVTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:19:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41912 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:19:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id u2so3309841eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQdyv44o0lMaGsIrdTDQzwqqE/OiS9gGi6TMQRjBRUk=;
        b=BBz++SQNUnZ0EGaXv4WmfJwoV7K/q4gb20DYijx0E4QvVwiLqXutESPb3Ow0rwQPT+
         y83bZHxSDBJBC/6naNdskwdrAhezX/R/P2BRl4/GfFnyH8LKG3qPLLs2lmsRv7WFuTi/
         4InjpR97BfMbnYHoJOT65Os1iAiF2mF6nrznE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AQdyv44o0lMaGsIrdTDQzwqqE/OiS9gGi6TMQRjBRUk=;
        b=bURH/vUoY0vMfyir6rqyzLHas8vwiAibL/DsVvJwfVQ/veX2eJdOVnrN9CASCFva44
         O/5oDDrjF3A5fmv7a2emnjQ5ZxPKLYoLudDZOv2+qmM75zykDf8YmQi/pUonbL8jB2GQ
         XcdO7Z5UtR5mWDaHHeBQPSlYx8lNhDVTcuNpi/k8btkxynBehDHwRzK6KsEMQtZA/Gs7
         xCrj0M+QpwpjT3BbihTHrfc349a9WHULrdCd2scNZ58JwkGq6UMxft8H3VrbcQhEKXpq
         Qw0iDSsJoKpSRTGdYLpDiJEuzSL8l+qaosLvtYcLMYBe6k/eYF9J+5evN50YLGcNJkU6
         ItVA==
X-Gm-Message-State: APjAAAX8CvqTZ8/xs1U0R0mOId9Fo9kk+O+sYmMNRy5eitFsu49iBkDw
        aL3K39A3+PkpP3jULVfa8jfOwQ==
X-Google-Smtp-Source: APXvYqxmxbjAr0yR/fINJ8z9PReCj5P+gnlxUeV2+d03yA/QHe0tF8fo2LBpOX+laf65HLYgwvA2wQ==
X-Received: by 2002:a17:906:1856:: with SMTP id w22mr24951377eje.130.1554931153448;
        Wed, 10 Apr 2019 14:19:13 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id d14sm1539386edj.57.2019.04.10.14.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:19:10 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Will Deacon <will.deacon@arm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ido Schimmel <idosch@mellanox.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bitops.h: sanitize rotate primitives
Date:   Wed, 10 Apr 2019 23:19:06 +0200
Message-Id: <20190410211906.2190-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ror32 implementation (word >> shift) | (word << (32 - shift) has
undefined behaviour if shift is outside the [1, 31] range. Similarly
for the 64 bit variants. Most callers pass a compile-time
constant (naturally in that range), but there's an UBSAN report that
these may actually be called with a shift count of 0.

Instead of special-casing that, we can make them DTRT for all values
of shift while also avoiding UB. For some reason, this was already
partly done for rol32 (which was well-defined for [0, 31]). gcc 8
recognizes these patterns as rotates, so for example

__u32 rol32(__u32 word, unsigned int shift)
{
	return (word << (shift & 31)) | (word >> ((-shift) & 31));
}

compiles to

0000000000000020 <rol32>:
  20:   89 f8                   mov    %edi,%eax
  22:   89 f1                   mov    %esi,%ecx
  24:   d3 c0                   rol    %cl,%eax
  26:   c3                      retq

Older compilers unfortunately do not do as well, but this only affects
the small minority of users that don't pass constants.

Due to integer promotions, ro[lr]8 were already well-defined for
shifts in [0, 8], and ro[lr]16 were mostly well-defined for shifts in
[0, 16] (only mostly - u16 gets promoted to _signed_ int, so if bit 15
is set, word << 16 is undefined). For consistency, update those as
well.

Reported-by: Ido Schimmel <idosch@mellanox.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/bitops.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 602af23b98c7..cf074bce3eb3 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -60,7 +60,7 @@ static __always_inline unsigned long hweight_long(unsigned long w)
  */
 static inline __u64 rol64(__u64 word, unsigned int shift)
 {
-	return (word << shift) | (word >> (64 - shift));
+	return (word << (shift & 63)) | (word >> ((-shift) & 63));
 }
 
 /**
@@ -70,7 +70,7 @@ static inline __u64 rol64(__u64 word, unsigned int shift)
  */
 static inline __u64 ror64(__u64 word, unsigned int shift)
 {
-	return (word >> shift) | (word << (64 - shift));
+	return (word >> (shift & 63)) | (word << ((-shift) & 63));
 }
 
 /**
@@ -80,7 +80,7 @@ static inline __u64 ror64(__u64 word, unsigned int shift)
  */
 static inline __u32 rol32(__u32 word, unsigned int shift)
 {
-	return (word << shift) | (word >> ((-shift) & 31));
+	return (word << (shift & 31)) | (word >> ((-shift) & 31));
 }
 
 /**
@@ -90,7 +90,7 @@ static inline __u32 rol32(__u32 word, unsigned int shift)
  */
 static inline __u32 ror32(__u32 word, unsigned int shift)
 {
-	return (word >> shift) | (word << (32 - shift));
+	return (word >> (shift & 31)) | (word << ((-shift) & 31));
 }
 
 /**
@@ -100,7 +100,7 @@ static inline __u32 ror32(__u32 word, unsigned int shift)
  */
 static inline __u16 rol16(__u16 word, unsigned int shift)
 {
-	return (word << shift) | (word >> (16 - shift));
+	return (word << (shift & 15)) | (word >> ((-shift) & 15));
 }
 
 /**
@@ -110,7 +110,7 @@ static inline __u16 rol16(__u16 word, unsigned int shift)
  */
 static inline __u16 ror16(__u16 word, unsigned int shift)
 {
-	return (word >> shift) | (word << (16 - shift));
+	return (word >> (shift & 15)) | (word << ((-shift) & 15));
 }
 
 /**
@@ -120,7 +120,7 @@ static inline __u16 ror16(__u16 word, unsigned int shift)
  */
 static inline __u8 rol8(__u8 word, unsigned int shift)
 {
-	return (word << shift) | (word >> (8 - shift));
+	return (word << (shift & 7)) | (word >> ((-shift) & 7));
 }
 
 /**
@@ -130,7 +130,7 @@ static inline __u8 rol8(__u8 word, unsigned int shift)
  */
 static inline __u8 ror8(__u8 word, unsigned int shift)
 {
-	return (word >> shift) | (word << (8 - shift));
+	return (word >> (shift & 7)) | (word << ((-shift) & 7));
 }
 
 /**
-- 
2.20.1

