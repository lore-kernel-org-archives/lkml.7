Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC048C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD97E2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgAIOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:14:40 -0500
Received: from verein.lst.de ([213.95.11.211]:54875 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731559AbgAIOOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:14:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 30C4468C4E; Thu,  9 Jan 2020 15:14:37 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:14:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     hch@lst.de, DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: Regression in 5.4 kernel on 32-bit Radeon IBM T40
Message-ID: <20200109141436.GA22111@lst.de>
References: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <400f6ce9-e360-0860-ca2a-fb8bccdcdc9b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Woody,

sorry for the late reply, I've been off to a vacation over the holidays.

On Sat, Dec 14, 2019 at 10:17:15PM -0500, Woody Suwalski wrote:
> Regression in 5.4 kernel on 32-bit Radeon IBM T40
> triggered by
> commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Aug 15 09:27:00 2019 +0200
>
> Howdy,
> The above patch has triggered a display problem on IBM Thinkpad T40, where 
> the screen is covered with a lots of random short black horizontal lines, 
> or distorted letters in X terms.
>
> The culprit seems to be that the dma_get_required_mask() is returning a 
> value 0x3fffffff
> which is smaller than dma_get_mask()0xffffffff.That results in 
> dma_addressing_limited()==0 in ttm_bo_device(), and using 40-bits dma 
> instead of 32-bits.

Which is the intended behavior assuming your system has 1GB of memory.
Does it?

> If I hardcode "1" as the last parameter to ttm_bo_device_init() in place of 
> a call to dma_addressing_limited(),the problem goes away.

I'll need some help from the drm / radeon / TTM maintainers if there are
any other side effects from not passing the need_dma32 paramters.
Obviously if the device doesn't have more than 32-bits worth of dram and
no DMA offset we can't feed unaddressable memory to the device.
Unfortunately I have a very hard time following the implementation of
the TTM pool if it does anything else in this case.
