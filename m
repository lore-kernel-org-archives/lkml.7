Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E45C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5307D2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfKFJlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:41:40 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59284 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfKFJlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:41:40 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5F7D11C0930; Wed,  6 Nov 2019 10:41:38 +0100 (CET)
Date:   Wed, 6 Nov 2019 10:41:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pascal Bouwmann <bouwmann@tau-tec.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 059/149] iio: fix center temperature of
 bmc150-accel-core
Message-ID: <20191106094138.62qkvhfpyf5brits@ucw.cz>
References: <20191104212126.090054740@linuxfoundation.org>
 <20191104212140.681522108@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104212140.681522108@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pascal Bouwmann <bouwmann@tau-tec.de>
> 
> [ Upstream commit 6c59a962e081df6d8fe43325bbfabec57e0d4751 ]
> 
> The center temperature of the supported devices stored in the constant
> BMC150_ACCEL_TEMP_CENTER_VAL is not 24 degrees but 23 degrees.
> 
> It seems that some datasheets were inconsistent on this value leading
> to the error.  For most usecases will only make minor difference so
> not queued for stable.
> 
> Signed-off-by: Pascal Bouwmann <bouwmann@tau-tec.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Minor miscalibration, and author specifically states it should not be
queued for stable. Yet, Sasha goes and queues it for stable. Why?

       	   	   	      	       	      	     	     Pavel

> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -125,7 +125,7 @@
>  #define BMC150_ACCEL_SLEEP_1_SEC		0x0F
>  
>  #define BMC150_ACCEL_REG_TEMP			0x08
> -#define BMC150_ACCEL_TEMP_CENTER_VAL		24
> +#define BMC150_ACCEL_TEMP_CENTER_VAL		23
>  
>  #define BMC150_ACCEL_AXIS_TO_REG(axis)	(BMC150_ACCEL_REG_XOUT_L + (axis * 2))
>  #define BMC150_AUTO_SUSPEND_DELAY_MS		2000
> -- 
> 2.20.1
> 
> 
