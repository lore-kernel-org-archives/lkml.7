Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9959BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673692190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evUVMFab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGVTZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:25:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfGVTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:25:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so7788148pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIU0BzkvuqdZNrPcue+VHhOV3QzV2Q9Zf8zNSiLyFJo=;
        b=evUVMFabvUM3H86gyQl5A4nJnqW11KbObl6ZskLiiksnaUlUdJZJExfe9BzjHe3sns
         J+D0Pzwx2dTszy1CDug92Nf7P+F5MLLXGS7GOAD7VAR+gWpK+hykgzm0ZMVQ8R1w+F4A
         oFdiIRL6O1w0sFz9C1e9ytUaRIUkJsBFjNUUYfEtgb2Jw3g3fnyUOP/8Fo0mtx81kLDC
         7KpRqWqyW+62pqVFIpCxURBhxZCqWj9RPVbJEfr5MfPyUWKSHJVaZgroVzuOrzmStks9
         Jp1pnEaNkgCMTfxXEPPaBWO39c73ZeSff2aeD5JXBKTeVsJmoSEcvZASWAmYatwap71A
         fE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIU0BzkvuqdZNrPcue+VHhOV3QzV2Q9Zf8zNSiLyFJo=;
        b=Etm2E+AQfR6kEVNUtahEkmfYmrwThbPOrV+SxoX+Pw0xNaIvJngNWS9C1arGDFn58t
         Pi4H/KNEpCpekOp0RX6gR4HCqB2IbFqwl3coVhMsKIOqrpkDvVHCsxrCQnBZWS5u/z1s
         whR33nr5peBeKgoqM1PK9R121TYFyORbDu1AX0AGNIpKML8nrd+JTDtp6Rw5mZX94+Pz
         Go0o1Aj2YPwlTr+24KEX3FaUGiZpmDD0hdjCuiIor8run/pZxb4puTxuYodCsKgwt4Fx
         8mSmYsUh30cLfPk3Vn35d7WGwkAc3gCqdJfx2eDKgOBYXhYupfS6WpSaDO05D6EqGIfs
         xh5g==
X-Gm-Message-State: APjAAAVEhxuOcd0KnAYpr91jat8C7jw86aO8tcL/0Me0+Aah1M6+ruRs
        I0jcrgaq1vXYZRqUR3glawwwPpC5DBRUlP/QD6sBHA==
X-Google-Smtp-Source: APXvYqw5e2C0EHbyA1kM4eUtBg6hIGV0L9sPBOMYwiIzp5UQ3HQOjtAHj2yCoGckJz8dYHdmFaQpeVd3R7tf6EaEslQ=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr77101018pje.123.1563823516746;
 Mon, 22 Jul 2019 12:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190721085409.24499-1-k0ma@utam0k.jp>
In-Reply-To: <20190721085409.24499-1-k0ma@utam0k.jp>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jul 2019 12:25:05 -0700
Message-ID: <CAKwvOdmRPGAbq29peHXrryqqYzc+6-Ag7+GDr7kYLQihQ0fHuw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Add compilation database files
To:     Toru Komatsu <k0ma@utam0k.jp>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Tom Roeder <tmroeder@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 1:54 AM Toru Komatsu <k0ma@utam0k.jp> wrote:
>
> This file is used by clangd to use language server protocol.
> It can be generated at each compile using scripts/gen_compile_commands.py.
> Therefore it is different depending on the environment and should be
> ignored.
>
> Signed-off-by: Toru Komatsu <k0ma@utam0k.jp>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 8f5422cba6e2..025d887f64f1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -142,3 +142,6 @@ x509.genkey
>
>  # Kdevelop4
>  *.kdev4
> +
> +# Clang's compilation database files
> +/compile_commands.json

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Also, if you're doing anything exciting with compile_commands.json,
I'd love to know.  We're using it for static analyses.

-- 
Thanks,
~Nick Desaulniers
