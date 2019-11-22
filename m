Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B26CC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D81206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hLEhYIK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKVBDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:03:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35344 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKVBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:03:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id q13so2639557pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 17:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLXiD3mid8KH+vzWk5eeV9cjY9C1Tzvqr7ZpCV412RY=;
        b=hLEhYIK9flS41tAVD9Y1bn4Jt1UMYp7abrfy7AKnCXRyYLediN4w0OgzUjMgs0WAYW
         rzprgJVKdgJxLcSWW6iAsj72BUpuEc3wX6C78lTdcb6JdJgZL51SVGpEs6Ai7XrsXt+y
         5MF2Lwf3FHcIrCf8H9/NtYF9ZkNBOYzfwh3jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yLXiD3mid8KH+vzWk5eeV9cjY9C1Tzvqr7ZpCV412RY=;
        b=SKeV127On/4X+zQFckrrZDZPAt/Jj8KbTJbQ97l/poZn7BnvZeavv2jsVSp+l1X2eZ
         ErNJzX08xXgffw0UWxmPpYVEQFeCU1sXpGRgGHtk2pccYjGz1DJw7IvOQdYzVbZHSpxO
         Bb0UswaZ6tYuJePY3PMhmRmTLBRyQPHsU3xs9ixzszc+YAO9oCCvzIfI22TINLwQOybY
         RCboJBvCHJfcfJFU3dXNMUVb9XNzXEOZow8y8YJIX+jeYilWqNMur1r7OrgE+WnJB462
         2LBu7hiIleugImmlx9vlB+7zn+5F7YpZn9lm2z9c5ZuopNYemw5Om//XT60Tm6kMA7YE
         029g==
X-Gm-Message-State: APjAAAWE9dVbaqtJyfETBDRlIPpnYK0w8hQRC2MI3cLsh3bTzXYo3zlG
        EZ8PoulD4F1miMMntl4biVeBoQ==
X-Google-Smtp-Source: APXvYqz/gdanKWHRL5lO19w7tDA97M8iQ7EDdo45/bL9HF9nQFFMvAJl5aGHe6J3GPDcKfidzkpnhw==
X-Received: by 2002:a63:4705:: with SMTP id u5mr12607717pga.7.1574384623397;
        Thu, 21 Nov 2019 17:03:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q34sm699235pjb.15.2019.11.21.17.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 17:03:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jo=C3=A3o=20Moreira?= <joao.moreira@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 0/8] crypto: x86: Fix indirect function call casts
Date:   Thu, 21 Nov 2019 17:03:26 -0800
Message-Id: <20191122010334.12081-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6:
- minimize need for various internal casts (ebiggers)
- clarify comments (ebiggers)
- switch all context pointers to const (ebiggers)
v5: https://lore.kernel.org/lkml/20191113182516.13545-1-keescook@chromium.org
v4: https://lore.kernel.org/lkml/20191111214552.36717-1-keescook@chromium.org
v3: https://lore.kernel.org/lkml/20190507161321.34611-1-keescook@chromium.org

Hi,

Now that Clang's CFI has been fixed to do the right thing with extern
asm functions, this patch series is much simplified. Repeating patch
1's commit log here:

    The crypto glue performed function prototype casting to make indirect
    calls to assembly routines. Instead of performing casts at the call
    sites (which trips Control Flow Integrity prototype checking), switch
    each prototype to a common standard set of arguments which allows the
    incremental removal of the existing macros. In order to keep pointer
    math unchanged, internal casting between u128 pointers and u8 pointers
    is added.

With this series (and the Clang LTO+CFI series) I am able to boot x86
with all crytpo selftests enabled without tripping any CFI checks.

Thanks!

-Kees

Kees Cook (8):
  crypto: x86/glue_helper: Regularize function prototypes
  crypto: x86/serpent: Remove glue function macros usage
  crypto: x86/camellia: Remove glue function macro usage
  crypto: x86/twofish: Remove glue function macro usage
  crypto: x86/cast6: Remove glue function macro usage
  crypto: x86/aesni: Remove glue function macro usage
  crypto: x86/glue_helper: Remove function prototype cast helpers
  crypto, x86/sha: Eliminate casts on asm implementations

 arch/x86/crypto/aesni-intel_asm.S          |  8 +--
 arch/x86/crypto/aesni-intel_glue.c         | 45 ++++++-------
 arch/x86/crypto/camellia_aesni_avx2_glue.c | 74 ++++++++++-----------
 arch/x86/crypto/camellia_aesni_avx_glue.c  | 72 +++++++++------------
 arch/x86/crypto/camellia_glue.c            | 45 +++++++------
 arch/x86/crypto/cast6_avx_glue.c           | 68 +++++++++-----------
 arch/x86/crypto/glue_helper.c              | 23 ++++---
 arch/x86/crypto/serpent_avx2_glue.c        | 65 +++++++++----------
 arch/x86/crypto/serpent_avx_glue.c         | 63 +++++++++---------
 arch/x86/crypto/serpent_sse2_glue.c        | 30 +++++----
 arch/x86/crypto/sha1_ssse3_asm.S           | 10 ++-
 arch/x86/crypto/sha1_ssse3_glue.c          | 64 ++++++++----------
 arch/x86/crypto/sha256-ssse3-asm.S         |  4 +-
 arch/x86/crypto/sha256_ssse3_glue.c        | 34 +++++-----
 arch/x86/crypto/sha512-ssse3-asm.S         |  4 +-
 arch/x86/crypto/sha512_ssse3_glue.c        | 31 +++++----
 arch/x86/crypto/twofish_avx_glue.c         | 75 ++++++++++------------
 arch/x86/crypto/twofish_glue_3way.c        | 37 ++++++-----
 arch/x86/include/asm/crypto/camellia.h     | 63 +++++++++---------
 arch/x86/include/asm/crypto/glue_helper.h  | 18 ++----
 arch/x86/include/asm/crypto/serpent-avx.h  | 20 +++---
 arch/x86/include/asm/crypto/serpent-sse2.h | 28 ++++----
 arch/x86/include/asm/crypto/twofish.h      | 19 +++---
 crypto/cast6_generic.c                     | 18 +++---
 crypto/serpent_generic.c                   |  6 +-
 include/crypto/cast6.h                     |  4 +-
 include/crypto/serpent.h                   |  4 +-
 include/crypto/xts.h                       |  2 -
 28 files changed, 446 insertions(+), 488 deletions(-)

-- 
2.17.1

