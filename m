Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B137C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2669214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1uaN/ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfILOFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:05:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33743 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732447AbfILOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:05:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id o9so24112451edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ha/ksfChi40fvWXvJ2Pp1OUPpzkomxxm5i7dcskz7Q0=;
        b=N1uaN/ryzApCA4SADojux1E9zO7nn0OPjjEhdzhTt0JKsMtlgusANPx2drUgpBAlLs
         SoZeqeON7maPDbM+8sK+uV/VnXPnMhc5g1bliSnosSXlo6RK5RwkdtVIW7Qp0ctU+sSL
         QIWvxhqIgpV8zoKpYk8nnZDbkc4QWsB8IV8IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ha/ksfChi40fvWXvJ2Pp1OUPpzkomxxm5i7dcskz7Q0=;
        b=Jv5rqHH0jIwk3j4PF6LxFJtjx6P9XLkoMe3lXEM6q9p1mINRgbH6NBClZSahNB2h3N
         we130suHIAo4DtjaeXMNTx3anbRmMbOEGIIXcPs9McJ2Z/lUOqY/nvPPSVSkI7iVYEZt
         XxHWFjyiiiLJr3zjMmBFXofrV4ZGYHh976meHWTaVhXghG4WZO2HzRiN+41LfW9OXrqM
         Ucct2wyWb112rn/wiEisc02A5mrpyEHxWdGkC77ZWC28Z26ygqPM15fYv5PArgLLGux6
         9q3KDT8kJ0adyRJY6jy8NWolRRTGelFSvyfzIGrJnie/49uyFwdTt1g6zFxoDqZfPz7J
         V8ow==
X-Gm-Message-State: APjAAAXI0gHCBeLRrONxJq2peB6EC9cZBwU6h7imLAULXaRdkejRpvXT
        rSbeXFWOw2kKoT/G0DqJoEpGIT4C/zenAQ==
X-Google-Smtp-Source: APXvYqzON2KHQQFke0uoToGCzmU/fr4R5bJ2Z/iyiiwEFdbuad3PtWsUv3lXaIIGsaZvtC5xYV6y2Q==
X-Received: by 2002:a05:6402:651:: with SMTP id u17mr34830937edx.59.1568297112249;
        Thu, 12 Sep 2019 07:05:12 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id f4sm4564572edf.47.2019.09.12.07.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 07:05:11 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id h7so27599263wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 07:05:11 -0700 (PDT)
X-Received: by 2002:a05:6000:1082:: with SMTP id y2mr35193821wrw.77.1568297110781;
 Thu, 12 Sep 2019 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190912094121.228435-1-tfiga@chromium.org> <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
In-Reply-To: <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 12 Sep 2019 23:04:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
Message-ID: <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stevensd@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Thu, Sep 12, 2019 at 9:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > To seamlessly enable buffer sharing with drivers using such frameworks,
> > make the virtio-gpu driver expose the resource handle as the DMA address
> > of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> > resource handle is a kind of DMA address already, as it is the buffer
> > identifier that the device needs to access the backing memory, which is
> > exactly the same role a DMA address provides for native devices.

First of all, thanks for taking a look at this.

>
> No.  A scatter list has guest dma addresses, period.  Stuffing something
> else into a scatterlist is asking for trouble, things will go seriously
> wrong when someone tries to use such a fake scatterlist as real scatterlist.

What is a "guest dma address"? The definition of a DMA address in the
Linux DMA API is an address internal to the DMA master address space.
For virtio, the resource handle namespace may be such an address
space. However, we could as well introduce a separate DMA address
space if resource handles are not the right way to refer to the memory
from other virtio devices.

>
> Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
> context.  virtio-gpu resources are not required to be physically
> contigous in memory, so typically you actually need a scatter list to
> describe them.

There is no such requirement even on a bare metal system, see any
system that has an IOMMU, which is typical on ARM/ARM64. The DMA
address space must be contiguous only from the DMA master point of
view.

Best regards,
Tomasz
