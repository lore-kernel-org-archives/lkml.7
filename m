Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A7F20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClRdcSpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfDZTWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:22:39 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37272 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfDZTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:22:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id w13so2585629vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7ipGmZUWCvILHKl1N8W9pjQhoVgXJtkFwGPFamiRLY=;
        b=ClRdcSpuBDw2LXj56vYDefYJm65krG3lgo5PTlHF86S9ePKoStQtVJNG41mwFBzKmP
         S0oP0mKCNhBHfeM70vJLT7NL8+oWXMGTGHGVqhhkAELxcZ8Uv6CS3cN6+vavQWTfBnfT
         ghG7L4u/KTDzL63MK3dtev/3hqW3ce8fU8ci8TaLmLrRwSUysrdKzwErHvQzpemSt/ek
         e53tg/0RHfqy4y6vizRv2xJoeWcw522f/SdHQTH8njUbAWkpvQGdYF/F9OlqaM555+kA
         bdEESX6evOeocLYV0Tf4whn5CCZc2sItQ7ymEbH0Ku45yNc6n/ZMh3BqaFXxizlHNTUU
         ShFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7ipGmZUWCvILHKl1N8W9pjQhoVgXJtkFwGPFamiRLY=;
        b=PNw3gTkPRUfUvKrLYJ9s4jHY3Vwqqn4BnyaQBqZBzVu7L4KvrkTKxKSDYznJrZx2SY
         NwTx/PH2WFDVlJlE0ljPoYA2qp85L6JqXURVYNPKMkK/BoenBlM8LA1wqKYKjrqoqqli
         ZEnrrRS8bd0KT/n6HCfiI1a8EuVi62/xuXTO5Qi+ueyUFtcTtGdZhuTSEvXNSDzvJlP8
         0bsGrsHoMt5GcQKkMyiJ5MoeoAsCX2CA3H7z9liEuD5KPv3x9X47IFX/0Ji8x5UOund8
         +xP2XNNbgZ3SbGu0ibYvN/U7NXQBFjtKxKxjlY4aSzzjlj96SPXfgJs1AgtpGAko1/1C
         E++g==
X-Gm-Message-State: APjAAAWs+z9Dhb/O5npQUUasNjwVMgC5v7fpZvmintPsOvdpbvZvtdeL
        hguazu5Xs5XhbGD8/h/2andg6ZBudC74tsrweNI=
X-Google-Smtp-Source: APXvYqyltNB45bfeDzKFfH/8A/H/kEQ70l6fjW+p5Cv46vv7LVcurN+GkJgRincJ8p9Gu26Fk1MuQFPV0S9BPdVcdrs=
X-Received: by 2002:a67:f6c8:: with SMTP id v8mr14308952vso.73.1556306557529;
 Fri, 26 Apr 2019 12:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190426182948.GA10020@bharath12345-Inspiron-5559>
In-Reply-To: <20190426182948.GA10020@bharath12345-Inspiron-5559>
From:   Bharath Veda <linux.bhar@gmail.com>
Date:   Sat, 27 Apr 2019 00:52:25 +0530
Message-ID: <CAMwgTV7k=32sSFYp38Ft8M-oXhcEqcOByO=fpUBMeS1_XvzN1g@mail.gmail.com>
Subject: Re: [PATCH] drivers/char/random.c: Make add_hwgenerator_randomness static
To:     tytso@mit.edu, arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this patch. It breaks the build.

Thank you

On Fri, Apr 26, 2019 at 11:59 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
>
> Make add_hwgenerator_randomness static as it is only declared on
> drivers/char/random.c
>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 38c6d1a..08fd00a 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2342,7 +2342,7 @@ randomize_page(unsigned long start, unsigned long range)
>   * Those devices may produce endless random bits and will be throttled
>   * when our pool is full.
>   */
> -void add_hwgenerator_randomness(const char *buffer, size_t count,
> +static void add_hwgenerator_randomness(const char *buffer, size_t count,
>                                 size_t entropy)
>  {
>         struct entropy_store *poolp = &input_pool;
> --
> 2.7.4
>
