Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705C8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E056217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XHS7tGut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfDYGaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:30:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34805 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfDYGaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:30:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190425062959euoutp012edc366a81c9943cb3379d309fe07f69~Yo9Ni5TXp1063910639euoutp01W
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 06:29:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190425062959euoutp012edc366a81c9943cb3379d309fe07f69~Yo9Ni5TXp1063910639euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556173799;
        bh=aVKIJGn6mAUxqF3A7GqWgRxXjBKT2wUUu1wHqAd8nXA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XHS7tGutDDjdblNRt0d3pE1uvATKJCsDKsMCaGQ89ybo4vcS2gRSZf9fdR35x2h7r
         H4p46LAmROorEVAriLt6reKm0lNqnV4brlk60G6+wZY3FMxQD9Ka+0XLO0RWQiGUqL
         DoK6otVQDIfIMmfWRLqCiDFCvg7LCiYDV72WGGUk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190425062959eucas1p13aa3cc48c82f4f889c91ab010d5e37e1~Yo9ND6fsK2838628386eucas1p15;
        Thu, 25 Apr 2019 06:29:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9A.46.04298.6E351CC5; Thu, 25
        Apr 2019 07:29:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190425062958eucas1p2fe667b077e638ef6fdc5703ea42e84d7~Yo9MXu2pN3009330093eucas1p2u;
        Thu, 25 Apr 2019 06:29:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190425062958eusmtrp130bf70ad964a876afe814bdf2284a4a7~Yo9MJuAfH3004630046eusmtrp1d;
        Thu, 25 Apr 2019 06:29:58 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-50-5cc153e60ea1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.B3.04146.5E351CC5; Thu, 25
        Apr 2019 07:29:58 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190425062957eusmtip21ebc171be57c8ed58715f8127be2235b~Yo9LwO-Hu2394523945eusmtip2D;
        Thu, 25 Apr 2019 06:29:57 +0000 (GMT)
Subject: Re: [PATCH v2] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <30b83273-5c79-5118-b4c7-ba1d93e1022e@samsung.com>
Date:   Thu, 25 Apr 2019 08:29:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190321082608.21366-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRj13b27u44md5u2B0uFSaZZmtDHhUIq/DHIH5EUVkLOvKi0qezq
        SiMUrdAhmmWl89s+HebHFDMJcWaaSa5tYaVphUOXsTK/SH9Yzmvlv3Oe5xzOc15eEpMY+d5k
        UnIao0lWquSEEG/vWzLvmowyxeweHw2hW0qb+PS7+Sk+XTXnQ5vNzQLaODHMp22dFQRdau7i
        0a3GW9ghUmE05BOKj8PPCMX3oSGBovVelqKwzYAUc0bfY8Rp4cF4RpWkZTSh4bHCxNa830Rq
        udfFu0slvGzUJ9YhkgRqDwxV+uuQkJRQjxA0V1YIODKPwPGrFnFkDoFh8j7668ib9ePmDxHY
        65x8jjgRrDhsqyJ3UkpFQ7ttnHBhTyoQWqwjmEuEUTU8mFloxF0LggoDnVO3JhJR4fBy0Chw
        YZzaBiX6ZcKV5kXFQN3cukQMA2X2Nav7qvzKRBHmwhjlB0+cFetYBiP2ap4rC6guAdh+jK4Z
        gIqAojLTOpbCdH+bgMNbYfBmAc4ZchF8GXos4EgBAltOKeJUB+B5v4XvugijgqCpM5QbHwZn
        1RjBPYsHvHeKuSM84Eb7HYwbiyDvmoRTB4C+v/FfrOmNFbuO5PoN1fQb6ug31NH/z61BuAHJ
        mHRWncCwYcnMhRBWqWbTkxNCzqWojWj1Jw2u9M92oAVrXA+iSCTfJMqO646R8JVaNkPdg4DE
        5J6i7XtNMRJRvDIjk9GknNWkqxi2B20hcblMdMnt8xkJlaBMY84zTCqj+bvlke7e2UhmDRif
        GZdSbmJpoTYxeJbcvy9aL168nDN5chrK8U9ZV0+MRj71v43CfR1lesL201IdhRfbFnu15qwj
        loZynYflbUdt0qI42PDg2/HQXF73zuLXXzvY6aObVQM0/WJMHVH/ymemOUgaGRvY1jtRYj+V
        +yE7M2nKlO9oqF9WynE2URm2A9Owyj8LtqiBRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7rPgg/GGDydx2ixccZ6VovrX56z
        Wsz7LGtx/vwGdotNj6+xWlzeNYfNYsb5fUwWmzdNZXbg8Ni0qpPN4861PWwe786dY/fYvKTe
        o2/LKkaPz5vkAtii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMy
        y1KL9O0S9DI2d/xnK5gtWrH45xSmBsZjgl2MHBwSAiYSHZ/kuxi5OIQEljJKXLv5la2LkRMo
        LiNxcloDK4QtLPHnWhcbRNFrRokP1/4xgSSEBSIktl2+B9YgIqAhsfHSLWaQImaBBUwSh9Zu
        ZILomMgosXX6CbAqNgFDia63XWA2r4CdxInTm9hBbBYBVYkps36BxUUFYiROTN3CDlEjKHFy
        5hMWEJsTqL7lcT8ziM0sYCYxb/NDKFteYvvbOVC2uMStJ/OZJjAKzULSPgtJyywkLbOQtCxg
        ZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGIfbjv3cvIPx0sbgQ4wCHIxKPLwnwg7ECLEm
        lhVX5h5ilOBgVhLhVTc9GCPEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cAUkVcSb2hqaG5h
        aWhubG5sZqEkztshANQkkJ5YkpqdmlqQWgTTx8TBKdXAGJUwi3mPRk2h67RykU9yewMfLNnC
        oXresSszzXL9xrDuPdGnTr6VNlzrcTE1av7pHhOttKud/T9PHmu+rbxHvHyj+8osuR0Kz+Im
        FP48zfMpX/u0RZ/DNZaHl5ISEq04NvBZGx766/nFYY7X+1OiwW8TBOwEX2vWz5jII2maPa/n
        DMOJWeISSizFGYmGWsxFxYkARwyz8dkCAAA=
X-CMS-MailID: 20190425062958eucas1p2fe667b077e638ef6fdc5703ea42e84d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e
References: <CGME20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e@eucas1p1.samsung.com>
        <20190321082608.21366-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

On 2019-03-21 09:26, Marek Szyprowski wrote:
> Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
> Architected Timers (arch_timer), because they both share some common
> hardware blocks (global system counter) and turning on MCT is needed
> to get ARM Architected Timer working properly. Increase MCT timer rating
> and hotplug priority over ARM Archictected timer driver to achieve that.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thomas: could you comment or accept this change? Daniel said that he 
leaves this for you: https://patchwork.kernel.org/patch/10814921/#22486971

> ---
> v2: added comments about the relation to ARM arch timer
>      rebased onto v5.1-rc1
> v1: https://patchwork.kernel.org/patch/10814921/
> ---
>   drivers/clocksource/exynos_mct.c | 4 ++--
>   include/linux/cpuhotplug.h       | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 34bd250d46c6..6aa10cbc1d59 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -209,7 +209,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>   
>   static struct clocksource mct_frc = {
>   	.name		= "mct-frc",
> -	.rating		= 400,
> +	.rating		= 450,	/* use value higher than ARM arch timer */
>   	.read		= exynos4_frc_read,
>   	.mask		= CLOCKSOURCE_MASK(32),
>   	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> @@ -464,7 +464,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>   	evt->set_state_oneshot_stopped = set_state_shutdown;
>   	evt->tick_resume = set_state_shutdown;
>   	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> -	evt->rating = 450;
> +	evt->rating = 500;	/* use value higher than ARM arch timer */
>   
>   	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>   
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e78281d07b70..53fb48de9589 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -115,10 +115,10 @@ enum cpuhp_state {
>   	CPUHP_AP_PERF_ARM_ACPI_STARTING,
>   	CPUHP_AP_PERF_ARM_STARTING,
>   	CPUHP_AP_ARM_L2X0_STARTING,
> +	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>   	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>   	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>   	CPUHP_AP_JCORE_TIMER_STARTING,
> -	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>   	CPUHP_AP_ARM_TWD_STARTING,
>   	CPUHP_AP_QCOM_TIMER_STARTING,
>   	CPUHP_AP_TEGRA_TIMER_STARTING,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

