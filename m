Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872962173C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="N9m7QtGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCKOeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:34:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39876 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:34:05 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so4193854ior.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuDy07zjfmgQGY7yoGUjNkjH8AXSJgbX0uTI8815zOk=;
        b=N9m7QtGa9YQUzI1PE++BJNRXtJeKszr88G0bbEXxKxaE0mYGrV2RUlmiQMdl/hjgj1
         ZAvpnHWQq7F2Kaj62k9ka0ZMZpmaqZxK0G1ghWrrzCSBdxdCH7Sq8jh/ATCJdAsZMd29
         F5QBNNHZUyyLX4N47B1w8mu+oe2e3BvtH+s5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuDy07zjfmgQGY7yoGUjNkjH8AXSJgbX0uTI8815zOk=;
        b=MkdURuy81vguhX7gnbj64nJzykYzVjVY/HWW1zCT1N/SXawe9p2Y2wo+57wWtAlh1H
         ghaBqJp5Liy+8C3bBqzWoU1tah4rDZ/ibaq8/ZCx5tBcqhRPFNUDFigCzqGSspZg43OA
         rubrS5ENbYS7l7RxAuoVdKi379ZCrOI9unQBS1uq57M2f1BIIJ2fli8IWQh23kZ2wxAm
         farCwajiQ11ge8GrOL0AL9owbYlQzplcValwJGCkMA5wkbU09C1got1i1DT/MDtElSrG
         caGt95q+zQGVYTA4qKsSc7RsjnV1q3YkEko/uvsFEsWQYCs2oiZ3RlCiaa+RuNXectT6
         BCWg==
X-Gm-Message-State: APjAAAUlmdUkWXst4UyRQMByhOrwKISEiKUlP3mtiCbqFcgJ6fDgqwPU
        VyBiPTj0HA8l6PKTmcYmJ/rvfpYp8yh0Z042YNu7UQ==
X-Google-Smtp-Source: APXvYqwiZ6qLyR3oO6lG0MJykLIi3NZKRzgjRPbDZDjbYeN/y0BlWuMFqtWeiyVtcQlqfqTtMENq8pMiuhrskac5YnQ=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr9171899iob.114.1552314843606;
 Mon, 11 Mar 2019 07:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-4-jagan@amarulasolutions.com> <20190304154911.s6rcx6bzal5slcjk@flea>
 <CAMty3ZBVh_PTYB-HmLCUuRsH+4NU=CaeXdKtNYqEDHHZuRGCvw@mail.gmail.com> <20190311140402.ie7abxda6pizrybj@flea>
In-Reply-To: <20190311140402.ie7abxda6pizrybj@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 11 Mar 2019 20:03:52 +0530
Message-ID: <CAMty3ZAs_m4dt0_vWB8OVT-M_J21-t5y4Mj=yM9wt3Wu_ED0LQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] drm/sun4i: sun6i_mipi_dsi: Support vblk timing for
 4-lane devices
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 7:34 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Mar 07, 2019 at 09:33:38PM +0530, Jagan Teki wrote:
> > On Mon, Mar 4, 2019 at 9:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sun, Mar 03, 2019 at 11:05:25PM +0530, Jagan Teki wrote:
> > > > Like other dsi setup timings, or hblk for that matter vblk would
> > > > also require compute the timings based payload equation along with
> > > > packet overhead.
> > > >
> > > > But, on the other hand vblk computation is also depends on device
> > > > lane number.
> > > > - for 4 lane devices, it is computed based on vtotal, packet overhead
> > > >   along with hblk value.
> > > > - for others devices, it is simply 0
> > > >
> > > > BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
> > > > (from linux-sunxi
> > > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > > >
> > > > tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
> > > > dsi_vblk = (lane-tmp%lane);
> > > >
> > > > So, update the vblk timing calculation to support all type of
> > > > devices.
> > > >
> > > > Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
> > >
> > > You should be explaining which issue you faced, in which setup, what
> > > were its symptoms and how that solution is fixing it.
> >
> > No, it is not a fix, didn't specify either. it is vblk timings support
> > like others dsi timings.
>
> So it's not fixing anything, and this isn't a new feature
> either. What's the point then?

You can consider a feature, as comments says it's vblk support for
4-lane devices which doesn't be 0. don't know why you are asking like
a first time patch since it's commented before[1]

[1] https://patchwork.kernel.org/patch/10657543/
