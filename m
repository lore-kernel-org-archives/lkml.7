Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14077C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6918208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFVqYmBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394071AbfIJQBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:01:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34612 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393142AbfIJQBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:01:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so17586739qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4GD13AWYtGaucIdPfBacL0HOCS06RwW+OYru26aZGo=;
        b=bFVqYmBJIFyWISBLSfHrMzHiHbX5do/4cERYQDzWJt+PZeUX0OHsy+TSpRVBXTL+aQ
         3OvVTAx2WOC9NxGNNC9S6FV8QWMDIDndDSi7jqkc0qtujb/mOjXJc5BbsLL4O7ILwOLl
         ioI7jRVbci1bxCMndyhJyQ1t7X59S++cBodci18y3HAd1Y/j6ApRGSqlu2EnSogzcaCP
         NdJyhxsV0XKDKjhdMZ64YeSabZD1Li+xXFb79HCd/3i3LEksxFoU/kzsuLi/8LdbqKR5
         wi/J4RsiJiLJJHF/ktI1oaePbrpTMpxPq5h6iC2XB1nngjzzPq6YNTUrNxnc3thwBD+/
         SMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4GD13AWYtGaucIdPfBacL0HOCS06RwW+OYru26aZGo=;
        b=ixMXC0rd0amt6yPX/LNI4J9O0yLO3lvnmM7gInsL6VpdG8WQA+avvmjWy/gbKdR6dX
         ng5MSkHNKMI1FR0/KBs5AE+DITF5HwBgA8Nleai9OMudM8VkmccVxrjQwtvJl9I+OE3S
         /yNGTnVNcGN85/ohMe+f9sQzK6FYsBpRiEHy+qzKQXA81WMeT82cst+W4nLolXZyCoI3
         ch3MVO09CtCsU6+VRncQx/a56eymzLuPGc/hkrwU0FbvUs46poQD+2HMyKxbkh7FMxZY
         wZf8nkHyrzS0RO6Q6JeQVqF64pmrCrBqvF1gy5DSvOVjUq/yBusC9FXhlwe3tuW7msQk
         xuAw==
X-Gm-Message-State: APjAAAVOL39OMudhcHTIOyXvRMZ+ZeQPL7TyBgKzE3t2wXxuMfm/NC3D
        nZi3ZS99uvRFkzljmvy6Go9i1lgnJsuPsc9vlw6H/A==
X-Google-Smtp-Source: APXvYqy6SzC7+IGaR6kLfQ1kWlTcyoGFIff7HiG5+P8pj2qyHaCRpqTlB6+sj4xNrcQCndtftJ80ILJGtJ0yn8yaSD4=
X-Received: by 2002:a37:2784:: with SMTP id n126mr29003422qkn.302.1568131309763;
 Tue, 10 Sep 2019 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org>
 <5D674C35.6060001@linaro.org>
In-Reply-To: <5D674C35.6060001@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 10 Sep 2019 21:31:38 +0530
Message-ID: <CAP245DWkd4RvH1y1E17sCEndNY=xs+69EJ-41ecRL_EE0Vnkug@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] drivers: thermal: tsens: Add interrupt support
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

Thanks for the review. Please find replies below.

On Thu, Aug 29, 2019 at 9:23 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Hi Amit,
>
> On 08/27/2019 08:14 AM, Amit Kucheria wrote:
> > Depending on the IP version, TSENS supports upper, lower, max, min and
> > critical threshold interrupts. We only add support for upper and lower
> > threshold interrupts for now.
> >
> > TSENSv2 has an irq [status|clear|mask] bit tuple for each sensor while
> > earlier versions only have a single bit per sensor to denote status and
> > clear. At each interrupt, we reprogram the new upper and lower threshold
> > in the .set_trip callback.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 377 ++++++++++++++++++++++++++--
> >  drivers/thermal/qcom/tsens-v0_1.c   |  11 +
> >  drivers/thermal/qcom/tsens-v1.c     |  29 +++
> >  drivers/thermal/qcom/tsens-v2.c     |  13 +
> >  drivers/thermal/qcom/tsens.c        |  32 ++-
> >  drivers/thermal/qcom/tsens.h        | 270 ++++++++++++++++----
> >  6 files changed, 669 insertions(+), 63 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 06b44cfd5eab9..c549f8e1488ba 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c

<snip>

Please snip liberally when only replying to a small part of the patch. :-)

> > +
> > +             spin_unlock_irqrestore(&priv->ul_lock, flags);
> > +
> > +             if (trigger) {
> > +                     dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> > +                             hw_id, __func__, temp);
> > +                     thermal_zone_device_update(priv->sensor[i].tzd,
> > +                                                THERMAL_EVENT_UNSPECIFIED);
> Why not use thermal_notify_framework? Or do you want to loop over all
> registered trips ?

Mainly so we get a driver call-back to set_trips where we might want
to change behaviour once we cross certain thresholds.

> Another comment I have is regarding support for multiple thermal zone.
> It might not be needed now, but presence of the same sensor can serve
> multiple zones (one for cooling and one for warming) . I am not sure if
> you want to put some infrastructure in place for that as well for
> interrupt handling.

It is premature to add such infrastructure to the driver until we
decide how we're going to implement support for this, IMO.

<snip>
