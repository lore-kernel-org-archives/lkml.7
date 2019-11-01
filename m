Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA12CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8324920650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4gJ23AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfKAPou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:44:50 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40319 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfKAPou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:44:50 -0400
Received: by mail-vs1-f67.google.com with SMTP id v10so6619878vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EryZRTfyuksqxAOsiXgBnBsO6Q4g8OGONpcbT/2UUtU=;
        b=g4gJ23AXi6bRyNKKbF6kjh2Pk/SIgEmk0fMp7yU2OpLF1/ZSxEbdKQ2jcL1t/s7J/0
         r0bV9COqOeg4Cq5X18jTt+9/QOwnZtzmoXU43GWevEdIG1WGMtRc2pCbbksNon998ATC
         RYHfnk/oc6w0lpn4KlG1RD+XtSSxaBWmYd1V9RlWndHbQ5tvHLVM2OtZ6ek4cI2xWRNt
         R3iakDWD0UnL0SsREP4Ka3pRfim+0rka4bOI/E6Y1rBKqdoZulqYrnLmldF6BQw22qOB
         hqW6VUonfcohOf+Nawcc27KX/td24YYGGrBLxrNdceLzOMTOw2m0wiX1Fd48dG5wZunR
         2c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EryZRTfyuksqxAOsiXgBnBsO6Q4g8OGONpcbT/2UUtU=;
        b=sCLG7ywbulqNhkDcTlJ9BUPjtq5SrI5dcdNvfzzK2s28PApo8CCd9XI0gIfxV+Rmwg
         STrEqPj8U9W7lU78fSWODgs4/bsDtGbFEH5srsZ9663BPfyCWZGJJ0u24h0rUhLX5PPX
         t64EzdeMN3KPTmJqZCIHkLykOqEF5Uz8wKxbQdKsN66XwZAkc9TvHLFuL+W96lv4dloM
         Y3cd2aeKVUdWj8UE9wN0gAHn2zYNGfrni53uMGjc9UdcCMb9vVds4ig3W4uMOyKvfMVn
         0oz9inHeF7pj0Rlred7x5D6SncW0jWaUe53KAKlBcCJrGFkq0R6AHLfFu5qu2948oeTc
         z7mQ==
X-Gm-Message-State: APjAAAVDM/OX0m7a69CIyS9taOzSHZXrK5atx8Tdqi1g4G3tz7DWpR73
        SLB44Xk+fxJvd/Oalq5Elg83FpPWG1DWIbudtZe05Q==
X-Google-Smtp-Source: APXvYqyH1Rx5ASstI+WbI3lXJTQCoOfcyvqAY38q2Tn/ntuwQF2PZaPqzpHPsoiSZYGDDuhXsCRPVJfLzeJkdoFRyBg=
X-Received: by 2002:a67:e951:: with SMTP id p17mr3253133vso.112.1572623088869;
 Fri, 01 Nov 2019 08:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-18-samitolvanen@google.com>
 <201910312042.5AF689AAC@keescook>
In-Reply-To: <201910312042.5AF689AAC@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Nov 2019 08:44:37 -0700
Message-ID: <CABCJKudW0tFrWryKj3-xW_eLWPSpCkaT9a14c9PH4a6-TT_=iw@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] arm64: implement Shadow Call Stack
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

On Thu, Oct 31, 2019 at 8:45 PM Kees Cook <keescook@chromium.org> wrote:
> The only suggestion would be calling attention the clearing step (both in
> comments below and in the commit log), just to record the earlier
> discussion about it.

Sure, makes sense. I'll add comments about this in v4.

Sami
