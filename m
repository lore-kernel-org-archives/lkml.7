Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784BDC43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBA920828
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 00:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g/LkE4xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbfIFADV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 20:03:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45039 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389062AbfIFADV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:03:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so2357618pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=0Ap1O2bRGHDTN8/1MAgOi/15FUHUI37QE4DT4enZiVA=;
        b=g/LkE4xFyaKVY1fcbkFs9yu5NGROGG6i4T474hOEJw0qXHSKxjNbjTV/UIkFmSXlrE
         6X4hUOh854NEO4Z5o1zyn5XQVgOwDPd498KcmPCeb4tVwJ/w364jG1Gazhifalz7WAze
         Uen6Ik2gJweCf1dyocHsH1d07nYUM691Q0Ens=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=0Ap1O2bRGHDTN8/1MAgOi/15FUHUI37QE4DT4enZiVA=;
        b=ZfAE3bkutk7n8uaSOtaYsaDTkfaeaw/37HyO+eeBHEu0pbuQ7r9Lv7iaw4jZxMPNIC
         jcwjgJ7kuK3w4oIIV7boAO66Pdknvm1Ma53msotCoYrpXbC4cT3OfrHhgxOk+eiM1KrG
         TrjnoNpo+RLJsvKlC4nOAWbR6hMz67T6OErfyi0fpRFOVBTW18YQYB453+uZSttsfO1T
         YJ7MEV64dVzxPLAzKxSw1QdT0yafcHxHcTrfvXw7OeyGfLtqRXggEWci2cYV95TrbRMg
         t0/CPcSmfBgqy/u+cIag+afNOdaXs9PbbWeL6zFnhaLfAC/G3bDAvVvOjXl+ie/LaHSg
         +L3g==
X-Gm-Message-State: APjAAAXtZcBJIumRwri+DRvVUCizsCmb927IJmBCy9cxoSUGi4V3lbMl
        m1wNmEn0K8M4U2xY9W/0Qw0vIA==
X-Google-Smtp-Source: APXvYqwKxt0ENj/VMAOTcaQ3FOYWHGWtFoXbK2eAUL73v5SBuSB87WxWVxzRlMDWUA3P5kPJAWeE2Q==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr7305107pfg.112.1567728199901;
        Thu, 05 Sep 2019 17:03:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k5sm2833198pjs.1.2019.09.05.17.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 17:03:19 -0700 (PDT)
Message-ID: <5d71a247.1c69fb81.2146f.7ed2@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190903170722.GA31716@codeaurora.org>
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-6-ilina@codeaurora.org> <5d6d1b72.1c69fb81.ee88.efcf@mx.google.com> <102c9268-c4ce-6133-3b0a-67c2fcba1e7a@arm.com> <20190903170722.GA31716@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        mkshah@codeaurora.org, linux-gpio@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 05/14] dt-bindings/interrupt-controller: pdc: add SPI config register
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 17:03:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-09-03 10:07:22)
> On Mon, Sep 02 2019 at 07:58 -0600, Marc Zyngier wrote:
> >On 02/09/2019 14:38, Rob Herring wrote:
> >> On Thu, Aug 29, 2019 at 12:11:54PM -0600, Lina Iyer wrote:
> >>> In addition to configuring the PDC, additional registers that interfa=
ce
> >>> the GIC have to be configured to match the GPIO type. The registers on
> >>> some QCOM SoCs are access restricted, while on other SoCs are not. Th=
ey
> >>> SoCs with access restriction to these SPI registers need to be written
> >>
> >> Took me a minute to figure out this is GIC SPI interrupts, not SPI bus.
> >>
> >>> from the firmware using the SCM interface. Add a flag to indicate if =
the
> >>> register is to be written using SCM interface.
> >>>
> >>> Cc: devicetree@vger.kernel.org
> >>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >>> ---
> >>>  .../bindings/interrupt-controller/qcom,pdc.txt           | 9 +++++++=
+-
> >>>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/q=
com,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,p=
dc.txt
> >>> index 8e0797cb1487..852fcba98ea6 100644
> >>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc=
.txt
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc=
.txt
> >>> @@ -50,15 +50,22 @@ Properties:
> >>>                 The second element is the GIC hwirq number for the PD=
C port.
> >>>                 The third element is the number of interrupts in sequ=
ence.
> >>>
> >>> +- qcom,scm-spi-cfg:
> >>> +   Usage: optional
> >>> +   Value type: <bool>
> >>> +   Definition: Specifies if the SPI configuration registers have to =
be
> >>> +               written from the firmware.
> >>> +
> >>>  Example:
> >>>
> >>>     pdc: interrupt-controller@b220000 {
> >>>             compatible =3D "qcom,sdm845-pdc";
> >>> -           reg =3D <0xb220000 0x30000>;
> >>> +           reg =3D <0xb220000 0x30000>, <0x179900f0 0x60>;
> >>
> >> There needs to be a description for reg updated. These aren't GIC
> >> registers are they? Because those go in the GIC node.
> >
> They are not GIC registers. I will update this documentation.
>=20
> >This is completely insane. Why are the GIC registers configured as
> >secure the first place, if they are expected to be in control of the
> >non-secure?
> These are not GIC registers but located on the PDC interface to the GIC.
> They may or may not be secure access controlled, depending on the SoC.
>=20

It looks like it falls under this "mailbox" device which is really the
catch all bucket for bits with no home besides they're related to the
apps CPUs/subsystem.

	apss_shared: mailbox@17990000 {
		compatible =3D "qcom,sdm845-apss-shared";
		reg =3D <0 0x17990000 0 0x1000>;
		#mbox-cells =3D <1>;
	};

Can you point to this node with a phandle and then parse the reg
property out of it to use in the scm readl/writel APIs? Maybe it can be
a two cell property with <&apps_shared 0xf0> to indicate the offset to
the registers to read/write? In non-secure mode presumably we need to
also write these registers? Good news is that there's a regmap for this
driver already, so maybe that can be acquired from the pdc driver.

