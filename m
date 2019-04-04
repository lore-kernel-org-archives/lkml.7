Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BCCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9C5206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Wq9XMcQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfDDLpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:45:20 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:55220 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=m5hGgWKj5guZbjtv86sKgv6BKMcG4UtlinPlkaJBtQM=;
        b=Wq9XMcQe2kWzm1GjS3jYf9rkDAiFae3tQR0Syb6kSMPUnpTBKlphogbwdwr8aQg0W2qBfWjbaB2HBM/spQ6tMLE43Zj6pOj2BmiOkFiENyM6Rw0L8oynFbd8vGwX9w0tO75NEKcqAJ3N13Ohlxf4RcMh2Zo+4elDYSC18+LF96eD7yU40GTPoXwkgRPmnL0fygZr3u6NDx0dsQ4lQNW1eXyrwHm3z86L7GiauG6CaKH4H44kiP/k9hNXa0nSrH2SljMDq6mtzkaArlb616xixvlU91KWguIxWfgoZeePegvkXbyry8g+UcYgpLDLydM+ciHFLz4+lLI0ZD8zqN38tQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:62338 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hC0o1-0004RS-SU; Thu, 04 Apr 2019 13:45:17 +0200
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
 <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
 <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
 <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
 <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
 <2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
 <20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <5ad479ea-a95f-b66b-20b6-5da41e2cee9a@tronnes.org>
Date:   Thu, 4 Apr 2019 13:45:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 04.04.2019 12.27, skrev Gerd Hoffmann:
>   Hi,
> 
>>> tinydrm_xrgb8888_to_*
>>>
>>> imo these could be put into some drm_format_helpers.c to be shared.
>>
>> I agree, my long term goal is to get rid of tinydrm.ko. Just haven't got
>> there yet.
>>
>> Gerd, if you end up using some of those functions, feel free to move
>> just those you need and I can do the rest later. But if you have time to
>> spare I wouldn't mind getting all of them moved ;-)
> 
> For now I just promoted cirrus to be a tinydrm driver ;)
> 
> Noticed that those helpers (including tinydrm_memcpy for the
> non-converting case) apply clipping on the source but not on
> the destination.  So, for fullscreen updates that works ok,
> but for updating sub-rectangles it doesn't ...

Ah yes, these MIPI type controllers support setting the destination
window in controller RAM for the incoming buffer so there has been no
need for clipping on the destination buffer.

> 
> So I guess I have to add a dest_clip bool parameter when moving them.
> /me looks for a good place.  drm_fb_helpers.c I think.
> 
> cheers,
>   Gerd
> 
