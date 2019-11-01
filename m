Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637F0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3538E20656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ai3N6Ic4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfKAQ2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:28:36 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33810 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAQ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:28:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id q16so3093806uao.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cugJW9F3kTAr1l84/vLpT5yr86XijpMcBnCXxXWK4UA=;
        b=ai3N6Ic4RRGuSAsXlls5IzMaslA5Wbr/HVntf4UgHRgBb1znSgpSqTQDhgWkXAk5oM
         H0TMkU5NqeJqmaviuucs+F/wv2mYGbxw4p/TlWjmTA7nxtnYoIewy1UZepA7s1zvqFi+
         J0gxVuzM5VGToU0Rd8Mze3tyCLh7RZ7qRdkeI4u+x2bACiJuZjdPOS6PF5wclT402Cyl
         E4V47Z+G3JNyTOeTMcNM9nltwL7iNcdGY46YKNmZkjxzRh51T0x1vup1917ckL2zPFgG
         WhafP3q/o/Aolmq4VvLO1/E0Za4fVCa/z+d1jFfQQJXZNS7+zE2mjM1J0A4RaF2Z5bp3
         En0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cugJW9F3kTAr1l84/vLpT5yr86XijpMcBnCXxXWK4UA=;
        b=R0SPez6SqALJIX5Kho1egOJ8evo2hDwV5ApaPn9jm+g2o//vgPCl6/8WKul4M0xW+R
         6SpdBxh6vy25XKIfuCibjsXhSX2O+/ZDYiW1cyn4cYwzH9sCMpMpZrTYsPi41/abr+FN
         vRICmcqGuFAEN5m/oOcdZOnzdSZNG/mvMuxnjiV5TtmUI4R/4M/fMAlPatP6mkpJyo6l
         Lz5GB62ISlL4msudC8O7MOsEjMzDVDihy7adoRVlxtiVv8KMp6OY7IwQSIvuvqoW8txP
         /JDEgQp1bnTXHGy0sMDXvQo2gusQspAPJBCne8PopoB5+VuQzwcu01KUgOoHjtTEiH+Z
         2AMQ==
X-Gm-Message-State: APjAAAVDIluvrwKLsZN/nCpdrsaspvfgT+PWUa7rwg2kyv+Tbu4eVQzy
        DPPMNf8GlYth7ukX7iH9CO7eXp4eUORnopIATPtfFg==
X-Google-Smtp-Source: APXvYqz0PMfInUZYTnVA7QuGr/acGPXLqC8RP/nrNkyeFglf9nt3ZmPDMS4W5mUNYn60Yk/KFVXZFpuxRp6NFZg7Kqc=
X-Received: by 2002:ab0:2381:: with SMTP id b1mr5975220uan.106.1572625713398;
 Fri, 01 Nov 2019 09:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-6-samitolvanen@google.com>
 <201910312050.C538F8F3@keescook>
In-Reply-To: <201910312050.C538F8F3@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Nov 2019 09:28:21 -0700
Message-ID: <CABCJKueLtOJsq+k-ywyUCOU+QCqxjKN2bO76Te4U43g0Xp9g-A@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] add support for Clang's Shadow Call Stack (SCS)
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

On Thu, Oct 31, 2019 at 8:51 PM Kees Cook <keescook@chromium.org> wrote:
> > +/* A random number to mark the end of the shadow stack. */
> > +#define SCS_END_MAGIC        0xaf0194819b1635f6UL
>
> Is 0xaf.... non-canonical for arm64? While "random", it should also
> likely be an "impossible" value to find on the call stack.

Agreed, and yes, this is non-canonical for arm64 and AFAIK all 64-bit
architectures the kernel supports. I'll add a note about it.

Sami
