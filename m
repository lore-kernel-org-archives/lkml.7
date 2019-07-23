Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99391C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647F3229F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXAWs6d2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392042AbfGWVYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:24:48 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56492 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfGWVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:24:47 -0400
Received: by mail-pl1-f202.google.com with SMTP id o6so22734065plk.23
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ds+yDlyVjybdin7f83dyTCd0MUOnW1rqJpaXINk50aY=;
        b=gXAWs6d2vlg5BYWrnPRZwakEFntdJVkTe2aKhDwU216RDblqMWjy0Qs40H075C/NuS
         kztEgi0juyk1ocSdIn6Mj3Uh5VsdGEuKaJMiqhLYTLC+hGPHfmILvhece/gb8Kn1ZSM8
         sJcF/uITqnLsw8glV/BmivbZ0zgMPgYuxS9QZ3hjgC+Mxk5WVQS4aF7OTT/fs8IZOb4v
         R3zc2ks9rcV3MaxCgiNa9cqUjMvOeQWgsytHTXv7THgoVmnvQhfH7mE4iytWW74xOHz2
         Hj18LQIEP6jOmEPouijbybHC/RMmH08o3G5rhJ1F/Kpy4llOsgrP8K6hKiH0cweJnXZ+
         IyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ds+yDlyVjybdin7f83dyTCd0MUOnW1rqJpaXINk50aY=;
        b=OxrIKr5P7AF3A2a/GnQXeUX91uqNjfAQatseeKHc48Tu+/FNzlhYr/PTaKUR23etaC
         LR77Z/NRQPdvuG6OYSXQx86qn4CSoi4fB6OrpLbW3cx0ymdjNCrCpyaPKgIs2Q6yENT1
         LA2hRlGtFghMe0gn2sJNUOVvB6HydW1nD/rP5RyAbyicdTa4jP7eNjos83zbEBSyRRHK
         nGdmJI3Dys2QFIfNGCXRfFRbukyi9wPVZu/HCYqw0RqfeRceqblBXVYlsFvlVSI9utNk
         QTtvnBoAC0DUz+M7ujdvb9C09Fm2qdnQt7bqmSBV8CMTgqJoj/XS6UoG9gAcDHSnNk47
         RMWw==
X-Gm-Message-State: APjAAAWLHjeeJUMDmlKGL8UasM4FK8g2KMxUpm4SBviZeVmuqQv4m27O
        W+WkTT4SOCchNRTgGqnVYyQLqO+ZRmPsmLGP3Ns=
X-Google-Smtp-Source: APXvYqxiSMNoXZNRJOiGmRiGNGuHdU6Za9rkxXjfGN35PlZJLxXSGmevxunC+0uwyuZWr4IwDRK4ZHAybRL+jF1pg+0=
X-Received: by 2002:a65:6448:: with SMTP id s8mr78700016pgv.223.1563917086436;
 Tue, 23 Jul 2019 14:24:46 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:24:12 -0700
In-Reply-To: <20190723212418.36379-1-ndesaulniers@google.com>
Message-Id: <20190723212418.36379-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190723212418.36379-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 0/2] Support kexec/kdump for clang built kernel
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

V3 of: https://groups.google.com/forum/#!msg/clang-built-linux/GzThkAkZqqI/J727I6vpBwAJ

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

