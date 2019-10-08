Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D7FC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363F021721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDUlhMJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfJHW5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:57:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38063 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHW5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:57:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so73079plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=1iVg1bgTgNlX0dVm1aEShQI+wslCHb8bQCi8jJ4tNNc=;
        b=QDUlhMJXKqmHUqSjPCk5eUuvJMAi05vnUZjLZXoyWt4EJdXtiOz2Y6Nr/MuLSLI04w
         0toDdOgS4ewieZ4KychKuLMMZDFwLqkjBPNmy/f7ti9npdfWUKH4nlcvtVwvuKRgpJ6J
         r20qPnrBvGNsk7IEz5JRvMz4WuJpc2KtWI6Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=1iVg1bgTgNlX0dVm1aEShQI+wslCHb8bQCi8jJ4tNNc=;
        b=fsnjqLsDHJNHTGGF+88dy2vBNF0Zzrmfbh+y9TpPTEy4UDdKHQAUwHN79ISkSW1jRA
         ZqqGjigfl3Y4YID2vBzs6ubr0kNmf5FQ/UBMY8OqJbqzdg5qa2u98UUnOBvkS2SPIAuu
         e5LHCwHr7abAJOrWmPvFL1Mr8ZNA2GKtIflcEjoPlPF3jVSzanTaZPeH2Um78px1F7As
         VhxMs3nWObDoplVo8hQsPKnCG8b2JojuL+1x3V5YEJbUZ5E/sA4mlxlXjyh1/TeO4tx0
         BXXJHoyYf+M9nGNxzw/+AMzoFIfWCCrb6Y2RRaD0fZEEAgipIXdnBIAzJyQnJzds6r0Y
         gRXw==
X-Gm-Message-State: APjAAAVHDj8u6LYjE28WJkxphDVZBvqR77SfkTHihI9YFS/2QBkGDZph
        U1GV/CFAgqxsvHl9/SAGZKmaYg==
X-Google-Smtp-Source: APXvYqzV5T/dDRhxX/AyCWGZl/1A1CtlsmcvDIFOotNiWyYZfmr0klgV6tsCqwZoGEkXP0gf/1Z7gA==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr37148337plq.177.1570575465981;
        Tue, 08 Oct 2019 15:57:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d4sm205853pjs.9.2019.10.08.15.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 15:57:44 -0700 (PDT)
Message-ID: <5d9d1468.1c69fb81.1bb45.193a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAE=gft4Rp_GmoVc1iRFH3tiu_taC=i72_Y+xXzk6eU6J80YhQw@mail.gmail.com>
References: <20191004233132.194336-1-swboyd@chromium.org> <CAE=gft4Rp_GmoVc1iRFH3tiu_taC=i72_Y+xXzk6eU6J80YhQw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: llcc: Name regmaps to avoid collisions
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 15:57:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-10-07 14:20:47)
> On Fri, Oct 4, 2019 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We'll end up with debugfs collisions if we don't give names to the
> > regmaps created inside this driver. Copy the template config over into
> > this function and give the regmap the same name as the resource name.
> >
> > Fixes: 7f9c136216c7 ("soc: qcom: Add broadcast base for Last Level Cach=
e Controller (LLCC)")
> > Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/soc/qcom/llcc-slice.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slic=
e.c
> > index 9090ea12eaf3..aa342938c403 100644
> > --- a/drivers/soc/qcom/llcc-slice.c
> > +++ b/drivers/soc/qcom/llcc-slice.c
> > @@ -48,13 +48,6 @@
> >
> >  static struct llcc_drv_data *drv_data =3D (void *) -EPROBE_DEFER;
> >
> > -static const struct regmap_config llcc_regmap_config =3D {
> > -       .reg_bits =3D 32,
> > -       .reg_stride =3D 4,
> > -       .val_bits =3D 32,
> > -       .fast_io =3D true,
> > -};
> > -
> >  /**
> >   * llcc_slice_getd - get llcc slice descriptor
> >   * @uid: usecase_id for the client
> > @@ -314,6 +307,12 @@ static struct regmap *qcom_llcc_init_mmio(struct p=
latform_device *pdev,
> >  {
> >         struct resource *res;
> >         void __iomem *base;
> > +       static struct regmap_config llcc_regmap_config =3D {
> > +               .reg_bits =3D 32,
> > +               .reg_stride =3D 4,
> > +               .val_bits =3D 32,
> > +               .fast_io =3D true,
> > +       };
>=20
> Why did you move this to be a static local? I think it works, but it
> makes it look like this is a local variable that's possibly used out
> of scope. Maybe leave it as a global?

And have a followup patch to move it to a static local? Sounds ok to me
if you prefer.

