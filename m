Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B95C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0F821880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lqejq1Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfHHMOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:14:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50702 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfHHMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:14:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808121439euoutp022ab05abc92baba8aab9d052a9626e40f~48ZH1XlW-3089330893euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 12:14:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808121439euoutp022ab05abc92baba8aab9d052a9626e40f~48ZH1XlW-3089330893euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565266479;
        bh=Kfg3TIFWVX/aMRLF2Z40ddqnbp+FhuwEieRXHM+KmiI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lqejq1QnJoGDwgGvFSV9Nd8L4GWqQFnkrPHjQPsuiSLJyvBPLbP9RTUaBAODnwc90
         tG/cPx240QkaV1cjHhDVrsIT2EO8tmrhUzhx10kFpPiGLhh2ozFRsCqVIz9jXoYeJA
         kEssBF0ywYZGI6OfGHnNaRFrwxr76YaDzIv9vHuU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808121438eucas1p12f5deb7d85acd79173b30a83858fea93~48ZHKZllV0058700587eucas1p1s;
        Thu,  8 Aug 2019 12:14:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 05.97.04374.E221C4D5; Thu,  8
        Aug 2019 13:14:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808121438eucas1p12c089f64953e2d9f8c7c2dcceae69942~48ZGRckvF1125411254eucas1p19;
        Thu,  8 Aug 2019 12:14:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808121437eusmtrp1bca8d024f9c7602bef217c9a2ccd2495~48ZGDG5Bu2440524405eusmtrp1V;
        Thu,  8 Aug 2019 12:14:37 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-da-5d4c122e958c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.39.04117.D221C4D5; Thu,  8
        Aug 2019 13:14:37 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808121437eusmtip2ef64e3e8618fe528509c92148a2e8bbd~48ZFlNImP0045500455eusmtip2q;
        Thu,  8 Aug 2019 12:14:37 +0000 (GMT)
Subject: Re: [PATCH 2/2] clk: samsung: exynos5800: Move MAU subsystem clocks
 to MAU sub-CMU
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, linux@armlinux.org.uk,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, krzk@kernel.org,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <fb033201-b798-e3f9-fbdc-0332b422e987@samsung.com>
Date:   Thu, 8 Aug 2019 14:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eeba8348-4c41-32c5-39f2-c693aafe6c4f@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7p6Qj6xBmeeqVtsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytfh3bSOLA5fH5WsXmT3e32hl
        99i0qpPNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDKWXl7CVDCPuWLCpvfsDYxHmboYOTgk
        BEwkFj6Q7GLk4hASWMEo8XjvLDYI5wujxKx7n9khnM+MEvt/3WfuYuQE67j06xwrRGI5o0TL
        xGtQzltGidN/l7OBzBUWiJVY+7gCpEFEQF+iu+0KI0gNs8ALRomee6/YQRJsAoYSvUf7GEFs
        XgE7icfbToPFWQRUJG6+PAoWFxWIkPj04DArRI2gxMmZT1hAbE4Be4lLHd/B6pkFxCWavqxk
        hbDlJba/ncMMskxC4BS7xLMrfewQZ7tI3N7fxQJhC0u8Or4FKi4jcXpyDwtEQzPQdbtvs0M4
        Exgl7h9fwAhRZS1x+PhFVpDXmAU0Jdbv0ocIO0o87wIpAYUkn8SNt4IQR/BJTNo2nRkizCvR
        0SYEUa0i8XvVdCYIW0qi+8l/lgmMSrOQvDYLyTuzkLwzC2HvAkaWVYziqaXFuempxcZ5qeV6
        xYm5xaV56XrJ+bmbGIEJ6vS/4193MO77k3SIUYCDUYmH98Qp71gh1sSy4srcQ4wSHMxKIrz3
        yjxjhXhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTCK6J3R
        yDQskSmJuht+6quaSN2nxHImaUtv7YWClxtfZp5qeZ5q+EfC4svN9Qd3LQpOPf5oXt1m3Y+a
        Acmu34z1VXRF1ZQc5qzcGVm0ZsdfdbNXbp9a/Be/Krx5ezon0zSDstAlalseeAldKFS60u17
        Q1a7XOz+SpWzRo8t7BaKhSbUnlqacUqJpTgj0VCLuag4EQCsAgc7TAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7q6Qj6xBh93a1tsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytfh3bSOLA5fH5WsXmT3e32hl
        99i0qpPNo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DKWXl7CVDCPuWLCpvfsDYxHmboYOTkkBEwkLv06x9rFyMUhJLCUUeLd
        u9VADgdQQkpifosSRI2wxJ9rXWwQNa8ZJWZevQhWIywQK7H2cQVIjYiAvkR32xVGkBpmgReM
        Ejc+bmOCaPjGKLHh52xWkCo2AUOJ3qN9jCA2r4CdxONtp9lBbBYBFYmbL4+CxUUFIiQO75gF
        VSMocXLmExYQm1PAXuJSx3ewemYBdYk/8y4xQ9jiEk1fVrJC2PIS29/OYZ7AKDQLSfssJC2z
        kLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmBEbjv2c8sOxq53wYcYBTgYlXh4
        C054xwqxJpYVV+YeYpTgYFYS4b1X5hkrxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAZJFX
        Em9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTChhJwQZftf473/eYa1zf
        wnRvzzTfG7b2xke8MzrTuiLq09LlasP6rpYba/2x++7psjL0TnP2hWv/pO8LfmM4cu1PtOC1
        mYo6myZbfFa9eHWHxEYvb749ptMtG6IDn/yszyiUk7RmWGG5L/ZVsmXObQOJpzvW/9V6MH/J
        GSML6R0tp5hEHbVO+ymxFGckGmoxFxUnAgCW3FMF3gIAAA==
X-CMS-MailID: 20190808121438eucas1p12c089f64953e2d9f8c7c2dcceae69942
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908
References: <20190807162456.28694-1-s.nawrocki@samsung.com>
        <CGME20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908@eucas1p2.samsung.com>
        <20190807162456.28694-2-s.nawrocki@samsung.com>
        <eeba8348-4c41-32c5-39f2-c693aafe6c4f@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 13:48, Marek Szyprowski wrote:
>> +static struct exynos5_subcmu_reg_dump exynos5800_mau_suspend_regs[] = {
>> +	{ SRC_TOP9, 0, BIT(8) },
> I would like to add a following comment:
> 
> /* MUX mout_user_mau_epll */
> 
> to the above line to indicate which clock it refers (like it is done for 
> other sub-cmus).
 
Good point, I will resend with that comment added.

-- 
Regards,
Sylwester
