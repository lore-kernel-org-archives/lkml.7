Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F30C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91C921019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 06:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wB0SFRtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfE2GZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 02:25:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46879 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfE2GZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 02:25:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26so981202lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B3lbQE2t8tEmVgt9o6GAQQq8+7jHXGWM6mCYIQ8+ya0=;
        b=wB0SFRtWdBS25FQwlxgDqoioG2JMCee1JO3trlXkUEQlwE8zKjg/0L5wXHjxb6GlVB
         wCA675RduQm0PynujnXytmOLpubVnOiDtA1jsfD68ihLy3uycaOsC5prWWrpvaxXJHZB
         p/pNvNjFXyXNSlYbSkE7FkEvK3p25Y/EocbjlC3XXWv7xYIEwAKk1Q58/2t9fVcmVpqJ
         I1qPVajgcAQPWILGcRQ/Y+h9LmTK0hIhh5Fm+XFXBPzwVlZliQ+7TfXEd7oI4hUM6dO7
         EAkyjLrzp7jk+zSRvQ4WqFup9N5s8CihTyK7soQmS41HjdWsVDe16OYsmbzhB4A1Hi2N
         X1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B3lbQE2t8tEmVgt9o6GAQQq8+7jHXGWM6mCYIQ8+ya0=;
        b=m9xJRt4tDuMy4qqD3dMkKUBA5WkbmT1nBODvB3VwLYedAlUe29q8Rl67yvGbBJO+Eo
         e5lxBBh5BVEpfIEPzyruJNS8Nx8kZTsy9FcufITW05GtBA/aHQdycLKe32C7hh1ljIx3
         aDZppFIX8yiLjsVpqYsZmVDd3JcIFNmapEI5A8bmnHtDaiHezbNUN21ZMbUFrSs+7/gQ
         NFAz3TVUavH2aZ0PXe7dsbafE7L3WBrIMfx9z9sJ1udqIHqQ0uHrRwC/HYB6SOpO9/Pa
         SflpyCNMiJsiX3w1eBue34cVP8QDShAglUhTqd8e30IwaidKoC+pXfclK9YhbFisKEDJ
         Yo0w==
X-Gm-Message-State: APjAAAURMsLO02UjFCvWi21LdCj2cpXs2DcJQ51F3csIn+EjEWqv93G5
        bTn9nXCwCi+cT05y02P4y5xJE5c/yeLVahDFEeR6Aw==
X-Google-Smtp-Source: APXvYqyBA+PSZZeZoqBiwk392JIbs7Yf+lJ3Xxyzvxrpibt4Wud2QcvuMDANB9aB6ixnoZPeTgRp6Q+/XUyoyxxWkUw=
X-Received: by 2002:a19:ae09:: with SMTP id f9mr1609906lfc.60.1559111122621;
 Tue, 28 May 2019 23:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdYFqcu=gz57H-+h5C3g_rvD-+XoRTw_A86PKDVA3=rfJg@mail.gmail.com>
 <CAHk-=wgZBfGwnyRGjziYvPMssSf7XO+7L_FTGfkR9Gz031VAzw@mail.gmail.com>
In-Reply-To: <CAHk-=wgZBfGwnyRGjziYvPMssSf7XO+7L_FTGfkR9Gz031VAzw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 May 2019 08:25:09 +0200
Message-ID: <CACRpkdYP+i8VQBm_1wr+SrW4QQ-hHO4jNT3Ln-z67ngphuQgbw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 6:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 28, 2019 at 1:44 AM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > The outstanding commits are the Intel fixes [..]
>
> Heh. Swedism? "Outstanding" in English means "exceptionally good". I
> suspect you meant commits that "st=C3=A5r ut", which translates to "stand=
s
> out".

Dammit it is a Swedishism of course, it happens when I'm stressed.
Luckily there is another one on the other end.

Thanks,
Linus Walleij
