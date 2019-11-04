Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D33CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CF920848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHQfGMcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfKDVon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:44:43 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38627 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfKDVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:44:43 -0500
Received: by mail-ua1-f65.google.com with SMTP id u99so5470700uau.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaXvf9wE3k9UaecG65PnRrmHU9a0z9eeJYq+CJlozEg=;
        b=pHQfGMcFvDs8Sz/sj2D9FDXz3MnOQRQu+N4CdnI6FNzotw2uFLAsGlw2AfCslqt5i1
         NhuT8B5Ezfwhp9svCCthVzKrqQzSaREP2/BOyA4VdDO3mOGFMeEnNqjZV9EKKb5BwgAH
         bM/dxgbkeGBwpw6v8NjWHN7WfR5TQqN/xXvS5kz11espcMoT6/ho31I/XOxv81JBcV1z
         GeqbggJuYjxj2QeyalY3/MCFCfCDWJn8/AxC+ZFPpCHvzX/Cpnxf1nw4yPeZBVh+ScLp
         O8nGwga8BiVRzIj9L+z7DaZgwmXUgoNZyiEQqIULFC5kXaLbkCP27rPqGbTAVSPqhK1Q
         tN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaXvf9wE3k9UaecG65PnRrmHU9a0z9eeJYq+CJlozEg=;
        b=pw85w+UJJW7EwfDR36rUuhDvNoBqU5654RZC08wpQ9HN/WIG4jq87LZVM2gG6gWZ7E
         4+7hTnY2T4k2MNWyNDrjiBddoRvs+kA9hVAHm3vonYZ52ejb0RGIPHbgGStGclq6dkUJ
         TLoezRK0uSfjw+henWgWAoUqknWUtsagGye0RqDNDwMKQ4ZXw6et2UB/oO3DPVXaK2qy
         h5iuhSYRakpfFAHwxp/jELtp5m2E7vyVCaGyjqRsyEppNjN+xRTM5bvnIphsFPcCEmMr
         HkeDbpnIF9BM/xtD2rqKJ4lGqXfRM1aSdUoFHREz99hJYYkZWTirj/nOUWzE9OGt8qSD
         f1ZA==
X-Gm-Message-State: APjAAAXFELOFzea8TmKoRoaAgy1ttYmEvI5HSgafW8zPT7kuR31biVWU
        /dKrt+/GEC0pm67Lr1bHTlc6AWzppYTXfrKyi3mprQ==
X-Google-Smtp-Source: APXvYqyozZ81Thh7mlXHgf1QUiqKh64ERV1FrTZSir+nNNiHAQ72oavyDPOWqxJDAI6llfn+2fNkSSVjyIyFG0syB7k=
X-Received: by 2002:ab0:5981:: with SMTP id g1mr1829842uad.98.1572903881724;
 Mon, 04 Nov 2019 13:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-4-samitolvanen@google.com>
 <20191104115138.GB45140@lakrids.cambridge.arm.com>
In-Reply-To: <20191104115138.GB45140@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 13:44:30 -0800
Message-ID: <CABCJKuf4wi6oUkJ68Z49UkK5q4WYYmSPt1X0pyw34ueNMkGC5Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/17] arm64: kvm: stop treating register x18 as caller save
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
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

On Mon, Nov 4, 2019 at 3:51 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > --- a/arch/arm64/kvm/hyp/entry.S
> > +++ b/arch/arm64/kvm/hyp/entry.S
> > @@ -23,6 +23,7 @@
> >       .pushsection    .hyp.text, "ax"
> >
>
> Could we please add a note here, e.g.
>
> /*
>  * We treat x18 as callee-saved as the host may use it as a platform
>  * register (e.g. for shadow call stack).
>  */
>
> ... as that will avoid anyone trying to optimize this away in future
> after reading the AAPCS.

Sure, that's a good idea.

> >  .macro restore_callee_saved_regs ctxt
> > +     // We assume \ctxt is not x18-x28
>
> Probably worth s/assume/require/ here.

Agreed, I'll change this in v5.

Sami
