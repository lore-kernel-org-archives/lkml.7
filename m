Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58832C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6B22BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jI+NycjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbfGYPmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:42:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38685 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389265AbfGYPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:42:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so15846227edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNkXECJCwZrlY0TNH7A1b2lGWt3otavBoyZrTznJtcA=;
        b=jI+NycjUP6dxobiyu7dooewJyiMPSKnZuEAR9QAAdHorsKKv9zQty8Zi/e3mTuuwTw
         f+5REnTryYYRy7SGL9GubSQdxHJJASl9Ylgtuj/XQKjHnxc3LR3PA0ZTh3KESVVHAP0l
         b+ZmbxdwQ8OgMxYul7lgpNzEHZXSO/mmnFCbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNkXECJCwZrlY0TNH7A1b2lGWt3otavBoyZrTznJtcA=;
        b=sBq/WxA9IQ86NGuFc/wwKY1Le9tysCZ2ZNBWrlOnYKlFEkrdAkC0fxiPZt9OpC7q3g
         Xhb196ZvEChmMjxLxuvoBnlh5Fdr3renYqH1zHdjGaCpNsKf4uBYG7V0yhU4BiFhXqfn
         fLkzAs6a2/4pDCRf6dZuBICV5r7HtF9NOT6p+nXv+gEtaXGcKW1/xDk9PyIjGBdjiVG4
         siUDhxmyTGGUjSKnvZ0c0rkngdQfD3HrspIaL6F7KzcIRy9ctbeYNe5FgBuHDIrnA8k7
         zvrJzoqIp0io2wGMVggm9OqRnJANkMjVgE+/6YsIg5V9lcAzaUq60jVdTlLRGhmqcYh+
         p6Iw==
X-Gm-Message-State: APjAAAXf2t+ujfaNx5bK5L4cxlpSGx+k7DCdTwEO8688py9lW5Gexobh
        zzfOzCyTVTkDDp8PsYNoGKen6rOvxrRL5A==
X-Google-Smtp-Source: APXvYqwkQpqC/Uc8NuGdcCroZPVdgqHvEITX9s8vt8veyNhChwTo90hnZuTsko3X/1mEebdfkMsxHA==
X-Received: by 2002:a50:c081:: with SMTP id k1mr77138843edf.19.1564069323506;
        Thu, 25 Jul 2019 08:42:03 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id uz27sm9849717ejb.24.2019.07.25.08.42.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 08:42:02 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id f17so45152875wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 08:42:02 -0700 (PDT)
X-Received: by 2002:a1c:343:: with SMTP id 64mr77603832wmd.116.1564069321964;
 Thu, 25 Jul 2019 08:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190725141756.2518-1-ezequiel@collabora.com> <20190725141756.2518-2-ezequiel@collabora.com>
 <1564069001.3006.1.camel@pengutronix.de>
In-Reply-To: <1564069001.3006.1.camel@pengutronix.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 26 Jul 2019 00:41:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BxQJBNqMnS1bCVXz-9+dCkw0g4xmiPLYgtVCJx_pbRPg@mail.gmail.com>
Message-ID: <CAAFQd5BxQJBNqMnS1bCVXz-9+dCkw0g4xmiPLYgtVCJx_pbRPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] media: hantro: Set DMA max segment size
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>, kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 12:36 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Thu, 2019-07-25 at 11:17 -0300, Ezequiel Garcia wrote:
> > From: Francois Buergisser <fbuergisser@chromium.org>
> >
> > The Hantro codec is typically used in platforms with an IOMMU,
> > so we need to set a proper DMA segment size.
>
> ... to make sure the DMA-mapping subsystem produces contiguous mappings?
>
> > Devices without an
> > IOMMU will still fallback to default 64KiB segments.
>
> I don't understand this comment. The default max_seg_size may be 64 KiB,
> but if we are always setting it to DMA_BUT_MASK(32), there is no falling
> back.
>

DMA mask and segment size are two completely orthogonal parameters.
Please check https://elixir.bootlin.com/linux/v5.3-rc1/source/drivers/iommu/dma-iommu.c#L740
for an example of how the latter is used.

Best regards,
Tomasz
