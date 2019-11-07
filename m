Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED26C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2093021D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573163611;
	bh=q6SKsLHXv+qLDAv/Si1jE9FsC4EPM3DgeowAA3ZAaX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YcXbwH5BisQ7T+7YfnyUZPIGkRvG61vT8dBRlunUMf+Pa3vhNO/z/nkf920meaBs9
	 YJd9vgEhQT6aamdJR+ETY389uFx6iGkANdrMc0fmF3318GOmrfowXqjnHvHXgaNu7Y
	 dwFbQ7xHWleB/AKRC0emxszM5UCTI8o4z9ZwQTmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfKGVxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKGVx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:53:29 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9828E222C5;
        Thu,  7 Nov 2019 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573163608;
        bh=q6SKsLHXv+qLDAv/Si1jE9FsC4EPM3DgeowAA3ZAaX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEYJ+z+Mor70QcV2yPq7FiaLWy/3ZTvRV6Xh2eM7/xHDjOvmKWGtDoe1mQSYfMdBc
         yeyqQm0HIVYRAEhXqnY1mPoCdIIFufty6Fcs/zHKqQVlXu+OQ3CPzOonJTvYYTHxvR
         6+J+ri0oYQD/oIRQ4Np94MW11oMSPnBmp1gvonaA=
Received: by mail-qk1-f176.google.com with SMTP id 205so3485224qkk.1;
        Thu, 07 Nov 2019 13:53:28 -0800 (PST)
X-Gm-Message-State: APjAAAWcvbBtKAc+5M4yugkY6w24c6HpVtt4uKEEepHwO5/hnbyBk6na
        LCRPS8J1HHk5lLGEshtd4zK306COH0eRDjEdGg==
X-Google-Smtp-Source: APXvYqxRrpYDbcHtlqqkdKNshF+TFNs6h/MBQZGDRhUH8Ti1BBiIS+leA9f/5p/0YVNfUwuJ2LVn2w4ciKgHvtx6mNQ=
X-Received: by 2002:a05:620a:205d:: with SMTP id d29mr5534809qka.152.1573163607663;
 Thu, 07 Nov 2019 13:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-6-john.stultz@linaro.org> <87k18nj4mj.fsf@gmail.com>
In-Reply-To: <87k18nj4mj.fsf@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 Nov 2019 15:53:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJtKMG7FfrHFjKpMx1As954UE2QqzMBOWEB4wGn=rsAug@mail.gmail.com>
Message-ID: <CAL_JsqJtKMG7FfrHFjKpMx1As954UE2QqzMBOWEB4wGn=rsAug@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] usb: dwc3: Rework clock initialization to be more flexible
To:     Felipe Balbi <balbi@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 4:14 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> John Stultz <john.stultz@linaro.org> writes:
>
> > The dwc3 core binding specifies three clocks:
> >   ref, bus_early, and suspend
> >
> > which are all controlled in the driver together.
> >
> > However some variants of the hardware my not have all three clks
>                                         ^^
>                                         may
>
> In fact *all* platforms have all three clocks. It's just that in some
> cases clock pins are shorted together (or take input from same clock).
>
> > So this patch reworks the reading of the clks from the dts to
> > use devm_clk_bulk_get_all() will will fetch all the clocks
>                               ^^^^
>                               which?
>
> > specified in the dts together.
> >
> > This patch was reccomended by Rob Herring <robh@kernel.org>
> > as an alternative to creating multiple bindings for each variant
> > of hardware when the only unique bits were clocks and resets.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > CC: ShuFan Lee <shufan_lee@richtek.com>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Cc: Yu Chen <chenyu56@huawei.com>
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Jun Li <lijun.kernel@gmail.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Jack Pham <jackp@codeaurora.org>
> > Cc: linux-usb@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v3: Rework dwc3 core rather then adding another dwc-of-simple
> >     binding.
> > ---
> >  drivers/usb/dwc3/core.c | 20 +++++---------------
> >  1 file changed, 5 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index a039e35ec7ad..4d4f1836b62c 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -305,12 +305,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
> >       return 0;
> >  }
> >
> > -static const struct clk_bulk_data dwc3_core_clks[] = {
> > -     { .id = "ref" },
> > -     { .id = "bus_early" },
> > -     { .id = "suspend" },
> > -};
>
> another option would be to pass three clocks with the same phandle. That
> would even make sure that clock usage counts are correct, no?

If you have the datasheet for the block, then perhaps some suggestion
of which clocks code be the same. My guess would be ref and suspend.

Maybe suspend is a fixed clock which is unmanaged on HiSilicon
platforms. If we allow for no clocks on some platforms, then why does
it have to be all or none?

Rob
