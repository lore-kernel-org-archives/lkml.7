Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A89C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3C2206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9g+7EyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbfJIWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:42:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34412 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbfJIWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:42:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so3814291qke.1;
        Wed, 09 Oct 2019 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcZVhoygDFyHDzYuA43lN10l1MvVKVVY2j3mhC7PG6s=;
        b=r9g+7EyR+yiEluZJQeCE31IQJ2xNxdoZvC66C/uQ4blcFvXuyPkEtQCq6hXr+j3jeY
         wF07ZBt/t5dgpwUpE0tC7d+e+rYKv/uK+FV/C7UDAEZGOQfyVyMQupZ4i1xR7KANEyO8
         eLYj14GZ0nkG7LaVluADVaO+MHIK4q16lCswaqrz/841Bi70XXUrDl5rIcYMbEMu7zg6
         Kha0wpXd/+Dj2xvO49tB7qZnIhuOwFK/j37YeULsA1PaVOViRUdeMyjzdihzcfyfH829
         P7VWRFL2+XtoxeRe1kbsGxhlxB0i7QP+M2S9J8DXM21LWJxaZdYtKsQdywzR2lPJlkZA
         +PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcZVhoygDFyHDzYuA43lN10l1MvVKVVY2j3mhC7PG6s=;
        b=ummnMfenOd94QIwQ8sfITHZXeQ+AOyvRWXsag5+ql2a1G8m2RKXzIVcd3sM3s04HhU
         jNoE+s5m3vs64nOh0YLjzBYeH3vKXq33fu1J/PqK9zBFf7zre+94HuZIeR2tNbQHB3+z
         LZV5eYy9HaXUACSJUCbF5i0jATp89giPVMhHEk6dh2+Ljirh96T13mznNGah4matirae
         0O1yGHvf+FjY4tGfWdG63RiJlL5TfZGgiv7Pqras11nlqlLGdM0g+2CB/X3jYsbffZyr
         JbjkSJWzPBDWEhUeSshoj3Q4awCROX6FiG41mYNKeCQq3uEBLKwly++TqO2+0kQz5kNi
         wL+Q==
X-Gm-Message-State: APjAAAUcvlExcwX3ABnKga++ymZKCQUMFmfRFQ+22y1mNSo986za4iUd
        8L5Yz9yyPcUCf7tVbx8cEqxlgLl4gSQ+1NLBRJY=
X-Google-Smtp-Source: APXvYqxpEiqzQG47M6fKoiompwGa2pjBQHEUTgLaVUC0lOx+OIbH2wt39dPBMETZzfhIFN2mxRMLAZ3QjfUJzhRJgIs=
X-Received: by 2002:a37:6d04:: with SMTP id i4mr6365560qkc.36.1570660938689;
 Wed, 09 Oct 2019 15:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org> <20191009204134.26960-2-ivan.khoronzhuk@linaro.org>
In-Reply-To: <20191009204134.26960-2-ivan.khoronzhuk@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Oct 2019 15:42:07 -0700
Message-ID: <CAEf4BzZLL=mL1nnyQ2tgGzLnaLBm+rzBOGrBp=KeiLzbo3Zcmw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/15] samples/bpf: fix HDR_PROBE "echo"
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org,
        sergei.shtylyov@cogentembedded.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 1:45 PM Ivan Khoronzhuk
<ivan.khoronzhuk@linaro.org> wrote:
>
> echo should be replaced with echo -e to handle '\n' correctly, but
> instead, replace it with printf as some systems can't handle echo -e.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  samples/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index a11d7270583d..4f61725b1d86 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -201,7 +201,7 @@ endif
>
>  # Don't evaluate probes and warnings if we need to run make recursively
>  ifneq ($(src),)
> -HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
> +HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
>         $(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
>         echo okay)
>
> --
> 2.17.1
>
