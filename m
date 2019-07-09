Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB1C73C60
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89A020693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKimPJQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfGIW6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:58:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33806 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIW6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:58:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so115285ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1q4TA7V+oBcDgmqSY6j6ZlCOYtkPjgIBwS25WUZLTs=;
        b=QKimPJQvVZxi7GGt2IK1wSGVwVlf4++Q5OMJBzPPYYowi8Envs3WSce6Gh6UtIGn7p
         mMKAlA/kneX13lMFTJKpO7ij59QRaHjSt/QfGE9ZB6jk35NiPPjRmvTbmNKN0ehzBGxA
         zyxh0P4ALP4P+wbKb/tJ0Mbl8WsNRtZvaujAom76uQk7w7Kx6RRDzBbgfDjAhBuCqqrc
         7JGBAc2nihErYrwfyD+Yp/S7DVlpCbM2jqSYhX4tCZC3CcBuONBCNN3NMDysY8fsf/qv
         UnUHv51vUsvmObHPcD6MQrJ5iWSwo8SF9ejOhIxDPhTaUnQR4sRnrdc+XPZEdGX4JSUy
         zC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1q4TA7V+oBcDgmqSY6j6ZlCOYtkPjgIBwS25WUZLTs=;
        b=h90UyiUk9iLNjtJaoi9mnXI+VuhSwmJgACQ4MEAofjgS6wLU1bcRPDeSAjG1+gX22H
         h1i0pY3UrUt314TFJyr6bChcJ1uULD4lOnfFrr9ZsmYoBiPl+3y6aXTcM/gGqhKWA93n
         QTTB7/NtKza2bnXVy/Lo9SnCUwSo0R/Jiks/rEWB0ca4xxFPrubzYLbKXkD/ZvTGA+rk
         NysyMnW/2PdQWSlbBGw7vxyEazq/mCDYTAXMGJUBD/wUZ177DZDYhhwawrkrQLoxqCJs
         O/0Nzm9uEPuAa5oJVyMI3kq+sNw/4WqCAkLORo767RmuzCL4EHqw7+Zcvd7MK5UyeXVe
         Ylpw==
X-Gm-Message-State: APjAAAU9cmgnxreZvlxvltz9dnSZvGUBr1aeBN4KFSNWrfsWRuBymdf4
        1+SgkxqJMX0QOY/nTYUP8u9BEQFDGjLD3pfYCyo=
X-Google-Smtp-Source: APXvYqxbFGUwEu2uaJdKJTp5ypFTyrjL1JHgGSn+2cAk5GRU6ARJ8/16eg6flo1l5iygVqe1kZ2+pFWrBsTQu9VGrl8=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr14985598ljj.146.1562713108067;
 Tue, 09 Jul 2019 15:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com>
 <20190703001842.12238-3-alistair.francis@wdc.com> <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
 <CAKmqyKP07futGV1WsZwvqGzeR646eo-ysVy9RCqaSOG-2qhH_g@mail.gmail.com>
 <CAK8P3a1zJPiR06uxZ5QVoEyDU64v=oUu_p9X-mULLeXN-som8A@mail.gmail.com>
 <CAKmqyKMtsQaq9DpfPY=T0pixrH2sntewDz42dTvD5rDcK+ZV0w@mail.gmail.com> <CAK8P3a36CXf+HGgL=nNYzc-1Qhh=tu6to0opwYjO4fO5KDxUDA@mail.gmail.com>
In-Reply-To: <CAK8P3a36CXf+HGgL=nNYzc-1Qhh=tu6to0opwYjO4fO5KDxUDA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 9 Jul 2019 15:55:18 -0700
Message-ID: <CAKmqyKMx8JqGw7uhUO5pDkgyRDCixv6TXPCZUSHrAu8efZNBRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct
 for RV32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 1:34 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 4, 2019 at 12:18 AM Alistair Francis <alistair23@gmail.com> wrote:
> > On Wed, Jul 3, 2019 at 12:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Jul 3, 2019 at 8:45 PM Alistair Francis <alistair23@gmail.com> wrote:
> > > > What I don't understand though is how that impacted this struct, it
> > > > doesn't use clock_t at all, everything in the struct is an int or
> > > > void*.
> > >
> > > si_utime/si_stime in siginfo are clock_t.
> >
> > But they are further down the struct. I just assumed that GCC would
> > align those as required, I guess it aligns the start of the struct to
> > match some 64-bit members which seems strange.
>
> These are the regular struct alignment rules. Essentially you would
> get something like
>
> struct s {
>     int a;
>     int b;
>     int c;
>     union {
>          int d;
>          long long e;
>    };
>    int f;
> };
>
> Since 'e' has 8 byte alignment, the same is true for the union,
> and putting the union in a struct also requires the same alignment
> for the struct itself, so now you get padding after 'c' and 'f'.

Now that I think about it more it does make sense. Thanks for the help
with this and all the glibc stuff.

I have a new patch set that seems to work on RV32 and RV64. I'm now
hitting issues with syscalls that glibc doesn't use but other projects
do like io_getevents in OpenSSL.

Alistair

>
>        Arnd
