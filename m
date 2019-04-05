Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE28C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560F221852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC42Bkjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfDEOiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:38:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40294 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDEOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:38:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so3175604pgo.7;
        Fri, 05 Apr 2019 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyTjWcg9E2VqCIkA67yW5kn+EGXjm4nBmoivdZZBm/E=;
        b=OC42BkjrQZvITg0jT+frPP+fjGzxRQcHS2A+PGmKWG2qq0TuPKq9ApJ1cm1mslgtsf
         ZYNrOe3eEWTI5FzEChbPb3ygZVnUO3dZwMqEVXjB4jEkto/ClMwK1FNfAGLrK/FdjzfR
         iM0ViP9zeKs7SrueN4eLX2IOTBEDwyFGazqSdTtA6tdckqimk8yVSE1aQYjdIJf10uRu
         NnkKiNzBAmhipId9ZUDjS3oyv5SYIw0gyDAzGNDib9YRSZT7OMOXY9l65FiUffo8k6DY
         faNYF3yv7Byr7entlgOuREcYn1FHD+hyOQ8fVlhjZh+8vKlrgtAmEgvfVlvLBHhB8awu
         G8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyTjWcg9E2VqCIkA67yW5kn+EGXjm4nBmoivdZZBm/E=;
        b=LOPLZZQGhFA0PzEUzCNdT815ichKEV4dKywDbWf5Z8c5IwCeBZN+TIT3feGWPLGuIj
         yRV14Xkf5a2Cfxr0YvXxOjwzBxg7lLu2JsLuTBjLr56rQu8s1Lax0la1fqN/8yDp92Pa
         1Kn9ZgPjIOVB1SOfRzIq+LBZdYMdosBLXYhB68bE1pmUGQfA3KOZoi/DnlWESQCxQ5yH
         /1QXXSsx2jcxe9KXjBnVVuLGOPDJwwKbNAEa6p76+UmnW7J9180yFtQL0SUrnhntl6/q
         UNXOvMLrjr14upp+dRflYwYgoOVylFl3DgEnLJuJCBFYq6lqI7LQ2TbpSn+pt6tQZ1PO
         49yw==
X-Gm-Message-State: APjAAAXtWgiCAfLNSi6/PIhkviNgvgU3+cRMhu2xH4icoi1Z2M/PzJbx
        2HZzjzY6gEdcMPFjqwD984LxP1V2dnQirNGQMYw=
X-Google-Smtp-Source: APXvYqwMw6o4i5hBHN0Hut2Dc+SCtPjwXIRbfKYAM5phifamkiEPf+29L+TIgkn6+6PFOMTDUB8S3+R4bwHDzw9Xvls=
X-Received: by 2002:a65:4302:: with SMTP id j2mr11842168pgq.291.1554475104250;
 Fri, 05 Apr 2019 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190308131426.10254-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20190308131426.10254-1-jiaxun.yang@flygoat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Apr 2019 17:38:12 +0300
Message-ID: <CAHp75VeJgLf7DNVy3=tAqwput3EJ2CqcGwCkNCWt820B3QK0gw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Read EC information on newer models
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 3:15 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Newer ThinkPads have a totally different EC program information DMI
> table. And thermal subdriver can't work without correct EC version.
>
> Read from this entry if the old method failed to get EC information.
>

Thank you for the patch. See my comments below.

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 62 ++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 2e24ee42a3c6..17fd2065000b 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -9959,6 +9959,37 @@ static char __init tpacpi_parse_fw_id(const char * const s,
>         return '\0';
>  }
>
> +static void find_new_ec_fwstr(const struct dmi_header *dm, void *private)
> +{

Today it's a new one, tomorrow something else might come. Care to use
versioning instead?
Something line find_ec_fwstr_vXYZ().

> +}

> -                       tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
> -                       if (!tp->ec_version_str)
> -                               return -ENOMEM;

>
> -                       t = tpacpi_parse_fw_id(ec_fw_string,
> -                                              &tp->ec_model, &tp->ec_release);
> -                       if (t != 'H') {
> -                               pr_notice("ThinkPad firmware release %s doesn't match the known patterns\n",
> -                                         ec_fw_string);
> -                               pr_notice("please report this to %s\n",
> -                                         TPACPI_MAIL);
> -                       }

Seems to me that this is the same to below. Can you leave indentation
in place and fix it in a separate (following) patch?

> -                       break;
> +       if (ec_fw_string[0]) {
> +               tp->ec_version_str = kstrdup(ec_fw_string, GFP_KERNEL);
> +               if (!tp->ec_version_str)
> +                       return -ENOMEM;
> +
> +               t = tpacpi_parse_fw_id(ec_fw_string,
> +                        &tp->ec_model, &tp->ec_release);
> +               if (t != 'H') {
> +                       pr_notice("ThinkPad firmware release %s doesn't match the known patterns\n",
> +                                 ec_fw_string);
> +                       pr_notice("please report this to %s\n", TPACPI_MAIL);
>                 }
>         }


-- 
With Best Regards,
Andy Shevchenko
