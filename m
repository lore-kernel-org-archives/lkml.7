Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B58C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB4D21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zn6dhuB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgACMPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:15:05 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59342 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:15:04 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200103121503euoutp019a3ba98672678edf43bc2d950b4cccb4~mX3uJeqZf0611006110euoutp01d
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 12:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200103121503euoutp019a3ba98672678edf43bc2d950b4cccb4~mX3uJeqZf0611006110euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578053703;
        bh=ZYRSG2dnRN2oLiPJQ2LIXSPSrUDBNRb5suqvQsyXhO4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zn6dhuB+mcy67uxhwk7X2oYyOonNDpV4aQVxqP5pewysu2dE556VrxZXRcWN+K6hX
         xY9NNLpAJKb8PnaT+kE9vXHKOhCWFbO+1JFhjMQhyW+r34whYUa6R+5FxxbWq6P2ho
         zlSWgemlagqnHrmn8miVj1gbPCEtXwqBla447rho=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200103121503eucas1p13bfbe8b3592eb8827c2283f099be7228~mX3uBWn_G0835208352eucas1p1p;
        Fri,  3 Jan 2020 12:15:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CC.66.60679.7403F0E5; Fri,  3
        Jan 2020 12:15:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200103121502eucas1p2030838b2fe5856b92dd84fa9a3f0c1a8~mX3s97Fzn1198811988eucas1p2L;
        Fri,  3 Jan 2020 12:15:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200103121502eusmtrp19e172d9b605d03a839a363221c831aff~mX3s9UZLb2556325563eusmtrp1K;
        Fri,  3 Jan 2020 12:15:02 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-93-5e0f3047c88d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6F.E3.08375.6403F0E5; Fri,  3
        Jan 2020 12:15:02 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200103121502eusmtip12804f41b83594e4780542c64be02ac40~mX3srJ1G13250032500eusmtip1G;
        Fri,  3 Jan 2020 12:15:02 +0000 (GMT)
Subject: Re: [PATCH -next] fbdev: s3c-fb: use
 devm_platform_ioremap_resource() to simplify code
To:     Jingoo Han <jingoohan1@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <908e757a-11e8-c3f0-13d2-5dc8564e5c43@samsung.com>
Date:   Fri, 3 Jan 2020 13:15:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <SL2P216MB0105ADD044BE3CA7B33CB6ECAA8F0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87ruBvxxBu23pCyufH3PZrHiy0x2
        ixN9H1gtLu+aw2Zx5+tzFgdWj52z7rJ7tBx5y+pxv/s4k8fnTXIBLFFcNimpOZllqUX6dglc
        Gdu37GMpOMRZsX7dP6YGxnfsXYycHBICJhJHZ55m6WLk4hASWMEo8e37ITaQhJDAF0aJRSvL
        IBKfGSU+rn/JCNNxfc1BdojEckaJJ4e+Q7W/ZZRYPn0X2FxhgUSJ6/d+gY0SEfCUWPNnOStI
        EbPAcUaJqc8vg41iE7CSmNi+CszmFbCT+PrpDlgDi4CKxKHuA8wgtqhAhMSnB4dZIWoEJU7O
        fMICYnMKxEgsX30ILM4sIC5x68l8JghbXqJ562xmkGUSAovYJeb/ngB1t4vEsneLWCBsYYlX
        x7dAQ0BG4vTkHhaIhnWMEn87XkB1bwf6Z/I/Nogqa4k750D+4QBaoSmxfpc+RNhRYumK/8wg
        YQkBPokbbwUhjuCTmLRtOlSYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2
        LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGYaE7/O/5lB+OuP0mHGAU4GJV4eBOU
        +eOEWBPLiitzDzFKcDArifCWB/LGCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEk
        NTs1tSC1CCbLxMEp1cA4NU3zgLTD2yNXZ3SWP925vHzhQ47iV3f9CuYYTp7++vy+xT2MMUFW
        smW6zCldVUlpLsk8jx9drzjL9+jBm59aU2b7+85ZO4n3Qm71XQbW+2ILtyndutN2/3hP6Zr5
        te/MzvyXr7ZLu3nC9d0zZ0uR49v+G0fYsAutSnm0I/+L5zO75U4R0XrnlViKMxINtZiLihMB
        d470gzADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7puBvxxBl1LhSyufH3PZrHiy0x2
        ixN9H1gtLu+aw2Zx5+tzFgdWj52z7rJ7tBx5y+pxv/s4k8fnTXIBLFF6NkX5pSWpChn5xSW2
        StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gdu37GMpOMRZsX7dP6YGxnfs
        XYycHBICJhLX1xwEsrk4hASWMkpM+DeLqYuRAyghI3F8fRlEjbDEn2tdbBA1rxklupYfZQNJ
        CAskSnz5sZcZxBYR8JRY82c5K0gRs8BxRoktl+cxQXQ8YJTY2rgOrIpNwEpiYvsqRhCbV8BO
        4uunO2CTWARUJA51HwCrERWIkDi8YxZUjaDEyZlPWEBsToEYieWrD7GC2MwC6hJ/5l1ihrDF
        JW49mc8EYctLNG+dzTyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k
        /NxNjMDI2nbs5+YdjJc2Bh9iFOBgVOLhTVDmjxNiTSwrrsw9xCjBwawkwlseyBsnxJuSWFmV
        WpQfX1Sak1p8iNEU6LmJzFKiyfnAqM8riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2a
        WpBaBNPHxMEp1cDo+dLJ/czv6kfTp6qXF8vU8z5+1sV1ReR74gxHg4k1N7h2P2k+m9B95+8z
        Zfc6Ad73IqceJyXtuN18QuKn3hf1pYZZE83q7Bo4GhbUFd4/ZxTt6Ji3+HX6BY2fHyaleHXF
        dVxknPslsePxPQYXkx27HyxgsTItD4+aOHXW47v/dkuf4rp6Zm+dEktxRqKhFnNRcSIA1B1P
        ycICAAA=
X-CMS-MailID: 20200103121502eucas1p2030838b2fe5856b92dd84fa9a3f0c1a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190917192130epcas4p487980f3b24a63f66203a009f1e59293e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190917192130epcas4p487980f3b24a63f66203a009f1e59293e
References: <20190904115523.25068-1-yuehaibing@huawei.com>
        <CGME20190917192130epcas4p487980f3b24a63f66203a009f1e59293e@epcas4p4.samsung.com>
        <SL2P216MB0105ADD044BE3CA7B33CB6ECAA8F0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/17/19 9:21 PM, Jingoo Han wrote:
> 
> 
> ﻿On 9/4/19, 7:57 AM, YueHaibing wrote:
> 
>> Use devm_platform_ioremap_resource() to simplify the code a bit.
>> This is detected by coccinelle.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> ---
>>  drivers/video/fbdev/s3c-fb.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
>> index ba04d7a..43ac8d7 100644
>> --- a/drivers/video/fbdev/s3c-fb.c
>> +++ b/drivers/video/fbdev/s3c-fb.c
>> @@ -1411,8 +1411,7 @@ static int s3c_fb_probe(struct platform_device *pdev)
>>  
>>  	pm_runtime_enable(sfb->dev);
>>  
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	sfb->regs = devm_ioremap_resource(dev, res);
>> +	sfb->regs = devm_platform_ioremap_resource(pdev, 0);
>>  	if (IS_ERR(sfb->regs)) {
>>  		ret = PTR_ERR(sfb->regs);
>>  		goto err_lcd_clk;
>> -- 
>> 2.7.4
