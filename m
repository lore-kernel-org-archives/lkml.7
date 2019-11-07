Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D705C214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=softbankrobotics.com header.i=@softbankrobotics.com header.b="W0xKGXpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbfKGPVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:21:11 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38144 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfKGPVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:21:11 -0500
Received: by mail-yb1-f196.google.com with SMTP id b11so411105ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=softbankrobotics.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1acTtONRgb0usuJaFUKddbXdLV9J2Ws9ySjq9JH1O8w=;
        b=W0xKGXpz7bBo4GhKfvhNjyJ3DWXTjk/DcrakRNDQI8I8isyDwNkdDtEzwiQQTHeGHZ
         FTFUB/PvzAahBWKK+KJMCJ1gV/4Sv7RaNcTleYVw5JPQiXQwq5t73YBeE4iKQhNtFDza
         cOuj0mmsyWz+iuq+OPJloZFi+v//kRxwml1SMeCUFFRKJ5IPZ0FaOS+LvcJyv39A3paX
         2mKn1kYfBeW41EQHEw3PeYAaM6RxeNeRE/30I2tWU9zF5rZabVKOH538QfMoEM8ShmMl
         ZfDbyuf6iqq9/ABZAjD3FIAXCfGW5+2ivDxPrJZGpV/PIfP8RhhPWr+p+mFGQAwIB2JE
         OQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1acTtONRgb0usuJaFUKddbXdLV9J2Ws9ySjq9JH1O8w=;
        b=MFak08t2SJBXmulo/3utkGKDonZBwYn67L7k4v0d17mkmaw+XPxgZD5agjVJQTAJJB
         XfDGWZfAdHOfcYGqeHe5hAmFB6WyU/9mmJlQDjXvZVVCDMpX+vmDEStseui2qOm7dYRc
         pIcQkKWFUdTryFqNSdMz5XJSRlJVKbyXKiilaiCqjbf4CeWEiIDGXgwrR6tC04Fweyxr
         YV8jSlZrVL3NYB4kVQjlZxsrkn+K96qV/y7pzlC7gM9z+xMuSQVPKKPrec4C5QO2a1Vx
         rIMQaeRC5UwS3VkwcHg+GIeapXZ6ZJzzSZdMLUgHnZxuErNtSQCx6KRsFt4ni5WxWhFd
         fcqQ==
X-Gm-Message-State: APjAAAUbxBMslTK9Szj54wpMwN8Gy6cRsz8QSkpU91S2ZmDbkBySmBRh
        bQd2/Kl0NuMV7VuyIkdwj1eUcIF8GWLVJ/YoYkX4ivuYf/U9hRtwiZHNDUAtywO+J5HTPxPwCGj
        HQW8wfek2Ttc1BWdtYjTP3oVBGrkoTGw=
X-Google-Smtp-Source: APXvYqx7EmjM+t4xin/Z0yi/k2ooVrTiv80qyGjcFmMoKt/Qrm/FEhkrqssKnn5ji0lB0fdEHsnIU6gRF+6cP0q7TxE=
X-Received: by 2002:a25:c791:: with SMTP id w139mr3505225ybe.300.1573140068994;
 Thu, 07 Nov 2019 07:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20191107002247.1127689-1-bjorn.andersson@linaro.org>
In-Reply-To: <20191107002247.1127689-1-bjorn.andersson@linaro.org>
From:   Julien Massot <jmassot@softbankrobotics.com>
Date:   Thu, 7 Nov 2019 16:20:58 +0100
Message-ID: <CADGp=QdLjo_S6_t1t95d5CiHpkHU5qrTmo-eRtFaFga1TLeWhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: sdm845: Add PCIe nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Nov 7, 2019 at 1:22 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Add PCIe controller and PHY nodes for SDM845 and enable them for the
> Dragonboard 845c.

Thanks a lot the gen 3 PCIE works on my 845 platform.
Tested-by: Julien Massot <jmassot@softbankrobotics.com>

--=20


*This email and any attachment thereto are confidential and intended=20
solely for the use of the individual or entity to whom they are addressed.

If you are not the intended recipient, please be advised that disclosing,=
=20
copying, distributing or taking any action in reliance on the contents of=
=20
this email is strictly prohibited. In such case, please immediately advise=
=20
the sender, and delete all copies and attachment from your system.
This=20
email shall not be construed and is not tantamount to an offer, an=20
acceptance of offer, or an agreement by SoftBank Robotics Europe on any=20
discussion or contractual document whatsoever. No employee or agent is=20
authorized to represent or bind SoftBank Robotics Europe to third parties=
=20
by email, or act on behalf of SoftBank Robotics Europe by email, without=20
express written confirmation by SoftBank Robotics Europe=E2=80=99 duly auth=
orized=20
representatives.
*



*Ce message =C3=A9lectronique et =C3=A9ventuelles pi=C3=A8ces=20
jointes sont confidentiels, et exclusivement destin=C3=A9s =C3=A0 la person=
ne ou=20
l'entit=C3=A9 =C3=A0 qui ils sont adress=C3=A9s.
Si vous n'=C3=AAtes pas le destinataire vis=C3=A9,=20
vous =C3=AAtes pri=C3=A9 de ne pas divulguer, copier, distribuer ou prendre=
 toute=20
d=C3=A9cision sur la foi de ce message =C3=A9lectronique. Merci d'en aviser=
=20
imm=C3=A9diatement l'exp=C3=A9diteur et de supprimer toutes les copies et =
=C3=A9ventuelles=20
pi=C3=A8ces jointes de votre syst=C3=A8me.
Ce message =C3=A9lectronique n'=C3=A9quivaut pas =C3=A0=20
une offre, =C3=A0 une acceptation d=E2=80=99offre, ou =C3=A0 un accord de S=
oftBank Robotics=20
Europe sur toute discussion ou document contractuel quel qu=E2=80=99il soit=
, et ne=20
peut =C3=AAtre interpr=C3=A9t=C3=A9 comme tel. Aucun employ=C3=A9 ou agent =
de SoftBank Robotics=20
Europe n'est autoris=C3=A9 =C3=A0 repr=C3=A9senter ou =C3=A0 engager la soc=
i=C3=A9t=C3=A9 par email, ou =C3=A0=20
agir au nom et pour le compte de la soci=C3=A9t=C3=A9 par email, sans qu=E2=
=80=99une=20
confirmation =C3=A9crite soit donn=C3=A9e par le repr=C3=A9sentant l=C3=A9g=
al de SoftBank=20
Robotics Europe ou par toute autre personne ayant re=C3=A7u d=C3=A9l=C3=A9g=
ation de=20
pouvoir appropri=C3=A9e.
*

**
