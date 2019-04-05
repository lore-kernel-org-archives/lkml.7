Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A9AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9706E20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Rc7GDfrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfDEOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:43:11 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:34818 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=AtyjFUG13+8wdGIbCPo7RfU9BUMpU5HTwvp3tG0LWgo=;
        b=Rc7GDfrXS5Dde2vlet2JHLLNQ+4Uv9JFxQzo3hKnUt0j3t6bWONpnHspt8mpb6x8x+gFvZfxavjj6KGmlCpJJ2FpSsXwh4yiBiuB4KPz1XcwCkuhr9wQjyxIwCpd+M/8zyqK9mGznPGX4xstjxNgRAozg9o0ZFgGFK6xvZwPpYac3cL1Oa4c9px1pEWm9ZF1bw5a0goDQTTJSNP3DnYymq1vehuF05I7VHWvg6ZemE0OOVbmX3wfg83uqwet7j8h0lvhDI0/4+ebPrbPX8MXCvD9k4yvNRiQlJfcB99+SZw3ZPju7B+QtNUo1mKXm/awB84nBnzARes8jxCNCBMTAQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:17486 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hCQ3h-0005Qr-Bh; Fri, 05 Apr 2019 16:43:09 +0200
Subject: Re: [PATCH v3 5/5] drm/cirrus: rewrite and modernize driver.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
References: <20190405095219.9231-1-kraxel@redhat.com>
 <20190405095219.9231-6-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b52ffab7-bc9d-9ce1-4c46-d6fd9b9aefe9@tronnes.org>
Date:   Fri, 5 Apr 2019 16:43:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405095219.9231-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 05.04.2019 11.52, skrev Gerd Hoffmann:
> Time to kill some bad sample code people are copying from ;)
> 
> This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> function is pretty much the only function which is carried over largely
> unmodified.  Everything else is upside down.
> 
> It is a single monster patch.  But given that it does some pretty
> fundamental changes to the drivers workflow and also reduces the code
> size by roughly 70% I think it'll still be alot easier to review than a
> longish baby-step patch series.
> 
> Changes summary:
>  - Given the small amout of video memory (4 MB) the cirrus device has
>    the rewritten driver doesn't try to manage buffers there.  Instead
>    it will blit (memcpy) the active framebuffer to video memory.
>  - All gem objects are stored in main memory and are manged using the
>    new shmem helpers.  ttm is out.
>  - It supports RG16, RG24 and XR24 formats.  XR24 gets converted to RG24
>    or RG16 at blit time if needed, to avoid the pitch becoming larger
>    than what the cirrus hardware can handle.
>  - The simple display pipeline is used.
>  - The generic fbdev emulation is used.
>  - It's a atomic driver now.
>  - It runs wayland.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
