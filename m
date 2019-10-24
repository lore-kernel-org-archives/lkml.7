Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FF7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401620663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1/fHDmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfJXWRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:17:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42507 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJXWRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:17:22 -0400
Received: by mail-vs1-f68.google.com with SMTP id m22so117901vsl.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHNXsthwregcyrL2BKVfLqYllW87y6QVnA+Lbr5Rgec=;
        b=u1/fHDmx2F03gUdsJoRaJfl7aP6BcoOTQj7WuOKplTSdf6uXX1E0Rf1hGTjZ93euSU
         NJGI0hMli675V4W1F5aGYPIB6vXEndENuc9l4uQvSvWlXKnpA/Q0fOf41lKCkzVymcMj
         vSAvJbnieQzBs39rOqmCk2ja2JZ+n2tLqqkQvWScrAsxpi7g4yEkQAJHTgbS1XIOEKGc
         ZIEUfghKoKXuOS8kPtcMk4jtp/voE4nzOI5nX/zgK6dajQqfV49v6nb1hfQWLq1Yey8y
         KbnrEILxVOYi9Z6E2nmjX/uSwH9bskxev0otzP5fbZ4T6AZwWHNu+W94Q+UntLXVb7q4
         mXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHNXsthwregcyrL2BKVfLqYllW87y6QVnA+Lbr5Rgec=;
        b=tb8St/Y4d59bC7Mcc79kSO2BGuzRDkRWJVi9SCC8GO7pPYPHQJl1DbjjbuP4mU4Gur
         nenAgViiTQOpvXSDwEOxP9aV4n4wkWv1TIfWHMjrLST3hzhK5PgKjOSffJXVV72ev/8o
         LiopuaXj2gHAvbPAE/R7a0l70wIPDOrq1YXHaqYjBl6MYgWFIXacn0m7307VZExDS96Q
         b5XQ33C4Ib9wNJH1FOd30RzjKDyq/uv+1Wovh7t9A0UWdqtiO8rmMzSi+EMBKMq2UIFt
         XeuwIb/zBkZSyAXxXbsWSdGoLH6RG+z07xWCZtX5u5J27/jkzyEkFSAPrF433kJOtd4t
         qVFg==
X-Gm-Message-State: APjAAAUU0zZ0U7xYSqTKlTwv/ElTxyGx+ZNpDofI8cVM8QD2Ec1e/vgl
        90CEyc1B/Sis5WNbTxVcLffSvi5lJmuT/xuyAcUfOQ==
X-Google-Smtp-Source: APXvYqyC5R+J94HY0QZwShcMklCS8zj2eZiTO4Hh3KIgdjFp8g8gOvA8xc0s1anKvCDkBcvEQB2MlCQ7jEx4vRyMG+k=
X-Received: by 2002:a05:6102:36a:: with SMTP id f10mr324969vsa.44.1571955439473;
 Thu, 24 Oct 2019 15:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <20191022162826.GC699@lakrids.cambridge.arm.com>
 <CABCJKudsD6jghk4i8Tp4aJg0d7skt6sU=gQ3JXqW8sjkUuX7vA@mail.gmail.com> <20191024080418.35423b36@gandalf.local.home>
In-Reply-To: <20191024080418.35423b36@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 24 Oct 2019 15:17:08 -0700
Message-ID: <CABCJKueb=xZzXBegc58aWRqPq6eCOpBf7uyyzVyNMujDSHhm1g@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 5:04 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> You can remove a CFLAGS for a whole directory. lib, kernel/trace and
> others do this. Look at kernel/trace/Makefile, we have:
>
> ORIG_CFLAGS := $(KBUILD_CFLAGS)
> KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))

That definitely looks less invasive in this case than adding
ccflags-remove-y, since we only really need this for one directory.
I'll use this in v2. Thanks, Steven.

Sami
