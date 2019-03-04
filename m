Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79156C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD1520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dcYOfK5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfCDJ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:28:29 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42735 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:28:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190304092826euoutp02264b5fae8340abdd858450aefbee4675~It2LRszLl2829228292euoutp02_
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 09:28:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190304092826euoutp02264b5fae8340abdd858450aefbee4675~It2LRszLl2829228292euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551691706;
        bh=WCdcNbGk4cnK4zCa2xWOdTnkbKroYWA5sjjOH7dgeI0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dcYOfK5SehjVmNix9QQjpOKidL6ZGldrl8xvpMkEsT/4iB0fvQBkLYAYAGMRPxI38
         FoH4p5VTQzkKxIETaoEz8hq4sqtmeEa4BjTrVBvUjUSeiojUmdGKL5t81jipudlgOl
         74FAeZ4fNTYygGVde5MFYPreyum2HqgioM7SKQic=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190304092826eucas1p2525fdee3ad9841b4bb8c05bb8aad0b13~It2Krmr2_2127721277eucas1p2C;
        Mon,  4 Mar 2019 09:28:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DD.54.04294.9BFEC7C5; Mon,  4
        Mar 2019 09:28:25 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190304092825eucas1p28f7b7540f2c93a49486ac157c841a1f3~It2J6YJa12127721277eucas1p2B;
        Mon,  4 Mar 2019 09:28:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190304092824eusmtrp11e32119aa333d85e0251790ba15bfc1b~It2Jrc9pL2088620886eusmtrp1d;
        Mon,  4 Mar 2019 09:28:24 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-18-5c7cefb99c89
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.F2.04284.8BFEC7C5; Mon,  4
        Mar 2019 09:28:24 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190304092824eusmtip2448faaa75367f80000f06c7fab864682~It2JJK7eD0054900549eusmtip2z;
        Mon,  4 Mar 2019 09:28:24 +0000 (GMT)
Subject: Re: [PATCH 1/9] drm/bridge: tc358767: Simplify tc_poll_timeout()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <252f51d3-1621-4e15-4228-06c83aff108a@samsung.com>
Date:   Mon, 4 Mar 2019 10:28:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226193609.9862-2-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7o739fEGBx9rWPR3GFr0dTxltXi
        4J7jTBZXvr5ns3gw9yaTRefEJewWl3fNYXNg97jc18vksXPWXXaP2R0zWT3udx9n8uj/a+Dx
        eZNcAFsUl01Kak5mWWqRvl0CV8b8PfPZCzbyV+zYfZi1gfEATxcjJ4eEgIlE95Jepi5GLg4h
        gRWMEm1rLrJAOF8YJVo7n0FlPjNKtHRsZoVp+f33NjuILSSwnFHi4V92iKK3jBKnn38DKxIW
        8JR4ePoaWJGIQIDEp6adbCA2s8BJRon+FncQm01AU+Lv5ptgcV4BO4kDXZOZQWwWARWJrrdz
        wHpFBSIkDve+Y4SoEZQ4OfMJC4jNKWArMe30X1aImfISzVtnM0PY4hK3nswHu1pCYBu7xNVL
        +xghrnaRuH/pIguELSzx6vgWdghbRuL05B6oeL1E08wrzBDNHYwSJxYvZ4NIWEscPn4RaBsH
        0AZNifW79EFMCQFHiQ3TBCBMPokbbwUhTuCTmLRtOjNEmFeio00IYoaixP2zW5khbHGJpRe+
        sk1gVJqF5LFZSJ6ZheSZWQhrFzCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMQ6f/
        Hf+yg3HXn6RDjAIcjEo8vAYqNTFCrIllxZW5hxglOJiVRHid7wKFeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MGpfKTh8mM3W3oEt6qHAQblyIc1r7rq5
        aTMtzm4/FLTl9eSdq8pnPWGVsmxy8lZpWrEmadue3OnNRT11zzeyZfznqto+S6KI+af/DL0j
        ZaqSWztMqrr/dy7JjC01WzBtQduOIxE+6vl/c/9ceWx8N3zv+fN/bCaH7fmtE7363V6dLbND
        Vq7Ks1NiKc5INNRiLipOBADxZw3oPwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7o73tfEGCyYrmPR3GFr0dTxltXi
        4J7jTBZXvr5ns3gw9yaTRefEJewWl3fNYXNg97jc18vksXPWXXaP2R0zWT3udx9n8uj/a+Dx
        eZNcAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        Xsb8PfPZCzbyV+zYfZi1gfEATxcjJ4eEgInE77+32bsYuTiEBJYySqxdu4wRIiEusXv+W2YI
        W1jiz7UuNoii14wS+zr6WEESwgKeEg9PX2MHsUUE/CS65h1gAiliFjjNKLH/0FZWiI7DjBKL
        2iazgFSxCWhK/N18kw3E5hWwkzjQNRlsBYuAikTX2zlgk0QFIiQ+Pt3HBFEjKHFy5hOwXk4B
        W4lpp/+CbWYWUJf4M+8SM4QtL9G8dTaULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlWMYqk
        lhbnpucWG+oVJ+YWl+al6yXn525iBMbftmM/N+9gvLQx+BCjAAejEg+vgUpNjBBrYllxZe4h
        RgkOZiURXue7QCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aGvJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjDbu9hO5xL7+u+9esa/JcPH94jUzq9XOOX3d
        G8b5bKGa5LzkIO3iaUvYtV+veqKsO8k59LBEzomASb4uvpyTdbynf3g4o4Ylb2eK223nvUz9
        1i5s22bW6vt25e6yUy62eWk5ITcpem+cT8ZiyXDGprkvOJ8/fnCU4+KyRRtP1W/QeZrQffrl
        FyWW4oxEQy3mouJEAN3BAF3VAgAA
X-CMS-MailID: 20190304092825eucas1p28f7b7540f2c93a49486ac157c841a1f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190226193630epcas1p3b1d54f03cc7e34c55f755ac72a549d95
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190226193630epcas1p3b1d54f03cc7e34c55f755ac72a549d95
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
        <CGME20190226193630epcas1p3b1d54f03cc7e34c55f755ac72a549d95@epcas1p3.samsung.com>
        <20190226193609.9862-2-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.02.2019 20:36, Andrey Smirnov wrote:
> Implementation of tc_poll_timeout() is almost a 100% copy-and-paste of
> the code for regmap_read_poll_timeout(). Replace copied code with a
> call to the original. No functional change intended.
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index e6403b9549f1..b0f8264a1285 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -252,24 +252,11 @@ static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
>  				  unsigned int cond_value,
>  				  unsigned long sleep_us, u64 timeout_us)
>  {
> -	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
>  	unsigned int val;
> -	int ret;
>  
> -	for (;;) {
> -		ret = regmap_read(map, addr, &val);
> -		if (ret)
> -			break;
> -		if ((val & cond_mask) == cond_value)
> -			break;
> -		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
> -			ret = regmap_read(map, addr, &val);
> -			break;
> -		}
> -		if (sleep_us)
> -			usleep_range((sleep_us >> 2) + 1, sleep_us);
> -	}
> -	return ret ?: (((val & cond_mask) == cond_value) ? 0 : -ETIMEDOUT);
> +	return regmap_read_poll_timeout(map, addr, val,
> +					(val & cond_mask) == cond_value,
> +					sleep_us, timeout_us);
>  }
>  
>  static int tc_aux_wait_busy(struct tc_data *tc, unsigned int timeout_ms)


