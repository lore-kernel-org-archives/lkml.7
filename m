Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E529DC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA4522CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+koLszY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfGYUHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:07:12 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50829 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfGYUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:07:12 -0400
Received: by mail-qt1-f201.google.com with SMTP id g30so45319335qtm.17
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ty05lRNnYEjxTaLhAlpE2gx2Zy7GWIE7L8QY/O06f/I=;
        b=L+koLszYgKU+7K9nKDi+EHeoRBBciyMOAI5YEVDbvAZ5G3sIs6JTFjtTJIKilccaLM
         c7LKP5MOeEt+hia2yo1iQh4XLA9TafkU+mdvYwPdkPODSqO2y7BTRagZkSdwWlpDwsfv
         b3exmk8ntSWX3XgsSuxyvD8gVy/Y/AljXpAJOO0sDR4KHMuZS1fbDY8x9klvQJCp8GfA
         ZfDHP6vPqBOrL+4vt6xcTU1ObkYGEbhgHrlUNYk5pgEDg7H5i9PUwT4QaRNoVxIms3WD
         +SalUPYER3CuQHjiTf9iexCPkW4BtXzvmrmqw613+y62lk/Lulg3pCCrGaZCZg8HnEei
         7v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ty05lRNnYEjxTaLhAlpE2gx2Zy7GWIE7L8QY/O06f/I=;
        b=EHqvdwPLDhubFGXDL3Wd12yRjR68lMmXVzeRZzx7oilhXtHhP647ztONetX6MwResn
         CbrAdpVx92ngy5e/XmyaD7IPHtm1XbteFLGlhmVTJFj6UaHaWhddMgd7Treq/GqHhl7r
         ijjag2mxMHgZ7GqhGYOkY9C0wOHno/S680Mf6sC8DkB1fVS+tV2dEqYkf1uxezQV3dBm
         TwodYLcR7JNsFSt1fAwbDLJ7GPdSrUfnfZHsTsgaNbRV/GPE3tvwMhAmz3WHRPYVpqjr
         NzHaxzKwr3EEe8r6luYr09ERDHE8zHU/GiiNEnaaWXJwjv3EXGQDBWmbA8qBsxwSkL9Z
         Z8+Q==
X-Gm-Message-State: APjAAAVBt55S/E+UXMDQ4H3NDSJKAHfQZ+xVHLLx4LNhALAzS3XCY7zE
        3fTKdn2vbaLBf1uQK7/I6U6QhGIhaPVeTmnv9OY=
X-Google-Smtp-Source: APXvYqw0907duddRtb4OUF5TewdHeasj/6+RTAfVpkbxz1rCPgrD2wgxG8RM7Saw1zlhKxYj72Ufj9JOySJ+X98mqbY=
X-Received: by 2002:a05:6214:601:: with SMTP id z1mr47731460qvw.197.1564085231149;
 Thu, 25 Jul 2019 13:07:11 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:06:19 -0700
In-Reply-To: <20190725200625.174838-1-ndesaulniers@google.com>
Message-Id: <20190725200625.174838-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190725200625.174838-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 0/2] Support kexec/kdump for clang built kernel
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
CONFIG_STACKPROTECTOR, and CONFIG_STACKPROTECTOR_STRONG flags via
`CFLAGS_REMOVE_<file>.o'

A good test of this series (besides boot testing a kexec kernel):
* There should be no undefined symbols in arch/x86/purgatory/purgatory.ro:
$ nm arch/x86/purgatory/purgatory.ro
  particularly `warn`, `bcmp`, `__stack_chk_fail`, `memcpy` or `memset`.
* `-pg`, `-fstack-protector`, `-fstack-protector-strong` should not be
  added to the command line for the c source files under arch/x86/purgatory/
  when compiling with CONFIG_FUNCTION_TRACER=y, CONFIG_STACKPROTECTOR=y,
  and CONFIG_STACKPROTECTOR_STRONG=y.

V4 of: https://lkml.org/lkml/2019/7/23/864

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

