Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B41C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE1206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="sCUtZwtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfDDShn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:37:43 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:51965 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbfDDShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=KSVLOLm6nDDYuypOIW6oh5HRGfAOsVMau0Q71I5+a7w=;
        b=sCUtZwtxelEiJKjpb8iSK8E8joLz02joXGzsONNefvAwWn+V6ql/RrgGwExa8ibwODinDqoyMgE07Q65qjAD0SmWL6KxtfMrP2K84jh0FHY9wi0cZfYxmoYa3RxGpimsUq+zQe6Gp0/ymLIYsqzmWKSxBq+VqupDF+rZsVQHYfTc1Hjf1QDLQeMCPzv0qxYLopYbzLAU3v6giFHRSrPUHy7iSjL1BEgVdpJv+HsUjaoy2uo63+IoLY9AeWdeo2TCG5aEryeTjxitZvMQXFvOj6AYFQ4QtK9LmnVipuUfsZdTMiDD0qbL+AYFTsCaDrdtRILIQCSOuUzNBssVcHfTBw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51017 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hC7F6-0000gg-9t; Thu, 04 Apr 2019 20:37:40 +0200
Subject: Re: [PATCH v2 1/6] drm: move tinydrm_memcpy() to drm_fb_helper.c
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
 <20190404152430.8263-2-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <cc824eb5-f34f-3b53-8b3b-87b0a7751800@tronnes.org>
Date:   Thu, 4 Apr 2019 20:37:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404152430.8263-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 04.04.2019 17.24, skrev Gerd Hoffmann:
> Also rename to drm_fb_memcpy().
> Pure code motion, no functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fb_helper.h                   |  3 +++
>  include/drm/tinydrm/tinydrm-helpers.h         |  2 --
>  drivers/gpu/drm/drm_fb_helper.c               | 25 +++++++++++++++++++

drm_fb_helper.c is for fbdev code so not a good place for this code, and
it's MIT licensed as well.
Daniel have in two rounds suggested a new drm_framebuffer_helper.c or
drm_format_helper.c as possible destinations for these functions.

Noralf.
