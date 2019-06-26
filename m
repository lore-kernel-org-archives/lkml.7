Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2805AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97802080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="XEtgO72d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFZPNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:13:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40357 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:13:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so1932119qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42SCxQLArmojaNJ4Eg62ZtOfK5NvG2Y4ROvc7fxE2rM=;
        b=XEtgO72dgbbxxJL4IFHjrM4f6XYpMuDAcGhRrjTTK3f920vg9awzgGxiEiDMGuccU4
         53To3pDyZNSTeWJJ0MnzQz59RhEZiVQjRtqqVXsha7EU+/eRVUUfQVQH94m2N+n0ijHz
         W0kaPdZikm5iS1vf6mjJQqKk07OC9VxzF52Hn95c3bAIIoHdpN7RgltATZDmYyevkLFL
         rh+T5Cul2txV6zLbz3uATd5bqDDQRC7W5mVwJ30Od9RIq3dezlNuhP5fVPAmMEo+pB0R
         3e9djL33wamnO01MPBGRAtGWgVglyTYBo8CrfkS/bYWCjjF5TL2jlDW78CECYKBU4AB3
         z3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42SCxQLArmojaNJ4Eg62ZtOfK5NvG2Y4ROvc7fxE2rM=;
        b=D/PLr8XMwdbyPgoamJtPyNPlj+1U7oQCa0DxBv5PSHwi+6zJ9gIJi0mNwMusTvIP8N
         HiB1zeghkNkW8BdGvAfWnAdoQoyUNovFTabCwz8tn/2eMqjLxkLqnXDnvF8Jtm89vEsC
         NKFF6fdMwoycUTMY4zTrGSTesWXkkHerYhpOH2Txs3iQt1jCinVQjVGCIG5bt+71AHnA
         9tf4cxfLuoDb+Yz+dSA4qtJfn2sw/9aKOwLXUabdtRp/1JKO7p1wuENDCtL4kTL6Xk7E
         9VySDBREaJO4iw1KzZvuPbw5XHRloyGsZY2ogRXxOGWfcaPnsR4LJwevsRr2oMHoy/k4
         n7wg==
X-Gm-Message-State: APjAAAV5TxRYCaVxJANc9QeITQAoAdRFNlPXvDWgFbP8PhI2WZE2I6rH
        SHvOjEdkeq028uUbv6+xZYps6ZpnmWBsmsk6bOeD9A==
X-Google-Smtp-Source: APXvYqzoFOtmbJfugAdoXgdyPg9Pjxx/aCVlUqLeuIoi11XpvRxnrjqOG6deciPV2fhUB7AzZff4qFVs7OXI9SIsbjs=
X-Received: by 2002:a37:6782:: with SMTP id b124mr4001921qkc.242.1561561987479;
 Wed, 26 Jun 2019 08:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190626132632.32629-1-axel.lin@ingics.com> <a99b04a3-f079-3a43-9e19-d9501b76a96e@ti.com>
In-Reply-To: <a99b04a3-f079-3a43-9e19-d9501b76a96e@ti.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 26 Jun 2019 23:12:55 +0800
Message-ID: <CAFRkauAewFwcQNzpSfAfXMiCdHuENcg2NRzKECjPQ1RtUCuXEA@mail.gmail.com>
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

Dan Murphy <dmurphy@ti.com> =E6=96=BC 2019=E5=B9=B46=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:07=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hello
>
> On 6/26/19 8:26 AM, Axel Lin wrote:
> > According to the datasheet https://www.ti.com/lit/ds/symlink/lm3632a.pd=
f
> > Table 20. VPOS Bias Register Field Descriptions VPOS[5:0]
> > Sets the Positive Display Bias (LDO) Voltage (50 mV per step)
> > 000000: 4 V
> > 000001: 4.05 V
> > 000010: 4.1 V
> > ....................
> > 011101: 5.45 V
> > 011110: 5.5 V (Default)
> > 011111: 5.55 V
> > ....................
> > 100111: 5.95 V
> > 101000: 6 V
> > Note: Codes 101001 to 111111 map to 6 V
> >
> > The LM3632_LDO_VSEL_MAX should be 0b101000 (0x28), so the maximum volta=
ge
> > can match the datasheet.
> >
> > Fixes: 3a8d1a73a037 ("regulator: add LM363X driver")
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> >   drivers/regulator/lm363x-regulator.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/l=
m363x-regulator.c
> > index 5647e2f97ff8..e4a27d63bf90 100644
> > --- a/drivers/regulator/lm363x-regulator.c
> > +++ b/drivers/regulator/lm363x-regulator.c
> > @@ -30,7 +30,7 @@
> >
> >   /* LM3632 */
> >   #define LM3632_BOOST_VSEL_MAX               0x26
> > -#define LM3632_LDO_VSEL_MAX          0x29
> > +#define LM3632_LDO_VSEL_MAX          0x28
>
> Similar comment as I made on the LM36274
>
> These are 0 based registers so it is 28 + 1
The code shows:  .n_voltages     =3D LM3632_LDO_VSEL_MAX + 1
so LM3632_LDO_VSEL_MAX needs to be 0x28.

                .name           =3D "ldo_vpos",
                .of_match       =3D "vpos",
                .id             =3D LM3632_LDO_POS,
                .ops            =3D &lm363x_regulator_voltage_table_ops,
                .n_voltages     =3D LM3632_LDO_VSEL_MAX + 1,
