Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51EFC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D82053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wnszb6on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgAHWoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:44:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36093 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgAHWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:44:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so4278530qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vo+6C1EuzsBLHBwL8bvb08t4OkksMVFETIJoYKx5DTo=;
        b=Wnszb6on0SMp/3XOzNETDRgBA1SdEWJobacWeeLrc4lDfi7vhmtnOldGqbPPBAZbfG
         7wp6u/0G5WV3uSIpGENHwwILKLe4qZ56kKoDHOHcvgCpvAf4N2HVstmon3dD9/r6c9sv
         qlfEDsZVhNNIdGprWFOmlxpJcR4ut9Km4zNUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vo+6C1EuzsBLHBwL8bvb08t4OkksMVFETIJoYKx5DTo=;
        b=X+5f3yJyZ6nvoh1fYmtSU7KtQ5UC7mUBdvm4vnGLu/zyVFH7tNSoMkt5S9n5GGOc+o
         TRb31D92Ad5ISEfAfRRwqm8Ib97G7JZATd5nmUOLZsXzq9/eVxOvJk83nbm2e38W0wYd
         KUQQgEq2lGtmlDkJIlvzkkg8L2wCK7B9VMhxkaAfTEKrKailax8PyMVqoPzA9RCvz18F
         /rcXbWH6+0zcxkGoyLTZu46Weetp0w2ofTh8qGqsuQZVC6GYSbesdIaMpPJFo84VdOJj
         V2vVh8bwlLiuRoTM3CBPTWM/VUUUuCDdOCdkSJyU90CRGg27Pn/LDE8CWRy0GAB8vVHD
         zLwA==
X-Gm-Message-State: APjAAAUPVan/o6vGAODxeOwDHtkvczCgT5Oa8xo4iNH4tVrdXMSEkMVl
        6kRwONZXzbKNICcBeLgGKaB0AFIJ8ePE1kc0IUVSRQ==
X-Google-Smtp-Source: APXvYqxnt7gN4ytrxX2jjjTbvXbu6erGQ6HNZhqe3Pr82LWm38qxIiDN1rgAR/6KRKR7dwyCXJ7fm7aQppC5xk7pbCM=
X-Received: by 2002:ae9:e103:: with SMTP id g3mr6826468qkm.353.1578523471432;
 Wed, 08 Jan 2020 14:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-8-drinkcat@chromium.org>
 <CAL_Jsq+jWtrV8-iDzqsefRxr_21jzf7AdSLap8k4hstqK3MBvQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+jWtrV8-iDzqsefRxr_21jzf7AdSLap8k4hstqK3MBvQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 9 Jan 2020 06:44:20 +0800
Message-ID: <CANMq1KCTdtKDB4bmdAFf+voTvCECedAKTJHue4H1quhW6SXbxQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7, RFC]: drm/panfrost: devfreq: Add support for 2 regulators
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 4:09 AM Rob Herring <robh+dt@kernel.org> wrote:
> [snip]
> >  void panfrost_devfreq_resume(struct panfrost_device *pfdev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index 92d471676fc7823..581da3fe5df8b17 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -91,10 +91,12 @@ struct panfrost_device {
> >         struct {
> >                 struct devfreq *devfreq;
> >                 struct thermal_cooling_device *cooling;
> > +               struct opp_table *dev_opp_table;
> >                 ktime_t busy_time;
> >                 ktime_t idle_time;
> >                 ktime_t time_last_update;
> >                 atomic_t busy_count;
> > +               struct panfrost_devfreq_slot slot[NUM_JOB_SLOTS];
>
> ?? Left over from some rebase?

Oh, yes, sorry.
