Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074EBC2BA1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE87A2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1VB0FI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfIOV6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 17:58:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53886 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfIOV6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:58:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so2022812wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asP2MeWC9oWpx/gaOK+HIONcvfsMWrL7pF7piAoOX20=;
        b=S1VB0FI71TIhbEAW+HnuYeu8lYF8IPAD5FbR8FKruD2QVdqxM5xYfHY82UeYuYHI38
         64nKSioCUrLEnubE0nEDImhDcGu1KxkcPyXvp2fQTSLRX6PqBfiSLWjroWJ0V2LZQ2hO
         eAQ4HbdEBCwaVhQt62GLJLi5lXY0Ok9tQm6EmRi1VluYcF6AujQFN8e9yz/57qpOqxp6
         9VhH0IskrMZgdi2BA7Sy8uhe1IzWkJRzYK+CgDyPlzzhzdrOcy/lLnMOPC6DtBCw4Vo8
         vyaH+FP4qqe1U+ckkQW+aD3UkKy5N5p1sdrOwwVaGE6JVghnT/jz7B37T5nhQzIF2W52
         P80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asP2MeWC9oWpx/gaOK+HIONcvfsMWrL7pF7piAoOX20=;
        b=rMjLYDhRjaTFZrLkBWKSlOU0V07CylRCCWAOWahyvL7Nw2Sevppa+35KQMTFkc296e
         6V7MDfq25zFG75TWRhSSYC+amhjpEJKQ1xToFJm19PzJYF1OAF7iG+cx7S/tdN93NIWi
         3LDfb74ZzikF56KcteRU647LWZJjRRfAePieUCN9xz6CXwcv1jnLWQQaYcT4aaxEBRNw
         LOFAqXkhvgqlOUIZ6bwroRovloUAvF2ZRfBt1AeeZVp0nfIbCz3smtF/BUXOwy3UUWUt
         CPK7o03ALarKq6i4hu+BPehSKwThEJKgB0axYLYkF4H6HlcIeXW73Q7+vy0WUcd/265c
         7OeA==
X-Gm-Message-State: APjAAAUH3IReYTrkNlAfs6AfaM6P5SXwtmanQiGlhrD2qEUlraSEy87C
        Rb/pmWoeXjbdN/oNJwCAxD4H7yPCL2DAZPcjw6o=
X-Google-Smtp-Source: APXvYqyLaIkBfO0cRj9G3hwB3BPI2zKLvyTV1roHXRqM+QcYeakzYrOkMQC9znKnOdI6GUB/SfDLHZfnKgSmiUH2ZS0=
X-Received: by 2002:a1c:eb16:: with SMTP id j22mr6071758wmh.176.1568584719359;
 Sun, 15 Sep 2019 14:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190829005009.GA5895@embeddedor>
In-Reply-To: <20190829005009.GA5895@embeddedor>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 15 Sep 2019 23:58:28 +0200
Message-ID: <CAFLxGvx3fbWn=kazG342PO60uyA0HM2Lzt2j-k7+vTBhLSoAjA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: super: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 2:50 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct ubifs_znode {
>         ...
>         struct ubifs_zbranch zbranch[];
> };
>
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
>
> So, replace the following form:
>
> sizeof(struct ubifs_znode) + c->fanout * sizeof(struct ubifs_zbranch)
>
> with:
>
> struct_size(c->cnext, zbranch, c->fanout)
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  fs/ubifs/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 2706f13e3eb9..ca86489048c8 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -661,8 +661,7 @@ static int init_constants_sb(struct ubifs_info *c)
>         long long tmp64;
>
>         c->main_bytes = (long long)c->main_lebs * c->leb_size;
> -       c->max_znode_sz = sizeof(struct ubifs_znode) +
> -                               c->fanout * sizeof(struct ubifs_zbranch);
> +       c->max_znode_sz = struct_size(c->cnext, zbranch, c->fanout);

First of all, c->fanout is bound checked.
I had to lookup how struct_size() works to understand this
single line of code and why you use the completely unrelated c->cnext here.
Sorry this change does not make the code any better just harder to read.

-- 
Thanks,
//richard
