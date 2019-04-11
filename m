Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598CCC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F8521773
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hqiF9XR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDKAdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:33:06 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:17163 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKAdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:33:06 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x3B0WwlL028763;
        Thu, 11 Apr 2019 09:32:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x3B0WwlL028763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554942779;
        bh=i+LyFugYRsMsRKj5tpFQqnuRxx8s4uixGuB3ZKdR1fg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hqiF9XR+odZ8FifL+v/BrYDdr2aUbZrGT60A0hmMyWnqBPdtOYEa3Yh5ElRvV5f1C
         O8icpHlR4abzvmAf6KWmTZ8UzmROSU92HdgcsCycYh4tmlUuQYj+oNGiwrghMReMxg
         Q2rPUmIMNBW8E2d3vXyyBPX5ojKNrgAvWQIQIBkYOmKM707XX7g/h3zu0Xk7qsniKC
         Wm1vNnG0w3CJeP7fi4Iv/2rijAy1/+YCVMTHuuk+Hjjk3XMLq3sncipr4zY9Dlz14K
         4IK3WgPXQ4PmbCWVIve5605zOpN2XJJCKTz+yGoWWAmMa3JsKHrD4YuUi1Pu9IbAxd
         HG80BvFoGV2VQ==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id d8so2486055vsp.2;
        Wed, 10 Apr 2019 17:32:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUg0tlYS07RwVim4vBJA/1O4GgVbsfYP9+iMhqtxOor1xLlTJqh
        Gp0ELKxV8cwuS8VLpUl/fXzUixLE+T1jaMM2Ggk=
X-Google-Smtp-Source: APXvYqxaLIx03ehW7G8KrJPwZ0yT2Nln13A7AJe0ZdEsIW+PI7jiRJQXndvJLIrWAomB0F9lhCnM7Q6D2xUrAucW7T0=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr27346942vsr.60.1554942777514;
 Wed, 10 Apr 2019 17:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190410155058.9437-1-joe.lawrence@redhat.com> <20190410155058.9437-2-joe.lawrence@redhat.com>
In-Reply-To: <20190410155058.9437-2-joe.lawrence@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 09:32:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_=bp0VTOze7ckfXSwFy0m_g6OYPxS5K-ac7jjoutB+A@mail.gmail.com>
Message-ID: <CAK7LNAQ_=bp0VTOze7ckfXSwFy0m_g6OYPxS5K-ac7jjoutB+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] livepatch: Create and include UAPI headers
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Joao Moreira <jmoreira@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Matz <matz@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        Nicolai Stange <nstange@suse.de>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 12:52 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Define klp prefixes in include/uapi/linux/livepatch.h, and use them for
> replacing hard-coded values in kernel/livepatch/core.c.
>
> Update MAINTAINERS.
>
> Note: Add defines to uapi as these are also to be used by a newly
> introduced klp-convert script.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  MAINTAINERS                    |  1 +
>  include/linux/livepatch.h      |  1 +
>  include/uapi/linux/livepatch.h | 17 +++++++++++++++++
>  kernel/livepatch/core.c        |  4 ++--
>  4 files changed, 21 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/livepatch.h



> diff --git a/include/uapi/linux/livepatch.h b/include/uapi/linux/livepatch.h
> new file mode 100644
> index 000000000000..bb86243de805
> --- /dev/null
> +++ b/include/uapi/linux/livepatch.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */


In my understanding, UAPI headers should be licensed under:

/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */


> +
> +/*
> + * livepatch.h - Kernel Live Patching Core
> + *
> + * Copyright (C) 2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + */
> +
> +#ifndef _UAPI_LIVEPATCH_H
> +#define _UAPI_LIVEPATCH_H
> +
> +#include <linux/types.h>


Why is this include needed?

> +#define KLP_RELA_PREFIX                ".klp.rela."
> +#define KLP_SYM_PREFIX         ".klp.sym."

These do not depend on <linux/types.h>



> +
> +#endif /* _UAPI_LIVEPATCH_H */



-- 
Best Regards
Masahiro Yamada
