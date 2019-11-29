Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0265217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQSTrm2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfK2KPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:15:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46085 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfK2KPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:15:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so5827502pga.13;
        Fri, 29 Nov 2019 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1KmOe5inJ+0us5/GEJwORM1YCKr6PiRIifE91YW7cY=;
        b=LQSTrm2upMcPvgf0lGjmhU0DimNXBwXpjIy+FHkmnOJgrJI627MK8XvzsbNaVkTfk9
         +4zytifICvfR0F1UcJzqUWeEydPOV9fUWsmoSzfQnlHjvPcY6RUP8+rP2uS27gRYEPIP
         d3gGmLTXXBtiFLRlphTLbVo2jpHIQQiMXj/NS9u/paRpTqK1J162yO7VoprztPmT0npB
         dCbBnOmPgFFZBqUelAc6JK0i45JaCTcVQG1Gr+fEaeMUZdiwl8rtS5ozNRo0tLBE0QKK
         uSNLhX1g1LPYbN575XEbUyUFKYKWrKrLTrib1TVeeUK1Yrty9Kd7SB1ygGUY9KIgpTSM
         7zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1KmOe5inJ+0us5/GEJwORM1YCKr6PiRIifE91YW7cY=;
        b=C7yzs10x8G/W/im7f/tCV/MmI82HO8qOm+hnrTejD9pZdQDbvunYeSqIurnkmeWLLJ
         fUaXrUjnolNhG1gsSw3Zmjh2hZtStwju9LcTXen8WVTXa+h4utmJ51Jz7ZKctSJQJXwm
         rIwIPTqIw7N9lejMKFnoTtB/vNV4F//xO20FGQGEm+x4bOL2vFpUr2WgqgAsMzehAnSr
         7RVPMmD7HZ0obO159Q+AXl1K0S/8XQTq4+RJoEC9kWGh6lSGWzd2nuG/XuNJpeJfiXlf
         61VzqJVTvNxZ3ICyome6bLTTcAo7NFLitTOpDqMbYKW6xW9ULE1ZcoVHFTTHpYo72ng7
         bgWQ==
X-Gm-Message-State: APjAAAXf6Xom81Jb4prfSytR+wHRh8nERydZed7eJj+xVWm3unsrtJ3X
        sCdhTEffydhgHJPN7X6bz4hyvtG1zQ6rzjTeS88=
X-Google-Smtp-Source: APXvYqwHwKfEOE/J1f8D08OxLtPRHK9CMUztFInQXFaxXNSe54ZGvlCWnLK8OpRP3g3pGL12zYUevQ3Fi9ehSuz2J74=
X-Received: by 2002:a63:2b51:: with SMTP id r78mr15867789pgr.4.1575022550211;
 Fri, 29 Nov 2019 02:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20191129091650.4765-1-michael.haener@siemens.com>
In-Reply-To: <20191129091650.4765-1-michael.haener@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Nov 2019 12:15:38 +0200
Message-ID: <CAHp75Vc5A8pX1az+vH1E-d_4awKnyh60=KUYFbyT2ahEsQTkGQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: pmc_atom: Add Siemens CONNECT X300 to
 critclk_systems DMI table
To:     Michael Haener <michael.haener@siemens.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 11:19 AM Michael Haener
<michael.haener@siemens.com> wrote:
>
> The CONNECT X300 uses the PMC clock for on-board components and gets
> stuck during boot if the clock is disabled. Therefore, add this
> device to the critical systems list.
> Tested on CONNECT X300.

Thank you for your patch!
Can you be more specific about the clock (which one? For example plt2)
and if possible type of hardware IP which is connected to it (for
example, Realtek Ethernet)?

> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
>  drivers/platform/x86/pmc_atom.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index 07d1b911e72f..57f06ca114a6 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -429,6 +429,14 @@ static const struct dmi_system_id critclk_systems[] = {
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "6AV7882-0"),
>                 },
>         },
> +       {
> +               .ident = "CONNECT X300",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "A5E45074588")
> +               },
> +       },
> +
>         { /*sentinel*/ }
>  };
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
