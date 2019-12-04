Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68310C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3859F2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4XMUWvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfLDUnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:43:42 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42970 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfLDUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:43:41 -0500
Received: by mail-yb1-f195.google.com with SMTP id p137so525632ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI1sz+UgmYlwd0FcX64qY5xEEMiY/gN/Xbiip79JI8Q=;
        b=q4XMUWvQwMVkQnvWBeeR8KamRV/bWMzH4ycUQaCSXuoaoHhyWyY9+mwi4woc9dJBMZ
         G7h0mQ/5RvZ3qSCdLCAGKa5rdUXSyZ7MUrJp7PuMynNhnJNmRgevOe5r7D/xyLL+Rpcc
         PynRnqFnoSjyOBgBt6V696UhGIzzpoMl/LHCdkxSlRJxCxFqar/KmgctsSrkx9riDw+V
         x5OPAmhsO+jKiV2U+uV+O6R7ACWqoe3SkJmUCXPrM20NPTQUQlkJA3ymUbvfV9EOUyC2
         2cBzF9ZXUq4OF6tQVoijtb5nhywjyr/vjXu5O4V77MokhxoLbsyTv8vpTIP7RTyUCYG4
         YL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI1sz+UgmYlwd0FcX64qY5xEEMiY/gN/Xbiip79JI8Q=;
        b=OneIyksvRBhRxXh3JYUd1GkHMSlUGx/8DN/nqQ5sC63uI5yahst/Z8CkRRFnURvWVZ
         3aZaX7yJ5upg8eEXHitdAC8B3F/b17a5tXu/zZorye8qtffV8+BN8LVq6R+AhOu/vAgi
         TjphsrXnWqCK/VXxJSqH+NvLLXGS0kEKA8r97G/BUgi3TAE7cPnllCWe2WsYDwzPlNzZ
         BMAaRrQWxaU61aD+wJxOotP3IfHqHhnzlPlf6A/Rf5h3gBWroQjKI2emXtvTxzizrhGG
         Fcs9smS0qzivgx04bSsmx//9eZxU64BSSNM+4mNombmhaFiM3rHsY2c5Q22K+pIxseDB
         FZCw==
X-Gm-Message-State: APjAAAXqUZpUCzUPbTgBF8WJ4HA6Knvrc0ohbK/aDrH7VYFkkOsXQBoq
        zYulKwibQRkFK2HwSBHY6xZManij
X-Google-Smtp-Source: APXvYqyRKR4MhHnesmksuhK9DJ36aI+PBdIC99R3Ap5k78raTiFPtawxVLA6KVnlJdqMMN5Ye2WFKw==
X-Received: by 2002:a25:6082:: with SMTP id u124mr3753332ybb.160.1575492218577;
        Wed, 04 Dec 2019 12:43:38 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id c20sm3754594ywc.80.2019.12.04.12.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 12:43:37 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id d95so527471ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 12:43:36 -0800 (PST)
X-Received: by 2002:a25:208b:: with SMTP id g133mr3908585ybg.337.1575492216303;
 Wed, 04 Dec 2019 12:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20191203224458.24338-1-vvidic@valentin-vidic.from.hr>
 <20191203145535.5a416ef3@cakuba.netronome.com> <CA+FuTSdcDW1oJU=BK-rifxm1n4kh0tkj0qQQfOGSoUOkkBKrFg@mail.gmail.com>
 <20191204113544.2d537bf7@cakuba.netronome.com>
In-Reply-To: <20191204113544.2d537bf7@cakuba.netronome.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 4 Dec 2019 15:43:00 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdhtGZtTnuncpYaoOROF7L=coGawCPSLv7jzos2Q+Tb=Q@mail.gmail.com>
Message-ID: <CA+FuTSdhtGZtTnuncpYaoOROF7L=coGawCPSLv7jzos2Q+Tb=Q@mail.gmail.com>
Subject: Re: [PATCH] net/tls: Fix return values for setsockopt
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 2:36 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> (there is a v2, in case you missed)

Thanks. I meant to respond to your comment. (but should have done sooner :)

> On Wed, 4 Dec 2019 14:22:55 -0500, Willem de Bruijn wrote:
> > On Tue, Dec 3, 2019 at 6:08 PM Jakub Kicinski wrote:
> > > On Tue,  3 Dec 2019 23:44:58 +0100, Valentin Vidic wrote:
> > > > ENOTSUPP is not available in userspace:
> > > >
> > > >   setsockopt failed, 524, Unknown error 524
> > > >
> > > > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> > >
> > > I'm not 100% clear on whether we can change the return codes after they
> > > had been exposed to user space for numerous releases..
> >
> > This has also come up in the context of SO_ZEROCOPY in the past. In my
> > opinion the answer is no. A quick grep | wc -l in net/ shows 99
> > matches for this error code. Only a fraction of those probably make it
> > to userspace, but definitely more than this single case.
> >
> > If anything, it may be time to define it in uapi?
>
> No opinion but FWIW I'm toying with some CI for netdev, I've added a
> check for use of ENOTSUPP, apparently checkpatch already sniffs out
> uses of ENOSYS, so seems appropriate to add this one.

Good idea if not exposing this in UAPI.

> > > But if we can - please fix the tools/testing/selftests/net/tls.c test
> > > as well, because it expects ENOTSUPP.
> >
> > Even if changing the error code, EOPNOTSUPP is arguably a better
> > replacement. The request itself is valid. Also considering forward
> > compatibility.
>
> For the case TLS version case?

Yes. It's a more specific signal. Quite a few error paths already return EINVAL.
