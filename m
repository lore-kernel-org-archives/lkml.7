Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695862072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 05:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576562159;
	bh=ccy4GII71vtTJy1bpcsZCFMbONaoxGQMS2KJn+90Mig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gQCTpbclJvJjVuX3i2JYzyGPPtI9rRh3AzzVkOfNOqLJ/Qtt+DpRO2Z6yDglttr44
	 oimjENTx6OpDdfeDuhOd9IMigFBhFUr0r95Y7bwCnhMtHkIKca/gNKiy5FKyed5YMK
	 ozLGXdT+05RV+I8T91ceIu+B+16/28P/MYz1dfek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfLQFz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:55:58 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:18008 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLQFz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 00:55:58 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xBH5tmrx014979;
        Tue, 17 Dec 2019 14:55:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xBH5tmrx014979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576562149;
        bh=LFaqLGzjz1ee8xQECm+Y0tDNHUhzFgCI0yOxq/aOoD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=blkFqBVct1QMPud+goV7Q/Q77JxYSnp8zTZPodFck+MV//cRIqhiDd3c5a079G2c1
         qwsZK72uMbcIUgrgUaIXXv48N8fcJn3TSc+GqeJGBlq/x6nCtpkE8aGHTjofqPFJsX
         iSRuiyaETFVh2OF6aKp54ZOwSxpsmD11owMZS9jRvaRZWvrZrz9OUzkpW7E5rdh9y7
         ErxjuU96Lw/Z49WnOmGL4oBj9k3dINwMF88IQOc3k3AWE2smBMCvVP8g8sYisWoBiF
         TfOrRXTf9MIZH7t755cbGop2reCS7sI8xIhel5KCFAHhPXLL7V8Dl3u5vLwl49z/C3
         fUmNquhrqfYtw==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id p191so2345109vkf.8;
        Mon, 16 Dec 2019 21:55:48 -0800 (PST)
X-Gm-Message-State: APjAAAXRMRJRHqlFMkFQncCYWc6IGuma3GY/Fmj1VFcIjzXGIoDAEdIi
        vOeIU8DCbMKvzIxggyuEeZBrlc0LBosvq35OwJA=
X-Google-Smtp-Source: APXvYqxngIpwPBKxsJUj0roVPoswrnRZ4/E7EJIRpXE43hzsfQsbIhn9ekjbsAGaoJ7V0PEzif1MvVHUADSbdHV7db4=
X-Received: by 2002:a1f:252:: with SMTP id 79mr2144490vkc.96.1576562147526;
 Mon, 16 Dec 2019 21:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20191217041424.29285-1-masahiroy@kernel.org> <20191217041424.29285-3-masahiroy@kernel.org>
In-Reply-To: <20191217041424.29285-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Dec 2019 14:55:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREowHti15Ob4sgGbChTN6zYHYueyhdtVhC2KHK08rCmg@mail.gmail.com>
Message-ID: <CAK7LNAREowHti15Ob4sgGbChTN6zYHYueyhdtVhC2KHK08rCmg@mail.gmail.com>
Subject: Re: [PATCH 2/8] kconfig: use parent->dep as the parentdep of 'menu'
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 1:14 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> In menu_finalize(), the dependency of a menu entry is propagated
> downwards.
>
> For the 'menu', ->dep and ->prompt->visible.expr are the same.

Just for clarification, this means
parent->dep and parent->prompt->visible.expr
have the same expression.

expr_eq(parent->dep, parent->prompt->visible.expr)
should return 1.



> Both accumulate the 'depends on' of itself and upper menu entries.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kconfig/menu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index b1b1ee8cf987..bbabf0a59ac4 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -326,12 +326,10 @@ void menu_finalize(struct menu *parent)
>                          * choice value symbols.
>                          */
>                         parentdep = expr_alloc_symbol(sym);
> -               } else if (parent->prompt)
> -                       /* Menu node for 'menu' */
> -                       parentdep = parent->prompt->visible.expr;
> -               else
> -                       /* Menu node for 'if' */
> +               } else {
> +                       /* Menu node for 'menu', 'if' */
>                         parentdep = parent->dep;
> +               }
>
>                 /* For each child menu node... */
>                 for (menu = parent->list; menu; menu = menu->next) {
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
