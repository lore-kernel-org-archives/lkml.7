Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F58EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328C821479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="Dr3t4YCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfEUNw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:52:56 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:54378 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfEUNw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:52:56 -0400
Received: from [172.27.227.142] (unknown [185.69.244.31])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A1BC1C1489;
        Tue, 21 May 2019 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1558446773; bh=T5HvSzh7U58yDS/HdAzE5Y5CTmjj27w0sEugeGRIUTs=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=Dr3t4YCm2LWkf3tR2qCVQGR+EU4Ucnmn4iXcRC8dZBZWD1NEGFCiwiMI82PU34vN3
         rESl6X/w3cD4bxNdZFhyT9Nc/wwKKeOVAmZczVIY9J25+Hq9XFOBK/9NLDljl0ZZ9L
         rE+SaKlq3RLTuo58/ediIVunL1YOnBQD9Ag6mdl0=
Date:   Tue, 21 May 2019 15:52:47 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190521130955.3omqwpx3i7njsb3t@flea>
References: <20190518170929.24789-1-luca@z3ntu.xyz> <20190520110742.ykgxwaabzzwovgpl@flea> <9B2B83DF-2C91-4DDA-B707-664A792A8BCF@z3ntu.xyz> <20190521130955.3omqwpx3i7njsb3t@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=luca@z3ntu.xyz; keydata=
 mQINBFgc0/QBEACzBE9TBfe+O2TARphhmhVgMd2zo3lkvjWdohb9mg9+NvUq7swQR2l8davgwaTN
 VwDUA9jdzfjp4GShf0VFnqqFGouEc3OMeuHFdtjG4RoYGW+XvEoAcTWgY6glANmMZMi33D+2wnQQ
 Qziie3LMTQ7Tlpk8at8Ck4ShmmGTmek9LNFq1eHs3IHK5eH0fDA/rYvPxFMmwbHRDjdwtXjZlXBC
 nxEXK8CJkNG58G+RbtPU0I8Iu02TDOkr9x6KwLT1lJmq03wCkuQEXrDAzo6kkeAMhzWBtBtxTB1M
 byOZqNlbzEtxOTK9iA74U6POyN//876ESQ87LicFS4mgoyHL0Vt7ro9CSH7Imzv96Ae8HDZqIcBy
 Bn9YMBswjy4JOsC9JP/oDhr71y40nnrVvgx4ZesJM0PL9J1JYQWJQ22GoinnDwSB11Re51OYsK+l
 xEqph38N+AjcNYm+l85O/l+BkkULC+0kHWG6wQCv67KyeYCJJhNqJucXj2gXXaKyv2ltWPwHgK6w
 OAtN9QbimcYV2PUgfx6hl5r7buwc3tefp9ccmtoLq74mgrKiLurHqa4pKCa1uqfhBEN5/Os5tMrX
 IGa2sRvKHK0Pn7iyJQyuclyOp4r9W+QUw2DENm4n6ovkl7rfriL6ibBgVLcnexdG/8LZRaWFV96G
 YY3VCcRlz8SCwQARAQABtBtMdWNhIFdlaXNzIDxsdWNhQHozbnR1Lnh5ej6JAj0EEwEIACcFAlgc
 0/QCGy8FCQWjmoAFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ+vac9s0tAs3X3BAAo6F00XKQ
 LAvQl/nTK4+2EHjtFUF0OnUK0rIN1b1l5WMVHFF8njcVqG1Qc7CKyYCS6mN6bbYkXsj3TXy8Vx9R
 P4ek8UoxEnVXYeayF5D+ke7yCmOJjSEBZVh/meA2jYOnPXEXR7bTT+PNaCTIgS6MucYous3ngiIL
 kDT9Q09ESjs9xhoqbpBr19fqE9HpuWCaVGi5tt8EQAVq32kfq9DFqanjuaz18/I3VV1fMKWoNZBu
 qJKveh9oDmkKe32PTVV8ak1tpWYNRhoIL8jZgJkzG8cMPdi6fi8xy7wIaT49py+0rndGF7i79nAx
 Sq3vlt6dMgcOlMYTZMw1O8Y28eiHm5DCzyPR5FkQvQ1xY2TPTZh9H4zukBLBkctDtccosGwZt3tb
 uoQ2Nelm12ldf4kdbGmWdSIEgTWLJb8LfiNe4PIPnWU2Ho0EbHs2RBa81Y83NEZpXYWpYLwUafkE
 5GG4E6tG1aUU2g/HSf+3BaHYVZ7vv2Zc7DmCkeYS5VyzZvajmVWj4pjPY5RrNbDKWOIIOc5ow+5e
 eLFX6wHWFlgM3zPr4IU/XqKhDUydx8pyRHEfDUTRJHokP4Ga3DyvfqtfF8zQQwIGbc+D8Tdt9JbM
 Op7ZhZwmE0J3q5DUuYVXFO9kWT5Rf2QvNNmbBNQnpXXUirwztbKA6BWoygQDVvVgdrQ=
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   luca@z3ntu.xyz
Message-ID: <EF411F71-D257-41FC-9248-B0E3F686B6B9@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 21, 2019 3:09:55 PM GMT+02:00, Maxime Ripard <maxime=2Eripard@bootli=
n=2Ecom> wrote:
>On Tue, May 21, 2019 at 08:43:45AM +0200, luca@z3ntu=2Exyz wrote:
>> On May 20, 2019 1:07:42 PM GMT+02:00, Maxime Ripard
><maxime=2Eripard@bootlin=2Ecom> wrote:
>> >On Sat, May 18, 2019 at 07:09:30PM +0200, Luca Weiss wrote:
>> >> Add a node describing the KEYADC on the A64=2E
>> >>
>> >> Signed-off-by: Luca Weiss <luca@z3ntu=2Exyz>
>> >> ---
>> >>  arch/arm64/boot/dts/allwinner/sun50i-a64=2Edtsi | 7 +++++++
>> >>  1 file changed, 7 insertions(+)
>> >>
>> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64=2Edtsi
>> >b/arch/arm64/boot/dts/allwinner/sun50i-a64=2Edtsi
>> >> index 7734f70e1057=2E=2Edc1bf8c1afb5 100644
>> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64=2Edtsi
>> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64=2Edtsi
>> >> @@ -704,6 +704,13 @@
>> >>  			status =3D "disabled";
>> >>  		};
>> >>
>> >> +		lradc: lradc@1c21800 {
>> >> +			compatible =3D "allwinner,sun4i-a10-lradc-keys";
>> >> +			reg =3D <0x01c21800 0x100>;
>> >> +			interrupts =3D <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>> >> +			status =3D "disabled";
>> >> +		};
>> >> +
>> >
>> >The controller is pretty different on the A64 compared to the A10=2E
>The
>> >A10 has two channels for example, while the A64 has only one=2E
>> >
>> >It looks like the one in the A83t though, so you can use that
>> >compatible instead=2E
>>
>> Looking at the patch for the A83t, the only difference is that it
>> uses a 3/4 instead of a 2/3 voltage divider, nothing is changed with
>> the channels=2E
>
>I guess you can reuse the A83t compatible here then, and a more
>specific a64 compatible in case we ever need to fix this=2E
>
>> But I'm also not sure which one (or a different one)
>> is used from looking at the "A64 User Manual"=2E
>
>I'm sorry, what are you referring to with "one" in that sentence?
>
>Maxime
>
>--
>Maxime Ripard, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin=2Ecom

Hi,

Sorry, I meant I didn't find anything in the A64 user manual whether a 3/4=
 or a 2/3 voltage divider (or one with different values) is used on the A64=
=2E

Luca
