Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55AD218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 13:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="naU3bMAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCWNlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 09:41:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54951 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 09:41:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so4662271wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C6FtgbJ2S+MpZPzJXM0bRBZ8M+ziQ7BhWeQuyPca/jw=;
        b=naU3bMAqjgjOyUo6tlYXnrDQBctJy8Xl4iswImBu9zynQCOYsUZS8gkXeC2cjvdkIZ
         wp3M1NruVylaBxE15z5TA8wfd/Swam7m2aMzC9o+e7+WzBDaV3+XX6uAbEQ/po+T1h0m
         exRDPhTHCLV/XLogGKNnzjolG8lIQdmwBfV4KW+kMrgp5ajvw2C3nOaIg0TXjPBuk0pp
         fKhg53svwAQ0BdAnCkwcbm52Xn1jG4axojQTq1TnM0DlzyOsY45aPVfbgKKtg5kb9kzG
         whGoJvi6RLDR4QWmAoGrDpkF5HCdEVG8VsbOGWnMirVdyB7TpL+K/9flJK1VpVcn9wwo
         MPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C6FtgbJ2S+MpZPzJXM0bRBZ8M+ziQ7BhWeQuyPca/jw=;
        b=ohXOTdZHt6uCZkn00pdvqTJyKlT8cUw4Pzq3JZAxfCSrSU456p2QGo1gwk43MarnNH
         M58YllJL/5WRv7UNWbgiaVOAMBMT9QzUsOg/YijPDodjSoOU0JsJowvriJPOf2METmAP
         rlO4J2gr5mk23PCVqPH1LH88a55a5S2bJOwv6H65SgzSPaQ85rGlHMEm641GmilLobsm
         44g5vhEU3KiNpBSMABL8dchtn9f2cRzQ6ZcUIkkgr6CaP+7sM2uf2y0zBaUERRZUbCfS
         6a9RjWHHOk8NvcXUDIXb2UNaOe+pIFhMH//xrB60C49lHVN1knWGxtGhGDmO65BuMf7n
         V/tQ==
X-Gm-Message-State: APjAAAV3hJp3chsC1vWZX/KnK53/ii5Wm96oUOBWQqkkBqidNqSONk14
        iVzm1BJweug+gohfmKG2RQykLmqjDl9VO+Y72Ay6Sg==
X-Google-Smtp-Source: APXvYqx7m7rxXCCO1m4ugslZ0Auc4LZ1orYrUy/MV3vESkuMKBAsu1c93Q82mLJj9u8jVggXQfacazFDaDJUje9W+BA=
X-Received: by 2002:a1c:f906:: with SMTP id x6mr114614wmh.126.1553348491774;
 Sat, 23 Mar 2019 06:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190220165013.12774-1-axel.lin@ingics.com> <24E35288-677D-4223-B94A-52A4F37792A8@schinagl.nl>
 <CAFRkauAPGEBxj7k2GvmFwhyc7ZuofhXou17b75F3G-mUWVaf9A@mail.gmail.com>
 <20190221094237.GA5970@sirena.org.uk> <d52c2711-71f3-9e72-f01b-e761f4a92a07@schinagl.nl>
 <CAFRkauDdx00VmqhmzohdCyWbPkctCU2D03JqkpSw2x7n-bDzHA@mail.gmail.com> <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
In-Reply-To: <15e97e28-0008-cda4-176d-a3feb9ad4e8a@schinagl.nl>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 23 Mar 2019 21:41:20 +0800
Message-ID: <CAFRkauA-NB=FBjxoXcnytsGE2A7-MQ6ipeA3s1LDTyjXYr9mng@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS defines
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olliver Schinagl <oliver@schinagl.nl> =E6=96=BC 2019=E5=B9=B42=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=884:37=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 23-02-2019 13:54, Axel Lin wrote:
> >> I will not disagree that it may be extra work to look up the define
> >> (especially if there is no tool tip or split view in the editor) but
> >> reading the whole lot of code, with only the magic values, you still
> >> have to look up the meaning of each magic value, have to guess which o=
ne
> >> has the same meaning etc.
> >>
> >> Further more, I do believe far more people reading will find an define
> >> to be more descriptive to read. Whoever needs to actually go in and
> >> fix/change things.
> > I disagree.
> > The reason I sent this patch is because these defines reduce readabilit=
y.
> > I do care about readability, but in this case these defines make
> > readability worsen.
> Well this really is up to personal preference isn't it? As personally
> find it much nicer to read without the magics :) If I actually have to
> modify or go into the actual meaning, then yes, I will have to dig into
> it a little deeper. But the overal code to a passer by, is still in my
> opinion much more readable.

It's not about personal preference.
The thing is your changes added unnecessary complexity as I pointed out.

> >
> > At the context of REGULATOR_LINEAR_RANGE, each fields has well known me=
aning.
> > When I look at the table with values (I don't care if it's hex or decim=
al),
> > it tells everything I need to know.
> > I can easily check if any linear ranger cover other ranges.
> > I can easily check if any gap between linar ranges, (probably due to
> > reserved bits).
> > I can easily count the number of entries in each range.
> > I can easily calculate the min/max voltage of each range and double
> > check with datasheet.
> > i.e. If there are something wrong, it's eash to detect it.
>
> In any case, you seem like a smart person that reads and writes hex and
> bits often enough. This is not true for everyone. I can just as easily
> reverse your arguments of course, for example, 'each field has a well
> known meaning' ... to whom? People that use these things daily, sure.
> People who just need to double check something or modify something, not
> so much. They have to look up the MACRO, the struct its in, compare it
> to others, so as you can see, what is natural for you, is not true for
> everyone. :)

To judge the readability you still have to understand the meaning of
fields of a REGULATOR_LINEAR_RANGE no matter using DEFINES or constant valu=
es.
Once you understand the fields of REGULATOR_LINEAR_RANGE, you will know
there is no readability issue with constant values in the table.

>
> Also, the general consensus is still to avoid magic values, and to stay
> consistent with the rest and not make expceptions, it makes sense to
> have defines instead of magic values.
>
> >
> > When you change the values to DEFINES, I have to check the value of
> > each define *one-by-one*.
> > There is no benefit in this case.
> >
> > I don't mean adding DEFINES is wrong. Just in this case it does not
> > help and actually has downside.
> > I only remove AXP20X_xxx_START/END/STEPS defines, not all defines.
> >
> > BTW, just show you an example (from drivers/regulator/88pm8607.c)
> > I don't think change all below values to DEFINES help in readability.
> > static const unsigned int BUCK1_table[] =3D {
> >          725000,  750000,  775000,  800000,  825000,  850000,  875000, =
 900000,
> >          925000,  950000,  975000, 1000000, 1025000, 1050000, 1075000, =
1100000,
> >         1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000, =
1300000,
> >         1325000, 1350000, 1375000, 1400000, 1425000, 1450000, 1475000, =
1500000,
> >               0,   25000,   50000,   75000,  100000,  125000,  150000, =
 175000,
> >          200000,  225000,  250000,  275000,  300000,  325000,  350000, =
 375000,
> >          400000,  425000,  450000,  475000,  500000,  525000,  550000, =
 575000,
> >          600000,  625000,  650000,  675000,  700000,  725000,  750000, =
 775000,
> > };
>
> Personally, I think this is a horrible table :p sure, I can guess that
> these are voltages (based on the fact that it's a regulator table and I
> am a little familiar here), but without knowing the context, I see a
> bunch of voltages, from 0,725 to 1,5 appearantly in equal steps, but the
> first question I ask, is the step always .25? I can't see, i'd have to
> go over each value and compare them all. Quite cumbersome ;)
>
> And then, there is a nother row, which starts after the 1.5 but at 0 and
> goes to 7.75. Are these two the same regulator? Why the overlap?

Your guessing is wrong. This is *not* a linear range table.
To judge the readability you had better really read the code first.
Macro's and defines cannot help you regarding this.

Axel
