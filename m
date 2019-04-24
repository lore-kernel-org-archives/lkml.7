Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B229BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gjdWXS4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfDXPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:03:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44795 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbfDXPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:02:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id j184so10554918vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKLrqEHsZgkXKIFnNrEflMfVKn1F3tCXT6JyQm68SoI=;
        b=gjdWXS4sz7Pz4Pb7GPMmkRX5Ad+ejIXPsRs+APt+HPnLgpYvEPZXoFQpv/N/f8rnnE
         ostLMHeZOpMFVt04Tf4VwDP7Hu+SaKLO9Q0VSQe131BuZ6o6Lxb0EH53o1PIKMcLLQEB
         X79E3KwNfQqvNNgvbmjrNG4ozxnQAbm0nYhUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKLrqEHsZgkXKIFnNrEflMfVKn1F3tCXT6JyQm68SoI=;
        b=aKw6r2PsKg+gG1pdLr1U0zqljDrVaaF7ESqeyeiDYuQkPtOgtoeA2BRF2rqpJjQCkV
         pAzhQOX86ZOBlDL1CXla4gcREfmi4v7SGAPvgx7nGX1178uDLsejQrp/+BRPrFhvbiRA
         56GV6mEq9UpDVVzHgLbvx1GLpGZHoFpvurKA4kGF+ZGIOimTf8jzpa/aHAeuWnG61UwL
         /vHdFUT7EIfFq0K+7yAIaU7HZ5T2Xd0kwWT+MV+KxA0Uiw56l6GQa+qk4s5nMkMwspDK
         z8mUED8pp/8GKF8aPXpRkFEa0y3TSdfpMRqY3vDpI+vHFzR/ZTIxwL8tZtsY87sUPYNC
         g7Nw==
X-Gm-Message-State: APjAAAV89Oyz6b9ZEt9Zff1bi2YEzqfPvnbDClr/GwZoEMaFkDTUtKKC
        /tBMEAFo2p4f8kOTY7sMQP2H5yt1aQ0=
X-Google-Smtp-Source: APXvYqy4v+kXSN57CIUOBBS0h/ser/UsjKJ0+5GBNZhVkveawZaT7YeYm6h8laZ6f6ZbMEAsqPlioQ==
X-Received: by 2002:a67:e407:: with SMTP id d7mr16801817vsf.212.1556118178309;
        Wed, 24 Apr 2019 08:02:58 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id i2sm3402748vsp.7.2019.04.24.08.02.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:02:57 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id q189so4088642vkq.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:02:57 -0700 (PDT)
X-Received: by 2002:a1f:3458:: with SMTP id b85mr16977824vka.4.1556118176584;
 Wed, 24 Apr 2019 08:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <1556107369-7655-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1556107369-7655-1-git-send-email-alex.popov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 08:02:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLJeC4oAagPGSquKi_EVvA9+aZkjtASGwriGMeR_dxwnQ@mail.gmail.com>
Message-ID: <CAGXu5jLJeC4oAagPGSquKi_EVvA9+aZkjtASGwriGMeR_dxwnQ@mail.gmail.com>
Subject: Re: [v2 1/1] kconfig: Terminate menu blocks with a comment in the
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

On Wed, Apr 24, 2019 at 5:03 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently menu blocks start with a pretty header but end with nothing in
> the generated config. So next config options stick together with the
> options from the menu block.
>
> Let's terminate menu blocks in the generated config with a comment and
> a newline if needed. Example:
>
> ...
> CONFIG_BPF_STREAM_PARSER=y
> CONFIG_NET_FLOW_LIMIT=y
>
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=y
> CONFIG_NET_DROP_MONITOR=y
> # end of Network testing
> # end of Networking options
>
> CONFIG_HAMRADIO=y
> ...
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/kconfig/confdata.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 08ba146..486b4c7 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -819,6 +819,7 @@ int conf_write(const char *name)
>         struct menu *menu;
>         const char *basename;
>         const char *str;
> +       bool need_newline = false;
>         char dirname[PATH_MAX+1], tmpname[PATH_MAX+22], newname[PATH_MAX+8];
>         char *env;
>
> @@ -871,12 +872,16 @@ int conf_write(const char *name)
>                                      "#\n"
>                                      "# %s\n"
>                                      "#\n", str);
> +                       need_newline = false;
>                 } else if (!(sym->flags & SYMBOL_CHOICE)) {
>                         sym_calc_value(sym);
>                         if (!(sym->flags & SYMBOL_WRITE))
>                                 goto next;
> +                       if (need_newline) {
> +                               fprintf(out, "\n");
> +                               need_newline = false;
> +                       }
>                         sym->flags &= ~SYMBOL_WRITE;
> -
>                         conf_write_symbol(out, sym, &kconfig_printer_cb, NULL);
>                 }
>
> @@ -888,6 +893,11 @@ int conf_write(const char *name)
>                 if (menu->next)
>                         menu = menu->next;
>                 else while ((menu = menu->parent)) {
> +                       if (!menu->sym && menu_is_visible(menu)) {
> +                               str = menu_get_prompt(menu);
> +                               fprintf(out, "# end of %s\n", str);
> +                               need_newline = true;
> +                       }
>                         if (menu->next) {
>                                 menu = menu->next;
>                                 break;
> --
> 2.7.4
>


-- 
Kees Cook
