Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE9BC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F0F2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCA4AKAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGLRM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:12:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34051 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLRM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:12:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so6977516lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pse6FXJG8sb0d/Uu8QeoRFImgF39wb/PbVEJNGqE/QM=;
        b=hCA4AKApWhYP67WsAtNV42plJm27P87ysQ5bJ1O15QXVycKOaZD1wFNQMgyqELQhB3
         aT9iA5dlMLTOM+JxqNGboMXdeDVHC64+39MgJ0Q3muUZZNIN3a0mgzT3ek+/s7Slls4X
         PqHIwq3s9cUUZCnC9AF+zcpXZa2sZC4x4iIKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pse6FXJG8sb0d/Uu8QeoRFImgF39wb/PbVEJNGqE/QM=;
        b=EK7u1/xj7mbVlv8yWYi1tb1a6+VIq4NleWZjSjBXVrHyxcYIwomzARKmlNOT3+8cxv
         SjUV5xuFgEWMHNEO2PhYH1MLgMDIO6HJ17obijvfiz8I3ymEmWpGZNKLt9/2HEkLH8Wt
         kFwq/MmNmces+uG9weyvB41eOg7pz9oQEFjtyaxvtbV80GveKiWiG/7g6/wDJpTgIdxs
         xg1FXVR2Xfaap3+QKTZZeiaqp0i2R+LEzyRiCosba7s+ksJVPd5LpalfY4S87NZi7onm
         iYkOFdNhv8fTVrRbs5XKwYkKJ8COIUQvBrIn7/gPYFQDvxy2a5MqGBM1ew5X7I/G9/Lz
         3MWw==
X-Gm-Message-State: APjAAAUke5qm4x1BfCuwe8GIICQlEMPYc0NJHgCMC6aT1EXs6qqhos9U
        nF6FTbwfgMNY/drKKfvCKg8szSoryyk=
X-Google-Smtp-Source: APXvYqwLdzcpyJW/eNPjLfd72vlhmEqnHDwfBREPlXIstxiT6OolP25em6aUteQATjUIyGmEKbEDKg==
X-Received: by 2002:ac2:482d:: with SMTP id 13mr5170992lft.132.1562951545386;
        Fri, 12 Jul 2019 10:12:25 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d3sm1182170lfb.92.2019.07.12.10.12.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 10:12:24 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c19so6958806lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:12:23 -0700 (PDT)
X-Received: by 2002:ac2:563c:: with SMTP id b28mr5172811lff.93.1562951543423;
 Fri, 12 Jul 2019 10:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190627204446.52499-1-evgreen@chromium.org> <CAFqH_53cmq+1Y_uL3D4-84v_vDJsoB0Qxr_zTVnOzX1XD7VEgQ@mail.gmail.com>
 <20190701060137.GB4652@dell> <14282971-65b1-f7db-26b9-d33636054ba6@collabora.com>
 <CAE=gft6e46pL4-4eC5LPUgePj4ibWzJPzKHJ3_oeFuwoM0K+QQ@mail.gmail.com>
In-Reply-To: <CAE=gft6e46pL4-4eC5LPUgePj4ibWzJPzKHJ3_oeFuwoM0K+QQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 12 Jul 2019 10:11:47 -0700
X-Gmail-Original-Message-ID: <CAE=gft5yfO5-6bTcHE4HKs4FV=Z4E43xQLe9TWfSAcvpOREyXQ@mail.gmail.com>
Message-ID: <CAE=gft5yfO5-6bTcHE4HKs4FV=Z4E43xQLe9TWfSAcvpOREyXQ@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: Expose resume result via debugfs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:04 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Mon, Jul 1, 2019 at 6:41 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> >
> >
> > On 1/7/19 8:01, Lee Jones wrote:
> > > On Thu, 27 Jun 2019, Enric Balletbo Serra wrote:
> > >
> > >> Hi Evan, Lee,
> > >>
> > >> Missatge de Evan Green <evgreen@chromium.org> del dia dj., 27 de juny
> > >> 2019 a les 22:46:
> > >>>
> > >>> For ECs that support it, the EC returns the number of slp_s0
> > >>> transitions and whether or not there was a timeout in the resume
> > >>> response. Expose the last resume result to usermode via debugfs so
> > >>> that usermode can detect and report S0ix timeouts.
> > >>>
> > >>> Signed-off-by: Evan Green <evgreen@chromium.org>
> > >>
> > >> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > >>
> > >> Lee, actually this patch depends on some patches from chrome-platform
> > >> to apply cleanly. Once is fine with you and if you're happy to have
> > >> this merged for 5.3, I can just carry the patch with me, shouldn't be
> > >> any conflicts with your current changes or if you prefer I can create
> > >> an immutable branch for you.
> > >
> > > I won't be taking any more patches this cycle, so if you're sure that
> > > it does not conflict, there is no need for an immutable branch.
> > >
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > >
> >
> > Thanks Lee.
> >
> > I think the patch is simple enough, I queued for the autobuilders to play with,
> > and if all goes well I'll add for 5.3 via chrome-platform.
> >
>
> I was hoping to pick this patch from a maintainer's tree, has it
> landed anywhere?
> -Evan

Nevermind, it's all the way in Linus' tree. Sorry for the spam, and
thanks Benson for the heads up!
-Evan
