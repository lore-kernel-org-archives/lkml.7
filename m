Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3428CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836D2214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxgo2Wt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfJWFrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:47:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45840 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbfJWFrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:47:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so30552797qtj.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 22:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f9WOenHv0SsCyblXFz9SFK/8h5V+cleS3WS1obhs2JY=;
        b=gxgo2Wt/VlyBqp8oFAAjLMqC7k6nO1YSO/FNF8dk3j8nQ/EyIVLKI1nKcU4jaQFYuU
         NA+GgyhtaPNe6gPJ70LLC9kx3OcU/3gnBgfGK0MZM9a+5gYDBVXmqoNLVtk0xbQiVFv7
         9DgWISHTNoakaUGNQ5mW2JiN0MB7z/0Nj0axNTWpDRIwxpQi9IqSXpJcM6+kExdpncMd
         C3PeQUmGZQqF+BXLAAtqIxAd9yebkNPNVz/Zc8vGbFjcH30VnzUH6x7eSTxlqUPm2MTT
         wNTBO6b2qK0aD24xtQAV1IKh/FV6VleRo0XzYyJEWFl1ZPi1yEx+gLnXE1tkULKUxz2t
         KvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f9WOenHv0SsCyblXFz9SFK/8h5V+cleS3WS1obhs2JY=;
        b=SbLtYG2q2I3XPuftSna6WYxiZeg71c2aE2YSXotDZ4/vmIajLR78OFVNaGhXYiuxJA
         qUVgNgl58irnU5mX2kgMhP6r/HmLfU+2fqrqHFg6G6GDDjpHBdLS5jqGJhGmMqVHtyPB
         kOJ6yDY7h3U1th3afSuhtXdAtahIUzMUelfTijcPwo9Lye1jR2r8+b1krLWOQUJoaDLJ
         HZzAqU5/aOx0Qw03xrLZVC9p5YnBb1GyzqErydXybPflY4qH0P6JCa2edtbj0FgQ/Y5/
         9Zw719hxwgegOjfO4rr8UIluqYydiWsCwjeP1rr4WUEBBg13g5nc4sCYDUW1+tORCgqk
         USfg==
X-Gm-Message-State: APjAAAXLDLsrZjTgKD2TLQ/CxRzzmHxvTZQn5HSINo0gmzrLcr9cfpre
        vrKRAnG4i1DJlP98ZtU7nKtOih0bzBirjVYVB9w=
X-Google-Smtp-Source: APXvYqwF3Ej0HdjncpvSi+yzIRxGTr1udcCX4dDn3d3Q9Eb4jGIEwxYSlVQ4eXGb/yYYjy5FM58Xc/XHPIUIPBQLjhU=
X-Received: by 2002:ac8:542:: with SMTP id c2mr7578807qth.338.1571809621155;
 Tue, 22 Oct 2019 22:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191018080841.26712-1-paul.walmsley@sifive.com> <20191018080841.26712-6-paul.walmsley@sifive.com>
In-Reply-To: <20191018080841.26712-6-paul.walmsley@sifive.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 23 Oct 2019 13:46:24 +0800
Message-ID: <CAEbi=3dk0R3HMnqsK1mSm2bewecdHm279f9zEq1pHWLPo9tdAg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] riscv: mark some code and data as file-static
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> =E6=96=BC 2019=E5=B9=B410=E6=9C=88=
19=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:58=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Several functions and arrays which are only used in the files in which
> they are declared are missing "static" qualifiers.  Warnings for these
> symbols are reported by sparse:
>
> arch/riscv/kernel/stacktrace.c:22:14: warning: symbol 'walk_stackframe' w=
as not declared. Should it be static?
> arch/riscv/kernel/vdso.c:28:18: warning: symbol 'vdso_data' was not decla=
red. Should it be static?
> arch/riscv/mm/init.c:42:6: warning: symbol 'setup_zero_page' was not decl=
ared. Should it be static?
> arch/riscv/mm/init.c:152:7: warning: symbol 'fixmap_pte' was not declared=
. Should it be static?
> arch/riscv/mm/init.c:211:7: warning: symbol 'trampoline_pmd' was not decl=
ared. Should it be static?
> arch/riscv/mm/init.c:212:7: warning: symbol 'fixmap_pmd' was not declared=
. Should it be static?
> arch/riscv/mm/init.c:219:7: warning: symbol 'early_pmd' was not declared.=
 Should it be static?
> arch/riscv/mm/sifive_l2_cache.c:145:12: warning: symbol 'sifive_l2_init' =
was not declared. Should it be static?
>
> Resolve these warnings by marking them as static.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/kernel/stacktrace.c  |  6 ++++--
>  arch/riscv/kernel/vdso.c        |  2 +-
>  arch/riscv/mm/init.c            | 12 +++++++-----
>  arch/riscv/mm/sifive_l2_cache.c |  2 +-
>  4 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 0940681d2f68..fd908baed51c 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -19,8 +19,10 @@ struct stackframe {
>         unsigned long ra;
>  };
>
> -void notrace walk_stackframe(struct task_struct *task, struct pt_regs *r=
egs,
> -                            bool (*fn)(unsigned long, void *), void *arg=
)
> +static void notrace walk_stackframe(struct task_struct *task,
> +                                   struct pt_regs *regs,
> +                                   bool (*fn)(unsigned long, void *),
> +                                   void *arg)

I think walk_stackframe() could not be static because it will be used
in perf_callchain.c.
