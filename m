Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72566C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4825820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zoB+I1qM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbfFMPsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:48:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33570 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbfFMJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:16:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so6142403wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P4N1UtPKJVcelijw7QBQ1XLSRt7ridPaKRyOBmFmp0w=;
        b=zoB+I1qMrXW5msQjRKnTgAM/Hh9auE47o+cxvqiEVcyurJ9wsx1RAYtZBDnCaKqDof
         m1Ka4fuQ842iFh57kWp7h+yZO+dKcLrZpYRtQolBfQ39M/3DG3mCMDtqhEsHLr6dNRla
         y/Uc11TrqvR08utOekpguuKCeTIWNQmbKCYf+sSd2FAqk+FEFwpdJVTvb+qSjd7GAa/s
         kBpbAdqYwmGMqkkI3YhCUFXD8oa+rDgIdLyeq5ym0FbmIKsEItDizEy0cX6vyncJePWp
         BZ7zlU7oGjUbfvuB7MiLU354VdrVer90caAiU3wh9nfbR3emhxaBGhOhkrpW/MC3+Qus
         KRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P4N1UtPKJVcelijw7QBQ1XLSRt7ridPaKRyOBmFmp0w=;
        b=hkCEBQVErU7oreVrhhfuYUZ7yIP9K4zjvcdzYqlzJ0LZsew70Jh+Q7DYgVuXzPF+bT
         +/oS+RdDJTsUzbWagyla9MyylGt6BfaGV56rZu5kWLzDeERsM5KB+FtF4FHJcHEvPGC4
         9ZY/MAkHVT/AuuL26RP0TFx6P//kvOfe++FvUm/PuqtbRjKWefNXXclvwRoLB4BGcxk3
         SWV1s0NuVkiG38D3qTdI9TeabWgA+mzTc3fp7r+zSq4Y1+n++Le7t3xO83WHv1MQOuh7
         ZvSn7D5iOYk4TvqQIklmXRnMbOdq6vuK4hYqzha7fb2YxCNVE39PcyCFYBTW3O1pDOMx
         8LSg==
X-Gm-Message-State: APjAAAUr9YNeYhCvpkUz6cqejzJh9pzBMdlYIgqYOmvG/ixQi2w5G3Fn
        sRqgA03+B8ejjIkUS4ftHRms3R9Q8yimSmwEG7uXmg==
X-Google-Smtp-Source: APXvYqya9k5qn89YYNprL6zry6x5KHz6UoRI9nvUtHBgDzPVPTHE/ALR4XfG2GiQ1hwNRfaH+VxDHQlRLeGVdjjdK7k=
X-Received: by 2002:a1c:700b:: with SMTP id l11mr2827093wmc.106.1560417403085;
 Thu, 13 Jun 2019 02:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190612170027.13dbb84b@canb.auug.org.au> <c526a510-a08f-8b99-a396-4274590e904f@infradead.org>
In-Reply-To: <c526a510-a08f-8b99-a396-4274590e904f@infradead.org>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Thu, 13 Jun 2019 11:16:31 +0200
Message-ID: <CAMO6nazLss_4cfAJZZLA+Ydrx0wPCxMYrZM2NQKDw1AmvSj_0Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 12 (staging/media/meson/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,
On Wed, Jun 12, 2019 at 11:50 PM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 6/12/19 12:00 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190611:
> >
>
>
> on i386:
>
> ../drivers/staging/media/meson/vdec/vdec.c: In function =E2=80=98vdec_rec=
ycle_thread=E2=80=99:
> ../drivers/staging/media/meson/vdec/vdec.c:59:2: error: implicit declarat=
ion of function =E2=80=98kthread_should_stop=E2=80=99 [-Werror=3Dimplicit-f=
unction-declaration]
>   while (!kthread_should_stop()) {
>   ^
> ../drivers/staging/media/meson/vdec/vdec.c: In function =E2=80=98vdec_sta=
rt_streaming=E2=80=99:
> ../drivers/staging/media/meson/vdec/vdec.c:324:3: error: implicit declara=
tion of function =E2=80=98kthread_run=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>    sess->recycle_thread =3D kthread_run(vdec_recycle_thread, sess,
>    ^
> ../drivers/staging/media/meson/vdec/vdec.c:324:24: warning: assignment ma=
kes pointer from integer without a cast [enabled by default]
>    sess->recycle_thread =3D kthread_run(vdec_recycle_thread, sess,
>                         ^
> ../drivers/staging/media/meson/vdec/vdec.c: In function =E2=80=98vdec_sto=
p_streaming=E2=80=99:
> ../drivers/staging/media/meson/vdec/vdec.c:389:4: error: implicit declara=
tion of function =E2=80=98kthread_stop=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>     kthread_stop(sess->recycle_thread);
>     ^
>
> Full randconfig file is attached.
>

This is fixed with "media: meson: vdec: Add missing kthread.h" from
Yue Haibing [0]. The patch is sitting in media_tree/master.

[0] https://patchwork.kernel.org/patch/10989333/

Regards,
Maxime

>
> --
> ~Randy
>
