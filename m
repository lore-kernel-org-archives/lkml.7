Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D117F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NdVoBpop";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VMYNtR5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfCZIBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:01:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCZIBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:01:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 080AC60AD1; Tue, 26 Mar 2019 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553587298;
        bh=K2uEP7D2bJslTaN7VR8HLvzhj2Cw7h5PwqVqEmycNIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NdVoBpopmye3fj7krSDCHf8dy/0z0k7mCS8aRCS0ndgP5O33D0ABGJV2kkrGEuH4w
         Dtwgzfd1OG5cYLvciQWktS2UW+UhkK1hRnHQ6YLZVFXfXWL/gyObmrx6GjdavvcaLb
         CTh7reF0xFFYcIfvliDBIaoAREW37K5FFmkC1suI=
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B936960AD1;
        Tue, 26 Mar 2019 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553587297;
        bh=K2uEP7D2bJslTaN7VR8HLvzhj2Cw7h5PwqVqEmycNIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VMYNtR5FJ3RN1YAl7tbQpFQ1p8a+7fB14a7Kg/mTgmnNxqyeCb7VbGBJqPIkCnBBF
         eLeeuEiuueshYE1vh9EdaSnAaIv0VmTOebjtpml5iccsb79XXXCty3ipa2tYHjY0zf
         k01hF7wq8/jYvuxPh8d4zPZ8AprMLX+oVRHcBYok=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B936960AD1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f42.google.com with SMTP id d26so9856325ede.10;
        Tue, 26 Mar 2019 01:01:36 -0700 (PDT)
X-Gm-Message-State: APjAAAVsbO/8EAAFil1wLxr20WibDOnYRYLFKRJwVD+Vl0cTjaP/XuE2
        /PThM0TYrsn2eGQAS49ie6zTzLJDm8B7tP9i5PU=
X-Google-Smtp-Source: APXvYqxGg8Psbwj9u/X5FhN+t4b6ik0Xp5iDQoffXcRyxaXAeJ9rAKXnyaZ8gqw/1OneaSUi/rtUgGHPjLxOAYJRcaA=
X-Received: by 2002:a50:d70b:: with SMTP id t11mr11265181edi.123.1553587295566;
 Tue, 26 Mar 2019 01:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <a897277d-23b3-9746-81dc-28f8925a9992@free.fr> <136857e7-0fe1-6fc6-729e-2cbf6ea72386@ti.com>
In-Reply-To: <136857e7-0fe1-6fc6-729e-2cbf6ea72386@ti.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 26 Mar 2019 13:31:24 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGyV7E-e6rSz8zci1LM7stZVyKjgAxfV3KkdLNPpxOm_A@mail.gmail.com>
Message-ID: <CAFp+6iGyV7E-e6rSz8zci1LM7stZVyKjgAxfV3KkdLNPpxOm_A@mail.gmail.com>
Subject: Re: [PATCH v1] phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Mar 26, 2019 at 1:18 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 22/03/19 9:42 PM, Marc Gonzalez wrote:
> > Copy init sequence from downstream:
> > https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998-v2.dtsi?h=LE.UM.1.3.r3.25#n372
>
> Can't we instead have reference to HW manual or datasheet?
> >
> > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > ---
> >  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   5 +
> >  drivers/phy/qualcomm/phy-qcom-qmp.c           | 110 ++++++++++++++++++
> >  drivers/phy/qualcomm/phy-qcom-qmp.h           |  12 ++
> >  3 files changed, 127 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > index 5d181fc3cc18..6000ae34b12b 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> > @@ -11,6 +11,7 @@ Required properties:
> >              "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> >              "qcom,msm8998-qmp-usb3-phy" for USB3 QMP V3 phy on msm8998,
> >              "qcom,msm8998-qmp-ufs-phy" for UFS QMP phy on msm8998,
> > +            "qcom,msm8998-qmp-pcie-phy" for PCIe QMP phy on msm8998,
> >              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> >              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845,
> >              "qcom,sdm845-qmp-ufs-phy" for UFS QMP phy on sdm845.
> > @@ -48,6 +49,8 @@ Required properties:
> >                       "aux", "cfg_ahb", "ref".
> >               For "qcom,msm8998-qmp-ufs-phy" must contain:
> >                       "ref", "ref_aux".
> > +             For "qcom,msm8998-qmp-pcie-phy" must contain:
> > +                     "aux", "cfg_ahb", "ref".
> >               For "qcom,sdm845-qmp-usb3-phy" must contain:
> >                       "aux", "cfg_ahb", "ref", "com_aux".
> >               For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
> > @@ -70,6 +73,8 @@ Required properties:
> >               For "qcom,msm8998-qmp-usb3-phy" must contain
> >                       "phy", "common".
> >               For "qcom,msm8998-qmp-ufs-phy": no resets are listed.
> > +             For "qcom,msm8998-qmp-pcie-phy" must contain:
> > +                     "phy", "common", "cfg".
> >               For "qcom,sdm845-qmp-usb3-phy" must contain:
> >                       "phy", "common".
> >               For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
>
> Please send the dt binding in a separate patch.
>
> Thanks
> Kishon

Thanks for the patch. Besides above comments from Kishon it looks good.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
