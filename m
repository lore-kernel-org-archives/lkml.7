Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7496C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBFA2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eG9aRe+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfCHSkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:40:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45337 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCHSkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:40:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so14749785pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6slduIA/nSzDx64DlCk55ut9hKQBho0qc7ZI7CXLNk=;
        b=eG9aRe+TTYpJOvAuvKI9hbnVkON2w26P0IjV9CewD41p9tfCZwZXNGrg0XoPvKQ5JS
         Z0UW1FTUFLDjKLTLusrrBDvXW7Ppa4sCzSRYPWMpJqJ+RQLFA3Yk6/y5kLRGBC5FZA4j
         eLW1TcHe/IJihJpRqlwk1E51QVLeofYbkzuNzxFfjaEPsplcndabGFTKxliqGWt1ZzhA
         cIt5UbmTL7TgDDYEmYOjWJ5dLE+XkzGwCyLOTFe42wk3w3cGWHoo426tEmLZjcO+PxeE
         Ax/fLKl6g9i35aF7t77/waHRaC8djma7OpPqM6P9BqIgScWRC/JPTS9Gv+bdqeuZdtka
         2Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6slduIA/nSzDx64DlCk55ut9hKQBho0qc7ZI7CXLNk=;
        b=WlPBTKjPZjr6W9vU+/mSrIW6UqQy8L99Z15EvkvJo8dJvkIImZs5KW3IoXPj1ASh+f
         ZQOtx2hOBwgwc/8dv4BYxTNjyOAjK8cJr6oGP4YKOt4EfytieYqv6uoaZ7Re82nKoQ+K
         kM+QT0wqTfVBE38JlfsIcDvnM0YKVm0xUzS2u8Ag2C1OJ/+nHZoV1jiWItz2RenFX7Vf
         AKlUIsa8s0vnSeo9VH6gRh2JZ0KA4D/tar2KKsRU9dwJEWRznvEK2qy24Ex4kR0K6yNw
         Xjj+9wbXC0wUXKDRAY14AZE+bXNFPsLWVDlBWW+YultXnsRIavJAIuB2qHSKl8qTVXUq
         OwUg==
X-Gm-Message-State: APjAAAXQF0pvlhQlgZukYOT2TAtVUot0acm6StGWxDAJNPgqyXjMOzNK
        wsOI0pH+QuIGgt3UNakM6osecWqrwn9ogLm2Q1J44g==
X-Google-Smtp-Source: APXvYqzUlFny+CLCYrL94e3rXIUunusPSy07OeFYHt/R/pyG/dJENr4W28wz6zf/bnJDpMAbyQ1i2HYfpLSGhRWZGEs=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr20081530plf.320.1552070414377;
 Fri, 08 Mar 2019 10:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20190308084022.GA31474@kroah.com> <20190308183743.11145-1-natechancellor@gmail.com>
In-Reply-To: <20190308183743.11145-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 10:40:03 -0800
Message-ID: <CAKwvOdk=A6QOHbqr78sr1jt=wfy08yqRf5HxE_qVOQVOZhNsvg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 10:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud'
> is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> It's not wrong; when options is NULL, baud has no default value. Use
> 9600 as that is a sane default.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/395
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Great find. Thanks for the fix, and thanks Greg for the advice and
additional analysis here.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 3bcec1c20219..35e5f9c5d5be 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1050,7 +1050,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
>  {
>         struct uart_port *uport;
>         struct qcom_geni_serial_port *port;
> -       int baud;
> +       int baud = 9600;
>         int bits = 8;
>         int parity = 'n';
>         int flow = 'n';
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
