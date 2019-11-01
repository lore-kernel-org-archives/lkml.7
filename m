Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FBCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B7F2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LILcQjVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfKAD7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:59:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41048 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKAD7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:59:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so5605357pgr.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jWbfirm5A7lClilm5TrxMUwFVETsZ0QZ3dgXNGgwJk0=;
        b=LILcQjVb+J77OLR0Wqh8wnQrNbg/1wbjTbvcWvcASlmFUoRhF+FiABYaQL4F6fbQbF
         uxzeSY91YoL9miij3Kit1NzjdfNC1KqoUlTChwS9qCXgWIlOVwAzcIYT52gA3K2PVO/8
         zI4nwynvLe0KA4Pq1Usu8zAit0zL/9zkfYAew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWbfirm5A7lClilm5TrxMUwFVETsZ0QZ3dgXNGgwJk0=;
        b=Aoo2YyQra/pOyQfIAFsstX/g/hDyrqGh6xrwp275dbXTF6owcdOnlGaawIgG2Xx1Rh
         T5/VMOYMkOiwK/JopEmX31hN9g4ICtndMyxCnqfnaRxl1TfsLU9LEUxOOVB8uWGzmCHB
         AZdHBZgMN1whEwAY9RB2OP62OKwpm5QMmgNxqMPurN45hWhkWh7cv4CASQDhx74MhPxn
         E+cN/HVhG8seiAMGt6UVELkTAZaFAwI7qGUjDEkHNQCUqs1LHe0le2CvcEEHRBiudPy5
         EcQh/1AwphkRN3slW+sFK0ZndmFMwrb7ezTQzuNSXQFgIicTSGV/h7E0wzueD+vp64t/
         3SIw==
X-Gm-Message-State: APjAAAWQekpW3Lp/mwh/c8BK/hxXxR5VADTUQyD4dfHu0sistAcNCb9I
        gxFe2+GnbrNN9cKWkN519uPPGA==
X-Google-Smtp-Source: APXvYqy5NPe898RXSU+w1c0UaOFby31e22ngkYRTC9hJdLIA+7oZafTpdC/J3+7KdM9QjpM8htFvPw==
X-Received: by 2002:a63:ee48:: with SMTP id n8mr11288858pgk.374.1572580772699;
        Thu, 31 Oct 2019 20:59:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c184sm5427852pfc.159.2019.10.31.20.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 20:59:31 -0700 (PDT)
Date:   Thu, 31 Oct 2019 20:59:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/17] arm64: preserve x18 when CPU is suspended
Message-ID: <201910312059.59F983B@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-14-samitolvanen@google.com>
 <CAKwvOd=kcPS1CU=AUjOPr7SAipPFhs-v_mXi=AbqW5Vp9XUaiw@mail.gmail.com>
 <CABCJKudb2_OH5CRFm64rxv-VVnuOrO-ZOrXRHg8hR98Vj+BzVw@mail.gmail.com>
 <CAKwvOd=dO2QjiRWegjCtnMmVguaJ2YHacJRP3SbVVy9jhx-BWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=dO2QjiRWegjCtnMmVguaJ2YHacJRP3SbVVy9jhx-BWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:34:53AM -0700, Nick Desaulniers wrote:
> On Thu, Oct 31, 2019 at 10:27 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Thu, Oct 31, 2019 at 10:18 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > > +#ifdef CONFIG_SHADOW_CALL_STACK
> > > > +       ldr     x18, [x0, #96]
> > > > +       str     xzr, [x0, #96]
> > >
> > > How come we zero out x0+#96, but not for other offsets? Is this str necessary?
> >
> > It clears the shadow stack pointer from the sleep state buffer, which
> > is not strictly speaking necessary, but leaves one fewer place to find
> > it.
> 
> That sounds like a good idea.  Consider adding comments or to the
> commit message so that the str doesn't get removed accidentally in the
> future.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Yeah, with the comment added:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
