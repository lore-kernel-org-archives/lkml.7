Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DDCC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E64206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXStx7eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfFTTua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:50:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43785 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfFTTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:50:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so1788228plb.10;
        Thu, 20 Jun 2019 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Chemluuget4oibVqPmtz//KQ0k8owAqeEz6djJYfRuQ=;
        b=jXStx7eHZX5+8yBlumX6fFxL+fL0cx8ELj6ffwxl74+YWKK4ELVJTopjbUUZqVCW+a
         jVJGNZxRMYw1t/LgudlbQmXOU1clNGJjqCgVMT8VtdjhYRkjl5JShKuaEaSXgrDDaqDW
         HChD7vxuezmDcPVOjYvG4oJsvamDI44yAGCHJuF7auw6QbT+JvbTuEc78+ZlwI/9qUbN
         7jRcKW7o0Wfna61IwKU/ZK90qywqqLPZE+c5jsGam3EvxUDTkkJZHLr1R6Fm79UbiCzI
         9xF/TIQ963PP4oYRNq4KovS8oBQPlDdkuSRAgp3bB3081tlqwJ+K3b6SQQGbqM6Pn2aP
         WCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Chemluuget4oibVqPmtz//KQ0k8owAqeEz6djJYfRuQ=;
        b=cg/0MjbH0tJq4dQKdV5hFecggs+jGnDq7l2S45TYP4QUteI2nIOiF3lDBsSK84alg0
         9yEeXHS/KYG9i2UfBAK18NvjBPP2dGUbogp59ZsBpktZmuHyM9AHtPO/Xm+Zdlmi9GTr
         3H0+cqKRjDK2xaB7sK++lX/5px6G7F0eTwRhen3Nao5Wnql3RvXp9DB8SiAiVVAEJLc1
         4nDlvQY02mf6N5OoTRevK8t8I6p8knxHI5/swf6IB4dXxWNL7yWxuloZgii510K5Z6oD
         CognD83lAM3T+0isUaMYa8kAP5qY7z+lD0Xwiy8z0ZvtrPIyHB+e6HQ9lchv+j8hufnv
         VB9w==
X-Gm-Message-State: APjAAAXX0Zg4ObYVaXX+3mltoDt6Nqz3/jzfHrS4T5x9on8HQBQOpJC/
        uVxynBE4h6WJziJRay308mj3uh5FKbVtANiLMoI=
X-Google-Smtp-Source: APXvYqwyCNCi2l4ymEaHhEjUAMB28S5oOhnsG6URoz/ZlEO4SCoS9p1V6qoYeps+5fL1WyJ9C5vWGwPWBhMnDHr+REI=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr124039108plr.262.1561060229336;
 Thu, 20 Jun 2019 12:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190620183827.23704-1-puranjay12@gmail.com>
In-Reply-To: <20190620183827.23704-1-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jun 2019 22:50:17 +0300
Message-ID: <CAHp75Ve+v7o=Ar=5Vc7yZndCxUNf3sn8YwpCHXMwdeJxuLKMoA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: platform: Delete x86-laptop-drivers.txt
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 9:38 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> The list of laptops supported by drivers in PDx86 subsystem is quite
> big and growing. x86-laptop-drivers.txt contains details of very few
> laptop models. Remove it because it does not  serve any purpose.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  Documentation/platform/x86-laptop-drivers.txt | 18 ------------------
>  1 file changed, 18 deletions(-)
>  delete mode 100644 Documentation/platform/x86-laptop-drivers.txt
>
> diff --git a/Documentation/platform/x86-laptop-drivers.txt b/Documentation/platform/x86-laptop-drivers.txt
> deleted file mode 100644
> index 01facd2590bb..000000000000
> --- a/Documentation/platform/x86-laptop-drivers.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -compal-laptop
> -=============
> -List of supported hardware:
> -
> -by Compal:
> -       Compal FL90/IFL90
> -       Compal FL91/IFL91
> -       Compal FL92/JFL92
> -       Compal FT00/IFT00
> -
> -by Dell:
> -       Dell Vostro 1200
> -       Dell Mini 9 (Inspiron 910)
> -       Dell Mini 10 (Inspiron 1010)
> -       Dell Mini 10v (Inspiron 1011)
> -       Dell Mini 1012 (Inspiron 1012)
> -       Dell Inspiron 11z (Inspiron 1110)
> -       Dell Mini 12 (Inspiron 1210)
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
