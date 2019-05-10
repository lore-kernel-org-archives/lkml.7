Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1756C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE62217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVxpVXnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfEJSME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:12:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42985 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfEJSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:12:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so8869667wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HRDKhytJDZbmBnyIz5yp7Hbwe4qinZP2/tXgzhcKfU=;
        b=EVxpVXnEidNmTynDhyYPoYFE0He6PuqnXqDwD+bQ0t4+qjYri8MaLpDrbW7/g65kX/
         Wd5p0kA/47SNSCkPUGYRheu/XwFmE9UNnKSrwPXwKhkjwH1QbdJcxY+2h4k5ft41sMVA
         PEC7j2khGu88VARrFan5B3hS5BsyScyUaKy6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HRDKhytJDZbmBnyIz5yp7Hbwe4qinZP2/tXgzhcKfU=;
        b=iFpdIBj2H2iX1d6+HUvgiUR0Lb57JzFIZcSHWdOP1jFDSSkWWpPJ6kKyxm/gr1DsKr
         cNa6YPbDSF5P9VXsiOGsAd0ath3Qw9Uc0p7avpgy6opqG1mNQ8T7eLc39GwPh3pySnlW
         O6AdXA5zx1hYebSc45M5Ymy5JuAtCe0fEBzD8fdTH+MJLRdxmn3ii0gGzSn0ywVXO7nO
         AM9phrlSgHGTdJPC7LxvIYKecrj5nYkvYZ2dz2XtOE2sAMJd3wVSzXHHxtYUpAUlYYsC
         SyJNMvr7Waqi5fKaCMaCL+dj8rcSsLFzBWCI8mYTYRmq3cx2TvKgMuXG9CokudI5KJe6
         9iaA==
X-Gm-Message-State: APjAAAX49UCUuu2I1pZQf9gIqyGC6kD6IocBNIr/yRWSfeGF3bR8r/RV
        TKk6Csv6B/kJ+0J0P9NyITrLDPc8kbnInkiBqs3TvA==
X-Google-Smtp-Source: APXvYqwbjIvof/DU5+IoR6wo4LfmWV5Ay4lQctVA38z0su6CfSPxUl7uBT5d+Nzm02j7RjAgqCZCi3GfWfkg11IEnqA=
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4644366wrn.197.1557511922117;
 Fri, 10 May 2019 11:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190510180151.115254-1-swboyd@chromium.org>
In-Reply-To: <20190510180151.115254-1-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 10 May 2019 11:11:48 -0700
Message-ID: <CAODwPW8Tx63pJK3DP+5-s8g9x-nZ+B4bKgCBTmRSuC-jBomEjg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Misc Google coreboot driver fixes/cleanups
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's some minor fixes and cleanups for the Google coreboot drivers
> that I've had lying around in my tree for a little bit. They
> tighten up the code a bit and get rid of some boiler plate.
>
> Stephen Boyd (5):
>   firmware: google: Add a module_coreboot_driver() macro and use it
>   firmware: google: memconsole: Use devm_memremap()
>   firmware: google: memconsole: Drop __iomem on memremap memory
>   firmware: google: memconsole: Drop global func pointer
>   firmware: google: coreboot: Drop unnecessary headers

Thanks, these all look good to me.

Reviewed-by: Julius Werner <jwerner@chromium.org>
