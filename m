Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7654C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5688205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S1pcckDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437194AbfHBWGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:06:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33066 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbfHBWGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:06:22 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so14240622iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1/TWolFXkF8n2eakMCgD8REetrsPK1Bg0dwz0uiBOo=;
        b=S1pcckDyJb9GvtnM13jO0KGslGXPD9H0rnb+8XDVqX6CheVsa05tK/aQNMmsAe2A/P
         /G+HKz3RBgzlhu2zYgkT2htRac/DFbkS12g6bnSOXsKwxPt1IbE2TDgIi4Mvfbow/eyn
         owD1uNS1RXoopTjvWMHX6lk0HBVQ6aYEiBst8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1/TWolFXkF8n2eakMCgD8REetrsPK1Bg0dwz0uiBOo=;
        b=Ddsya06wuNMP/vQoRzJalGFWbogN3SBTIa5GSlWbU1HFsLJhaALZQQteYp6tG/byBM
         7jCe76DwMGzB0Vps+cq+6fIHYNIFDtmL2f7Wj4n09Ygg0ICLUXfYkrYA7/+YNBfrvaq/
         04NbDR6DT+KUSLSR3LEJbtCRoDXl9tU2q0XP+GxZEabHHq+uVKA2Imckd9KbUZDc5UGa
         3Dv/1edsdU9n/OQAqTSvNev8R/Pc1k76YEH8oMvDB9P9aLQ412izJR/MLFVNHlBjLW9I
         iMjwTTVblTl+bjZsWqkueKBVzRLr8ysqB0aokH+aihP3Jmohwyx7qDVGBVWpdDOMPj/L
         2GCQ==
X-Gm-Message-State: APjAAAUdaN6xQkFr4f9BJQ9BhlAtbtWPaQ1JP1zl7Krfend+0A5s8qFu
        IaS6ps6c6kHNNpFVFUDJi5/wJNkCHzO+ZZfwy/7EXQ==
X-Google-Smtp-Source: APXvYqwfJxGSyk20XhVriQcgXAR0bh1eRgAJfMy7uLCjUEAjkHspS2zZ1jtdkNULZoSMvIHicrHdGDptsZClGQBuPWY=
X-Received: by 2002:a02:c916:: with SMTP id t22mr3112765jao.24.1564783581127;
 Fri, 02 Aug 2019 15:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190802213756.GA20033@lst.de>
In-Reply-To: <20190802213756.GA20033@lst.de>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 2 Aug 2019 15:06:10 -0700
Message-ID: <CAJs_Fx45VtKe52eTuAUcqSUTrY=892OwhCZNrLGoQHHBwETCdQ@mail.gmail.com>
Subject: Re: please revert "drm/msm: Use the correct dma_sync calls in msm_gem"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Sean Paul <seanpaul@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 2:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Rob,
>
> I just saw your above commit in Linus' tree, which is completely
> bogus and misunderstand the DMA API. Next time you have any issues
> please Cc the relevant maintainers and mailing lists.  But even
> more importantly get_dma_ops is an completely internal API, and
> whatevet your helpers are trying to do is bad - if the dma wasn't
> mapped at the time you call the new sync_for_device helper, this
> is broken because you can't call dma_sync_sg_for_device on unmapped
> address.  If it was mapped it is bogus as well as you can't double
> map it.  Please describe what you're actually trying to fix and we're
> going to work on a proper solution, but this shot from the hip is just
> going to make things worse.

Sorry, this is just a temporary band-aid for v5.3 to get things
working again.  Yes, I realize it is a complete hack.

The root problem is that I'm using the DMA API in the first place.  I
don't actually use the DMA API to map buffers, for various reasons,
but instead manage the iommu_domain directly.

Because arm/arm64 cache ops are not exported to modules, so currently
I need to abuse the DMA API for cache operations (really just to clean
pages if I need to mmap them uncached/writecombine).  Originally I was
doing that w/ dma_{map,unmap}_sg.  But to avoid debug splats I
switched that to dma_sync_sg (see
0036bc73ccbe7e600a3468bf8e8879b122252274).  But now it seems the
dma-direct ops are unhappy w/ dma_sync without a dma_map (AFAICT).

(On some generations of hw, the iommu is attached to the device node
that maps to the drm device, which is passed to dma_map/dma_sync.  On
other generations the iommu is attached to a sub-device.  Changing
this would break dtb compatibility.. so for now I need to handle both
iommu-ops and direct-ops cases.)

For v5.4, my plan was to revisit (at least for arm64) exposing cache
ops to drivers, so I can use drm_clflush_* instead, and stop abusing
DMA API.

BR,
-R
