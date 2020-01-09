Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7EC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B97F2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 06:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgAIG6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:58:45 -0500
Received: from mail.manjaro.org ([176.9.38.148]:37720 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgAIG6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:58:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 4F46036E4E03;
        Thu,  9 Jan 2020 07:58:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id INa9G9XjTyTz; Thu,  9 Jan 2020 07:58:40 +0100 (CET)
Subject: Re: [PATCH 1/1] drm/rockchip: fix integer type used for storing dp
 data rate and lane count
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     David Airlie <airlied@linux.ie>, Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200108223949.355975-1-t.schramm@manjaro.org>
 <20200108223949.355975-2-t.schramm@manjaro.org> <2028959.b8b8FNkPgY@diego>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <2b02f9e1-5aa0-9d21-16e4-251fffbb736a@manjaro.org>
Date:   Thu, 9 Jan 2020 07:56:05 +0100
MIME-Version: 1.0
In-Reply-To: <2028959.b8b8FNkPgY@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.01.20 um 01:15 schrieb Heiko Stübner:
> Am Mittwoch, 8. Januar 2020, 23:39:49 CET schrieb Tobias Schramm:
>> commit 2589c4025f13 ("drm/rockchip: Avoid drm_dp_link helpers") changes
>> the type of variables used to store the display port data rate and
>> number of lanes to u8. However u8 is not sufficient to store the link
>> data rate of the display port.
>> This commit reverts the type of both the number of lanes and the data
>> rate to unsigned int.
>>
>> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
>> ---
>>  drivers/gpu/drm/rockchip/cdn-dp-core.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
>> index 83c4586665b4..806cb0b08982 100644
>> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
>> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
>> @@ -94,8 +94,8 @@ struct cdn_dp_device {
>>  	struct video_info video_info;
>>  	struct cdn_dp_port *port[MAX_PHY];
>>  	u8 ports;
>> -	u8 max_lanes;
>> -	u8 max_rate;
>> +	unsigned int max_lanes;
> 
> although I would think u8 should be enough for max_lanes?
> There shouldn't be be more than 255 dp lanes?

True. I'll test and send a v2.

Thanks, Tobias

> 
> Heiko
> 
>> +	unsigned int max_rate;
>>  	u8 lanes;
>>  	int active_port;
>>  
>>
> 
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
