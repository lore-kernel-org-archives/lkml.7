Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455D3C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF842054F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvitIodt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfGAQdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:33:02 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43507 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGAQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:33:02 -0400
Received: by mail-yb1-f193.google.com with SMTP id f18so188139ybr.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iebLtLWu418k95Kx2ofdTbul5h9LD/QgsmaJTNXUic=;
        b=YvitIodt8pObBJlcMj4/I4OBo2yXXRz78udE0mjFcaBpi15LhVR8eDKvR8c4d/aozS
         gIeQTDIzxUIkPZFNJHhMvD7vkxzCWxEyImFdPkW42dNX2PLGPmNW1FC7W2ByuMZjuys8
         fiLXkxNh9hJAIodVeGtVQBF5FSCDPBC9NtUZY0kjrwwFf58uv35aTkTEVzX1UTUk6r8a
         aslpezN1dBGILoh2tr9s1CzxMkSev+SOujMjsQgQgvCKyD+Ov6bHftOpFQt2t6/ty9e9
         iXD4gyRw5qAfZiiihfJNy0VBEMqBh7F51Fo94qJhSKSM6u2C3hVGQq8heqb3Uu7WvBMn
         zeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iebLtLWu418k95Kx2ofdTbul5h9LD/QgsmaJTNXUic=;
        b=YGYak7GEjDPiUr5hdRKDc0F9EupnsQDakS34C+NHxfA5dwL0NaB8BMSGIdyKNPzCzt
         S0Vho6N0v6bpv598hO2dR91nXN8WRHC6vdbvvqGYmViXUQ+hYgITI5VqJsmGLe9Kc8QT
         Z2Q4GT/mQv/rw0k5huEgHpWKW4MazXz265TBu1aq+vsE+4k7YLTJKFcLzg5txbdPEZq5
         6i4iPTpCPx/t3lf4mAYrLNX9/Tfva8MjYu+ZEl/blFevQMSuFYcsDaiDdBZgZKyatNgy
         kSBgxBJiLhm/gYP6LdkxRtaNGJOS6/8YoFOpNpNHh13a7hPKHJUIru+WnU29wMgiB5YP
         CaqA==
X-Gm-Message-State: APjAAAVExHSXpLyYj6EPv3whKVmp0XE13H8CurynXkIKDIWYCNkIJRsX
        RNLfnVxHX87e5vUz48R5XyenZaW/xrAOfaMf62ZtFA==
X-Google-Smtp-Source: APXvYqzgtEr9wX8WYSeyGwFxuZx2a50Hfm6Semoiiegi0woZ+2ZMYhI8rCjxozwhaJd1CrJIL57CcLPEfAfpBDz4OeY=
X-Received: by 2002:a25:1854:: with SMTP id 81mr16323730yby.152.1561998781066;
 Mon, 01 Jul 2019 09:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190701155208.211815-1-zwisler@google.com>
In-Reply-To: <20190701155208.211815-1-zwisler@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 1 Jul 2019 09:32:49 -0700
Message-ID: <CABXOdTdD1vWigFBEeQ5-O2myOVGAY-_oTf94Pgj3CxxEH8XE4g@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/build: Move _etext to actual end of .text"
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Johannes Hirte <johannes.hirte@datenkhaos.de>,
        Klaus Kusche <klaus.kusche@computerix.info>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 8:52 AM Ross Zwisler <zwisler@chromium.org> wrote:
>
> This reverts commit 392bef709659abea614abfe53cf228e7a59876a4.
>
> Per the discussion here:
>
> https://lkml.org/lkml/2019/6/20/830
>
> the above referenced commit breaks kernel compilation with old GCC
> toolchains as well as current versions of the Gold linker.  Revert it so
> we don't regress and lose the ability to compile the kernel with these
> tools.
>
> Signed-off-by: Ross Zwisler <zwisler@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  arch/x86/kernel/vmlinux.lds.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 0850b5149345..4d1517022a14 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -141,10 +141,10 @@ SECTIONS
>                 *(.text.__x86.indirect_thunk)
>                 __indirect_thunk_end = .;
>  #endif
> -       } :text = 0x9090
>
> -       /* End of text section */
> -       _etext = .;
> +               /* End of text section */
> +               _etext = .;
> +       } :text = 0x9090
>
>         NOTES :text :note
>
> --
> 2.20.1
