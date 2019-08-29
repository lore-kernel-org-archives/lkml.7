Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21524C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C722070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlL2hAot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfH2OOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:14:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41888 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH2OOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:14:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id m24so3191208ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZPXqqYLvYN4nDDMAMbMyVJNvSWypAmknhRGtnG9An0=;
        b=KlL2hAotI+Z9cY+vLTcjRK2l4vLCniCUDB73rwQchP635EqH94J6VH3zfuR8gkDpcU
         exeYmRnofhSEHsgOWkZZNKFKPwlmx1UvpU7pYWQGScpMo9rKeZJEETGuARcjSqCIg96Z
         LQnehM2j8IsT0eoi/Tl2XOReGvz4z6CZSpvr3tG6oToGwEKfm+UvVAwNVBeoGwU1tbx6
         4Yd70kNlyZdZZ2yp/3oatnErKk+9I97u/mctJDo4I/h605iqsUDJ6HCfLwK6s0LS/Z/e
         u4oj3Fk4ShYtQWxQUsQdcDkWKRDCen898Mr+X1Ohapkbrx0EuqgICYR8N9k7SKhuF/vr
         fBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZPXqqYLvYN4nDDMAMbMyVJNvSWypAmknhRGtnG9An0=;
        b=pSWfj7Gyx+SD8p4cML4X1tahgKEr/R85vo511no0itPEA7IMGkwh7gSdhUtOItMQ5Z
         iWANgA84RrwqVwk+IvKuCPWgwBbNkIy/7OHmNll7q5sY9NLgGuaMXdxveSdeUdsMW4AI
         m42Bkwb180dnlI0nM63ZXsw2hj+OWNEX7RmVkDYueYVUFtM5a3MVnvU7/9NkwoLFnkMq
         kw73MvVJA6COrxvhMW/OOX2KTeczQkUVuBeVt89iXl+kNYeHg9GglFrb5hr983G2SRWc
         2P2F8M1H8PVo8B3GNy2wPTjwrqdQZo2foPIScTEgn7crF3VkwzxtvVmEO2CEnmWn2frQ
         VdoQ==
X-Gm-Message-State: APjAAAXqIHPqDtP7uUUcZDPmSXDA9K8WOO0vCUOc3ySsVU3vLJHZO8jO
        s1e+RJ2MUlz0Wv9bHgAlT7ldyhbu+53DLepdNVg=
X-Google-Smtp-Source: APXvYqwVXF45iA4SPxnty9W9MtJC/8yxJzML9QIFcOs4Sg0ut209ynRlBwkOKugQgTb11H/Q4VpLVg3ZVRphVg0IX5c=
X-Received: by 2002:a2e:2b0a:: with SMTP id q10mr5433518lje.203.1567088053585;
 Thu, 29 Aug 2019 07:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com> <20190828225535.49592-11-ndesaulniers@google.com>
In-Reply-To: <20190828225535.49592-11-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 29 Aug 2019 16:14:02 +0200
Message-ID: <CANiq72mQihii6xaP1pBfyDin3wZOOuMdh9PGAKbmuAPovhV7gQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] x86: prefer __section from compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        David Miller <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 12:56 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> diff --git a/arch/x86/include/asm/iommu_table.h b/arch/x86/include/asm/iommu_table.h
> index 1fb3fd1a83c2..7d190710eb92 100644
> --- a/arch/x86/include/asm/iommu_table.h
> +++ b/arch/x86/include/asm/iommu_table.h
> @@ -50,9 +50,8 @@ struct iommu_table_entry {
>
>  #define __IOMMU_INIT(_detect, _depend, _early_init, _late_init, _finish)\
>         static const struct iommu_table_entry                           \
> -               __iommu_entry_##_detect __used                          \
> -       __attribute__ ((unused, __section__(".iommu_table"),            \
> -                       aligned((sizeof(void *)))))     \
> +               __iommu_entry_##_detect __used __section(.iommu_table)  \
> +               __aligned((sizeof(void *)))                             \
>         = {_detect, _depend, _early_init, _late_init,                   \
>            _finish ? IOMMU_FINISH_IF_DETECTED : 0}
>  /*

I see other patches that reduce unused -> to __unused, but is this
unused -> __used intended?

Cheers,
Miguel
