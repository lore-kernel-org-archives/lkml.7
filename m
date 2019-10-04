Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C8C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DCF215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRUKKM0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfJDUZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:25:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34289 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbfJDUZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:25:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so4410743pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w4g0iJ9qE6GBqGrmQNHbJmYQGNfgSU66gamnsISgAnI=;
        b=LRUKKM0XrQrNsQOxFLOTCBk5GmF+LGwqWPGxk22YyKYEpMhIURnNk34uKwWOLfmvxk
         2nkMJu9D4/hhr/pqgmpWuqIY7xZMdk1emUAwY56fldOONHD/4KXs/GAI3JJuqKdN+pMF
         firZTjyRlPMmxPjOkQLePBXV8X4aNZfND5PgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w4g0iJ9qE6GBqGrmQNHbJmYQGNfgSU66gamnsISgAnI=;
        b=gkLdxXcu+cMTc+Jl4ibjKHNHep2GvqQMhoZyIOIIbm0gqYrUwSX4h5houB4s1/S4nH
         V4GhFTFKv4CJKaT91ZXc/Nhk3KB4Le9OnE5ydjg/lKi13Y/S0ybsWe3r6AF7UpYROBy1
         0wxC/KNQD9g/hPnZ0EwY16JFzUGFBEc6I448XRxqFlVJ39DOCbB1qyJM2Sm4YRDf7I6v
         QsniTZnaQpx1/tEh9So/dX1B3KOe906HABt3DEUvRf7OCgmF9QdX9djGkHT9GYSnT5GD
         s2dC4uwEC8dw5iWy7t9RGRz62rbVkx6IbI+2oHORPszlSHQtYKf9CwH+WwQpqjV+LVcI
         qLAQ==
X-Gm-Message-State: APjAAAX0mPyt+ibpOT3kNLFmuy2ytI1uh1m1wRSnJO9ADIEXrBPKAdA4
        ADZIci14UXfPCxmZkI56aQTelw==
X-Google-Smtp-Source: APXvYqyl6XnIpTwr3vnhilw9YEEZ6ArLoOcFdiuKfbUAULNxJ3PfJ2T0boH2Nz++hfXAJXe8DWondQ==
X-Received: by 2002:a63:1e16:: with SMTP id e22mr17500139pge.413.1570220757037;
        Fri, 04 Oct 2019 13:25:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j128sm10444222pfg.51.2019.10.04.13.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:25:56 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:25:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Lift address space checks out of debug code
Message-ID: <201910041323.F082AA4B19@keescook>
References: <201910021341.7819A660@keescook>
 <7a5dc7aa-66ec-0249-e73f-285b8807cb73@arm.com>
 <201910021643.75E856C@keescook>
 <fc9fffc8-3cff-4a6f-d426-4a4cc895ebb1@arm.com>
 <201910031438.A67C40B97C@keescook>
 <91192af8-dc96-eeb9-42ab-01473cf2b7c0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91192af8-dc96-eeb9-42ab-01473cf2b7c0@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:50:54PM +0100, Robin Murphy wrote:
> On 03/10/2019 22:38, Kees Cook wrote:
> > What do you think about the object_is_on_stack() check? That does a
> > dereference through "current" to find the stack bounds...
> 
> I guess it depends what the aim is - is it just to bail out of operations
> which have near-zero chance of working correctly and every chance of going
> catastrophically wrong, or to lay down strict argument checking for the API
> in general? (for cache-coherent devices, or if the caller is careful to
> ensure the appropriate alignment, DMA from a non-virtually-mapped stack can
> be *technically* fine, it's just banned in general because those necessary
> assumptions can be tricky to meet and aren't at all portable).

Okay, then since the vmap check is both the cheapest and the most
important to catch in the face of breaking everything, I'll move that
in and we can keep USB's other checks separately.

-- 
Kees Cook
