Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62FC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE88208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 22:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lrRcHrdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfITWJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 18:09:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38331 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfITWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 18:09:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id w10so3818710plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=Ia51y5IXDxm/cJxz0UGqZ4dK87iJysuphikAUaMsngE=;
        b=lrRcHrdKiD38yhoWkw/8qIWPHY/a8TSdarnatkKzzDWnVihCAQdN/qq27pE+qZ/mPF
         OhDDTovjCVKiVleFyTelAfpP5Z8IFgmQ8V1avSOD1mlxAmYjWLPbuyiArlkW1VPbi7kS
         dCAI6SFMgnOswIsah6MSsQsT9NapqEYtR6zrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=Ia51y5IXDxm/cJxz0UGqZ4dK87iJysuphikAUaMsngE=;
        b=q1mhtowwdgNoRReZ97rr0yfniMienUZBO6Fi/teCZ9olVedZNGP29kZajoeBG8MEOU
         1QkoK4vyMEtlN15D+iv9k4yI8Sv4rgkQv3S9Z7hytVmSsxi/jm5+0ZtBtbeIElb73ysn
         jjaBs7eg2pQHwRGSqCrlJ1JPvYCL662/jA4xMdUDxfOPeGO1XQX6mvmMVg5BzMbinT/o
         bw5SDBaCGj/bVKx26bjSim5+OjssZVBzTO7uvkQSzIMAvYeVWNWR8eKQsmetyxpkKGm4
         FzK+fUm47/kQCN1IfW/KIiNQ6gbFwJRK65HN4AZrME820B4d45SQoBMlLyjMMDxMxegr
         7odg==
X-Gm-Message-State: APjAAAUOsd+4Mk0D6eRwfjgUJkzaXUL/PB9ZpxyF7cF9JfYnJH958PAA
        Orn2gf2pwS5mTyytz2yn6E5wAQ==
X-Google-Smtp-Source: APXvYqwePnl3IPYOcD3W2Z6H0IwI2bTRc6lUa7mXRarmtkQpqr4egd2BS/VAtpTlhP6S2E6JZLVPzA==
X-Received: by 2002:a17:902:728f:: with SMTP id d15mr19555584pll.211.1569017374255;
        Fri, 20 Sep 2019 15:09:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q132sm3558103pfq.16.2019.09.20.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:09:33 -0700 (PDT)
Message-ID: <5d854e1d.1c69fb81.4f771.9391@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHLCerPqEK2sSGGtDj85DH+qCzgtWi4ainuQv8BgQ3-Dgi93BQ@mail.gmail.com>
References: <cover.1569015835.git.amit.kucheria@linaro.org> <f627e66c455f52b5662bef6526d7c72869808401.1569015835.git.amit.kucheria@linaro.org> <5d854c82.1c69fb81.66e1f.96ab@mx.google.com> <CAHLCerPqEK2sSGGtDj85DH+qCzgtWi4ainuQv8BgQ3-Dgi93BQ@mail.gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 09/15] arm64: dts: msm8996: thermal: Add interrupt support
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:09:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-09-20 15:07:25)
> On Fri, Sep 20, 2019 at 3:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-09-20 14:52:24)
> > > Register upper-lower interrupts for each of the two tsens controllers.
> > >
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 60 ++++++++++++++-----------=
--
> > >  1 file changed, 32 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/=
dts/qcom/msm8996.dtsi
> > > index 96c0a481f454..bb763b362c16 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > > @@ -175,8 +175,8 @@
> > >
> > >         thermal-zones {
> > >                 cpu0-thermal {
> > > -                       polling-delay-passive =3D <250>;
> > > -                       polling-delay =3D <1000>;
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> >
> > I thought the plan was to make this unnecessary to change?
>=20
> IMO that change should be part of a different series to the thermal
> core. I've not actually started working on it yet (traveling for the
> next 10 days or so) but plan to do it.
>=20

Ok so the plan is to change DT and then change it back? That sounds
quite bad so please fix the thermal core to not care about this before
applying these changes so that we don't churn DT.

