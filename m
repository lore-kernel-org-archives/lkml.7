Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C70CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82D820679
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llfdsR0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfKAUdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:33:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46889 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfKAUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:33:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id m6so627271vsn.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dKpzKxgNAxP7uchZEE718nvYJMIp2XAO+c9cDo3MTw=;
        b=llfdsR0mFeyjibNMIjs4xEF9RnIEM/F4fsan8LefCEHgwtIYNAOKIWcaMLXCPUXpJ6
         A9Z8a1hAgX5vph4HYseMN3OqV8I4aKmmq61yuf71G+j+fbM6F/3QgbQISzZRx++xQ6uQ
         rpxg24u1nhhkPdYZ+GFUsMLFT0BeCg+0eevZt88sPMVsXoz6DTHteeXsogaoUL2SzY9v
         ghKr14XCTinh2/ic+0QjTvbuoVjhyxGzJVQN5RBRvaOEv1Ld5FTshxsndE4TaEObzpiZ
         /X2kDb3o7l53lLDAuOgjn1yk+JP4f9YS1pPMkt9P5uzVOg4IpQmpskO8NUzz8gBdCY7Z
         QN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dKpzKxgNAxP7uchZEE718nvYJMIp2XAO+c9cDo3MTw=;
        b=r6ONq7BS4w/VBqpZeBDGg9P6gfR1Yp6+dQogNRtwF1amCYKH6WifHKkYmnXQHvDzQd
         avF2QneN8RFfrFN6QaMiXW5r7bK8VH7Mp9qYRzASCi/nNrS17FvagIN/lccYIcbSKDDm
         CR6MNS2GbjcRv4L5er2apLchmw0KwJpSPSFO8zYm/ycyQpLW/Tiut0/0UNDf3OjohVVs
         aYONmGgIywtKGO7phVJgB4tF4n1zWFuNN18X37XTVTtEiT1rqAICw+QynIZXXCr+X64g
         /OEDwIE1qUBA2+BYITuU2tJceUG5vRU6jvJ2/PK6DWHEo1N8dCOCRX49Lb2HmGWYsiwq
         Kltw==
X-Gm-Message-State: APjAAAUylQy2Sn+mkUpdX/mxI4MuMZ3zTuUboZQO2HfRgZH0+FPT/qWz
        CIdxfxVYc3HGRl45lfgMape41SJy1al1NAWxkRR7nA==
X-Google-Smtp-Source: APXvYqyDyHEaxIBZlzITcLvjh/p5XeQ4QgzocUuUCOwXN0WOuNqq+ARu4A8BUTsto1yGSfnwMlhvbSnvYIziXBMnd3E=
X-Received: by 2002:a67:e88f:: with SMTP id x15mr1725327vsn.5.1572640378099;
 Fri, 01 Nov 2019 13:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-12-samitolvanen@google.com>
 <201910312056.E3315F0F@keescook>
In-Reply-To: <201910312056.E3315F0F@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Nov 2019 13:32:46 -0700
Message-ID: <CABCJKufrebN0C-9m09bXPMhqfB7tkiaaPvuG8+pJSszMBHYcKQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/17] arm64: disable function graph tracing with SCS
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 8:58 PM Kees Cook <keescook@chromium.org> wrote:
> IIRC, the argument was to disable these on a per-arch basis instead of
> doing it as a "depends on !SHADOW_CALL_STACK" in the top-level function
> graph tracer Kconfig?

Yes, that's correct.

> (I'm just thinking ahead to doing this again for
> other architectures, though, I guess, there is much more work than just
> that for, say, x86.)

We can always change this later if needed, and possibly figure out how
to make function graph tracing and kretprobes work with SCS.

Sami
