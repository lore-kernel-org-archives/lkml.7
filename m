Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6778B2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OYKlUNiw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NsCx2Qmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfC0Otp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:49:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfC0Oto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:49:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3271B60E5F; Wed, 27 Mar 2019 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553698183;
        bh=HvCyUfOCBKmAaByccJ3+Wont3VUgVT3KZaPar6dTAN4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OYKlUNiwtZ8M5V2RHY1CiteJFdaZWSHzbTGJI4bTkgqXuxEW/h5WffOB1k8UUntBp
         NjD4u4Vep2s87FORClsvGldiI+De08RrrOAYiqiLcNG/rU5R/Y5zKNiIOB+6HASBCm
         PZVt7XjMosJOpaKu3EVnNnPGyBYErFBsYkJpJuWU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BB266086B;
        Wed, 27 Mar 2019 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553698178;
        bh=HvCyUfOCBKmAaByccJ3+Wont3VUgVT3KZaPar6dTAN4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NsCx2QmgY97YDIoNG7jCM5P04zsFQHzJu4wsK707w15OlusOtZh7k2mL5ZkxZOKDE
         cg5XUoxxHTuPjAytHyis6EHbgsTe7lLS3bVX2imKKnEuGMoYTRHT+2wfwsmUX1Tj1o
         mWl41JRmXcbTzYIPE5oUu8MKHZgaNkX3n2rnF3QE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BB266086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] vc04_services: vchiq_arm: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Elwell <phil@raspberrypi.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Tobias_B=c3=bcttner?= <tobias.buettner@fau.de>,
        Eric Anholt <eric@anholt.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, pakki001@umn.edu,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190324224331.1163-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e04a034b-98e2-ed4b-22d9-833c5d950e18@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:19:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324224331.1163-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 4:13 AM, Kangjie Lu wrote:
> When kzalloc fails, "platform_state->inited = 1" is a NULL pointer
> dereference. The fix returns VCHIQ_ERROR in case it failed to
> avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c  | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> index dd4898861b83..0f12fe617575 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -209,6 +209,8 @@ vchiq_platform_init_state(struct vchiq_state *state)
>   	struct vchiq_2835_state *platform_state;
>   
>   	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
> +	if (!state->platform_state)
> +		return VCHIQ_ERROR;
>   	platform_state = (struct vchiq_2835_state *)state->platform_state;
>   
>   	platform_state->inited = 1;
