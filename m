Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70440C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BA6204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyA4yNqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfDSTNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:13:23 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47050 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfDSTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:13:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id e2so3284624vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QUm65j9zaqX3NmkwhqrGvg2w2/MqiKzyq38aKFYGFE=;
        b=FyA4yNqIL4cKH95MMKw4u/A3HUc3RVRvgJELbGY/WBldZ6rdrykfCHJJdZCwLgZ5/b
         TpTHsZOmpr83Isxt1Vcc/9IuWEfDRwra4T/T8ofh3mChN975HK584QQNFexIo/ojZd3b
         ShHVQunRSEKIdYgCajppGiO4IENZHzWP38jZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QUm65j9zaqX3NmkwhqrGvg2w2/MqiKzyq38aKFYGFE=;
        b=e5noWpK0dBK/sk+L79g7vcvLdzpUvDqYEZ2xTdy7I6f1ZlXkc239Z1u0P7Ny3dHSvn
         j1qryFupsMkfozMa0fQbs7wO3jLfQfpf87Iqd+lLMR/AbYaMoxcIk+zHSp/bJIXVTCR2
         igGKF2IQf7vuq5hJOuzGvofTTm/JCjV3F/V8nZbm0J+FPoEkGE6hrhocieE8JgukY/Vu
         t/OmythEwS4URuHgmz3aeUl1Kx5VfBhcDcehFIM3dxQIy0AaKUt3aTxawKom2lo+xKze
         GlPMqYgs5KRz6NEUhmUOht3aUdmjd7KRI+b5nXBXUkxzkmtkS9HWZporUN6y8AHD2IDu
         pxFw==
X-Gm-Message-State: APjAAAX3s7Oh5R15PyTkKw3jvTHcAYhADjoBIHGMtaW6DNzslb/dVhFl
        noTueeEzUJsAVBQLu+6F7pHTOi4Wwzo=
X-Google-Smtp-Source: APXvYqz0CIcX9VfUqePLOuReGO8F2s7Xh6veL17B4kFbxSalvhw8R3/GlYU5g2Pii9ZZcqmk1/mNHA==
X-Received: by 2002:a67:fa04:: with SMTP id i4mr2405088vsq.18.1555686162823;
        Fri, 19 Apr 2019 08:02:42 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id q190sm1846675vkd.50.2019.04.19.08.02.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 08:02:42 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id c6so1844390uan.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 08:02:41 -0700 (PDT)
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr2239270uap.112.1555686161245;
 Fri, 19 Apr 2019 08:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <1555669773-9766-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1555669773-9766-1-git-send-email-alex.popov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 19 Apr 2019 10:02:29 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+qUm_ad6XOU7eLbCEdV3bUjJeYoseZrWdpzXqe84-5Bw@mail.gmail.com>
Message-ID: <CAGXu5j+qUm_ad6XOU7eLbCEdV3bUjJeYoseZrWdpzXqe84-5Bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kconfig: Terminate menu blocks with a newline in the
 generated config
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 5:29 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently menu blocks start with a pretty header but end with nothing in
> the generated config. So next config options stick together with the
> options from the menu block.
>
> Let's terminate menu blocks with a newline in the generated config.
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Seems fine to improve readability at a few bytes size increase.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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
> --
> 2.7.4
>


-- 
Kees Cook
