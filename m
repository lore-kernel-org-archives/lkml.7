Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61AC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EC32173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQFKQEvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEUWxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 18:53:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43413 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEUWxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:53:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn7so49784plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02nYY05v2QFr3Hfg9pPQ1xvZe/bkgLIox6orT9FB980=;
        b=oQFKQEvKdJ9k/WFF/QUvYG+lk/dKXT9bQyVDOteomDhohhE9Ml6KumTyPptjehvXnY
         zE8hStZBeEQEuFfa07M2G1PtOf3jsGFNzM7kBoKaTghA739BAod9YKK542Jk7NskzBAX
         bEyTsq16Z90dWKWOu3Er36r8Lw8INwaMeI8RRM7BU9zOLeCHBZAlCarDjPrlP0xwqGx+
         gA1H2ehrLIxAWqySLfHykLk2mIa1A6FdOSK+V9jv1Fm7yKnu+pJ1P4bHCzRH+nPPZBmf
         bOLqzG1U7yWFQpXjDBcCDUjh6E1nwjevDnXNbvbMamUIeJ4uwpoaw2YHFih3R6yQEIjK
         YO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02nYY05v2QFr3Hfg9pPQ1xvZe/bkgLIox6orT9FB980=;
        b=ZHLRnL4LvoCnUDqWUGuOCynvFRcxhbPEZZ1ko19nqJ31ToAGi3NTn+MS0EFCNbOU8+
         b6CkjbsZlid1xchns87vmBz528f+iAykWWyBGGI3BVmgwZ78LwphnaSpc5ttedDr1S4S
         6O0JtylN31tTWcLt+CbCB/0jMPXGF+0771oYb0SGqb0YyfzdD/oQlzgsTjjxXs9tGlAH
         QSrY/YcFEBp64tNeelXpawp6/L6tI41z6x5Fv4DswnZZkpS/XJrVAOWZ4DYLWq1GfGY0
         7jrYGiH1r5MvWm1Zv/rFd4WqFFH9e3N2mbFL7j17bVqrIv8dc0t74gEQbe9IRsiNvqc7
         mngA==
X-Gm-Message-State: APjAAAXNDmmpoaKuE9UF3efM0UFTRantvyO/yAMqwukkMfVjZt8lfkZE
        r7LU2q1CYEdkKHQj4rabXaUkJ83+ONC9sNqDmtejMw==
X-Google-Smtp-Source: APXvYqxduUhjYzwZiokDSqwpPRvgN6vAthBQXb7qyFz6P22SFMj6sUEJqqC0+eAyn0AKlW6iepuBKAfLujn+D2SO9Lw=
X-Received: by 2002:a17:902:4e:: with SMTP id 72mr34044835pla.80.1558479224024;
 Tue, 21 May 2019 15:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190521174221.124459-1-natechancellor@gmail.com>
In-Reply-To: <20190521174221.124459-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 May 2019 15:53:32 -0700
Message-ID: <CAKwvOdmgpx0+d905PdRqUFeg8Fj8zf3mrWVOho_dajvEWvam9w@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: Remove an unnecessary NULL check
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        rsmith@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:42 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:47: warning:
> address of array 'param->u.wpa_ie.data' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>             (param->u.wpa_ie.len && !param->u.wpa_ie.data))
>                                     ~~~~~~~~~~~~~~~~~^~~~
>
> This was exposed by commit deabe03523a7 ("Staging: rtl8192u: ieee80211:
> Use !x in place of NULL comparisons") because we disable the warning
> that would have pointed out the comparison against NULL is also false:
>
> drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:46: warning:
> comparison of array 'param->u.wpa_ie.data' equal to a null pointer is
> always false [-Wtautological-pointer-compare]
>             (param->u.wpa_ie.len && param->u.wpa_ie.data == NULL))
>                                     ~~~~~~~~~~~~~~~~^~~~    ~~~~
>
> Remove it so clang no longer warns.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/487
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index f38f9d8b78bb..e0da0900a4f7 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -2659,8 +2659,7 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
>  {
>         u8 *buf;
>
> -       if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
> -           (param->u.wpa_ie.len && !param->u.wpa_ie.data))

Right so, the types in this expression:

param: struct ieee_param*
param->u: *anonymous union*
param->u.wpa_ie: *anonymous struct*
param->u.wpa_ie.len: u32
param->u.wpa_ie.data: u8 [0]
as defined in drivers/staging/rtl8192u/ieee80211/ieee80211.h#L295
https://github.com/ClangBuiltLinux/linux/blob/9c7db5004280767566e91a33445bf93aa479ef02/drivers/staging/rtl8192u/ieee80211/ieee80211.h#L295-L322

so this is a tricky case, because in general array members can never
themselves be NULL, and usually I trust -Wpointer-bool-conversion, but
this is a special case because of the flexible array member:
https://en.wikipedia.org/wiki/Flexible_array_member. (It seems that
having the 0 in the length explicitly was pre-c99 GNU extension:
https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html). I wonder if
-Wtautological-pointer-compare applies to Flexible Array Members or
not (Richard, do you know)?  In general, you'd be setting
param->u.wpa_ie to the return value of a dynamic memory allocation,
not param->u.wpa_ie.data, so this check is fishy to me.

> +       if (param->u.wpa_ie.len > MAX_WPA_IE_LEN)
>                 return -EINVAL;
>
>         if (param->u.wpa_ie.len) {
> --
> 2.22.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
