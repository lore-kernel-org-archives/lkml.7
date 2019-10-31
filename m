Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A23CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEB12087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zkd+dczq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfJaRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:35:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46527 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbfJaRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:35:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id 193so3538372pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vxne2J2U+zueRlGB+uihx88K5obGcz7JfVVNIfE6MI=;
        b=Zkd+dczqhPUCvaVxq3B8963P3V8Y9R+M6ldUJWVSSAWMYKxKqeHtnfr2PdTP/xQu2b
         M24kRR6f+BemlR/4Y0IvK/z1JsB3EOLUV7taiH84F2Ii6S/051a5P0kFaw58bDYFmRYl
         aNg+ivt2iWFLU8ljqbd20wQiN/S62lqFSuUkwS/f02KuHQnSP26/xslqjUm0PxnUl/nM
         qI0N36UakRSXzfSUr6wSxS+I2jAHofRSRz2rGKpUptLXuoFXn9q5tA4/x48cLuSowzWM
         m7sGquCCjWRdIn+Z2H+0+h0T7us+31n+XfF8IpapK82l/iCdOiiKW9oFk4wdTg6QArPU
         kr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vxne2J2U+zueRlGB+uihx88K5obGcz7JfVVNIfE6MI=;
        b=IoZbR+IGTd1TBxa6yu2/kqWmdzvAq6ljGirNK3U318UDll8sK90gSgGSIfiAD4pLSQ
         l+pJfIdKDf+CwPf9so33kOqpTfUNhd7GaAJ66DnKM+x+/xje0Cxqk1/YJHfd4u+v3OLc
         RA8pmiXdMLrHigCKRT4eOcpWDXZdFNwiXrzaMf/brDuO+U3sDE7JuKC7aQ7/KCRSE4bn
         7TGim1MNOmS6hTqnIq7K06utUwDUrXuZZavzQYPDkPa7zCRqviralNtrKVXf9cKoEZok
         Mgxf0uFpAlsaGpp73Y6akMK0Knev657pwuZH9GTdHAzKGaFA+be2SXYQpWSyfg4McYwb
         x/+A==
X-Gm-Message-State: APjAAAWDpYnggQs7dwspWEE7Ncte7miTrbK07c9xjz5UCJsf+ZYNkQqW
        acGuJKMlOBZOjRCpz3Xj+SrUIGlTPegUIOAyqvMYxA==
X-Google-Smtp-Source: APXvYqz/lhCOKKkE7+XVjZtp5lyRajdclaBkyDSosLmDck7GxCYMMFfzkg348/A5b/zQnTjld0uu3Efy3NYsSqb59C8=
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr8889337pjy.123.1572543304777;
 Thu, 31 Oct 2019 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-14-samitolvanen@google.com>
 <CAKwvOd=kcPS1CU=AUjOPr7SAipPFhs-v_mXi=AbqW5Vp9XUaiw@mail.gmail.com> <CABCJKudb2_OH5CRFm64rxv-VVnuOrO-ZOrXRHg8hR98Vj+BzVw@mail.gmail.com>
In-Reply-To: <CABCJKudb2_OH5CRFm64rxv-VVnuOrO-ZOrXRHg8hR98Vj+BzVw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Oct 2019 10:34:53 -0700
Message-ID: <CAKwvOd=dO2QjiRWegjCtnMmVguaJ2YHacJRP3SbVVy9jhx-BWw@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] arm64: preserve x18 when CPU is suspended
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 10:27 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Thu, Oct 31, 2019 at 10:18 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > > +#ifdef CONFIG_SHADOW_CALL_STACK
> > > +       ldr     x18, [x0, #96]
> > > +       str     xzr, [x0, #96]
> >
> > How come we zero out x0+#96, but not for other offsets? Is this str necessary?
>
> It clears the shadow stack pointer from the sleep state buffer, which
> is not strictly speaking necessary, but leaves one fewer place to find
> it.

That sounds like a good idea.  Consider adding comments or to the
commit message so that the str doesn't get removed accidentally in the
future.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
