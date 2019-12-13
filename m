Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 04:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3654324679
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 04:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="NgCbOcIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfLMEio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 23:38:44 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43197 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMEio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:38:44 -0500
Received: by mail-ua1-f68.google.com with SMTP id o42so327177uad.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 20:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=End3OvBpc+ygNGyVRW83GCf3Bo6cZwj7YlQ/woj7ERg=;
        b=NgCbOcIfEosgK7rGmNe2T5lGSJOb8IDeMriMbHtrhCum7NjFGyqAhn7K8CbTiJyEdO
         6+W75tOyldD9w2Tm//wqoeF2XB8XiWag8787WGwLJTpcluK6VO0s0jj1Fga83B/uPImD
         P/e4bBZVi6LadafPV00uBmigNWzl28j1FnWsB4PVjPnvdw9viP7bRInczKdFcH4HOTJZ
         6TJWuiwcl+Q10A/NsbU+dV4K8W3Pl6KTGw8WMl+2YmUqvjz73KwgajaaSn1Ump9Lisgo
         aFtFhdFGUPvQWGfFhgNpGrRAOkZeOzf//86XUGfxshiyjyTXh5VIdTmSZG3dSNQ+KmBu
         2Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=End3OvBpc+ygNGyVRW83GCf3Bo6cZwj7YlQ/woj7ERg=;
        b=uVfYgy55sNEZTurH9NSjQDjYZMuAwhh46ZfWjlCJON0HHOB06kECp7hL5IcTqODTyh
         CdYX4Cd6bmvCojlUOrOwgNQ/9E0YNgyPZmU9GBHIF/AwFZeEQ+FzIp5PsuqLhn07S3n/
         FFzgInsSDnY15wK4PatESizks4o7T6lPD781hNvX6XddK3WMLIq6FNBKHnffbMkJcmVf
         YWTYzC/VvZhqUrEGCC0Ec+I/DZOfHpF9eaigmMdiWPU0mf2MxyipptCHWH+Ki8nZc9Qi
         anFiaCT4bvAAQrzUqLxN5pDyFNLySRAxH/YQR3dpn4ZMny0Y0wNsprHJXmmNZEVig3+o
         tzcA==
X-Gm-Message-State: APjAAAVFidc8kNBcnoV/e/+INLgmCdFYvsW5aRUXktPQPMs0eXQ0fvjV
        5aXecFA/tseKFZoSFdQqn8Gxuyyt9AzwfxW7wMfP6Q==
X-Google-Smtp-Source: APXvYqwv9mzxgV/3oPODaUBDzbQgXuYQWXhKnbm7cl4vi1ycEuXmhUCYBcB7WE3KiGJh/ydRTwYlGm3vUIO6AcUK7UE=
X-Received: by 2002:ab0:30eb:: with SMTP id d11mr11521987uam.67.1576211922735;
 Thu, 12 Dec 2019 20:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20191212061702.BFE2D6E85603@corona.crabdance.com>
 <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com> <20191212232859.E09FC6E85603@corona.crabdance.com>
In-Reply-To: <20191212232859.E09FC6E85603@corona.crabdance.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 13 Dec 2019 10:08:31 +0530
Message-ID: <CAHLCerN9jc94ydKKoaDZPoTy=LmVZti6UUpND5aK3FMzTkCmoA@mail.gmail.com>
Subject: Re: [RESEND PATCH] thermal: rockchip: enable hwmon
To:     schaecsn@gmx.net, jdelvare@suse.com, linux@roeck-us.ne
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, Dec 13, 2019 at 4:59 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> Hello Amit,
>
> > On Thu, Dec 12, 2019 at 11:47 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
> > >
> > > By default, of-based thermal drivers do not enable hwmon.
> > > Explicitly enable hwmon for both, the soc and gpu temperature
> > > sensor.
> >
> > Is there any reason you need to expose this in hwmon?
>
> Why hwmon:
>
> The soc embedds temperature sensors and hwmon is the standard way to expose
> sensors.

Let me rephrase - is there something in the hwmon subsystem that is
needed that isn't provided by the thermal subsystem inside
/sys/class/thermal?

> Sensors exposed by hwmon are automagically found by userland clients. Users
> want to run sensors(1) and expect them to show up.
>

That is a good point. In which case, I wonder if we should just fix
this in of-thermal.c instead of requiring individual drivers to do
write boilerplate code. I'm thinking of a flag that the driver could
set to enable the thermal_hwmon interface for of-thermal drivers.

> Why in rockchip_thermal.c:
>
> drivers/thermal/ provides a high-level hwmon api in thermal_hwmon.[hc] which is
> used by at least these thermal drivers: rcar_gen3_thermal.c, rcar_thermal.c,
> st/stm_thermal.c, and broadcom/bcm2835_thermal.c. I want to hook up
> rockchip_thermal.c exactly the same way.
>
> Apparently, other architectures hook up the cpu temperature sensors to hwmon
> elsewhere. Most seem to do this in hwmon/, e.g. hwmon/coretemp.c. These drivers
> are written from scratch. Utilizing thermal_hwmon.[ch] for chips which have
> already drivers in drivers/thermal/ seems to be more elegant.
>
>  Stefan
