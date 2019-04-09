Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84170C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52869214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554826536;
	bh=iqwfzav26qB7O1+vlrYQstVE06mZ7Z+Ix2PAnbjQjkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xj+MT17i4kzcfy23a6/jBMzVakzX4vktaBtAX5CAN8QXica3x2sOV/72aoi+KLr0r
	 kuaJ7Ubv2x4J34FsElDlDlag/g+AlnjEdvycM+gGG42SbUwgAdYoejoW+tOJnMoHBw
	 mOHbH2LjnsB62KQrbh+jIzvIBAxic5/X0nrPNHeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDIQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIQPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:15:34 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBD8218E2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2019 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554826533;
        bh=iqwfzav26qB7O1+vlrYQstVE06mZ7Z+Ix2PAnbjQjkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GSExMhgcALA5l1vO3G9FlqDb9didpbiR55HPteUKUuX1bhW+VVtLajp8vnqWeQoBJ
         +KPrwzNFZe7hW4q145SYxGS7Ba8UNMkBvPChv18i5rDVP7RN/4hbceHAL1OjJxvq0I
         mYoYfvwHh2+hBHPVEA1jQETvCZukKzNtt1wwqgZg=
Received: by mail-qt1-f169.google.com with SMTP id v20so20405390qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 09:15:33 -0700 (PDT)
X-Gm-Message-State: APjAAAVQFk/MtscGQs5wPn2wh4EY2nYHxB0jIXKplOegoIo4WySXSOTS
        e8CzKMTqTEk0n/juenIhqOvVef4Xti7iUtGsYQ==
X-Google-Smtp-Source: APXvYqyQgON6RncgFto+LtazyWMhak9Z6zYeKlyVMxRtYe0ujXd+VlItuD/tvgZ5cohgtmTimMrkPRkjDInIZd36Ly0=
X-Received: by 2002:ac8:3f6f:: with SMTP id w44mr29567542qtk.59.1554826532511;
 Tue, 09 Apr 2019 09:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com> <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
 <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
In-Reply-To: <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Apr 2019 11:15:21 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
Message-ID: <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 10:56 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> On Mon, 8 Apr 2019 at 23:04, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
> > >
> > > On 01/04/2019 08:47, Rob Herring wrote:
> > > > This adds the initial driver for panfrost which supports Arm Mali
> > > > Midgard and Bifrost family of GPUs. Currently, only the T860 and
> > > > T760 Midgard GPUs have been tested.
> >
> > [...]
> > > > +
> > > > +             if (status & JOB_INT_MASK_ERR(j)) {
> > > > +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
> > > > +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
> > >
> > > Hard-stopping an already completed job isn't likely to do very much :)
> > > Also you are using the "_0" version which is only valid when "job chain
> > > disambiguation" is present.
>
> Yeah, guess that can be removed.

Steven, TBC, are you suggesting removing both lines or leaving
JS_COMMAND_NOP? I don't think we can ever have a pending job at this
point as there's no queuing. So the NOP probably isn't needed, but
doesn't hurt to have it either.

> > > I suspect in this case you should also be signalling the fence? At the
> > > moment you rely on the GPU timeout recovering from the fault.
> >
> > I'll defer to Tomeu who wrote this (IIRC).
>
> Yes, that would be an improvement.

Actually, I think that would break recovery because the job timeout
will bail out if the done fence is signaled already. Perhaps we want
to timeout immediately if that is possible with the scheduler.

Rob
