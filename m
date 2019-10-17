Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8781FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC87F2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kmKV20v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408858AbfJQK3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:29:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43365 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405814AbfJQK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:29:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191017102945euoutp010fe3881d10b331f2b0cc2eb402f15fc4~OaHhNTD9t2820928209euoutp01p
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:29:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191017102945euoutp010fe3881d10b331f2b0cc2eb402f15fc4~OaHhNTD9t2820928209euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571308185;
        bh=ZjIFPBGEjo2kDW295EaM/UizGZcq0H56U/i+RZZh32U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kmKV20v+PWAl221+OHslwAHevjRfAz4UlMHjs2nN1cuYjLtBDeakSUdZzFp7jkAjB
         2ZAlIwmN4lFjvZQSsZY8Iz3i/k32yrfAMHjmmaKDnQa4YCY55Hn8yk0aA9RPQzxuAg
         yvAW7QvfVC/oIo7RW6DR8IlPPitGvKi/yREGa6OA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191017102945eucas1p241a81734c92bb401a9c8c72c9fc93ad3~OaHgr8O6_1641016410eucas1p2-;
        Thu, 17 Oct 2019 10:29:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.4F.04469.99248AD5; Thu, 17
        Oct 2019 11:29:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191017102945eucas1p2e765a04e0f7e7865b1bc3534aecf973f~OaHgcwUgz1599815998eucas1p28;
        Thu, 17 Oct 2019 10:29:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191017102945eusmtrp18c1be788566b9fa0ce53e979a01b0c52~OaHgcAeOq2403524035eusmtrp1f;
        Thu, 17 Oct 2019 10:29:45 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-22-5da84299f21a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.36.04166.89248AD5; Thu, 17
        Oct 2019 11:29:44 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191017102944eusmtip1ca23aafdf49f11a74c15364bafc60170~OaHf8aDdC0261702617eusmtip1i;
        Thu, 17 Oct 2019 10:29:44 +0000 (GMT)
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <3cc6b317-5fab-ee46-cd27-d3a71b436dfa@samsung.com>
Date:   Thu, 17 Oct 2019 12:29:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010135507.GS2036@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O2eXs9Xqcxq+WCStCxjkJaIOFZbRj0H9sB+VJdNOeVJRp+yo
        qaWJis1hapa3YWiUadO8DDUTM1NwhpeVdhUTLbEhLfCWFlo5zyz/Pe/zPs/3Pg98FClvE7pS
        YeoYVqNmIhQiqaCp66d5T/GxSpWXocmJri+qFdL5Y+MiumrqC6LLpouEtNlcJ6ZH734k6B9v
        tAQ92FIioovMbQRdP6c8KlU+1X8SK42GTJFy+F2rSJmz5KXMbjAg5Yxxq5/ovPRwMBsRFsdq
        PH0uSEON8y0oul0cP7Y4Q6agGyIdklCA98FiQTOpQ1JKjisR1P7qE/DDLILP1koxP8wgaLN0
        EauWuu55u6oCQfrQY7vKiqCjvVpoUznhy5A3OSuwYWe8Hd7OP1txkHiSgDvdPci2EGFv0Fl1
        y0koSoZ9IOe9h40W4J0wVZ6x4t2EVTCyYCJtWIYd4WXx+AovwXsh81vGyjMkdoMn1hKSxy4w
        NF5K2G4B7hdDtaXHHvs4aAtm7dgJJk0NYh5vgZ7bWQLekIZgrJ+vAzgLwWBqEeJVh6DT9Fpo
        S0pid6ht8eRpX8ioMpM2GvAG+GB15ENsgLymQjstA22GnFfvAr2p5t/ZF68GyFyk0K+ppl9T
        R7+mjv7/3TIkMCAXNpaLDGE5bzV7xYNjIrlYdYjHpahII1r+VT2/TdPNaG7gYgfCFFKsl+Wi
        CpVcyMRxCZEdCChS4SwrTX+gksuCmYREVhMVpImNYLkOtJkSKFxkVx1GA+Q4hIlhw1k2mtWs
        bglK4pqC7p8EP8l+S9DztjzpQpLSLX+idbjRwKYeuDlScAQx5YGSWzvCvydRk3+czJ0PfbWe
        fYHb6DTirHvK0iOWGNbWZY7rXGr6k2vPdRX6T9w7xcyesKQ2IsUAVx/lIPXvjWdU5RuvwUFZ
        RHNAVLZ8Ktkn8Wv0gLqu93rL6aF1Z0wKARfKeO8mNRzzF0pkl7dRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7oznFbEGnxdZGOxccZ6VoupD5+w
        Waz++JjRYsGnGawW589vYLd4MPcmk8W3Kx1MFpd3zWGzmHF+H5PFxq8eDlweO2fdZffYtKqT
        zePOtT1sHv1/DTz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEvY9P3XYwFB9grHv75zNzA2M7WxcjJISFgIrHhxHeWLkYuDiGB
        pYwSTf/esEAkZCROTmtghbCFJf5c62KDKHrNKLFh1kdGkISwQJrE/cOPwWwRAWWJq9/3gk1i
        FnjDJPFn6T6wSUICS1gk9lzQBrHZBAwlut6CTOLg4BWwk+i/rgcSZhFQlfi4tI0FJCwqECux
        aa8ZSJhXQFDi5MwnYFM4BYwkOt+0ga1iFjCTmLf5ITOELS+x/e0cKFtc4taT+UwTGIVmIWmf
        haRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMy23Hfm7ewXhpY/AhRgEO
        RiUe3gmMy2OFWBPLiitzDzFKcDArifDOb1kSK8SbklhZlVqUH19UmpNafIjRFOi3icxSosn5
        wJSRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBcdbcHr3g0yZn
        mBqYfp65nsyoIHBd5VPSzI7nNjkZrsLsYYGqjgfa5/YU88YJvcsvEJIIOatTsGXnlffJ5oeY
        Z5f3hr+r+errYtmzKF5nHcuFS5IuEo0Cq3ikzkaq68ySVZ7x+9i+iPaYR05bryzdu8dSZVrJ
        lHPdvYkP69zmRNzkvvVZ/OhrJZbijERDLeai4kQAhuEDhOECAAA=
X-CMS-MailID: 20191017102945eucas1p2e765a04e0f7e7865b1bc3534aecf973f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008180759epcas3p3c367142db499635c71d9601dd3e63956
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008180759epcas3p3c367142db499635c71d9601dd3e63956
References: <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
        <20191008161535.GN4382@sirena.co.uk>
        <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
        <20191008171747.GS4382@sirena.co.uk>
        <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
        <CGME20191008180759epcas3p3c367142db499635c71d9601dd3e63956@epcas3p3.samsung.com>
        <20191008180750.GT4382@sirena.co.uk>
        <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
        <20191009141352.GC3929@sirena.co.uk>
        <c1a50291-5260-357d-1701-47526dbcd62c@samsung.com>
        <20191010135507.GS2036@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10.10.2019 15:55, Mark Brown wrote:
> On Thu, Oct 10, 2019 at 12:19:55PM +0200, Marek Szyprowski wrote:
>> On 09.10.2019 16:13, Mark Brown wrote:
>>> We should revert the enable call, it shouldn't be required, and ideally
>>> the default balancer could be updated to only make configuration changes
>>> if they're actually required which would help avoid triggering any such
>>> things in future if we don't absolutely have to.
>> Okay, Then in case of regulator core - do you accept the initial patch
>> as it indeed forces the default balancer to avoid unnecessary changes,
>> or do you want me to rewrite it to assume min_uV = current_uV for the
>> already enabled regulators during the initial balancing, like suggested
>> by Dmitry?
> Neither, I'm suggesting you make the change above.

I've posted a revert:

https://lkml.org/lkml/2019/10/17/267

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

