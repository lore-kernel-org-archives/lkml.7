Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3380020830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="rh3l9hbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfDJJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:42:38 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:58898 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfDJJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=f3Ysy2SwmVD/tqb2y0QcMCx/5hMRO7/soZr9zhCS7jE=;
        b=rh3l9hbGbO22SXeVdpJYOLsp0y+QyxJRR7sRLux9r00iIsfv2YpcGstSMT5lzYyAORFKhuTBoo6KVbiCIFfQCnIP4SjDgsc/lx3pXuiVHiqZCHMkupM5GogxhN7sVnfh2n14LbAlehYntFlVv3dYMGdCbiwI7rYqZcInkw8nhGI2hdr5WKi3gDRTwSdSvAqTz6ikItxX+SbiIbCnp+pIY3x01hNlPaOTaE7xHnOq0hDI1tOamI0VpbmAGpCF1NTu6nuC3Oll8ma2qVcABzDE35cIlg0DSdog8IXNJ7a8NovQbCEj5sneCCO5DlFT3bwuIHNBcUDDkHbcGs4nMvbefQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51254 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hE9kZ-000121-R3; Wed, 10 Apr 2019 11:42:35 +0200
Subject: Re: [PATCH v2 1/3] drm: switch drm_fb_memcpy_dstclip to accept
 __iomem dst
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
References: <20190410063815.17062-1-kraxel@redhat.com>
 <20190410063815.17062-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <f73b4d2e-1767-3512-0a8a-d447a2f22639@tronnes.org>
Date:   Wed, 10 Apr 2019 11:42:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410063815.17062-2-kraxel@redhat.com>
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
> This patch makes drm_fb_memcpy_dstclip() accept a __iomem dst pointer
> and use memcpy_toio() instead of memcpy().  With that separating out the
> memcpy loop into the drm_fb_memcpy_lines() helper isn't useful any more,
> so move the code back into the calling functins.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
