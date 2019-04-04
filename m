Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3312075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="XRsYxes9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDDKGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:06:16 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:48639 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=oMxen7sXc1WBJneb2cacQ9YGw31pOzasd22fxQJIahU=;
        b=XRsYxes9lzGFsGSr+l9u3eiNy6QYuKDHDMwQw/XUX4kzx+B/aUZF9RcQwuFjqo87DfOoYD99YUNTtazTI1ZfvZyFFVSRorNseeNzV072D+JuD0el/s/s2CQrwDlITJay7fH1dVJqGgRGZw3UyUyuHLrf49eCGemjZj2zBZgXkYFW8xpEJP4LC8rScDBBs4t/GrwD6ZHa2ctbADfFw3ioQjixBGCSJKVM+MCs6X/wKIwtqKf5ohCXGgZQWEwJX0vFkDGu9RNY4Zr9QEx3/knKo2GsCtQBNlDbQm//Gq8r1urgdUkebeMrBgA5h+9I3JPjxqeUtOzYaHJIz4J7Hw8mmA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:61712 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hBzG8-0007Vh-V9; Thu, 04 Apr 2019 12:06:12 +0200
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
To:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>,
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
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
Date:   Thu, 4 Apr 2019 12:06:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 04.04.2019 10.52, skrev Daniel Vetter:
> On Thu, Apr 4, 2019 at 10:30 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>>   Hi,
>>
>>>> Speaking of wayland:  Seems at least gnome-shell insists on using XR24.
>>>
>>> Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
>>> convert XR24 to other formats, for display not supporting anything
>>> else. Because userspace.
>>
>> Have a pointer to these helpers?  grepping around in drm didn't turn up
>> anything so far ...
> 
> tinydrm_xrgb8888_to_*
> 
> imo these could be put into some drm_format_helpers.c to be shared.

I agree, my long term goal is to get rid of tinydrm.ko. Just haven't got
there yet.

Gerd, if you end up using some of those functions, feel free to move
just those you need and I can do the rest later. But if you have time to
spare I wouldn't mind getting all of them moved ;-)

Noralf.

> From a quick look the xrgb8888_to_rgb888 is missing, but for a quick
> hack you can just use rgb565 to get going.
> -Daniel
> 
