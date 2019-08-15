Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1021C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BC521743
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IKj4fHPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbfHOKaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:30:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42100 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOKaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:30:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id m44so1705273edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gehrfSX/wYrGDiK8IqXnoPhYbim32JFwF8t1ONu8CwY=;
        b=IKj4fHPmdhELeh90ShgbJmumqDoKz4HjY9PfX+7XdlHjTTZy8VBZMWV8V0jgtKigwJ
         RqABRgkm9B8EAn+pmeIpfze0Tyfh2OmUTy9FzVzVkYUiACFB6c0YcnrGGDeZX/qyDe0P
         N3pdQMX0iGWiIsb1N8JDM8yyCWEvtLttRdL/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gehrfSX/wYrGDiK8IqXnoPhYbim32JFwF8t1ONu8CwY=;
        b=BO3PsH93+98I/VtXrCCZGu+ycCsh8GZT5HHo4vLYa4+5oF5mgsvIP2mwhT/lYbUPlJ
         FqZ503Ib6VNLReoew0QdY1U9QRog1VhhjEo77SuUNNg9BBVo6LjNoqgimLHs8sTLPN2a
         NezLjHKPwyyDqalQjvYxFwLgkuyYiS89Nrd5FWnobKVwGB0i8BmxS85wHi0h+YHRmiKk
         hb9SeeAbT7MnfBsa/FugSUmPtd23o7g7OMY73iS5v6Jh7grZ/w+9JqmbS8yjTSiDX+bq
         SdVpIqrNg4/RlLWqSAA8CGUK1rwd2JrksyYRxcbP6NTz9DouILPQALy3V3aCDvcv4dat
         xNWw==
X-Gm-Message-State: APjAAAXWKCy0/0kwWlKKjYQNESfjDuDvgjw7C/L7PjL2vo0XMmZZbKZG
        WizeOOXuAmH8woKje6TJLiuXqwmYV99Dlg==
X-Google-Smtp-Source: APXvYqze9XqnZ1bIC1olcle44/Q6FvU1juObFiiqge/4CsAKNe2SeOR1qHNAXiUPkzdIVhImLK7pRA==
X-Received: by 2002:a50:97ea:: with SMTP id f39mr4506598edb.279.1565865014145;
        Thu, 15 Aug 2019 03:30:14 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id f22sm484389edr.15.2019.08.15.03.30.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 03:30:12 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id z1so1757601wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 03:30:11 -0700 (PDT)
X-Received: by 2002:adf:f851:: with SMTP id d17mr4704460wrq.77.1565865011444;
 Thu, 15 Aug 2019 03:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190730184256.30338-1-helen.koike@collabora.com>
 <20190730184256.30338-6-helen.koike@collabora.com> <20190808091406.GQ21370@paasikivi.fi.intel.com>
 <da6c1d01-e3f6-ad73-db55-145d7832a665@collabora.com> <20190815082422.GM6133@paasikivi.fi.intel.com>
In-Reply-To: <20190815082422.GM6133@paasikivi.fi.intel.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 15 Aug 2019 19:29:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cd2k5ZCDfu=a281NLOa88vpm-P7ZPWF4Nnx==iyEkn7A@mail.gmail.com>
Message-ID: <CAAFQd5Cd2k5ZCDfu=a281NLOa88vpm-P7ZPWF4Nnx==iyEkn7A@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] media: rkisp1: add Rockchip ISP1 subdev driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Helen Koike <helen.koike@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Eddie Cai <eddie.cai.linux@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen Jacob <jacob2.chen@rock-chips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        =?UTF-8?B?6ZKf5Lul5bSH?= <zyc@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacob Chen <cc@rock-chips.com>,
        Allon Huang <allon.huang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 5:25 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Helen,
>
> On Wed, Aug 14, 2019 at 09:58:05PM -0300, Helen Koike wrote:
>
> ...
>
> > >> +static int rkisp1_isp_sd_set_fmt(struct v4l2_subdev *sd,
> > >> +                           struct v4l2_subdev_pad_config *cfg,
> > >> +                           struct v4l2_subdev_format *fmt)
> > >> +{
> > >> +  struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
> > >> +  struct rkisp1_isp_subdev *isp_sd = &isp_dev->isp_sdev;
> > >> +  struct v4l2_mbus_framefmt *mf = &fmt->format;
> > >> +
> > >
> > > Note that for sub-device nodes, the driver is itself responsible for
> > > serialising the access to its data structures.
> >
> > But looking at subdev_do_ioctl_lock(), it seems that it serializes the
> > ioctl calls for subdevs, no? Or I'm misunderstanding something (which is
> > most probably) ?
>
> Good question. I had missed this change --- subdev_do_ioctl_lock() is
> relatively new. But setting that lock is still not possible as the struct
> is allocated in the framework and the device is registered before the
> driver gets hold of it. It's a good idea to provide the same serialisation
> for subdevs as well.
>
> I'll get back to this later.
>
> ...
>
> > >> +static int rkisp1_isp_sd_s_power(struct v4l2_subdev *sd, int on)
> > >
> > > If you support runtime PM, you shouldn't implement the s_power op.
> >
> > Is is ok to completly remove the usage of runtime PM then?
> > Like this http://ix.io/1RJb ?
>
> Please use runtime PM instead. In the long run we should get rid of the
> s_power op. Drivers themselves know better when the hardware they control
> should be powered on or off.
>

One also needs to use runtime PM to handle power domains and power
dependencies on auxiliary devices, e.g. IOMMU.

> >
> > tbh I'm not that familar with runtime PM and I'm not sure what is the
> > difference of it and using s_power op (and Documentation/power/runtime_pm.rst
> > is not being that helpful tbh).
>
> You can find a simple example e.g. in
> drivers/media/platform/atmel/atmel-isi.c .
>
> >
> > >
> > > You'll still need to call s_power on external subdevs though.
> > >
> > >> +{
> > >> +  struct rkisp1_device *isp_dev = sd_to_isp_dev(sd);
> > >> +  int ret;
> > >> +
> > >> +  v4l2_dbg(1, rkisp1_debug, &isp_dev->v4l2_dev, "s_power: %d\n", on);
> > >> +
> > >> +  if (on) {
> > >> +          ret = pm_runtime_get_sync(isp_dev->dev);
> >
> > If this is not ok to remove suport for runtime PM, then where should I put
> > the call to pm_runtime_get_sync() if not in this s_power op ?
>
> Basically the runtime_resume and runtime_suspend callbacks are where the
> device power state changes are implemented, and pm_runtime_get_sync and
> pm_runtime_put are how the driver controls the power state.
>
> So you no longer need the s_power() op at all. The op needs to be called on
> the pipeline however, as there are drivers that still use it.
>

For this driver, I suppose we would _get_sync() when we start
streaming (in the hardware, i.e. we want the ISP to start capturing
frames) and _put() when we stop and the driver shouldn't perform any
access to the hardware when the streaming is not active.

Best regards,
Tomasz
