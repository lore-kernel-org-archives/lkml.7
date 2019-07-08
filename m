Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C1C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6712053B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="k2+S14er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfGHCCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:02:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33416 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfGHCCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:02:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so12149996qkc.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 19:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9zeZmIHYQzgzcVC1ySz+U2rX4P47jP7v6z+8qZqHJx4=;
        b=k2+S14erQQTZvHh8v3xnH1OORZKY+i+8jSnF8bYTJlmBrexoyGCZi5Ftz0Yl1tKRhU
         6vhNjrYyvp0c7ZwiT+w8/ODFCwqDLVQzvibfV4p/Umnzhk8j97a7zJ5UuXN+RRI5X1GY
         x1nhryIsJfaR+LFiRCdTL1tO3HpKwUm/KRQU+RnGPXtbh25XJe3U1jlMEMhe3Dym2ISG
         wAjXwZ5e3ysVGQAgUKvNk6QT2uLYPA0a0AH4dl/J7ueArh5blbNTqSxOZljYP+nUsnsk
         lzf6qj6vLxkMFVWjW4QnUpUw+8aCg5ipLTXBkbxxP00JY3qazAHLQcRJ5zph2BoXXoK2
         7Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9zeZmIHYQzgzcVC1ySz+U2rX4P47jP7v6z+8qZqHJx4=;
        b=g+nyXjaVNHhX9fvk6ReICb77blngspemiBnGZSE1GAPE37qvM5dlvZfpEzQjJlFE6o
         WZxR7pgWVT/oLrvh4P+Kyt9nc3iPfpswn7uAeQ7rBbrd71dDZA6cW5vBe+ofY3CjuJxb
         FzcJEYdtRkztuoUcKTgV2Sa2R4bye0BFYpfa5I3ZZmGOGk3xlim/ZyXtBd9rTBGowvix
         njDXuqpiZnr8J9cN4bjBBUBsKddnqpc20dEJxLTNWVTqamd80RNsF2n4e5iIFMPT2vHV
         5sq+3sy340kKhbb74TsQRS39ZeUNp91Y6JbS7TvOSVepJMiEPPIQuOYF+mOHYj3uq2zJ
         MUTg==
X-Gm-Message-State: APjAAAXKLbq5+mc/Al7Y0dKWtTvymPEyh76y1X4dERcCOEugSwhSI8E+
        jtxSJs9kA+EwveGNkeV45Zlfs7ci0vLvLngb8M5aQQ==
X-Google-Smtp-Source: APXvYqy9d17m/pkjiibSQDQ0rDiXuyc3qmOMlGCf0PE7BPh55kqzDftEMRtTECA+zUcEexUmHJcxgmQkkUQdwo7KT6E=
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr11590982qko.195.1562551332297;
 Sun, 07 Jul 2019 19:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132632.32629-1-axel.lin@ingics.com> <a99b04a3-f079-3a43-9e19-d9501b76a96e@ti.com>
 <CAFRkauAewFwcQNzpSfAfXMiCdHuENcg2NRzKECjPQ1RtUCuXEA@mail.gmail.com>
In-Reply-To: <CAFRkauAewFwcQNzpSfAfXMiCdHuENcg2NRzKECjPQ1RtUCuXEA@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Mon, 8 Jul 2019 10:02:00 +0800
Message-ID: <CAFRkauAuvM5gjCDnJeVgKy48Qr6yRyX6L-B1f=bdhM3+rApTTQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 1/2] regulator: lm363x: Fix off-by-one n_voltages for
 lm3632 ldo_vpos/ldo_vneg
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Lin <axel.lin@ingics.com> =E6=96=BC 2019=E5=B9=B46=E6=9C=8826=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dan Murphy <dmurphy@ti.com> =E6=96=BC 2019=E5=B9=B46=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Hello
> >
> > On 6/26/19 8:26 AM, Axel Lin wrote:
> > > According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.=
pdf
> > > Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
> > > Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
> > > 000000: 4 V
> > > 000001: 4.05 V
> > > 000010: 4.1 V
> > > ....................
> > > 011101: 5.45 V
> > > 011110: 5.5 V (Default)
> > > 011111: 5.55 V
> > > ....................
> > > 100111: 5.95 V
> > > 101000: 6 V
> > > Note: Codes 101001 to 111111 map to 6 V
> > >
> > > The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum vol=
tage
> > > can match the datasheet.
> > >
> > > Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
> > > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > > ---
> > >   drivers/regulator/lm363x-regulator.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator=
/lm363x-regulator.c
> > > index 5647e2f97ff8..e4a27d63bf90 100644
> > > --- a/drivers/regulator/lm363x-regulator.c
> > > +++ b/drivers/regulator/lm363x-regulator.c
> > > @@ -30,7 +30,7 @@
> > >
> > >   /* LM3632 */
> > >   #define LM3632_BOOST_VSEL_MAX               0x26
> > > -#define LM3632_LDO_VSEL_MAX          0x29
> > > +#define LM3632_LDO_VSEL_MAX          0x28
> >
> > Similar comment as I made on the LM36274
> >
> > These are 0 based registers so it is 28 + 1
> The code shows:  .n_voltages     =3D LM3632_LDO_VSEL_MAX + 1
> so LM3632_LDO_VSEL_MAX needs to be 0x28.
>
>                 .name           =3D "ldo_vpos",
>                 .of_match       =3D "vpos",
>                 .id             =3D LM3632_LDO_POS,
>                 .ops            =3D &lm363x_regulator_voltage_table_ops,
>                 .n_voltages     =3D LM3632_LDO_VSEL_MAX + 1,

Hi Dan,
I'm wondering if you read my previous reply.
You can try to call regulator_list_voltage() for selector 0x29 with
current code,
I believe it will return 6.05V which is wrong because the h/w only
support up to 6V.
And that is exactly the issue this patch try to fix.

BTW, you seem mixes the meaning of latest valid selector
(LM3632_LDO_VSEL_MAX) with n_voltage
since you mentioned it's 0 based registers.
From the context all the LM3632_LDO_xxx_MAX are defined as latest
valid selector because you
can find the code: .n_voltages     =3D LM3632_LDO_VSEL_MAX + 1.

Regards,
Axel
