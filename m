Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54E2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF46D222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hyz83QNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfKSLut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:50:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45710 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:50:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so18581461oir.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 03:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6H3XfOBXtIiDw4txYzYCJc8lZpqHl4icgBSK0hl1HNw=;
        b=Hyz83QNB+ZAMKm/a/WM+zhXVhLZEcOqNiX2CpGkJylJwBOQBkfslsAevDP4t748NOk
         asre3wGP56oqrVg+XvV1vLI2Y0vkiyvKJw6E97M6OFG744CW0lqLTFyUxHhDhfKDqjJs
         HAInYQQrg5BuruatKj0YY8OKQx8hXyCg6SH9JmHzuOQZWWet/Me8TOxM5tUttPKtUvpK
         E5nioQ3zEA6le4dD9uy4TXgxYNflARtWVL8/x2ylI7qtiorT3EeXRI/10fwBR3qblJMn
         pImhU2z1t2pHgyPlwJtUWmOMxC1K0SRF3+79Y47SDElFR4DHrfU/2mCY7+Fp/KWKCMcA
         XTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6H3XfOBXtIiDw4txYzYCJc8lZpqHl4icgBSK0hl1HNw=;
        b=lkdNEqURTIRupdwD4TzJ0BumjAsGsif0ooM6rC3F1ypieM1cIg0UHTzM9Btb2H1A2P
         fQrnQbpiBrkFl7CpTeK87aMQxwqefxH0as3fiB2MvLof2YxgO16lnhBO4qv/sQhW847l
         ji3bM8ub+D1L8pSXLK9Y2VNIpdlk0z9LxX8BuuyAZfT4lPRynANQXciBJjUX3GCUyLCP
         I2WUqsdly7fEYljMqehjwKZ6DOTPEYy/3CpoYdKqqJyBcf/9HXzJMgVqwxogrwYWcAhP
         Izwb6oR9ZGgVI0h3VPLgQ0A8GzKiN2inkswV1/gjPqbGIXcb84YeyCAuY6a1RfdnwL+L
         Uc0Q==
X-Gm-Message-State: APjAAAWGmX8SyHPyckW/co9x44vd1v2sngNl7DrcDHTF6NWJ9u3sP6zU
        26DDDv5Dl70/9PIS23o6igo0wrP0xGahHdYQAJ2W3Q==
X-Google-Smtp-Source: APXvYqw68/73yXEhDgoAzdeN8F8gTfkjq9l6Cb55BvKoGJJr3Einswr8zpoKZ+WdDZs7uOZVtuAqoQT7mWM5BmFyikE=
X-Received: by 2002:aca:5413:: with SMTP id i19mr3800567oib.121.1574164246147;
 Tue, 19 Nov 2019 03:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20191119183042.5839ef00@canb.auug.org.au>
In-Reply-To: <20191119183042.5839ef00@canb.auug.org.au>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Nov 2019 12:50:34 +0100
Message-ID: <CANpmjNO8=F1-FzUSTr0LAv8uYdQXKO3MT9yqHRGboCfOS1RPiQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm tree with the rcu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 at 08:30, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the akpm tree got a conflict in:
>
>   lib/Kconfig.debug
>
> between commit:
>
>   dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
>
> from the rcu tree and commit:
>
>   fa95a0eadaa7 ("kernel-hacking: group sysrq/kgdb/ubsan into 'Generic Kernel Debugging Instruments'")
>
> from the akpm tree.
>
> I fixed it up (I added kcsan into the above) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, looks good to me -- makes sense to also move this into the
'Generic Kernel Debugging Instruments' section.

Many thanks,
-- Marco

> --
> Cheers,
> Stephen Rothwell
