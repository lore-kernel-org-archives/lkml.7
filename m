Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DBC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B082B2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXte6O0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbfHGWQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:16:16 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38533 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:16:16 -0400
Received: by mail-pg1-f201.google.com with SMTP id w5so56427846pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WAx2iZwY+b66jFRqTbeBjgCzUPOFgxIWR/mlIl2o4o4=;
        b=SXte6O0s2gqT/sciaXjNXKFl17t0HVM1stklZdU2I0M8JAmFyxOLldcjSeEZv7NkbW
         MfIV4R/1Ea6JaDY+vDOFRvkW96Zl2+OA9FxTDjGksdhXjj8cz/zgrD0zok3Gr+9SEix3
         C5dUfTCf5c6Ql3efXBJ0o7Y5jHMOdZZhHlsPvPHL7CRdG1ojq044YORZE28q0n+DprU/
         T4T/AsUTUvRqAiKONWJ4FH1NJzEhifkVioBybgvVcmkQuF316JsuyI+8GCG/N6wgxXnq
         DwCjHBp3MiSO9igDj7OpESYZZ0oHAJsFuqE1r0BfVl86uOc2WQS/wWNtfSRPlGAFswCG
         UU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WAx2iZwY+b66jFRqTbeBjgCzUPOFgxIWR/mlIl2o4o4=;
        b=cT0cettAmx2R8zV0n7Ocw7IvtTpecv66JwsAIKyrIN/MyElQoNv++cyeWZzfhDGeSA
         yFhO2gAmv1teL/MV09ecZsc+O+9csym2WmRIm2wYlQyOXr3AY4FdjgCaA0QL0NMmPDir
         DuiwcIIS45bZszAd7D34NqPxb3+K0/A6jqxeLcxQLE7nXnRCN4+xSM9jizOlLqEIL6jf
         FDE2Nk2FKyMarCwo4fBLUewWtJDfE7apDcsSqW2Pl0BWeTc8SjE2GKBOOJDuU7/x2TB8
         VyQvNPzBsAjXzhCQrLQMxFhOM6RbVrOClKr76uXBNct9ZeYFtOE4jxj/dpXpHW5wdi8+
         KxLw==
X-Gm-Message-State: APjAAAWesmOFqdCTPIC+fOJJQ87GsUWzAM+NqjLkqYkcUqhuHvpyvJsl
        zp+7NyR30vfGkdMuVOPlFldxxTo29ajTkOBHA7A=
X-Google-Smtp-Source: APXvYqw1TbwYP68dOQBj7b5A0KG60WzILBZYnIqPNNmp62W1XGaUxkYogiPnNTWl1QbbJoJ1i3Sz6VoZqKhkyAJUbxk=
X-Received: by 2002:a63:9e56:: with SMTP id r22mr9652732pgo.221.1565216175000;
 Wed, 07 Aug 2019 15:16:15 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:15:34 -0700
In-Reply-To: <20190807221539.94583-1-ndesaulniers@google.com>
Message-Id: <20190807221539.94583-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190807221539.94583-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v5 0/2] Support kexec/kdump for clang built kernel
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Reuse the implementation of memcpy and memset instead of relying on
__builtin_memcpy and __builtin_memset as it causes infinite recursion
in Clang (at any opt level) or GCC at -O2.
2. Don't reset KBUILD_CFLAGS, rather filter CONFIG_FUNCTION_TRACER,
CONFIG_STACKPROTECTOR, CONFIG_STACKPROTECTOR_STRONG, and
CONFIG_RETPOLINE flags via `CFLAGS_REMOVE_<file>.o'.

A good test of this series (besides boot testing a kexec kernel):
* There should be no undefined symbols in arch/x86/purgatory/purgatory.ro:
$ nm arch/x86/purgatory/purgatory.ro
  particularly `warn`, `bcmp`, `__stack_chk_fail`, `memcpy` or `memset`.
* `-pg`, `-fstack-protector`, `-fstack-protector-strong`, and
  $(RETPOLINE_CFLAGS) should not be added to the command line for the C
  source files under arch/x86/purgatory/ when compiling with
  CONFIG_FUNCTION_TRACER=y, CONFIG_STACKPROTECTOR=y,
  CONFIG_STACKPROTECTOR_STRONG=y, and CONFIG_RETPOLINE=y.

V5 of: https://lkml.org/lkml/2019/7/25/1276

Nick Desaulniers (2):
  x86/purgatory: do not use __builtin_memcpy and __builtin_memset
  x86/purgatory: use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS

 arch/x86/boot/string.c         |  7 +++++++
 arch/x86/purgatory/Makefile    | 29 ++++++++++++++++++++++++-----
 arch/x86/purgatory/purgatory.c |  6 ++++++
 arch/x86/purgatory/string.c    | 23 -----------------------
 4 files changed, 37 insertions(+), 28 deletions(-)
 delete mode 100644 arch/x86/purgatory/string.c

-- 
2.22.0.709.g102302147b-goog

