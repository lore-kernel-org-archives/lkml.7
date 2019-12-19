Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D23C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7039E20716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSKSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:18:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39132 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfLSKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:18:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so2433765oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBfpTXVpKERfPCUf14OHD25gfpTFwcw7s5JiNlGDUoM=;
        b=TKlKttJQdojiXeAQT2Rbluabm4mZiPJDueOZaDc5YntEO3p5inJ9/vO2mucxA9J26v
         gLBRcORbucSl/gPDcDSSni58SL8f4KAIek5MoswCb3uBBVEMyi0bJKAT7WaMB6IgVd4e
         MoHMPBfeF6z/mHqlq30epzLVSMxr6SvSgMOXIa0HAuuxWg7yGlIOEQ2+osJMwLlhm8iN
         1O1QH+dqGvjGbarELcbjXokpXeT93nud0sO24vLmtxLQ+/pSje+JENfLRbMGimiGv/Ns
         FKJQbokUfz2RAn0RvvgUTwzUJcheK2XC/XT/4Mhk8eOmgaU5H18OFCPwd4MvkMVRDfLr
         HHhA==
X-Gm-Message-State: APjAAAXKeBBen+fzlKlAGt8Y5KvO+e05WjC8MJt8ABaLMXoupiXwWMhP
        FWzRDqiw+IC4vm/344oPCe54rR1yVtHk/hcZDTQ=
X-Google-Smtp-Source: APXvYqxKyRNwS6QLwpbYAjN8wwj1dZAiLECzHCQK8knRk73UYUPRCuTuK604XVYYJwKviWnSLi3BYVdg9nHjYIsqjaM=
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr1714729oic.131.1576750701225;
 Thu, 19 Dec 2019 02:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20191216062806.112361-1-yuchao0@huawei.com>
In-Reply-To: <20191216062806.112361-1-yuchao0@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Dec 2019 11:18:09 +0100
Message-ID: <CAMuHMdWnOCOqNCNnrsdNw4q3vG-Htm3bPBngqFJ8Frk8m13ytQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 16, 2019 at 7:29 AM Chao Yu <yuchao0@huawei.com> wrote:
> This patch tries to support compression in f2fs.

> --- a/fs/f2fs/Kconfig
> +++ b/fs/f2fs/Kconfig
> @@ -92,3 +92,26 @@ config F2FS_FAULT_INJECTION
>           Test F2FS to inject faults such as ENOMEM, ENOSPC, and so on.
>
>           If unsure, say N.
> +
> +config F2FS_FS_COMPRESSION
> +       bool "F2FS compression feature"
> +       depends on F2FS_FS
> +       help
> +         Enable filesystem-level compression on f2fs regular files,
> +         multiple back-end compression algorithms are supported.
> +
> +config F2FS_FS_LZO
> +       bool "LZO compression support" if F2FS_FS_COMPRESSION

This should depend on F2FS_FS_COMPRESSION, instead of just hiding
the question, to avoid the option always being enabled when
F2FS_FS_COMPRESSION is not set:

        bool "LZO compression support"
        depends on F2FS_FS_COMPRESSION

> +       select LZO_COMPRESS
> +       select LZO_DECOMPRESS
> +       default y
> +       help
> +         Support LZO compress algorithm, if unsure, say Y.
> +
> +config F2FS_FS_LZ4
> +       bool "LZ4 compression support" if F2FS_FS_COMPRESSION

Likewise.

> +       select LZ4_COMPRESS
> +       select LZ4_DECOMPRESS
> +       default y
> +       help
> +         Support LZ4 compress algorithm, if unsure, say Y.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
