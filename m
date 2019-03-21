Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAD421915
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fuh3H1KZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfCUMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:30:00 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:49618 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:30:00 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190321122957epoutp036029e6fedc06ec6657665ee241584808~N_SgdWYjd0667306673epoutp03Z
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:29:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190321122957epoutp036029e6fedc06ec6657665ee241584808~N_SgdWYjd0667306673epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553171397;
        bh=HKQ/FarAnJYQ4yiEhsnpBn/53YkL899I1IWds8wPdYI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fuh3H1KZi8RFWP6nZMg4UWbOKVWunXSGEWT/Db32bulqcEWzOUXd66wovHYdamJv5
         N0dHfpIlha0YRA4MhGtuw+J0BJFd+v+SwWVSjqEtpkMPG4grNyFxGeAW5bn5Wub7MU
         godI1KnkBxaj0+VPoTjkyXSl+1LOshb3DjHB1dGY=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190321122953epcas1p3bea6695c3e2677f52252dd8c9e32296f~N_SdVS1zO1805418054epcas1p3_;
        Thu, 21 Mar 2019 12:29:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.09.04108.1C3839C5; Thu, 21 Mar 2019 21:29:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190321122953epcas1p192f681df4dff207eae429e7b59db46af~N_ScqtbYV1075710757epcas1p1X;
        Thu, 21 Mar 2019 12:29:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190321122953epsmtrp2d99e115518aa2dd51d35a615496e9e11~N_ScnejxG0292502925epsmtrp2W;
        Thu, 21 Mar 2019 12:29:53 +0000 (GMT)
X-AuditID: b6c32a39-8b7ff7000000100c-1d-5c9383c175ce
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.6B.03692.0C3839C5; Thu, 21 Mar 2019 21:29:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190321122952epsmtip25680efc3cb9a9606d00ec5fcfc74aca4~N_ScajTKM2765327653epsmtip2W;
        Thu, 21 Mar 2019 12:29:52 +0000 (GMT)
Subject: Re: [PATCH v2] clocksource: exynos_mct: Increase priority over ARM
 arch timer
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <af0dfbcb-4a9c-7d41-b08d-994d3a57604e@samsung.com>
Date:   Thu, 21 Mar 2019 21:30:08 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321082608.21366-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmtzvvrtXquixPg5bdnhrqrja7ilrQgwuZmYFFGXrT2xT3YndK
        VvSgkY/eDaPWw8gsk2S1dIllkpklgRPsRWRYswdFalpR/qFtu4v87zvnfN855/v9DoEpHLiS
        KDBYeLOB01H4JKnrYUR01IODtix1qVXN3DrjCGIujsxm3O6bMsbpeRHE9DSfx5kz7vsSpr69
        V8bcdlZiKwjWWVeOs29e3MPZga4uGXv7yj72WEMdYkecqnR8S2FSPs/l8eZw3pBrzCswaJOp
        tRuzV2Zr4tV0FJ3ALKPCDZyeT6ZWpaZHrSnQedehwos5XZE3lc4JAhWTkmQ2Fln48HyjYEmm
        eFOezpRgihY4vVBk0EbnGvWJtFodq/EScwrz+598lZl+he609XzH96OGkAoUTAC5FF66Tssq
        0CRCQTYh+NzXIRGDYQTPRt2Byi8EL28MBf2TWIdf42KhBcHgWE2ANYjg6vBl5GNNJzeDq+et
        nxVK2hG4PY2YL8DIRgSfjtllPhZORkLr51e4D08j58Lz3x6/Wk6mgPuCzTuPIKTkAnA4l/nS
        M7xNBz/clYqUEOg82+/HwV661XMc82GMDIPX/VUSEc+Bg43n/HOBHMfh8NAdmehhFdQdqQ34
        mQ5fHjcE8koYGWjBRbwbrne246K4DEFDa3dAEAetNTaJbzmMjABHc4w4bCoM/Dzi3xlIOZQd
        UojsedDT1ysR8SyoLi0PtGdhtNuFnUBz7RPs2CdYsE+wYP8/7BKS1qGZvEnQa3mBNmkm/rcT
        +Y81MqEJdXSltiGSQNQUORt7KksRxBULJfo2BARGhcqbt9qyFPI8rmQXbzZmm4t0vNCGNN7H
        PokpZ+QavadvsGTTmti4uDhmKR2voWkqTO5YsTJLQWo5C1/I8ybe/E8nIYKV+9HqzJxS65IC
        +pHlz+bMa+04u/eUyVP1bt722E2Jxe75Gaqh6vfvkmTV2yfv+LZTVXngo2o0sdLTX8mPtzQ1
        /TCHdRjJvpzR9Rpiz8OnztxtNZ0RClX8F3t7uXKqZ2vCYmP1FtXz5bUpexdu+F7y4NXNRfZe
        61NqLE2b4Tr6tr5wXRolFfI5OhIzC9xfDRKDbsIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvO6B5skxBv0vrSw2zljPajHvs6zF
        +fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i86apzA4cHptWdbJ53Lm2h83j3blz7B6bl9R7
        9G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8aTE6/ZC76JVEy+/JGtgXGLYBcjJ4eEgIlEy6db
        bF2MXBxCArsZJf7sfMgGkZCUmHbxKHMXIweQLSxx+HAxRM1bRomvN2azgtQIC0RIbLt8D6xZ
        RGAWo8S1tZdYQRxmge2MEle39DJBtExklNg6/QTYWDYBLYn9L26A2fwCihJXfzxmBLF5Bewk
        zs+dzAqyjkVAVWL9JnOQsCjQhrsXX7BAlAhKnJz5BMzmBCpvedzPDGIzC6hL/Jl3CcoWl7j1
        ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgiNMS3MH4+Ul8YcYBTgYlXh4PYwmxQixJpYVV+YeYpTgYFYS4d0VPTlGiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsb0VhYvvbPyZ/b4fhLP
        F2Nf8Jcv4NULp6qOV3oZ0XUJJ088W5cZmm4/UdjXl6FnUuzG1H530YmdpmW9uwPfG3B/355+
        p+6x/5EaF+7KDTw9gZ+7D8pmrLx7bNblnwvS5fcdWCP/brbm25YtR3Z8iH0hrZl7usch9fRq
        zh+bOjbxLlpR1W122lKJpTgj0VCLuag4EQCNuWzZrAIAAA==
X-CMS-MailID: 20190321122953epcas1p192f681df4dff207eae429e7b59db46af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e
References: <CGME20190321082621eucas1p16d48ef152cd76edb7d46e8c773fa000e@eucas1p1.samsung.com>
        <20190321082608.21366-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 19. 3. 21. 오후 5:26, Marek Szyprowski wrote:
> Exynos Multi-Core Timer driver (exynos_mct) must be started before ARM
> Architected Timers (arch_timer), because they both share some common
> hardware blocks (global system counter) and turning on MCT is needed
> to get ARM Architected Timer working properly. Increase MCT timer rating
> and hotplug priority over ARM Archictected timer driver to achieve that.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v2: added comments about the relation to ARM arch timer
>     rebased onto v5.1-rc1
> v1: https://patchwork.kernel.org/patch/10814921/
> ---
>  drivers/clocksource/exynos_mct.c | 4 ++--
>  include/linux/cpuhotplug.h       | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 34bd250d46c6..6aa10cbc1d59 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -209,7 +209,7 @@ static void exynos4_frc_resume(struct clocksource *cs)
>  
>  static struct clocksource mct_frc = {
>  	.name		= "mct-frc",
> -	.rating		= 400,
> +	.rating		= 450,	/* use value higher than ARM arch timer */
>  	.read		= exynos4_frc_read,
>  	.mask		= CLOCKSOURCE_MASK(32),
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> @@ -464,7 +464,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  	evt->set_state_oneshot_stopped = set_state_shutdown;
>  	evt->tick_resume = set_state_shutdown;
>  	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> -	evt->rating = 450;
> +	evt->rating = 500;	/* use value higher than ARM arch timer */
>  
>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
>  
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e78281d07b70..53fb48de9589 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -115,10 +115,10 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_ACPI_STARTING,
>  	CPUHP_AP_PERF_ARM_STARTING,
>  	CPUHP_AP_ARM_L2X0_STARTING,
> +	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>  	CPUHP_AP_JCORE_TIMER_STARTING,
> -	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_TWD_STARTING,
>  	CPUHP_AP_QCOM_TIMER_STARTING,
>  	CPUHP_AP_TEGRA_TIMER_STARTING,
> 

As the cover-letter, the arch-timer of Exynos SoC
used the h/w block of MCT. I agree.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
