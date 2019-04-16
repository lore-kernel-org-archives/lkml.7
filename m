Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33589C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033D520643
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ec4hopwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfDPN5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:57:15 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38422 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfDPN5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:57:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id s2so11587518vsi.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEd+xSQR2LTimrj2aK/S3itZ61++AERxE8UnNX5os0Y=;
        b=Ec4hopwqJh3GcC677f1JmclbZ4Pes8vIBhxrL/B/Ep59Rx4l5qdNWVMadnJKaKL9bl
         xdFmKjNtHhI400/1ymPCYWCpmoMykZVbVDluBe2SJNaJYNQMb4Z0q2z1FUt9Ns37qpVn
         l/DymOybQbYTjKaD01N1LCOsg5wzsREjM/MzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEd+xSQR2LTimrj2aK/S3itZ61++AERxE8UnNX5os0Y=;
        b=mOtFiKCZ7odHkB8gAg4Jhg10UtnLi/HEhYw7UXvPuoSsG6jmmU8salZEfyoVrac5Ml
         kyPeyBP7Zrdx7cquu0W5BRnVoJmr6HUKtqdlt3JgsXrMZmqt7JozB7ty0JLuYyYlCwVl
         NGlXZ+/869Cr0GnuDWoWBNFLGd9DwfO8SouBsSVrjUlmJP4VdTNSU0J9rt8fiEaqv2eB
         cgFi9Znx/Y5ih5gABIV8Gjz1IDKvKSRmbPjAvuEpHSwDSu2AnzVnXZl2s/DAB5zMjNg8
         Q1Y/m1pIQlcNkQ7Ks/+NwBxT7wzEhm+zJSF5RYpKK3Wlm4mAtaEKnSBjtndgxWleK6zj
         Vnqw==
X-Gm-Message-State: APjAAAWhJLmuwF//fd0e9rbAq3l54hPkRkbHY0lA2vVm+Q0BmTK7E9zo
        zTAf7eAjnZqZX2BA2POn7zWdpRdIB68=
X-Google-Smtp-Source: APXvYqzd69pxdy9uE/294wmDN56C8CykQ8y8+S1G7VV9LCWOPeyXZCgeubfvo6AK5+cqT1cR1jxZfg==
X-Received: by 2002:a67:edc8:: with SMTP id e8mr43836261vsp.190.1555423030060;
        Tue, 16 Apr 2019 06:57:10 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id q190sm20591306vkd.50.2019.04.16.06.57.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:57:08 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id b8so6735903uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 06:57:08 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr43897232uah.123.1555423027609;
 Tue, 16 Apr 2019 06:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190411180117.27704-1-keescook@chromium.org> <20190411180117.27704-2-keescook@chromium.org>
 <947dbe9a-3444-6fe4-9f79-f8f210da8960@linux.com> <CAGXu5jJTM=pdAjsC63Z6T=HaztTqSqUQQ8=GN=tqv2n6CKc3nw@mail.gmail.com>
 <450e21b0-606a-f19a-a4fe-f7508d6a215c@linux.com>
In-Reply-To: <450e21b0-606a-f19a-a4fe-f7508d6a215c@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 08:56:55 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+bVtkXHhs03t_yb1gp51WRhzZGqNpzV5VPb6dfnptw5w@mail.gmail.com>
Message-ID: <CAGXu5j+bVtkXHhs03t_yb1gp51WRhzZGqNpzV5VPb6dfnptw5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] security: Create "kernel hardening" config area
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Potapenko <glider@google.com>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:55 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 16.04.2019 7:02, Kees Cook wrote:
> > On Mon, Apr 15, 2019 at 11:44 AM Alexander Popov <alex.popov@linux.com> wrote:
> >>
> >> What do you think about some separator between memory initialization options and
> >> CONFIG_CRYPTO?
> >
> > This was true before too
>
> Hm, yes, it's a generic behavior - there is no any separator at 'endmenu' and
> config options stick together.
>
> I've created a patch to fix that. What do you think about it?
> I can send it to LKML separately.
>
>
> From 50bf59d30fafcdebb3393fb742e1bd51e7d2f2da Mon Sep 17 00:00:00 2001
> From: Alexander Popov <alex.popov@linux.com>
> Date: Tue, 16 Apr 2019 16:09:40 +0300
> Subject: [PATCH 1/1] kconfig: Terminate menu blocks with a newline in the
>  generated config
>
> Currently menu blocks start with a pretty header but end with nothing in
> the generated config. So next config options stick together with the
> options from the menu block.
>
> Let's terminate menu blocks with a newline in the generated config.
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  scripts/kconfig/confdata.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 08ba146..1459153 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -888,6 +888,8 @@ int conf_write(const char *name)
>                 if (menu->next)
>                         menu = menu->next;
>                 else while ((menu = menu->parent)) {
> +                       if (!menu->sym && menu_is_visible(menu))
> +                               fprintf(out, "\n");
>                         if (menu->next) {
>                                 menu = menu->next;
>                                 break;

Seems fine to me. I defer to Masahiro, though. :)

-- 
Kees Cook
