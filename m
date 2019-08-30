Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4290622CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ai/zCqyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3S2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:28:36 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39291 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3S2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:28:36 -0400
Received: by mail-pf1-f172.google.com with SMTP id a67so1864786pfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=9GeCgw/KxFloNeY2cmQhUJuI6BYk8fDzNxr9XRd8OXk=;
        b=ai/zCqyb/BzQPSLxNpUrZR7CwKxGWQ2I+RXtaeVKtdkNKoEKnMxFwrdfTlSjANybDL
         FF+SNidSutGnxWc+1lYqacTgreiFWZg7A6uEls2EktdaioC8OiAd991XAHTvd/I/CTsq
         I0D3cpqKf3EdMUshwYywp0JTUbS39u11rPAy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=9GeCgw/KxFloNeY2cmQhUJuI6BYk8fDzNxr9XRd8OXk=;
        b=Is4JEVQdOUuRcROes7vGX4ENvQrnSdJlsjxOQCPgzAA1E5oFGaYjNh3kGhkVhEjtzD
         jRG5cyNtUEXDe3QdArnt9FVjzW+YagnfIL38/LTbZ3gLACVO9tZujmLdahggNx5kIfue
         XmzECnURcA4z7HdtWszIkA8HqMjYqY1SOVvmc/bAytrXNb8O+t/ogErUurZZz62Cvbax
         1PPjvW7U5aaL6wS76xQyVy4+VgWF1EgaJJ8/9JZqkj1aOJodT9eugchMp61tDk+LcW31
         tVd2Hz/e1bDtbVbVustCTFW5isIPBU2tXh9FCGE7qur4wuarWZZGcorbcSkhDDOYa91z
         w9Lw==
X-Gm-Message-State: APjAAAUAGz/09mgobRu5Yq+qC9hzFT8jbwTxg7emnAyOqxmzFmVmqfih
        TTCbhYN0J33musWkmcPWiNIqAA==
X-Google-Smtp-Source: APXvYqzMiFGN83Njt2/JrFLYZUyyM9L9qiaHV6onYdWf1y1eG8n3W6IX2y++KngHRNf/PFHG04PAew==
X-Received: by 2002:a63:460c:: with SMTP id t12mr13961916pga.69.1567189714926;
        Fri, 30 Aug 2019 11:28:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g14sm7411264pfb.150.2019.08.30.11.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 11:28:34 -0700 (PDT)
Message-ID: <5d696ad2.1c69fb81.977ea.39e5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830164520.GK26807@tuxbook-pro>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org> <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org> <20190223165218.GB572@tuxbook-pro> <6dc0957d-5806-7643-4454-966015865d38@linaro.org> <5d694878.1c69fb81.5f13b.ec4f@mx.google.com> <20190830164520.GK26807@tuxbook-pro>
Cc:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>, robh@kernel.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 30 Aug 2019 11:28:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-08-30 09:45:20)
> On Fri 30 Aug 09:01 PDT 2019, Stephen Boyd wrote:
>=20
> > Quoting Jorge Ramirez (2019-08-29 00:03:48)
> > > On 2/23/19 17:52, Bjorn Andersson wrote:
> > > > On Thu 07 Feb 03:17 PST 2019, Jorge Ramirez-Ortiz wrote:
> > > >> +
> > > >> +Required child nodes:
> > > >> +
> > > >> +- usb connector node as defined in bindings/connector/usb-connect=
or.txt
> > > >> +  containing the property vbus-supply.
> > > >> +
> > > >> +Example:
> > > >> +
> > > >> +usb3_phy: usb3-phy@78000 {
> > > >> +    compatible =3D "qcom,snps-usb-ssphy";
> > > >> +    reg =3D <0x78000 0x400>;
> > > >> +    #phy-cells =3D <0>;
> > > >> +    clocks =3D <&rpmcc RPM_SMD_LN_BB_CLK>,
> > > >> +             <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
> > > >> +             <&gcc GCC_USB3_PHY_PIPE_CLK>;
> > > >> +    clock-names =3D "ref", "phy", "pipe";
> > > >> +    resets =3D <&gcc GCC_USB3_PHY_BCR>,
> > > >> +             <&gcc GCC_USB3PHY_PHY_BCR>;
> > > >> +    reset-names =3D "com", "phy";
> > > >> +    vdd-supply =3D <&vreg_l3_1p05>;
> > > >> +    vdda1p8-supply =3D <&vreg_l5_1p8>;
> > > >> +    usb3_c_connector: usb3-c-connector {
> >=20
> > Node name should be 'connector', not usb3-c-connector.
> >=20
>=20
> It probably has to be usb-c-connector, because we have a
> micro-usb-connector on the same board.

Ok. Or connector@1 and connector@2? Our toplevel node container story is
sort of sad because we have to play tricks with node names. But in the
example, just connector I presume?=20

>=20
> > > >=20
> > > > The USB-C connector is attached both to the HS and SS PHYs, so I th=
ink
> > > > you should represent this external to this node and use of_graph to
> > > > query it.
> > >=20
> > > but AFAICS we wont be able to retrieve the vbux-supply from an extern=
al
> > > node (that interface does not exist).
> > >=20
> > > rob, do you have a suggestion?
> >=20
> > Shouldn't the vbus supply be in the phy? Or is this a situation where
> > the phy itself doesn't have the vbus supply going to it because the PMIC
> > gets in the way and handles the vbus for the connector by having the SoC
> > communicate with the PMIC about when to turn the vbus on and off, etc?
> >=20
>=20
> That's correct, the VBUS comes out of the PMIC and goes directly to the
> connector.
>=20
> The additional complicating factor here is that the connector is wired
> to a USB2 phy as well, so we need to wire up detection and vbus control
> to both of them - but I think this will be fine, if we can only figure
> out a sane way of getting hold of the vbus-supply.
>=20

Does it really matter to describe this situation though? Maybe it's
simpler to throw the vbus supply into the phy and control it from the
phy driver, even if it never really goes there. Or put it into the
toplevel usb controller?

