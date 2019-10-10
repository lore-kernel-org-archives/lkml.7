Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44946C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA702190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vBLh+U+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfJJKT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:19:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35225 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJJKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:19:58 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191010101956euoutp01eb9aa0781ff4a70ba360804db1d3c46f~MQd8xuHUX0866608666euoutp01V
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:19:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191010101956euoutp01eb9aa0781ff4a70ba360804db1d3c46f~MQd8xuHUX0866608666euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570702796;
        bh=rPGMLa4IDLLuWtAjZwyfz5N0eLTRTzLhEwZMDWJ47vY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vBLh+U+o7nEsSwLpdbKYc3lgbgwBEkFMIbKtipAlaBhi0sZEiXgQJnxtyt/1e6cFK
         i7qUCQ9LdFgpQ/T0lYdkjA/Ckf6EnWCA8XGxYNHJElfMvyq0axigZ7G09sjn9LxwhE
         FjtDc1NVbL88d76zcPgqL958CeAHf0XHNaHeZMpI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191010101956eucas1p228077496a7f6c6e3e64b524dc2baf2ff~MQd8UJWVq1367813678eucas1p2L;
        Thu, 10 Oct 2019 10:19:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1A.08.04374.CC50F9D5; Thu, 10
        Oct 2019 11:19:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191010101956eucas1p18ba34263e4f5f23d2968ab9230512c0d~MQd77fe_w2168821688eucas1p1H;
        Thu, 10 Oct 2019 10:19:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191010101955eusmtrp15c00b0ff1a53f51aa0cb097fb3e4aa1a~MQd760wQg2948529485eusmtrp1E;
        Thu, 10 Oct 2019 10:19:55 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-9e-5d9f05cc0fe0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.D1.04117.BC50F9D5; Thu, 10
        Oct 2019 11:19:55 +0100 (BST)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191010101955eusmtip26af5944c8f7b126ae16eab7bae6b30e4~MQd7bPntl1301113011eusmtip2G;
        Thu, 10 Oct 2019 10:19:55 +0000 (GMT)
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
Message-ID: <c1a50291-5260-357d-1701-47526dbcd62c@samsung.com>
Date:   Thu, 10 Oct 2019 12:19:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009141352.GC3929@sirena.co.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O2fn7Gw4OU5tnyaVM4UCbyhxuklh4X5FPwqxlDrlSS03bcdr
        +UO0zIZkal4amlK0bDNvmKnpzAUtUZrXMumiaBcGo0zNiVp5dqz897zP5XveFz4ClXZjXkSi
        KpVRq+gkOS4WtL1YsgQMYDWxwb3FHlRzZSNGlU3N4JRhdhpQtT8qMcpiaRJSk9VvEernaAFC
        jXRW4VSlxYhQzQuKA2JFh/a9UNGiv44r3r3uwhVFq8GKG616oJhr2XIUPyHeF8ckJaYz6qDw
        0+KEepsOSbHjmXrrPTwHPMM0QERAMgw+1Y0JNEBMSMk6AEvyylF+mAfwcY8O44c5ABfnOBsf
        MXTkIrzwYE0o1TjekpI2AD/1SDnsRp6DJdZ5R8Cd9IVji92ODpS0IvDWy37ACTgZAjU2Dc5h
        CRkOi+ytDl5A+kFd9wLKYQ8yFn6wm1He4wr7bs+sPUQQorVsx2oUR6PkVvjEVoXyWAYnZmoc
        y0FyWAinl3MQfutDcHH0oZDHbtBqbl3H3rC/tFDAB/IAnHr1SMgPhQCO5FYC3rUXPjcPYVwz
        Su6AjZ1BPH0Q5hssKEdD0gWO21z5JVxgSVvFOi2BBflS3u0PteaGf7W9g8PoTSDXbrhMu+Ec
        7YZztP97a4FAD2RMGquMZ9hQFZMRyNJKNk0VH3g2WdkC1j5V/y/zQjswrpwxAZIAcmdJQl91
        rBSj09kspQlAApW7S+5qq2Klkjg66xKjTj6lTktiWBPYTAjkMsllp8mTUjKeTmUuMEwKo/6r
        IoTIKwf4eA/oA7omys+Llo0pXz4eKbZmD63s39a1qT0qusJqQpg9BnZ7yeq3gnE/ldKecdw6
        kSeqbxy433CVYSNDfWZ1eEGcb0xMdkrQbtVhfBDLXjJER3S+uRPh5DNp9C+lj/2WFZY1en4X
        lUc6L0SF7wq76H8tv8nmmRnwuebrlboouYBNoEN2omqW/gOvo6+HUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7qnWefHGpw8YWGxccZ6VoupD5+w
        Waz++JjRYsGnGawW589vYLd4MPcmk8W3Kx1MFpd3zWGzmHF+H5PFxq8eDlweO2fdZffYtKqT
        zePOtT1sHv1/DTz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
        yshUSd/OJiU1J7MstUjfLkEvY83bZUwFP9gqVr1azNbAeIC1i5GTQ0LARGL1ziamLkYuDiGB
        pYwS6zq2skEkZCROTmuAKhKW+HOtiw2i6DWjxIfVN9lBEsICaRL3Dz9mBLFFBJQlrn7fywJS
        xCzwhkniz9J9LCAJIYHFLBJtJ8CK2AQMJbredoFt4BWwk+j/sQUsziKgKrFs71fmLkYODlGB
        WIlNe80gSgQlTs58wgIS5gRq3fk3HCTMLGAmMW/zQ2YIW15i+9s5ULa4xK0n85kmMArNQtI9
        C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYl9uO/dyyg7HrXfAhRgEO
        RiUe3gOn58YKsSaWFVfmHmKU4GBWEuFdNGtOrBBvSmJlVWpRfnxRaU5q8SFGU6DXJjJLiSbn
        A1NGXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxuV/PyZMvvzM
        /bHLapX8W07Laxv2v5bVzugpTFgkEbD0dkrtpsvR/Ve3Ou5Nm/Xxlsxp4RNP1MPmXH45c4vh
        Xv3Gy1/9QxeuUTT4VPLs+splZ8LTzQI+BVi85Y5Z0VodOo/75OorBU6nrym1W0xgvRu5fmfr
        Bd0Ve76rvg/Y5RNd7i9mtWxvi7QSS3FGoqEWc1FxIgBtqP7A4QIAAA==
X-CMS-MailID: 20191010101956eucas1p18ba34263e4f5f23d2968ab9230512c0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191008180759epcas3p3c367142db499635c71d9601dd3e63956
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191008180759epcas3p3c367142db499635c71d9601dd3e63956
References: <20191008124736.GJ4382@sirena.co.uk>
        <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
        <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
        <20191008161535.GN4382@sirena.co.uk>
        <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
        <20191008171747.GS4382@sirena.co.uk>
        <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
        <CGME20191008180759epcas3p3c367142db499635c71d9601dd3e63956@epcas3p3.samsung.com>
        <20191008180750.GT4382@sirena.co.uk>
        <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
        <20191009141352.GC3929@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 09.10.2019 16:13, Mark Brown wrote:
> On Wed, Oct 09, 2019 at 12:29:00PM +0200, Marek Szyprowski wrote:
>
>> Okay, then what is the conclusion, as I got lost a bit? How do you want
>> this issue to be fixed?
> We should revert the enable call, it shouldn't be required, and ideally
> the default balancer could be updated to only make configuration changes
> if they're actually required which would help avoid triggering any such
> things in future if we don't absolutely have to.

Okay, Then in case of regulator core - do you accept the initial patch 
as it indeed forces the default balancer to avoid unnecessary changes, 
or do you want me to rewrite it to assume min_uV = current_uV for the 
already enabled regulators during the initial balancing, like suggested 
by Dmitry?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

