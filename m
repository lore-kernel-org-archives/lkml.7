Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD94C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFEB20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCGJ2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:28:31 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43044 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:28:31 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so16270960qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1hkc2wlfr9EDw+JoiDngTMJSyanmuTkloMa1qx8TKg=;
        b=X0KEsMu9U08LwKKOLB44aybb1vTC68c/PMdPYZ99NkdakgedZkQx5Xj+5h8dRhqNqb
         6vynCeUWQ7egbkTkyLAzHALiVz6WmvAYanC+AtMIDhIRH6w/Jl+yORGF6JJkPOEUIqB6
         P3rGK2qu3GBo7CluQ3LzFev8LrIYWPRJ0c3NaCCbb6IAD1jvde5AZA9QJgcEWzg1Tsgg
         p1A9k8kW844VRdR4Ski4kqJyAAW0A1SxiKLOXjS6vd7LegZTBuSCxrZSvxXj0O7w8Wn9
         TqnSQU+k/na8JafiikAoXSKdp/ve3vhyA8SNPTvMI9XHg5lwxqDpLnhGKIh3nsBPzzAv
         gHzw==
X-Gm-Message-State: APjAAAW4AnoIEEx/6fHkA8wJ3JACZe3xE3YiYhe4u26++dJUVcyylris
        swpa0EbQ5SMYUiwKZVwq01JsN4l3JeHf1eimLYg=
X-Google-Smtp-Source: APXvYqzl53HB5GonTjSW/JUqKvMPTT8p6Feh8cSX+xAhrA2PZmRv3wHQLDCnHrk2qQQbTDeVS4/Z8HqtuAxHVFUEMek=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr9034062qtn.96.1551950910127;
 Thu, 07 Mar 2019 01:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20190307085246.1477426-1-arnd@arndb.de> <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
In-Reply-To: <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 10:28:12 +0100
Message-ID: <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2019-03-07 8:52 am, Arnd Bergmann wrote:
> >
> > -#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
> > +#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)
>
> I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter
> in most cases, but it could potentially happen at runtime where callers
> use a non-constant argument. However, it also means we don't need to
> special-case 64 any more (since that's there to avoid the same thing
> anyway), so we could simply flip that to handle 0 instead.

Yes, good idea.

> FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)",
> but that may not be to everyone's taste.

I like that. So shall we do this?

/*
 * Shifting '2' instead of '1' because of
 * https://bugs.llvm.org/show_bug.cgi?id=38789
 */
#define DMA_BIT_MASK(n)    (((n) == 0) ? 0ULL : ((2ULL<<((n)-1)))-1)

         Arnd
