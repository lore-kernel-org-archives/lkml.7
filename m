Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBEDC2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A82054F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUYqVV8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLFRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:33:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38193 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFRdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:33:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so8495160ljh.5;
        Fri, 06 Dec 2019 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8WsX+x8KU6gUIwy/1//w+CEj5HT779TaFh6Pmjbp38=;
        b=ZUYqVV8T9JTpk4ry/AHYteosNs6QeOlQVc4u+lO5bk+9+39VJiKBP1yhGM5tvctPAx
         mmPYQgX+VppiUnSb0CEOpYos0LjuiKAWWa0c6/TxoDkI7o0qvJRqn6nbwmVYmeN40TZ6
         1lNAcscV/gJJYeBZKQfvW0Hi3NzIEZl+uO71/euytUUSPkp/+Ix/YZv6Qd6yA/Sw7Rk6
         EUjG+HL/xXuGbeKBTatDVVw9zShAWFKRsCUafqCUGEMxDTPRRm7o7gp0JGLOMgLQoxmZ
         TpVpSEz33ynfhIw3Z6m0WJIbfZoCd8x4oSgsdojvGGBJjSavtAD9YbWrlAJcrnvBnXXU
         81ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8WsX+x8KU6gUIwy/1//w+CEj5HT779TaFh6Pmjbp38=;
        b=auiUuJI1xioEnaIvnlAmvw4CfRRxIiZid8j3qtTDcDvQE2G8gPCj+T7A7CvsO/Lb5C
         gswT7lhsJqAgePxibw1N3PN6b3Q1GVQ65TgvswAM1mrm5Y/qvgQeniLW87NZL7CA+XYl
         iJyolc7ipiocJ0IGtezBzaT5FRcc/9/E1uQUqNRgmwE2jASHXPu74wm6VfhVsaCMS9aQ
         4XIse9O26OCpaN3BWh7dHn63nSY7ezFJXIC5FVnbtftcm90f5at06BA6Xx2jmQhjkRwq
         TdFp8itqA33RtKHZtGuRb9FNaSxsrFaOKDVuIEYYtAn7zIXn+PAnky13ZsNxzeDmWqOK
         jguA==
X-Gm-Message-State: APjAAAUGxlVXfJeUfut3npuyuhJu5D5n3p/fvWXxSs6twvyknPANpmUh
        GBd0HlL+1H41Rk4SioQHokkNDF1zVq2WGUaHkTs=
X-Google-Smtp-Source: APXvYqzT0bK5X6/HGopFVV6NbSHSsmWK/d897bK7Uz5bhfSZNF5iE6Ic7eC4ol/IWQhbs4mTbE4shs4EsBamETVnMP0=
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr9588383ljo.86.1575653627233;
 Fri, 06 Dec 2019 09:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20191205215151.421926-1-jim.cromie@gmail.com> <20191205215151.421926-20-jim.cromie@gmail.com>
 <CAHp75VcSkm4M7VOuMWnNUOMAPbbvmodGfn9_Pu25H213pMuxFA@mail.gmail.com> <4e758f68-f1f3-432b-7bc0-2691012ec831@rasmusvillemoes.dk>
In-Reply-To: <4e758f68-f1f3-432b-7bc0-2691012ec831@rasmusvillemoes.dk>
From:   jim.cromie@gmail.com
Date:   Fri, 6 Dec 2019 10:33:21 -0700
Message-ID: <CAJfuBxy67e9wmOTCM2PY_Dwp2O4bWh1J2WLxrAbPO3tQCM56OQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] dyndbg: rename dynamic_debug to dyndbg
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 12:49 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 05/12/2019 23.24, Andy Shevchenko wrote:
> > On Thu, Dec 5, 2019 at 11:54 PM Jim Cromie <jim.cromie@gmail.com> wrote:
> >
..
> >> /sys/module/dyndbg/parameters/:
> >
> > Isn't this path a part of ABI?
>
> Yeah, I think this is a somewhat dangerous change, and I don't really
> see the point.

OK, I didnt realize this was ABI.
I withdraw that patch, and will fix the following one.


>
> Unrelated: Jim, if you want these patches picked up eventually, you have
> to put akpm on the recipient list (he is on this one, but AFAICT not on
> any of the others).
>

Oof.
GregKH has in the past picked up my dyndbg stuff, and Jason's too
but that was 7 years ago


> Rasmus

thanks,
JIm
