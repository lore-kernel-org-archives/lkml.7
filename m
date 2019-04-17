Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E590620674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfDQQTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:19:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40300 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:19:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so27995835qts.7;
        Wed, 17 Apr 2019 09:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1b9GSK1VJr1GL9RcS5con8Prr8JPtAwFnxmkS4Pf3c=;
        b=QVRgoRJl69TlVpIqeDuMloOV/KRdBD3GdGM/J92PBdvuo+tmOpyzWCkreutZ9hGZUI
         1tVUd+3Hm7lDByvoUy0NBIsG2W1YP1kpskPQanxulRzWO4jftPNn0ysSzjq4wZOABMFL
         99eXhf415M5Yhu3aCdwNk5jyLmyf4PplLyEzb36DXN+BHnnnMDBhKTVd3ubxiV/PWqqx
         pSumolFuSGzTJViXuKSZ3bCOaWwP0MjPmdrxMWbx6K6baGUJ/Gei8zToIQnb3F+tDtrP
         T7lJNDfPsUxSEYfsAC+Rikj4IIYXHdWnkTQPkc0qhAcmC0sqLIX+vIow3yApBDIqaQ6I
         mvtQ==
X-Gm-Message-State: APjAAAXBDzPJByR/2BuwjJze6GhklV7YGwWvVZpQgPEWoh2ez4mQwn+j
        WM4/1REhYQhoVqbgfFGsrZ/4T1k7XmloIJZOKWQ=
X-Google-Smtp-Source: APXvYqwvqBeAhXMpfw61DPYGN3eB/GwOK6eBSVxzTm/UN7mdMOU0P+3NWtw7afLpPAQNzyglYzTdCGJXNVsqdjN3Cb8=
X-Received: by 2002:a0c:ba10:: with SMTP id w16mr72768455qvf.115.1555517982549;
 Wed, 17 Apr 2019 09:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190416203620.539628-1-arnd@arndb.de> <CAF=yD-K89Z2ea_iakjfP98GnfU-yXts8LU4GW3Rr_etJ+r92pw@mail.gmail.com>
In-Reply-To: <CAF=yD-K89Z2ea_iakjfP98GnfU-yXts8LU4GW3Rr_etJ+r92pw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Apr 2019 18:19:25 +0200
Message-ID: <CAK8P3a2z5QT7VooQPytx-C+Z_+kxzqmWmB8x-ow9PaApPuFY8g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Andrew Hendry <andrew.hendry@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:46 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Tue, Apr 16, 2019 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> > socket protocol handlers, and all of those end up calling the same
> > sock_get_timestamp()/sock_get_timestampns() helper functions, which
> > results in a lot of duplicate code.
> >
> > With the introduction of 64-bit time_t on 32-bit architectures, this
> > gets worse, as we then need four different ioctl commands in each
> > socket protocol implementation.
> >
> > To simplify that, let's add a new .gettstamp() operation in
> > struct proto_ops, and move ioctl implementation into the common
> > sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> > through.
> >
> > We can reuse the sock_get_timestamp() implementation, but generalize
> > it so it can deal with both native and compat mode, as well as
> > timeval and timespec structures.
> >
> > Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> > Link: https://lore.kernel.org/lkml/CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: reworked to not break sparc64 support
>
> From the discussion of v1 I thought you planned to unconditionally
> call sock_gettstamp() for all protocols, avoiding the need to plumb in
> all these new callbacks?
>
> That is more concise, though this closer to the existing behavior. So,
> fine either way.

Thanks for the reminder. I have definitely waited too long before revisiting
this series, and only had a vague recollection of that discussion but could
not find it in the logs (found it now, and the Link I quoted...).

I would prefer to get this series into the coming merge window, and
probably don't have time to rework it completely by then, so I hope
the current version is ok.

I also found your comment on lock_sock(), which could be easily
added inside of sock_gettstamp() if you think we should have that.
There is one more issue I just noticed (I dropped the necessary
sock_read_timestamp()), so I have to repost the series anyway
to fix that.

       Arnd
