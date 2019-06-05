Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4539FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB842070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEujYf9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFEU4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:56:18 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35384 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFEU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:56:17 -0400
Received: by mail-it1-f196.google.com with SMTP id n189so5803627itd.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=Z05gjPlf/yCai77dOI/lTSyk0VZcij0YM3BvTgoHGIQ=;
        b=YEujYf9y/+0yEdS5CDgIoV8JUsrCxTRpvHYP65N/L6oQk1WVo/q4bL1rowkypWGRe5
         OU5s8rvZRRCcnEaptRDwiKUiKUNPmOUSUuebq6zOrPgENocHuL9rmrKhJMSfcBureSqz
         Q8F88TtekYjNtJT+SikryJFrWMhsnc82cywdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=Z05gjPlf/yCai77dOI/lTSyk0VZcij0YM3BvTgoHGIQ=;
        b=F22NgcXUSKf2/VEjiQcDFBXwV3CsfqS6XJ9LGpV0IriaWoZm95nFDzwJq0keMFbhCK
         uPuKf5GQsZSun8DPRW3d3X/oo5SnK4bcZyPoHmIricqUTtjL8xHT8a8oIwIG4ns/uM4s
         PCYr/vLbRfR97DmBWWvX+bmN/pHTxx/13vA4i65Wg17OvOfY23taUvaKZj9XwwY2QDUV
         OdmhYvPKRGviKG+Y8oi+tO8lE6912ypuBi/KnQ0HyXGno0jC8Zqo87xomL/zczWR6ann
         RCjOHmKRNB12mGaUkcDpt5G2iNLtV2/p2aD6EQVqgFDWumJffyu4JaCdfTRl/Kdyb55p
         jTNA==
X-Gm-Message-State: APjAAAV8D3X8cZ1YgKHivlbuv2EzB7azX5upksaYZP8qYZmg6oZj+lX0
        fcnUjJ6XdJVDJlXDUGMVi6GZ1Q==
X-Google-Smtp-Source: APXvYqwNykzCVjCI6b97uTUIZ7tU+W4ozoPUalmMA1kwkowgQKM/BewvSEaQcHg7FP3+Mv7tbWqMvA==
X-Received: by 2002:a24:eec1:: with SMTP id b184mr29848831iti.61.1559768176415;
        Wed, 05 Jun 2019 13:56:16 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10061409itc.42.2019.06.05.13.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 13:56:15 -0700 (PDT)
Message-ID: <5cf82c6f.1c69fb81.9e342.dbda@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFp+6iHZeawnz7Vfk3=Oox-GN_y6c-E9wMwc-qdp1bTOXgqjFQ@mail.gmail.com>
References: <20190604222939.195471-1-swboyd@chromium.org> <20190604223700.GE4814@minitux> <5cf6f4bb.1c69fb81.c39da.5496@mx.google.com> <CAFp+6iHZeawnz7Vfk3=Oox-GN_y6c-E9wMwc-qdp1bTOXgqjFQ@mail.gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
User-Agent: alot/0.8.1
Date:   Wed, 05 Jun 2019 13:56:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2019-06-04 21:55:26)
> On Wed, Jun 5, 2019 at 4:16 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Bjorn Andersson (2019-06-04 15:37:00)
> > > On Tue 04 Jun 15:29 PDT 2019, Stephen Boyd wrote:
> > >
> > > > The SMMU that sits in front of the QUP needs to be programmed prope=
rly
> > > > so that the i2c geni driver can allocate DMA descriptors. Failure t=
o do
> > > > this leads to faults when using devices such as an i2c touchscreen =
where
> > > > the transaction is larger than 32 bytes and we use a DMA buffer.
> > > >
> > >
> > > I'm pretty sure I've run into this problem, but before we marked the
> > > smmu bypass_disable and as such didn't get the fault, thanks.
> > >
> > > >  arm-smmu 15000000.iommu: Unexpected global fault, this could be se=
rious
> > > >  arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x000000=
02, GFSYNR1 0x000006c0, GFSYNR2 0x00000000
> > > >
> > > > Add the right SID and mask so this works.
> > > >
> > > > Cc: Sibi Sankar <sibis@codeaurora.org>
> > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot=
/dts/qcom/sdm845.dtsi
> > > > index fcb93300ca62..2e57e861e17c 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > @@ -900,6 +900,7 @@
> > > >                       #address-cells =3D <2>;
> > > >                       #size-cells =3D <2>;
> > > >                       ranges;
> > > > +                     iommus =3D <&apps_smmu 0x6c0 0x3>;
> > >
> > > According to the docs this stream belongs to TZ, the HLOS stream shou=
ld
> > > be 0x6c3.
> >
> > Aye, I saw this line in the downstream kernel but it doesn't work for
> > me. If I specify <&apps_smmu 0x6c3 0x0> it still blows up. I wonder if
> > my firmware perhaps is missing some initialization here to make the QUP
> > operate in HLOS mode? Otherwise, I thought that the 0x3 at the end was
> > the mask and so it should be split off to the second cell in the DT
> > specifier but that seemed a little weird.
>=20
> Two things here -
> 0x6c0 - TZ SID. Do you see above fault on MTP sdm845 devices?

No. I see the above fault on Cheza.

> 0x6c3/0x6c6 - HLOS SIDs.

Why are there two? I see some mentions of GSI mode near these SIDs so
maybe GSI has to be used for DMA here to get the above two SIDs at the
IOMMU? Otherwise if we do the non-GSI mode of DMA we're going to use the
"TZ" SID?

>=20
> Cheza will throw faults for anything that is programmed with TZ on mtp
> as all of that should be handled in HLOS. The firmwares of all these
> peripherals assume that the SID reservation is done (whether in TZ or HLO=
S).
>=20
> I am inclined to moving the iommus property for all 'TZ' to board dts fil=
es.
> MTP wouldn't need those SIDs. So, the SOC level dtsi will have just the
> HLOS SIDs.

So you're saying you'd like to have the SID be <&apps_smmu 0x6c3 0x0> in
the sdm845.dtsi file and then override this on Cheza because our SID is
different (possibly because we don't use GSI)? Why can't we program the
SID in Cheza firmware to match the "HLOS" SID of 0x6c3?

>=20
> P.S.
> As you rightly said, the second cell in iommus property is the mask so th=
at
> the iommu is able to reserve all that SIDs that are covered with the
> starting SID
> and the mask.
>=20

Well if 0x6c6 is another possibility maybe it should be <&apps_smmu
0x6c0 0x7> to cover the 0x6c3 and 0x6c6 SIDs?

