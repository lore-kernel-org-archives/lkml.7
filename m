Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFC520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="mR/MMpPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfDJJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:45:05 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:49080 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfDJJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=LAaD4g1HdSPwZGUD42rfBbgK3pIGBTQq+sMlHWof2rs=;
        b=mR/MMpPmc5Hz+KA6C9iAG/G+O4fpM7U22fCBgfq65vyjJ+QQetXCFwxm8qIMLTjnc5MfuLJjcgTQ5D4A0x0ydhlQQ61ChmTNa8wQ2epI3SijRO0/8GplFmPsaYSgxS898gXchb6Y+6OrNVh27bPnhWj80MkfOzmOJkisXed8abA4KP2D6jPvSYT478fHA8oHIJOFEF8InJS2/z9flMTko3kemNwKkUItPyzQkq7XCSBrPDMuOz1jNcaVlD6eXz9scqE1tzQYZYfj7Zt/hlfpjtzd/agT3c+20zUYopmeNenEAS2oVM95Cc7WbA5XjAJPGl6NLgVr8V8LvXNMoJ/4lQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51269 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hE9mv-0001oJ-VL; Wed, 10 Apr 2019 11:45:01 +0200
Subject: Re: [PATCH v2 3/3] drm: switch drm_fb_xrgb8888_to_rgb888_dstclip to
 accept __iomem dst
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
References: <20190410063815.17062-1-kraxel@redhat.com>
 <20190410063815.17062-4-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <cb9f6d26-b169-1872-7d52-584d3f1daf62@tronnes.org>
Date:   Wed, 10 Apr 2019 11:45:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410063815.17062-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.04.2019 08.38, skrev Gerd Hoffmann:
> Not all archs have the __io_virt() macro, so cirrus can't simply convert
> pointers that way.  The drm format helpers have to use memcpy_toio()
> instead.
> 
> This patch makes drm_fb_xrgb8888_to_rgb888_dstclip() accept a __iomem
> dst pointer and use memcpy_toio() instead of memcpy().  The helper
> function (drm_fb_xrgb8888_to_rgb888_line) has been changed to process a
> single scanline.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
