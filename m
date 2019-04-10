Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06442133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfDJObj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:31:39 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:60620 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732287AbfDJObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:31:39 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EEGGhlRpONG8zEEGHh1bQt; Wed, 10 Apr 2019 16:31:37 +0200
Subject: Re: [PATCH 0/7] media: atmel: atmel-isc: new features
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        Nicolas.Ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
Cc:     ksloat@aampglobal.com
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <588f729b-0234-0019-ec40-54aa8a89da6b@xs4all.nl>
Date:   Wed, 10 Apr 2019 16:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM0Njr35yidXKzq3/GsxEx02j11xyiksh7QgG3EN5+/0SgKH0jXvCwXf+c3WaFvYfmKf+qK1kvQ8ShZy2B84RNN6aS4dS7ZFfq+rETQ/ZDXe2lVmyh4L
 eaq1YLKL4YfHrOKTW93u/d6c53vWPWr5qgyc8N+THzTSwu+6M2pGIOKt9ggxL85V5aMQyJXK6dIkl75tS6lWEqmWE2yiCMd8lnTJX3EywMVWWrYJulETcRyq
 a7FoZEACK0fN1noeG+m12DeC4FznlUzAGiQ7UV0/Ri6QnHaM42Y5jyVV6ZJdt9T5NWM+re2s20qrK0zAsrdVyAo7H9RxaXwEfUZmScSx+2q3a1C9EzbWnn1G
 PUAen2KQBEpdfKtdvXn6EyoqY5hnF4o/YIk9CJBw65NwrVbXCiPfr7yRMD329+Etd0HeIyBSFWr+HU8EP0opC6ZyzLGKv++eLWiAU3VV/YUinv9tc0xJkRN/
 Tb9tafF2VeiGfzjJDnicewjZFLqQCkD2noEvZEx1zbXGxCedQIpwjOPDEGs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 1:07 PM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This series includes feature rework, feature additions and bug fixes for the
> atmel-isc driver.
> It applies only on top of my previous patchset:
> media: atmel: atmel-isc: removed ARGB32 added ABGR32 and XBGR32
> media: atmel: atmel-isc: reworked driver and formats
> available at:
> https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=for-v5.2b&id=03ef1b56cba6ad17f6ead13c85a81e0e80fbc9d1
> 
> One open question is regarding the WHITE_BALANCE error returns: it would seem
> logical to return EAGAIN or EBUSY, but this is not compliant with
> v4l2-compliance.
> Does it make sense to return success on every occasion? even if the
> DO_WHITE_BALANCE does nothing?
> In this series I used the return EAGAIN or EBUSY from the v4l2-ctrls, but I
> can change if always success is a better way of returning (even if normally
> a return value serves this exact purpose - return some code )

See my comments. Use v4l2_ctrl_activate() instead to mark controls active
or inactive and the control framework will do the rest.

I think it would speed up matters if you split up your series: one series
containing just fixes (I can merged those quickly) and one for the new
functionality.

Regards,

	Hans

> 
> Eugen Hristev (7):
>   media: atmel: atmel-isc: add safe checks and fixed wrong ISC state in
>     error case
>   media: atmel: atmel-isc: reworked white balance feature
>   media: v4l2-ctrl: fix flags for DO_WHITE_BALANCE
>   media: atmel: atmel-isc: add support for DO_WHITE_BALANCE
>   media: atmel: atmel-isc: limit incoming pixels per frame
>   media: atmel: atmel-isc: fix INIT_WORK misplacement
>   media: atmel: atmel-isc: fix asd memory allocation
> 
>  drivers/media/platform/atmel/atmel-isc-regs.h |  25 +-
>  drivers/media/platform/atmel/atmel-isc.c      | 346 +++++++++++++++++++++++---
>  drivers/media/v4l2-core/v4l2-ctrls.c          |   1 +
>  3 files changed, 336 insertions(+), 36 deletions(-)
> 

