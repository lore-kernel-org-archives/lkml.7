Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0627CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF5321835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVT5yy7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfJ1VLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:11:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33413 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfJ1VLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:11:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id u13so7948996ote.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBYWQW9UvbERGywOWVvHYvLEUYwA7AlxyhS5hIUH/BQ=;
        b=pVT5yy7n+WJeNRc6Kqv08AdoWrhHCG9vtEOvUXQif3l/WjBzZ4AhsvpYb6aZMWKLQ3
         EecZu6Zc6mPcKxGiNDjiFaS6sg5erNopZSti0+Aza4Jd5c2mjgYvFe2zPxZq1Uqv8v5a
         EYnQHDDHofxDoRze/I+cCAawQz8iipUPSbNswKzyCRIiLHloXHqbmVng65P+ElYkksRW
         TxOLLJHhesY/wDtkmXY2pBmCmuD8PWE0nuVlb7iFotk7OyoySsnEVwLqeKoqOo3KuqMa
         sXj8gBfw4Uz+r4060/NBygCj7FFw8nQxVoKBrWm9TIib5SGWW1Z6JtvuZj24KaARGNh/
         uq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBYWQW9UvbERGywOWVvHYvLEUYwA7AlxyhS5hIUH/BQ=;
        b=cRjEmZUY2RSzvpVH8G/tZPAGbZLUprcFNppXbU+aOGP7/3LeswtFeHzguI1/V/X594
         5HPTsHiwTEdYrwA2v3X99DcLSqcopAA445sk8Ilo5JRkfZ+KkvBwwdHcIAEzovcYzobu
         moB6fckp2jBljrQw9vkfyPWd18tXpHKhZqFS0VbiwJwZd4dWpZaQkDpFuRmmaolAJZGW
         ZVNfEdjLprq5sjVjFf5vAe5hsUxJ7gAqu4XU6nr0Olu4gyzynCdxlN+3JI22qd0IEGbO
         jYagzKbyzQed5osBOCsRblVEl5IZ00MTx3BbI5eNj2HTMcys2a3kFS2fzf6PmjPL+tBl
         FCsg==
X-Gm-Message-State: APjAAAX0YzEh+Wujj45VhRCNOoS4eIND7Sezl9LCizmnq1qZIuf1n1j9
        YsgbXx6zImR6iABLzM/YpkzJc2HS3vzehGJqtW94KA==
X-Google-Smtp-Source: APXvYqzZlp/Hwl4spcTIxcPlRPWVaONev/r+vSRpbK+HYKkKdKaJOdOZ1o68YRa0duONP2nNeFRlys2UNb7JGmmxgOE=
X-Received: by 2002:a05:6830:4c1:: with SMTP id s1mr973895otd.232.1572297097075;
 Mon, 28 Oct 2019 14:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <1570515056-23589-1-git-send-email-hariprasad.kelam@gmail.com> <CAGngYiX0zoAQB=SEoXfoMm9u_JzHu3eLErj4zmTYtSAoDwkp6Q@mail.gmail.com>
In-Reply-To: <CAGngYiX0zoAQB=SEoXfoMm9u_JzHu3eLErj4zmTYtSAoDwkp6Q@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 28 Oct 2019 17:11:26 -0400
Message-ID: <CAGngYiXxagQMiHA-pZupTPHfyFz4kU=QOrvM28L_jSV1VGw=jQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: make use of devm_platform_ioremap_resource
To:     hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, friendly reminder... Did you miss the patch review below, or
is there a reason
why this isn't getting queued?

There seems to be a crowd chasing down this type of warnings, resulting
in multiple duplicates.

On Tue, Oct 8, 2019 at 9:31 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Tue, Oct 8, 2019 at 2:11 AM hariprasad Kelam
> <hariprasad.kelam@gmail.com> wrote:
> >
> > From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> >
> > fix below issues reported by coccicheck
> > drivers/staging//fieldbus/anybuss/arcx-anybus.c:135:1-5: WARNING: Use
> > devm_platform_ioremap_resource for base
> > drivers/staging//fieldbus/anybuss/arcx-anybus.c:248:1-14: WARNING: Use
> > devm_platform_ioremap_resource for cd -> cpld_base
> >
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
>
> Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
> Tested-by: Sven Van Asbroeck <TheSven73@gmail.com>
