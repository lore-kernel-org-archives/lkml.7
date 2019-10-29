Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8085CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A2A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojI912WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfJ2VVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:21:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32842 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfJ2VVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:21:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id m193so164698oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8xArhRDoNXUbWX4EdmjweiHTW4/JnIyhzo/xyW6XxM=;
        b=ojI912WJLMKSe3iQP4WzhQapOtESvGrxE3lsv+poUzeRJOvYMlT5VDHYgM0JzH0W+P
         GwzA2iaxTkr79Yd7ObLdokzSiwQXcbC/T1LuORrYy328g18YaLRVvCn1qXXpijqq92ic
         y7EvOOdGC232K3ShfM7UVEDVke2LadybNi/xrh83ohR8YkA8eoS19aIBf+woFwI/EvbQ
         uawUf7MN1Dk0I8RJ/p5G8dDBLsKvnWVo1Yq3Glnb0hp2iL8M192isnr7unr+xY8qMPqO
         f1/ylqy+PdUlVsVFUJvGsAtP8hnvDi2U50zbUseLrGC+gle/3Qf42CzO81+L00jOcQ/6
         B9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8xArhRDoNXUbWX4EdmjweiHTW4/JnIyhzo/xyW6XxM=;
        b=kpqANedAmkHqogSNyYgs/aG/1VPWYroytpEprDCZuQXOOyFrc5H5f4VX4xWcXrhNJs
         A8qYLh+8OzZmhg9VVmc4qmngkwRzLoUQG1DwQQPuXIHQQcIIph0tTqOQTEvwVR+e2OsW
         F1x6lwnXOErRz9SCIXiYgi4czbQZrz/ZV5Yl6VBfi4l2Fz8ymwrzMzW7ptX9pbVlyP03
         o6vHlCHrgg1Z39sHbxAcGD1LfGM1J5ELoaAB7ih08hFMzHLuLXEvAkSVAYetfmqsweRC
         sLjw/oWyBwbWfa3OCOvPZlc0VGfBNSjUvJchaiJY8ZJ9THsBYWQwA/IdbYt9YjVJNeCP
         qOVQ==
X-Gm-Message-State: APjAAAVesMghQql3x5Y5tfEeE6AEt8EYkIGELi7BWQIInRay01tbj73u
        kJunXK/NxiyRLwdlrl4dBooGplHSsomasJDW3IZq8Q==
X-Google-Smtp-Source: APXvYqz9iikOCmyCYThBR+xrlLZBkbgNK8dGvSf09Nn4AtfDYJp882m2GUQge7vjRFhlgRNd3utC76a1kjoznAPknhc=
X-Received: by 2002:aca:58c2:: with SMTP id m185mr6043338oib.128.1572384104335;
 Tue, 29 Oct 2019 14:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-3-john.stultz@linaro.org> <87pnifj4tg.fsf@gmail.com>
In-Reply-To: <87pnifj4tg.fsf@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 14:21:31 -0700
Message-ID: <CALAqxLW4bRKOUchQXM0WKy-SWT7GQrA+6acu_1QMjEwwxCaU0w@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] usb: dwc3: Execute GCTL Core Soft Reset while
 switch modes
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 2:09 AM Felipe Balbi <balbi@kernel.org> wrote:
> John Stultz <john.stultz@linaro.org> writes:
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > On the HiKey960, we need to do a GCTL soft reset when
> > switching modes.
> >
> > Jack Pham also noted that in the Synopsys databook it
> > mentions performing a GCTL CoreSoftReset when changing the
> > PrtCapDir between device & host modes.
> >
> > So this patch always does a GCTL Core Soft Reset when
> > changing the mode.
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
> > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v3: Remove quirk conditional, as Jack Pham noted the
> >     Synopsis databook states this should be done generally.
> >     Also, at Jacks' suggestion, make the reset call before
> >     changing the prtcap direction.
> > ---
> >  drivers/usb/dwc3/core.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 999ce5e84d3c..a039e35ec7ad 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -112,6 +112,19 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
> >       dwc->current_dr_role = mode;
> >  }
> >
> > +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
> > +{
> > +     u32 reg;
> > +
> > +     reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > +     reg |= DWC3_GCTL_CORESOFTRESET;
> > +     dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +
> > +     reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> > +     reg &= ~DWC3_GCTL_CORESOFTRESET;
> > +     dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +}
> > +
> >  static void __dwc3_set_mode(struct work_struct *work)
> >  {
> >       struct dwc3 *dwc = work_to_dwc(work);
> > @@ -154,6 +167,9 @@ static void __dwc3_set_mode(struct work_struct *work)
> >
> >       spin_lock_irqsave(&dwc->lock, flags);
> >
> > +     /* Execute a GCTL Core Soft Reset when switch mode */
> > +     dwc3_gctl_core_soft_reset(dwc);
> > +
>
> This is totally unnecessary. We have several platforms supporting dual
> role *without* this trick. The only reason why the databook mentions a
> reset is because some registers are shadowed, meaning that they share
> the same physical space and just appear as different things for SW. The
> reason being that Synopsys wanted to reduce the area of the IP and
> decided to shadow registers which are mutually exclusive.

Ok. I've dropped this for now. Without this I do see an occasional
issues seemingly more frequently where he board seems to initialize
improperly on boot (usb-c is connected, but it doesn't seem to detect
until I unplug and replug), but it also trips (though seemingly less
frequently) without this, so this may be just affecting the timing of
a initialization race issue. I'll watch this for more info and follow
up on it later.

Thanks for the review!
-john
