Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83175C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D722218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HjAID45K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfCUJTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:19:13 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23062 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfCUJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:19:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190321091909epoutp01ef5620069f48395a7999e5dc38853990~N7r68RlXJ1428314283epoutp01T
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:19:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190321091909epoutp01ef5620069f48395a7999e5dc38853990~N7r68RlXJ1428314283epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553159949;
        bh=OSeVXsGl8uqUwnJlurlaqqUfPTZb5Xw3+nP9bodBnvA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HjAID45K65aP3qC4SCfzNIlOlTrvrWih4e2dzOl+A1Po5spCZVT/CJ0+5ME9K+mK/
         fIOsc9s0/4pUhmtwp6jq00Kv8RMHxcH955FGq1Kzkm2KWwWaDSAlblu4X/5D0Wk0Lf
         tgPJUN6F5vuqncDlLBnYsU9/A/avQyl/ixy0JwBs=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190321091906epcas1p117dc596be7f1d950d7d689a3def51176~N7r3tj8XR1867718677epcas1p17;
        Thu, 21 Mar 2019 09:19:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.A5.04257.907539C5; Thu, 21 Mar 2019 18:19:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190321091905epcas1p1d7544346c6428b1c04d43ec377843338~N7r3Q0Ctj0618006180epcas1p1O;
        Thu, 21 Mar 2019 09:19:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190321091905epsmtrp26eb04ac0593a92a1a36249ee0558c459~N7r3P9lqG0626206262epsmtrp2W;
        Thu, 21 Mar 2019 09:19:05 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-28-5c9357097c8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.46.03662.907539C5; Thu, 21 Mar 2019 18:19:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190321091905epsmtip1c7f764dcd315e7fc3a158c76ef4d4995~N7r3FjtbB3219532195epsmtip1I;
        Thu, 21 Mar 2019 09:19:05 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: exynos-bus: Suspend all devices on system
 shutdown
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c2b39c36-a2f4-282e-1145-c61cfa18c6ce@samsung.com>
Date:   Thu, 21 Mar 2019 18:19:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321090110.26506-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTn292ud6vZ1yw9SeW6UqBg7aqra6RFSg0qEyR6sFgXvam4V7tT
        ekBZ0ZNeJpWux4ySygxNdJlpli2i/miG2cMHSVlZhpJaSe9d7yL/+53f9zvnd875DkVoKshw
        Ksfq5B1WzkyTKrnnXpQuRrm6yKh7/S2BvV5cqWB9vqogtr1gKttaf4Zkhw57EVvsuy1jP3hH
        EHvN2xXEduy8TC5SGto7dxiqyw+Qhrv9DTLDkZpyZBiqnp6mWJe7IJvnMnmHlrdm2DJzrFmJ
        9LJ0U7JJP1fHxDAJ7Dxaa+UsfCKdsjwtZkmO2d8Orc3nzHl+Ko0TBHpO0gKHLc/Ja7NtgjOR
        5u2ZZnuCfbbAWYQ8a9bsDJtlPqPTxer9wg252Y+a98jtdcGbn9WWEgXo7biDSEkBjof3HR3y
        g0hFaXAdgl+7fAopGETwsbBRJgVfEZw/ekL2L+X33YsBVSOCnzurgsQHDR5A4HFPF3EIXg1t
        nr5R0SR8BMHVMu9oQOBuBO7OltFSJI6Gpt4XpIgn4BnQNvIGiViNk2BwpMLPU5Qcz4SKLyqR
        nozXwMDbW3JJMhEelvTIRYnSL398KUKkCRwG7T1umYQjYHftaUJq+g8JRwc1Ek6B6u/vFBIO
        gY8PaoIkHA5D/Y2khLfBlYdeUmwZ8H4ENU0tgYQ4aCorkom+BI6Cyvo5klcw9H85pBBpwGrY
        vzdgFQmt3V2BvU2BC/sOBMobwFPSJTuGZrjGDOMaM4FrzASu/2alSF6OQnm7YMniBcYeP/az
        q9HopUazdajh8fJmhClEj1cbYo8bNQouX9hiaUZAEfQkdXxikVGjzuS2bOUdNpMjz8wLzUjv
        X3UhET45w+a/e6vTxOhj4+Li2Hhmrp5h6DB15aJkowZncU4+l+ftvONfnoxShhegwnTrlPV9
        neejklV36nuX+nper+xN6UvlFzuKcoo/tQyHnnNtLz152LRqRUTIq2looFZ7yLwprLbr5tDa
        yJfu58Z7g1Vln3e0HnvS0Dvrg+oZO/wj9NTGkGGB2NtmdxITxl9J6U6t2ZjE5F9Wfm9ceMHj
        u+/u+XO284Tt2rSvwTdSn9JyIZtjogmHwP0FsCoJvL8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnC5n+OQYgw3npC02zljPanH+/AZ2
        i1sNMhaXd81hs/jce4TRYsb5fUwWL4/8YLRYe+Quu8XtxhVsDpwet+7Ue2xa1cnmcfDdHiaP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgyjh1qJWlYAdfxbWtC5gbGJ9ydzFyckgImEj8O7iE
        tYuRi0NIYDejxOv7rUwQCUmJaRePMncxcgDZwhKHDxdD1LxllFi86g87SI2wQLjE1W2vwZpF
        BPoYJV5+XcME4jALPGKUeHHgDBNEy0RGiUf794C1sAloSex/cYMNxOYXUJS4+uMxI4jNK2An
        8enHGjaQdSwCqhJrvnKBhEUFIiTuXnzBAlEiKHFy5hMWkBJOoPJzy+VBwswC6hJ/5l1ihrDF
        JW49mc8EYctLNG+dzTyBUXgWku5ZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
        0rx0veT83E2M4PjS0trBeOJE/CFGAQ5GJR7ebtNJMUKsiWXFlbmHGCU4mJVEeE1sJ8cI8aYk
        VlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYGw7NUuaSUUyKqBf
        dIHqzf0nQ3h1HLLi5zX59+V+KpWY4O+weXWK1Ns3zR6rzZIq5uV/8A1ITiyXEr/JF/Rqna32
        y2vTHQN4Xj3Rf2Up8P1nurLXhnl7JlbsXps19/MkRv/1gRIxmQH7Zqn8/fBo7QGfucm7fRfW
        2p5K6Fgz73USW3nOvyZzcyWW4oxEQy3mouJEAPJWbyurAgAA
X-CMS-MailID: 20190321091905epcas1p1d7544346c6428b1c04d43ec377843338
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b
References: <CGME20190321090120eucas1p1d5122777e84f4e3c965946a8c5aead8b@eucas1p1.samsung.com>
        <20190321090110.26506-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 19. 3. 21. 오후 6:01, Marek Szyprowski wrote:
> Force all Exynos buses to safe operation points before doing the system
> reboot operation. There are board on which some aggressive power saving
> operation points are behind the capabilities of the bootloader to properly
> reset the hardware and boot the board. This way one can avoid board crash
> early after reboot.
> 
> This fixes reboot issue on OdroidU3 board both with eMMC and SD boot.
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This is an alternative to https://patchwork.kernel.org/patch/10781433/
> limited only to Exynos-bus driver.
> ---
>  drivers/devfreq/exynos-bus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index c25658b26598..486cc5b422f1 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -514,6 +514,13 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void exynos_bus_shutdown(struct platform_device *pdev)
> +{
> +	struct exynos_bus *bus = dev_get_drvdata(&pdev->dev);
> +
> +	devfreq_suspend_device(bus->devfreq);
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int exynos_bus_resume(struct device *dev)
>  {
> @@ -556,6 +563,7 @@ MODULE_DEVICE_TABLE(of, exynos_bus_of_match);
>  
>  static struct platform_driver exynos_bus_platdrv = {
>  	.probe		= exynos_bus_probe,
> +	.shutdown	= exynos_bus_shutdown,
>  	.driver = {
>  		.name	= "exynos-bus",
>  		.pm	= &exynos_bus_pm,
> 

Actually, I already agreed the previous patch.
Also, it looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
