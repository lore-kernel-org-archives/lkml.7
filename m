Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA4DCA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D7D20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ofNboEQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407717AbfJXBsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:48:08 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17634 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJXBsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:48:07 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x9O1m38r025121
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:48:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x9O1m38r025121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571881684;
        bh=Pg0PBlnvPGzMa1Lyb7SgzTssmkI1SxEtJ6FEB1T4F30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ofNboEQUqp9lsgicKTvUAhaI7rxygS4zx6c0oGCexmwGMPEnMQ2X2tFyof+S6L0J6
         v0OmQrC6FYcrzKSBR3CwB375LfzIrrpjUdons4tKy3jNeXm/SD874D9IsRl4EWrzNp
         AjNjFCpTMcSsJCfcmcotwgHuxmfSEPWVX5uHhVjI3yoONOKjO0dL6pnEoKFQdXWHLL
         vpvhZaeulMcrd9JVnoaJWAOwCMbJzvw7ZD38JJ4c0m6AOkpSah3shwoWHWn0wGLBTf
         X7yYyHqp8S9OjAFYIPhc3QrG0AUr7iQoh/FqYciJRtC/TCAFmaJckK+MB/dxA7Z62/
         xXXczs18i3CRA==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id m21so6646308ual.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 18:48:03 -0700 (PDT)
X-Gm-Message-State: APjAAAXqhaCeoxRxgc0ESYmXbVgvVDmaSK8YOZsPnBkTEgPL8U/ThyJv
        UBXyk4V19NPdvI6B139gWmYTcC15+3sk/qZyUZ4=
X-Google-Smtp-Source: APXvYqx1CqHmDEr3VPRqLGPoMM6fTlsUos2Z4E1CXGQPNl+XNURVhKBiM/jscveAYlAHmW9WHc6ytxEH92P8yvA+VtU=
X-Received: by 2002:a9f:3e81:: with SMTP id x1mr7475449uai.121.1571881682588;
 Wed, 23 Oct 2019 18:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <20191022162826.GC699@lakrids.cambridge.arm.com>
 <CABCJKudsD6jghk4i8Tp4aJg0d7skt6sU=gQ3JXqW8sjkUuX7vA@mail.gmail.com>
In-Reply-To: <CABCJKudsD6jghk4i8Tp4aJg0d7skt6sU=gQ3JXqW8sjkUuX7vA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 24 Oct 2019 10:47:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATrz4fTp1RWHfwq36M4Xs1CdkoZtnoYfZ4ouNKow5F0RQ@mail.gmail.com>
Message-ID: <CAK7LNATrz4fTp1RWHfwq36M4Xs1CdkoZtnoYfZ4ouNKow5F0RQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Thu, Oct 24, 2019 at 1:59 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Tue, Oct 22, 2019 at 9:28 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > I think it would be preferable to follow the example of CC_FLAGS_FTRACE
> > so that this can be filtered out, e.g.
> >
> > ifdef CONFIG_SHADOW_CALL_STACK
> > CFLAGS_SCS := -fsanitize=shadow-call-stack
> > KBUILD_CFLAGS += $(CFLAGS_SCS)
> > export CC_FLAGS_SCS
> > endif
> >
> > ... with removal being:
> >
> > CFLAGS_REMOVE := $(CC_FLAGS_SCS)
> >
> > ... or:
> >
> > CFLAGS_REMOVE_obj.o := $(CC_FLAGS_SCS)
> >
> > That way you only need to define the flags once, so the enable and
> > disable falgs remain in sync by construction.
>
> CFLAGS_REMOVE appears to be only implemented for objects, which means
> there's no convenient way to filter out flags for everything in
> arch/arm64/kvm/hyp, for example. I could add a CFLAGS_REMOVE
> separately for each object file, or we could add something like
> ccflags-remove-y to complement ccflags-y, which should be relatively
> simple. Masahiro, do you have any suggestions?


I am fine with 'ccflags-remove-y'.

Thanks.


-- 
Best Regards
Masahiro Yamada
