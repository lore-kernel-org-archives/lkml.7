Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDCC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D865A20673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JuqzY1c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfFFIIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:08:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57708 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFIIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:08:25 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190606080823euoutp01ee36c428a88b0caf6297ae85bba25cb4~ljZG7A6T30575805758euoutp01M
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 08:08:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190606080823euoutp01ee36c428a88b0caf6297ae85bba25cb4~ljZG7A6T30575805758euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559808503;
        bh=c/gerDQkcKR8doaPOF0H2AdLIDtd5igL1h7NJQn+Cg4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JuqzY1c5ncxoHFrWEZGP41Ka6uDPwslGI3Wl10FncruPZThIErCR8D+wXCmrefd6r
         l8ANAV5b1oNcPryHuAJKKHFAksV9cd0oEsn48x10JiUiNziBDJEa64jNL1Zwkqe8Ls
         HJdSaFKb8JhBS2AhBAeHF0BnA1UkpSK2ja028/GM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190606080822eucas1p1432240c660a37266918c666787721582~ljZGPoVAq1908319083eucas1p1D;
        Thu,  6 Jun 2019 08:08:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 85.32.04298.5F9C8FC5; Thu,  6
        Jun 2019 09:08:21 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190606080821eucas1p2cbab58ec759edf9a4f8254fe46ee1289~ljZFSHpTj2100821008eucas1p2D;
        Thu,  6 Jun 2019 08:08:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190606080820eusmtrp22d482888c6fc3ed84794be49eb99e983~ljZFCjFib0559905599eusmtrp2M;
        Thu,  6 Jun 2019 08:08:20 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-38-5cf8c9f52db4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B9.A2.04140.4F9C8FC5; Thu,  6
        Jun 2019 09:08:20 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190606080819eusmtip2fc6bdfc496506998a20b632dad1af733~ljZD1KUff2890928909eusmtip2N;
        Thu,  6 Jun 2019 08:08:19 +0000 (GMT)
Subject: Re: [PATCH v3 03/15] drm/bridge: tc358767: Simplify polling in
 tc_link_training()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3c50e3e2-9fb8-6962-9988-32d14aa429b0@samsung.com>
Date:   Thu, 6 Jun 2019 10:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605070507.11417-4-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH/d3X7rTJdRoeLJRGBUn5iKAbmWQlXDJKCCpyUUuvVuqM3dQs
        KFHTaZaPsHC6jNDyEfnKcmJZU1oilqmVD0wRS6zMUlcaTXO7Sv73Oef7/Z1zvvCjcXkn6Uaf
        Vp/jNWpVlIKyJx6/nH2zydw6o/SZ1m9lk7U72CRjIskmacdJdqa7mWBfNJowtts8QbFD+l6M
        Tc8plrBdDYUUO/DxFcFWFvVROx24ruvXMG4obx7jDLoBCVegzSe5wasmjMuy+HCmnicYN1Xj
        zr3Oa8eCpUft/cL4qNNxvMbb/4T9qYm/KeTZWeZ8S/8rPBGNyDKQlAZmC3xLKcQykD0tZ0oR
        3BgdocRiGoEldX6xmELQmPmRXHrytjJHIgr3Ebz5k0WKxTiCwrJ5zOpyZpRw+0GKjV2YYJhM
        MthG4YwZg+edOTaBYjaApbaXsrKM8Yfu1q+4lQlmLTxK00usvJI5AoMvq0jR4wSt+SOElaUL
        /uKbFbY5OOMByXUFuMiu0DdSZEsEzLgEtB9yCfHuPTBW20GJ7AxfTI8kIq+GeUMRJvJlGCxN
        wcXHWgR1VQZcFLZDs+ntwhX0woYNUNngLbYDoKdxBrO2gXGEnnEn8QZHyH18CxfbMtCmykX3
        Ghhsr1sc6AolHWYqGyl0y5LplqXRLUuj+7/3DiLKkSsfK0RH8IKvmo/3ElTRQqw6wis0JroG
        Lfy0tjnTZD0yd540IoZGihUyqP6tlJOqOCEh2oiAxhUuMlX/tFIuC1MlXOA1Mcc1sVG8YESr
        aELhKrtoNxQiZyJU5/hInj/La5ZUjJa6JaIk+FmurmjSrT+TPlq461fc3PZ9CY4ebetKq70J
        y6FA9VhkWvj6wL0d4K7MbJvWtulqw0Pkx8I8mw/M7P4s7fmRfTc0K22YvfLhcFS8A2ac3SbU
        f08vnrAQfvtrvTYPB4zZPX32KeheS9hYZPm79w8P+sXpm+yCDCWXNvaVzbZ/DlIQwimVryeu
        EVT/AKvm/6xlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7pfTv6IMTg3zdSiucPWoulQA6tF
        U8dbVosfVw6zWBzcc5zJ4srX92wWD+beZLLonLiE3eLyrjlsFnfvnWCxWD//FpsDt8flvl4m
        jwdT/zN57Jx1l91jdsdMVo/73ceZPPr/Gngcv7GdyePzJjmPc1PPMgVwRunZFOWXlqQqZOQX
        l9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlvP/TwlrwU6DiyO0TzA2M
        T3i7GDk5JARMJC6un8jexcjFISSwlFFi5/yvrBAJcYnd898yQ9jCEn+udbGB2EICrxkl2no0
        QGxhgRiJeWtamEBsEQE/ia55B5hABjELfGeSmLh8LwvE1KOMEhfOrmEEqWIT0JT4u/km2CRe
        ATuJKydfg21gEVCR2NI+lx3EFhWIkDjzfgULRI2gxMmZT8BsTqD6JdNWg21jFlCX+DPvEjOE
        LS/RvHU2lC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl
        5+duYgTG8LZjP7fsYOx6F3yIUYCDUYmHV2Lj9xgh1sSy4srcQ4wSHMxKIryJt7/ECPGmJFZW
        pRblxxeV5qQWH2I0BXpuIrOUaHI+ML3klcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpgXFS/dINlzEXz47P/Wy2bGuG+5YTn2fAzr7Qrn3cwatfUPzuZ23HBuC5r
        0zzF1unbBfY1fglYOv1/8OS2YN1zlW4ebbM4BCYejlvoZrVz5efJl5RVVBg/6r1s2yrDsqdn
        d0tu9dt8nezAlOy2y+FTQywrz5lZ2oq8rW47u32OK2P4gb/8P8y/KrEUZyQaajEXFScCAKTo
        M9P3AgAA
X-CMS-MailID: 20190606080821eucas1p2cbab58ec759edf9a4f8254fe46ee1289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605070528epcas1p1d9b1d1b09ffaafa511936ed3ded29097
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605070528epcas1p1d9b1d1b09ffaafa511936ed3ded29097
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
        <CGME20190605070528epcas1p1d9b1d1b09ffaafa511936ed3ded29097@epcas1p1.samsung.com>
        <20190605070507.11417-4-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.06.2019 09:04, Andrey Smirnov wrote:
> Replace explicit polling in tc_link_training() with equivalent call to
> tc_poll_timeout() for simplicity. No functional change intended (not
> including slightly altered debug output).
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 5e1e73a91696..115cffc55a96 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -748,22 +748,19 @@ static int tc_set_video_mode(struct tc_data *tc,
>  
>  static int tc_wait_link_training(struct tc_data *tc)
>  {
> -	u32 timeout = 1000;
>  	u32 value;
>  	int ret;
>  
> -	do {
> -		udelay(1);
> -		tc_read(DP0_LTSTAT, &value);
> -	} while ((!(value & LT_LOOPDONE)) && (--timeout));
> -
> -	if (timeout == 0) {
> +	ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
> +			      LT_LOOPDONE, 1, 1000);
> +	if (ret) {
>  		dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
> -		return -ETIMEDOUT;
> +		return ret;
>  	}


Inconsistent coding, in previous patch you check (ret == -ETIMEDOUT) but
not here. To simplify the code you can assume that tc_poll_timeout < 0,
means timeout, in such case please adjust previous patch.


Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  
> -	return (value >> 8) & 0x7;
> +	tc_read(DP0_LTSTAT, &value);
>  
> +	return (value >> 8) & 0x7;
>  err:
>  	return ret;
>  }


