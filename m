Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF823C010A1
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969A9217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcHtpXj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbfKEKTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:19:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388412AbfKEKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:19:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id s1so20695998wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vg9FJPss8oQNDihBdCZVUS9OPM3FEf7k8iX3IaB/rMk=;
        b=RcHtpXj3xta/TON458H7sjcflesgxh5ZIlGgF/w8cfKM3Tk++oQ+UbZoc9IbQXIzNP
         lZfX6mIUUKkgE4D47Exwy+dGakSiN0zHvJYFfxPtZ9uY0UBy7SkGiDKKyKO1VicjgGe2
         lHaKhpBd+dQXxgTS0O8qp8jxGhIuK897UuPkUay4dMSF3M1M5+2/j6DUaE5x4kwSlV2k
         FZPFnDT9ipt72eBrh88K+/boQvPA+ScTe+0DiBMVtpbdc48zbwDqyVtemGY50IG8Zq1f
         y1G/01WqP974kRwLTd2zh6RvthXOlf2ebuB+RJP6MnPNd7yWKGkgarAUEMiTvDTWzIKv
         1siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vg9FJPss8oQNDihBdCZVUS9OPM3FEf7k8iX3IaB/rMk=;
        b=DQYqNmitdevQ8xWx3yek1+qqdMDMQaWpHkJ7d2J8QZvIY1M5TKHUCSHPH1TbUsU+ja
         MexrHqGvzBAnoSA7Vx+21fHTrxHtZMYHBdzkBfyYh4Bupp/aqclDnquO3hhNq+0eT8cX
         pC2UONoVeHNDnlbgdRiMpQXHc52JauMAdbxz8wj3dlrThx4RGOc+vrg2BAS1VG4zrZOK
         VcJ1TarPN3KaJ9igqX9CfhhuzNiH5rnY4boHi0upgBhO01uaK8s9e448Vp0J9Wnvsw8p
         dOFZ9StAZ+SrVIb32hbd5n7SzARqvLTvSS5/5mjZzzs7bfOcGoYdaZosDoFmfrbHcDlz
         Mb3Q==
X-Gm-Message-State: APjAAAX8ES1ejEqLvKAWVBu4r3gkk+dI9KogShxOXiL54ZELj84u2BrM
        B3DLVzZf9c7W1PYWuKehNpb0Og9xfk4P1XiGcPKz/Q==
X-Google-Smtp-Source: APXvYqwc5X4e8SULXzuHD/iDw6JHvrLWDIMOYR8u3xD+xd7yygIt7ZnRIEQDjl27KzoMY9DuDrlrVwgs2+8GyXTUg0U=
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr28633229wrv.216.1572949159760;
 Tue, 05 Nov 2019 02:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20191104170303.GA50361@gandi.net> <719eebd3-259d-8beb-025a-f2d17c632711@gmail.com>
 <20191105080554.GA1006@gandi.net>
In-Reply-To: <20191105080554.GA1006@gandi.net>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 5 Nov 2019 11:19:08 +0100
Message-ID: <CAG_fn=V1rriybnSB3WSS-yqWEAuAdo89MG1SWPkvneizX61TVA@mail.gmail.com>
Subject: Re: Double free of struct sk_buff reported by SLAB_CONSISTENCY_CHECKS
 with init_on_free
To:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, clipos@ssi.gouv.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 9:06 AM Thibaut Sautereau
<thibaut.sautereau@clip-os.org> wrote:
>
> On Mon, Nov 04, 2019 at 09:33:18AM -0800, Eric Dumazet wrote:
> >
> >
> > On 11/4/19 9:03 AM, Thibaut Sautereau wrote:
> > >
> > > We first encountered this issue under huge network traffic (system im=
age
> > > download), and I was able to reproduce by simply sending a big packet
> > > with `ping -s 65507 <ip>`, which crashes the kernel every single time=
.
> > >
> >
> > Since you have a repro, could you start a bisection ?
>
> From my previous email:
>
>         "Bisection points to the following commit: 1b7e816fc80e ("mm: slu=
b:
>         Fix slab walking for init_on_free"), and indeed the BUG is not
>         triggered when init_on_free is disabled."
>
> Or are you meaning something else?
Could you please give more specific reproduction steps?
I've checked out v5.3.8 from
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git, ran
`make defconfig` and added CONFIG_SLUB_DEBUG_ON=3Dy.
Then I've built the kernel, ran it on QEMU with slub_debug=3DF and
init_on_free=3D1, SSHed into the machine and executed `ping -s 65507
127.0.0.1`
This however didn't trigger any crashes.
Am I missing something?
> --
> Thibaut Sautereau
> CLIP OS developer



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
