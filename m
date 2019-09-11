Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14864C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFDA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568204764;
	bh=2pPMn/FVFbCJXIco4hndCy4yU4apLjVYE56Muit6qTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TsbyW5h4+sjwhziUo8Fo4bw0KOh8AqbRrl6ozLwM8HhjGG+w4IwOXStl0BZapGqU7
	 7hVgos3Su0eGcKmZPrb0y3rgbfvSI6TClpHEiROkITUSS3C3oAbHaNGUmIz+PhmObO
	 Eatc4lYmsjht4yzsM6mOibfeEQb+iIlt5Ny03t4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfIKM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfIKM0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:26:03 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C6D20872;
        Wed, 11 Sep 2019 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568204763;
        bh=2pPMn/FVFbCJXIco4hndCy4yU4apLjVYE56Muit6qTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btzmfK97dcowxxq/8O16K0PTIHFX9tbMeTa4kmm/4lheEz68VruqQERLYbjUHM7pT
         UQuI7VeW+2AwHOtw1j1+hzWgSQZUCqL1FzHNEviy7J4EEGFE/Q6uZpmOIjk/HmSi+A
         nvQJ+0cyNIOUl0sZ8SvdEO6tyrB/Dxykx+hTJkDY=
Received: by mail-lj1-f178.google.com with SMTP id y23so19453563ljn.5;
        Wed, 11 Sep 2019 05:26:02 -0700 (PDT)
X-Gm-Message-State: APjAAAWeURmGifab4o3ALSzzcE0gRRftC/AlKNN+3E9Huz4aGCo7Hx01
        ZL7rpbeH+LueER2NNNmXJJJPnuuCGjtipjV6xvA=
X-Google-Smtp-Source: APXvYqw8gd+xprNyWbgdYgqyXgDC15vF70jPsWIWsn6xVgL8eKxH8DV9rxOR9uhU6qghey5K9nKVIBQo3AdRVaPcC8k=
X-Received: by 2002:a2e:b4e3:: with SMTP id s3mr23885542ljm.143.1568204760929;
 Wed, 11 Sep 2019 05:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190911110500eucas1p2e1304a19e2e75ee43d80fcdc3b871237@eucas1p2.samsung.com>
 <CAJKOXPeojuk1UrYo9Wakaaq4VJt3Ts22Vi-V5xzwAXoFU5+tcA@mail.gmail.com>
 <20190911110446.32058-1-m.falkowski@samsung.com> <CAJKOXPeZ2usT+bx23n-hXxsLsbZqr-0JEtyagK8sfsLaFiaH5w@mail.gmail.com>
 <d7e938e8-d42e-be22-ce76-561159064180@samsung.com>
In-Reply-To: <d7e938e8-d42e-be22-ce76-561159064180@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 11 Sep 2019 14:25:49 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdM_A5Enmv_GOJuKLvfBBwi-z3qWiW4WG9L-dmuW9T5Wg@mail.gmail.com>
Message-ID: <CAJKOXPdM_A5Enmv_GOJuKLvfBBwi-z3qWiW4WG9L-dmuW9T5Wg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: arm: samsung: Convert Samsung Exynos
 IOMMU H/W, System MMU to dt-schema
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Maciej Falkowski <m.falkowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 at 13:57, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Krzyszotf,
>
> On 2019-09-11 13:36, Krzysztof Kozlowski wrote:
> > On Wed, 11 Sep 2019 at 13:05, Maciej Falkowski <m.falkowski@samsung.com> wrote:
> >> Convert Samsung Exynos IOMMU H/W, System Memory Management Unit
> >> to newer dt-schema format.
> >>
> >> Update clock description.
> >>
> >> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> >> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> >> ---
> >> Hi Krzysztof,
> >>
> >> Thank you for feedback.
> >>
> >> v3:
> >>
> >> - remove obsolete interrupts description and
> >> set its maxItems to one. There are some incompatible
> >> files which will be fixed with another patch.
> > Driver stopped supporting two IRQ lines in commit
> > 7222e8db2d506197ee183de0f9b76b3ad97e8c18 (iommu/exynos: Fix build
> > errors). The second IRQ line in Exynos3250 DTS seems to be ignored.
> >
> > The patch now looks good to me:
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > However for some reasons you did not CC the IOMMU maintainers. Please
> > use scripts/get_maintainer.pl to get the list of folks to CC.
>
> Frankly I don't see any reason to spam IOMMU ml or maintainer with this
> discussion about dt-binding conversion. This patch will be merged via dt
> tree if I got it right.

Indeed usually subsystem maintainers are not interested in DT schema
conversion although they are mentioned as maintainers for this file so
it is nice to CC them... I would not call spamming when there is
explicit pattern for CCing.

Best regards,
Krzysztof
