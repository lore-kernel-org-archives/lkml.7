Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E46C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C452073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h8mGzCSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfDQA0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:26:44 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12709 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbfDQA0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:26:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190417002641epoutp0317cd3f4f5ca49b85cbf72c36e2e29d32~WG1uFLnjb1475314753epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 00:26:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190417002641epoutp0317cd3f4f5ca49b85cbf72c36e2e29d32~WG1uFLnjb1475314753epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555460801;
        bh=FF7WvuT4ClQMF58lP61YQnieKgTAePz9cCBTgm27x/o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=h8mGzCSli8OdY3k33uctrwUBVKFGOPfqeSzYy5vJBDYjVoEHqGG8tZlZ/HUEt3RhT
         inTZOD1zKiNh79lXPhrHzwcuMyGWuB1fVv7Me3/5WU/1osoQDe44ZIGS71G/GA1Rid
         +ROcD31QSFeo46uwU5hmox+r9O1W3feKZat8qM5c=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417002635epcas1p16aa0315abff2813a0ae629c02feabb7f~WG1oukh0t2181921819epcas1p14;
        Wed, 17 Apr 2019 00:26:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.2F.04139.7B276BC5; Wed, 17 Apr 2019 09:26:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190417002631epcas1p3889b8fc60ccff285910656a577f07adc~WG1k0yMJU2480824808epcas1p31;
        Wed, 17 Apr 2019 00:26:31 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190417002631epsmtrp10ae2bb8be2d6153f94b504f29b58a43d~WG1kz9qQd1254012540epsmtrp1L;
        Wed, 17 Apr 2019 00:26:31 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-87-5cb672b72904
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.07.03662.7B276BC5; Wed, 17 Apr 2019 09:26:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190417002631epsmtip2918d640805a848f323a1c19229de5a33~WG1kolLk21983919839epsmtip2C;
        Wed, 17 Apr 2019 00:26:31 +0000 (GMT)
Subject: Re: [PATCH v2 18/19] PM / devfreq: tegra: Enable COMPILE_TEST for
 the driver
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <187605bc-94f5-4e66-e6ee-98a77aa904c9@samsung.com>
Date:   Wed, 17 Apr 2019 09:27:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <77653f79-45ef-1557-c940-0140bcb69311@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa2xLYRjO19OeczrK0d1ei8scITYpPds6hyiaiVRMsmQ/jEy6Yz3aZb2l
        p8NckjFmxmoukTkWxCphLmO6iwVjGHOPWcxokPkxMxPbCIks2p2K/Xue570+3/eSmPoyHkfm
        OTy828HZaDxC3nA3QaNpdDdkaz9c07IXvvcgdrd4Rs4+3dVPsB3NVTg7VH4PsfuGRZx9u/Mc
        zv5uPilnvZde4suUxqaADxmviwHCWF48gBu9/hpkHKqblqFYl7/YynNm3h3PO3Kd5jyHRU+v
        yjSlmXSpWkbDLGQX0PEOzs7r6eXpGZoVebbgQnT8Js5WEJQyOEGg5y9Z7HYWePh4q1Pw6Gne
        Zba5FrrmCZxdKHBY5uU67YsYrTZJF0zMybcOP9mjcDVGbGnz9RNFqIEsQ0oSqBQYGfQRZSiC
        VFNNCB51d4TJIIIrIzW4RH4iGNgrYv9KSh73hgM3EQTa28PkG4LDja9RGSLJSGoNeDuzQnoU
        NYJgsLlSEarGqLXw487Z0U44lQgtvV14CE+kZkDnrx4UwipqCZT33RrV5dQsKHn/ZDQ/msqC
        921XFFLOJGg//kkewkpKD6X+N+H+sdD96ZRMwtOhuP4EFloCqGICbtRfDxIiSJbDyGzJTCT0
        PfATEo6DzwdLwngbnG+/h0ulpQj8LS8UUiAZWs4ekYU8YlQC1DbPl0ZNgIEfBxQhGSgVlJao
        peyZ0PEhIJPwZKjeuw+XsBE+t3qxCjRDHGNGHGNAHGNA/D/sNJLXoBjeJdgtvMC4mLGfXYdG
        bzVR14SOPktvRRSJ6PGqc7/rs9UKbpNQaG9FQGJ0lMpg9merVWaucCvvdprcBTZeaEW64Fsf
        wuKic53By3d4TIwuKTk5mU1hUnUMQ8eqapelZaspC+fh83nexbv/1clIZVwR8k1R5R/72pnQ
        uNn80HD43VWvN7U6ak/byoq5E+Z09+2/vX7usLKwS2ON2Zxx36jBqipNVTmBWLG2SGY19CW5
        yNW9GyPSbkZP3VJmKNRP3nDaV/fqz8zVdy52q74c0WQuTU8i+hv2H43Z2aZ+Tvxas73LkWUY
        VyEvL820VH8cWjC4g5YLVo5JxNwC9xdBm9HEwQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSvO72om0xBl93c1ms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlfDnTylqwnavi2JI37A2M2zi6GDk5JARMJNpO
        v2DrYuTiEBLYzSix+8RrdoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKfJ7SxgJSIywQLnHvwl9W
        kISIQBOTxOeHLUwgCWaBSIn+R92sEB3zmCQ27/sFNpVNQEti/4sbbCA2v4CixNUfjxlBbF4B
        O4neV/vA4iwCqhJt988wg9iiAhESZ96vYIGoEZQ4OfMJmM0pYCvRseUmK8QydYk/8y4xQ9ji
        EreezIc6Ql6ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX
        5qXrJefnbmIER5mW1g7GEyfiDzEKcDAq8fCu+Lk1Rog1say4MvcQowQHs5IIr2PKlhgh3pTE
        yqrUovz4otKc1OJDjNIcLErivPL5xyKFBNITS1KzU1MLUotgskwcnFINjJwsM8TSr1noeqhn
        s9jxbJ4jGMkf7baE0WvRdsVvwq+1LA9/Sjfxi4prWtSjeHvntZdyHb6NGVWLLttL/J9bWTbp
        ULLoUqvbs22yquZMPckhpXRN9Cnj6x+Xv8Xu9rY8JrbxgunMs5u/f390UbQn7/rZxJA1H+cb
        6x4uf2vPtDnXft87hXfPXiuxFGckGmoxFxUnAgAwIbAcrgIAAA==
X-CMS-MailID: 20190417002631epcas1p3889b8fc60ccff285910656a577f07adc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190415145614epcas4p494a515b20cd351e220ac4eb37c05b7fb
References: <20190415145505.18397-1-digetx@gmail.com>
        <CGME20190415145614epcas4p494a515b20cd351e220ac4eb37c05b7fb@epcas4p4.samsung.com>
        <20190415145505.18397-19-digetx@gmail.com>
        <8d8c55b8-b4aa-e072-7c5f-0b1e5e883031@samsung.com>
        <77653f79-45ef-1557-c940-0140bcb69311@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 17. 오전 12:52, Dmitry Osipenko wrote:
> 16.04.2019 10:43, Chanwoo Choi пишет:
>> On 19. 4. 15. 오후 11:55, Dmitry Osipenko wrote:
>>> The driver's compilation doesn't have any specific dependencies, hence
>>> the COMPILE_TEST option can be supported in Kconfig.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 78c33ddd4eea..bd6652863e7d 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>  
>>>  config ARM_TEGRA_DEVFREQ
>>>  	tristate "NVIDIA Tegra30+ DEVFREQ Driver"
>>> -	depends on ARCH_TEGRA
>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>  	select PM_OPP
>>>  	help
>>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>>
>>
>> I think that it doesn't need to make it a separate patch.
>> You can merge this patch to patch17 and then drop this patch.
>>
> 
> I'd prefer to have this change as a separate patch because this is a logically distinct change from the patch 17.
> 
> 

OK.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
