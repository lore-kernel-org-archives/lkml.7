Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B3FC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC2B22464
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nWJQronm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfLPXcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:32:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37866 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLPXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:32:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so4600565pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=LeMUMboDVzm2QWwockzmkeOLuKIN6ObYJndKOlIc/bI=;
        b=nWJQronmqToOJdg65iUQ+P5PSsiryidRw7ZNlSr2TlDwTySJJ2Hrlmb+oe6jqXnQP4
         lGZaQo6LkA5HusPxZyWfjI12oK1+eLFYbEptEaQG2hiZl2Kwtj/Q7lLyjqi84zX6O3CQ
         TJJLF2MoSXTEV3rnpYbIXrmRRer2EqOLb6ZaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=LeMUMboDVzm2QWwockzmkeOLuKIN6ObYJndKOlIc/bI=;
        b=i6I0hKvphxPilkTADOQIZ7C6orrrImz9mlIN/wTsqIjb83BFqfkxWkMoe2oiRG0NnI
         HmIdqM55so35WCupn3WU426vfkc6nVJoUji6wwbH4AERCLT527l3ex4BYXOjg0YPTK5P
         i2yYU23B61hhnUKF1BgkIe9kfaTbBUpJyIaHNpNp9U1Z6lPEEmytZJ8kcYgnoj69n8As
         70Wwqmk/pWSjP6o12Ex59DdiQcPNu8yRV77MOOCnwbQ0BVQSvQfoE/9s8g/593PExJmQ
         kgo2H02DVawpGowiqQP7QZXnoA1FzSidFVZ2oYxwaUtm8aYpdz01T3mIV3zz1JqHt9R0
         NVTA==
X-Gm-Message-State: APjAAAVPq8R1+a+aX+Nc23uRLy7qLlwZfAv1+DT8BlBtJOSm//OYggdx
        zOX3hV0CuKAQIHt2mZj8TF0rSOsK4B852A==
X-Google-Smtp-Source: APXvYqzaWY1YSUwFa9HWbSq19JquDx0TkjXI6+m61uPNM6SNn/BHAGmZJpRRuA4QUKFjRlBdgLpxdw==
X-Received: by 2002:a63:d543:: with SMTP id v3mr21130714pgi.285.1576539167626;
        Mon, 16 Dec 2019 15:32:47 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j22sm615154pji.16.2019.12.16.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:32:47 -0800 (PST)
Message-ID: <5df8141f.1c69fb81.98eee.37b4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=Urn0ZhQSaVBkdq0hTEqe=bDP0KPz87Rd4B_bCF2CoFUA@mail.gmail.com>
References: <20191216211613.131275-1-swboyd@chromium.org> <CAD=FV=Urn0ZhQSaVBkdq0hTEqe=bDP0KPz87Rd4B_bCF2CoFUA@mail.gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-cheza: Add cr50 spi node
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 15:32:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2019-12-16 14:53:22)
> Hi,
>=20
> On Mon, Dec 16, 2019 at 1:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Add the cr50 device to the spi controller it is attached to. This
> > enables /dev/tpm0 and some login things on Cheza.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/bo=
ot/dts/qcom/sdm845-cheza.dtsi
> > index 9a4ff57fc877..f6683460dc82 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> > @@ -651,6 +651,20 @@ &spi0 {
> >         status =3D "okay";
> >  };
> >
> > +&spi5 {
> > +       status =3D "okay";
> > +
> > +       cr50@0 {
>=20
> Between v2 and v3 of your upstream bindings you changed this from
> "cr50@0" to "tpm@0" in the example.  I'm going to assume you did that
> for some reason and you should be matching the binding example here.
> ...or you should change the binding example to be cr50@.
>=20

Oh yeha, will fix and resend.

>=20
> > +               compatible =3D "google,cr50";
> > +               reg =3D <0>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&h1_ap_int_odl>;
> > +               spi-max-frequency =3D <800000>;
> > +               interrupt-parent =3D <&tlmm>;
> > +               interrupts =3D <129 IRQ_TYPE_EDGE_RISING>;
>=20
> Certainly we need an interrupt, but I don't see it in the bindings.
> Any idea why it isn't there?
>=20

I just forward ported the binding and didn't look back. I'm converting
it to YAML so I'll roll that fix in. Thanks.

