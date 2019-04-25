Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D3C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E1620679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwP49ySy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfDYNQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:16:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46702 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfDYNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:16:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id w73so10794723qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvpcsYxKpblRj5+jchkadP+EIMWVQeoHvjsvGTTCyfU=;
        b=BwP49ySy1oK+txg9tILWwHgxJATEKK4Jywj0sHWsKnrD6rqjmliO1SD9A30rz5M+SC
         SKY0ZV8kAK04gcX4MM0QbJveGD/sAHEWSt/6fHw5A30J6Utxv+SmFN5lQdqOANJz+kL/
         uc1Tmds5YYAa0qAbik8Lu/IEBwQVP7WeLuqHPmnIf4QhPf3aculo1Hm14D7N2GSpvIhe
         JHDEGs0JLEaaonEZ2ROFnPpv3Ve3AkCdvD/Bt6vD04nhx5YQg2bVo3I4MlMlqsgHB912
         d5qmZO1drFGV140WZL5Jw/7XF8tC4Mfd5ivB8MtuutPbI/YOPFT1b6OryFMCQXW5rk1R
         B7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvpcsYxKpblRj5+jchkadP+EIMWVQeoHvjsvGTTCyfU=;
        b=Qchjh2W8y1mI3vUS3rWFpf7MdRzD8ANCZsQxfBEHYM9SAZcUPdljLTQRZZcTLEKsEF
         Ixfmwtmjgddt9NLQ7suGHSUAwpc8GfrsVY2ZBKVkz1cJhndQpNS2CT+bzLe/azNTjIP0
         ALPCTIRBGLipwxXCMxv8Qrf4vL+ntSnUOj0giiZ4yMV7BRkOZ7AMX8DcHegz7pLoECbJ
         w3HaTNVCJ6a+iZJHSUWSyNDZ5B8RbwCXXt4cvomGU3ve190Ke0PhU5crplbpK77A3/1i
         Cne4p+eEBdWCrILpdoq3gfo7bI1dH2o4z1kuCDa2XTe6UO9SGgBVoY9C0nl8WsOcn0ED
         RW1Q==
X-Gm-Message-State: APjAAAVTE6EmmUKxRlHXS5696eD5GgWZ2tFcKgKiXSluDCnB3DH5caIP
        SAnirKmHCyIAZ65TEZK2nfwfdhYU5nRU2WShggaYdw==
X-Google-Smtp-Source: APXvYqwTnLIRWJLwG6Gy5cAbJMVOpWMRQzdhJIoRjlH0tStq4oIRKnwHBwVrNFgLO/4TYmUMdRwN/PrHwADYrw+FW24=
X-Received: by 2002:ae9:ee10:: with SMTP id i16mr26572798qkg.109.1556198206901;
 Thu, 25 Apr 2019 06:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553853990.git.amit.kucheria@linaro.org>
 <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr> <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
 <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr> <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
 <903fa0a6-5c40-97b4-1c01-fd84f3e51c62@free.fr> <8e53ea22-d248-8c63-bcda-15b502eb9699@free.fr>
 <CAHLCerPj6MQ0LeqUHM_91NOW1cP0z75DD7oBnR7Q3-8rpCmnww@mail.gmail.com> <0e2ffc33-1ffd-2eb2-e6a7-117b3f14c2e7@free.fr>
In-Reply-To: <0e2ffc33-1ffd-2eb2-e6a7-117b3f14c2e7@free.fr>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 25 Apr 2019 18:46:35 +0530
Message-ID: <CAP245DXBPS-ARxHGKeaj6E_z-fQp9m8QOXBzJuNHEABUkdJhRw@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 6:36 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 25/04/2019 08:31, Amit Kucheria wrote:
>
> > [PATCH 3/3] arm64: dts: msm8998: thermal: Restrict thermal zone name length to under 20
> >
> > The thermal core restricts names of thermal zones to under 20
> > characters. Fix the names for a couple of msm8998 thermal zones.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8998.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > index 062a93a12198..01757829d5f3 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -536,7 +536,7 @@
> >                       };
> >               };
> >
> > -             cluster0-mhm-thermal {
> > +             clust0-mhm-thermal {
> >                       polling-delay-passive = <250>;
> >                       polling-delay = <1000>;
> >
> > @@ -551,7 +551,7 @@
> >                       };
> >               };
> >
> > -             cluster1-mhm-thermal {
> > +             clust1-mhm-thermal {
> >                       polling-delay-passive = <250>;
> >                       polling-delay = <1000>;
> >
>
> Wouldn't it be better to drop the "-thermal" suffix than to chop characters
> off from the actual description?

Probably a good idea, but it will perturb my OCD and cause a large
search and replace to replace all thermal zones names in this series.
:-) I want to keep it consistent across all boards.

I don't think Andy would like that too much.

> Or would it make sense to increase the 20-char limit to 24?
> => Probably impossible without breaking the user-space ABI, since
> THERMAL_NAME_LENGTH is defined in include/uapi/linux/thermal.h

Yes, I abandoned that path quickly after seeing where this was
defined, but I have a follow-on patch to make this a compile-time bug
rather than wondering why the thermal zone failed at runtime.

> Anyway, for msm8998 patches, you have my
>
> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Thanks a lot for testing.
