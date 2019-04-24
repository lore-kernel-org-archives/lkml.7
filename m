Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E103CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE6820656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmJ9yk6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfDXVYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:24:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40903 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfDXVYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:24:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so304454wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/odU1I0OQEBPcTiXm89SI+/1Purl4tZSBbeIjyJLm8=;
        b=mmJ9yk6RbTXRkB7q95dlKg4QJK20jlGMyuU0IbwasJASBOSvYnGzPlNnZ38VrqRph5
         cUABshfuc8pmODMZ6gnOFuFwVCPhGxjGDrQrX3cGDSJWirQ6YwCflaNEhWUHwnBWPbmt
         4cNl9jTcqvfMDN60OR/HnD5iMuMlvY7PAC2RdOQqOy/jnYsJgaYyZqBnE2+pmr6Rs85M
         6qNTOGm2Sfk221sY52pLg9edfRK5JH7YPIGOIoG1e8TBB4fFCaLG9VSIgdqd9dMSiRtf
         yrQCz5tCRoWrNr2kWvxJuC/LLQbBqBQLSqn/PW3gphtX8GdM4VCyjx3wf4Lc5NKrR+tH
         imng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/odU1I0OQEBPcTiXm89SI+/1Purl4tZSBbeIjyJLm8=;
        b=X4K2fUsgnRtspw5EV1zZBlDfaRMTCxkNA1tX7rrA16fnUSId/01Npr7Fbhpwgd02zk
         rc1D61tqjdueT4WxfrMfshMA7lNcokMQp/nnE9StiIFrE8cvXXV85NpA7zJrPVJ0TTn6
         8NzaLJfNo1KRyaGBCwe/ldlLBkG1y0oLECu+8eqTbLEwnEDU7/FkYGkCy2l8EDimFCLP
         BoSLGTRaaOktQTAolBKD+pd8SLOmioPqH90AgAihOzDFNirrrSungpRnan5y3qE1Rxki
         xx+tnAGYT+R+p5RcOxPpgKJLH1xTx2mj1gqd+lYmr8hSeI02bEm2TOtPvKAuqNelWDiy
         /yig==
X-Gm-Message-State: APjAAAUJ6o9nurk7Uy8wyrSVoEEIQp08Z1vO278Aes/ScKtLxqYycJrn
        pikY/jOPhpBTZLQ6jjzNKZYpBblffIxap98Jl/Rp8Q==
X-Google-Smtp-Source: APXvYqz4F8jThLYFjaJ6/cSWM8slPWfpUcGoO5dKPnj51K9xNrr2h2lMhgtLpsJQdfU8nasx0JfCbhtAKQVcsMs6Gbg=
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr763935wmb.23.1556141078464;
 Wed, 24 Apr 2019 14:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-25-git-send-email-john.stultz@linaro.org>
 <20190424170910.GC21067@ravnborg.org> <CALAqxLWmrabPxnpN7T_9KCLNrpzj0dnzbNs8vLhz+GBGyRxp_Q@mail.gmail.com>
 <20190424211536.GB27952@ravnborg.org>
In-Reply-To: <20190424211536.GB27952@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 14:24:25 -0700
Message-ID: <CALAqxLUP6egCR486gw-Utxf6zmrXDv-nPNmUjWLDD7RqHiYxVg@mail.gmail.com>
Subject: Re: [PATCH 24/25] drm: kirin: Pass driver data to crtc init and plane init
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:15 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > > I missed where ade_driver_data came from.
> > > This looks an extra patch to intoduce driver_data,
> > > that maybe should be merged with an earlier version?
> >
> > I'm not sure I'm following you here. Can you clarify a bit more?
>
> So I looked at this a bit more - and got the bigger picture in place
> again.
>
> driver_data is assigned using the lookup done at probe() time.
> For now this is just assigned to ade_driver_data as this is the
> only option.
> So an indirection via driver_date or calling ade_driver_data
> direct is the same.
> And you have several patches where you migrate to use driver_data
> rather than calling ade_driver_data direct.
> It confused me that the patch introducing the lookup at probe()
> came before all call sites were migrated to use driver_data.
> But I get it now so it is fine.
>
> Maybe a few words in the commit log like:
>
> This patch refactor to call functions via driver_data,
> rather than hardcoding them via ade_driver_data.
> This is doen so we later can assing another stucture to
> driver_data to support other chips.

Sounds good! I'll integrate this into the change log.

> PS. I did not complain about your spelling mistakes in the
> changelog. I have a similar (or worse) keyboard from a spelling
> point of view.

Oh yes, a deficiency of mine. Good reminder I should run through the
logs w/ the spell checker.

Again, I appreciate the feedback!

thanks
-john
