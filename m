Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94335C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4F021873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EtRisAry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfCUJ3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:29:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52749 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCUJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:29:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190321092922euoutp014ee0150909a5595812b2ed9e25d2afea~N7014nuw91490414904euoutp01a
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190321092922euoutp014ee0150909a5595812b2ed9e25d2afea~N7014nuw91490414904euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553160562;
        bh=zbcBR66o1lvd1oRZy9rEquFLyRMTmhIcWRG1/fuSS/8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EtRisAryB0o2X7yyKl/TITXtwgwBl03DhO9i/ywqHPNBpgSRC3c9O7WniWNxbntW5
         gfeaxRqrP588LI3fNQrPrUK8Xf0lWM5aJfsiJJRpNAKaW68+FWjE3YqxqBlZX0pUtT
         yPKI1p7kfHCARoQ2G7/eIcS3G2kFURw+NMCGHHQk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321092922eucas1p1ef30de30abd92f0cfcac08d735620cbd~N701ezzyV2401624016eucas1p1W;
        Thu, 21 Mar 2019 09:29:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.A8.04294.179539C5; Thu, 21
        Mar 2019 09:29:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190321092921eucas1p2895133c3f8b09a3f0ef722c3df7f1c45~N700nyF7M1396613966eucas1p2G;
        Thu, 21 Mar 2019 09:29:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190321092920eusmtrp2ef3bcf2d73c6d93b9d18fc7d84d42c6d~N700dJUYo2222022220eusmtrp2h;
        Thu, 21 Mar 2019 09:29:20 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-5b-5c93597150ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.5E.04284.079539C5; Thu, 21
        Mar 2019 09:29:20 +0000 (GMT)
Received: from [106.120.50.74] (unknown [106.120.50.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190321092920eusmtip1f1c08ad327476edad35e84bdb15744cc~N70z-CvhF0221702217eusmtip1f;
        Thu, 21 Mar 2019 09:29:20 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: exynos-bus: Suspend all devices on system
 shutdown
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f41be303-0159-0730-501b-f465a1418861@samsung.com>
Date:   Thu, 21 Mar 2019 10:29:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3Z3t6s0fZyKJ5OkQUZRmiF26cUUrPYhqL7kO7b0opavu2pZ
        UFMxaqjIVqYr0LDSlmWOuUqG4LRGak6zUHwBy2G+ZGYOMRXL7Wb57XfOc/7nf/7wUIRYR3pT
        KenZjDxdlioROPMNb39Z9mZFqWP3aU3BdGNFA0n3276StMXyQkgPKnzovub7Anq+pB3RFZYW
        Hj3Zvojoofw6QaiTdHD4ulSnvSWQtn438qSlei2Szuu2nSajnQ8nMqkpuYw8IOScc/LHiRZe
        phpfXtDLFeiOSImcKMBBUGRbIpXImRLjOgSdCw8QV9gQaH+OIfuUGM8jKBu5sK4YeDIn5Pq1
        CN4PxnOCGQTTDbcJ+4M7joBPhmnHWg9chKCi3Si0FwQeRVA13MOzTwlwIChnlAI7i3AIjC3P
        O9by8Q54NPXQYe2JY+GbeRJxM27wrtLKt7MTPgod1hVHn8C+UNh0j+DYCwatVTy7GWCTENQD
        LQR3dzh0rI4jjt1hyqwXcuwDv1+vCwoRfO5+JuSKYgR9BRV/FYegzdy7Fohas9gFDc0BdgQc
        Bk+HEzh0gYEZN+4GF1AZ7hJcWwQ3b4i5HX6gMT//59ra84EoQxLNhmSaDWk0G9Jo/ttWI74W
        eTE5bFoSw+5PZy75s7I0Nic9yT8hI02H1n5S56rZ9go1r5w3IUwhyWZRZKgqVkzKctm8NBMC
        ipB4iIKOqGPFokRZ3hVGnhEvz0llWBPaSvElXqKrm0ZjxDhJls1cZJhMRr7+yqOcvBWIHI87
        oy+hw10naoprPYu8ArqsYVmJqsflJ2UZlb3+NWPK8vqonWS9Qru0jA3H1EZr98v8lLk9na4H
        Cjbl6hJVbT+2K8oEwWZ2dsu1uCy/UvJ4yFB0zOKJgzZsXCD7/UaWbW8sX7psTXR1RHuVsDJy
        1tqceza8sdDXkuyjOiXhs8mywN2EnJX9AU7SsddFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7oFkZNjDN4/srLYOGM9q8X1L89Z
        Lc6f38BucatBxuLyrjlsFp97jzBazDi/j8ni5ZEfjBa3G1ewOXB63LpT77FpVSebx8F3e5g8
        +rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+PKi31MBZMFKr5tKWpgnMrbxcjJISFgInFj5Uf2LkYuDiGBpYwSl1avYYZIyEic
        nNbACmELS/y51sUGUfSaUaJv+1FGkISwQLjE1W2vWUESIgKtjBI7PjaAVTELPGKUeHHgDBNE
        yzFGiWdTVoK1sAkYSnS9BZnFycErYCfx+PdndhCbRUBVYumrJWA1ogIxEv9u72WFqBGUODnz
        CQuIzSlgL3HqyR+wGmYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKA
        kWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYCRuO/Zz8w7GSxuDDzEKcDAq8fAuMJkUI8Sa
        WFZcmXuIUYKDWUmE18R2cowQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wOTRF5JvKGpobmF
        paG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsZFe/axqx68wHYvfXf9yWOTPirz
        L2Ob983vm5X11mU/+bpfduwSn7pc93TTnA82c+c/9Tp+5f/i43svHX0kbqYwdc3XBRtDFeM8
        3jE8f3TC6T//lLfn+1i279+uz7jynEysQd6HVJYtZjzNBvZqvuKVy59XP/p3KXLmAavWw3vS
        I5y5dx98YbKMSYmlOCPRUIu5qDgRAJPjGf7aAgAA
X-CMS-MailID: 20190321092921eucas1p2895133c3f8b09a3f0ef722c3df7f1c45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b
References: <CGME20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b@eucas1p1.samsung.com>
        <20190321090110.26506-1-m.szyprowski@samsung.com>
        <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2019-03-21 10:19, Chanwoo Choi wrote:
> On 19. 3. 21. 오후 6:01, Marek Szyprowski wrote:
>> Force all Exynos buses to safe operation points before doing the system
>> reboot operation. There are board on which some aggressive power saving
>> operation points are behind the capabilities of the bootloader to properly
>> reset the hardware and boot the board. This way one can avoid board crash
>> early after reboot.
>>
>> This fixes reboot issue on OdroidU3 board both with eMMC and SD boot.
>>
>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> This is an alternative to https://patchwork.kernel.org/patch/10781433/
>> limited only to Exynos-bus driver.
>> ---
>>   drivers/devfreq/exynos-bus.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index c25658b26598..486cc5b422f1 100644
>> --- a/drivers/devfreq/exynos-bus.c
>> +++ b/drivers/devfreq/exynos-bus.c
>> @@ -514,6 +514,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> +static void exynos_bus_shutdown(struct platform_device *pdev)
>> +{
>> +	struct exynos_bus *bus = dev_get_drvdata(&pdev->dev);
>> +
>> +	devfreq_suspend_device(bus->devfreq);
>> +}
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   static int exynos_bus_resume(struct device *dev)
>>   {
>> @@ -556,6 +563,7 @@ MODULE_DEVICE_TABLE(of, exynos_bus_of_match);
>>   
>>   static struct platform_driver exynos_bus_platdrv = {
>>   	.probe		= exynos_bus_probe,
>> +	.shutdown	= exynos_bus_shutdown,
>>   	.driver = {
>>   		.name	= "exynos-bus",
>>   		.pm	= &exynos_bus_pm,
>>
> Actually, I already agreed the previous patch.
> Also, it looks good to me.

Yes, I know, but MyungJoo had some objections, that's why I prepared 
alternative version.

> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

