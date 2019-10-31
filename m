Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C354FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F420650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 17:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKrGepNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfJaR1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:27:40 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46748 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJaR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:27:40 -0400
Received: by mail-ua1-f65.google.com with SMTP id i31so659973uae.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46AmydREw6SfU27IOaxxeyDyoZWG9jeVi2WIEFhrMqA=;
        b=uKrGepNXzPXDPzJbvbemKuf7R6S5LOyd1Myup06RKzLSP2nrNd0gQdYUKo5Mow3DAS
         +SE7IfD6gsDwY0qy8BSl0pYU8GPWYV87yKCwXeFmUj8tfcvjCxE6XCZvWViSX7BLJr2h
         JeRICf0gxuCWKgnMwiCuZSLMzerlDUIsThoYOFbNVmV4Iio6o99JIWYLgpdzR7oI4BDx
         tISF+YHwsfL5BB8DS6m0YqBcFdYRIfZsqtAtZCMGUCUGgOjGgmE4qf5gvZ9MBWNon0hF
         l2JKhPx8hF2es29OTb38GxXTjoyqOeNJvDE0LRnzacnT1nPR0db8A8Us17QUjMd2B+Rn
         jUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46AmydREw6SfU27IOaxxeyDyoZWG9jeVi2WIEFhrMqA=;
        b=lT2dbtZ6ORTh+rlD71NXXNgjr2olUht7e6XZSwCVcBCax/NSuyQVghcu1b+jqZs2B/
         yZw7X+CHzLb1ihr12axohwTjgiTsSYphjQkGCfsDCW5u8cgqtMJO2QCJvwpmaMnT3vny
         qi8PhR9VXutB2yBDV6XIIXQ9V81pocM+XrPorgWRGcQkt56EJ0t2C//PVY8juUf5j/e9
         lWUk9CTpx2rI2oHZpEK56g1GD2VGZ+HSPRg+cfiqhdGMMGt0s47HpR4ov+0g3GjcmUf9
         LhEPw+/W0zNkOI40PFlNmbd+OJTsXXC0n8p1mPrYWA2E6IsfrkqgXDAU99N8aziAdL8n
         bbcg==
X-Gm-Message-State: APjAAAXhrilFQwnygwXWMcDj5FlP28osF3YUq419H4g+/EuwpOZrCCHb
        w3SnovP/u4CaHhdc03m1k+6skNC5zJOcRCxqlCIRbw==
X-Google-Smtp-Source: APXvYqwHBpr5C3UNKE6XLzBUe1Jy/aZ4Jd12qOfI93i2wDsaUH2oAUrgK4KH1mAvPJ/zcWPVngS0f/6vsb1FU+PAYk8=
X-Received: by 2002:a9f:3772:: with SMTP id a47mr3382097uae.53.1572542858440;
 Thu, 31 Oct 2019 10:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-14-samitolvanen@google.com>
 <CAKwvOd=kcPS1CU=AUjOPr7SAipPFhs-v_mXi=AbqW5Vp9XUaiw@mail.gmail.com>
In-Reply-To: <CAKwvOd=kcPS1CU=AUjOPr7SAipPFhs-v_mXi=AbqW5Vp9XUaiw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 31 Oct 2019 10:27:26 -0700
Message-ID: <CABCJKudb2_OH5CRFm64rxv-VVnuOrO-ZOrXRHg8hR98Vj+BzVw@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] arm64: preserve x18 when CPU is suspended
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Thu, Oct 31, 2019 at 10:18 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +       ldr     x18, [x0, #96]
> > +       str     xzr, [x0, #96]
>
> How come we zero out x0+#96, but not for other offsets? Is this str necessary?

It clears the shadow stack pointer from the sleep state buffer, which
is not strictly speaking necessary, but leaves one fewer place to find
it.

Sami
