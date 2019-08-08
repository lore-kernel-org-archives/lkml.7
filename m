Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4114E217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dGKe+vIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfHHO5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:57:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53988 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:57:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808145710euoutp027432f882eb18baf6f2ce113a9c88dffb~4_nBGvv7z2617926179euoutp02i
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 14:57:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808145710euoutp027432f882eb18baf6f2ce113a9c88dffb~4_nBGvv7z2617926179euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565276230;
        bh=6841UKnoTDUqsOcLg4LGaS92LQST5PASS4awtxBo+80=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dGKe+vIL07G/T+JmMhebD6rj631eoFY6SoF8sHWP6d7WcdtYS/AjEq2C04iUul8oF
         df4OR/7B0RX7gVUq7KXsBwPxGUcRsjRup3sBxKwXcMIGi0patoZ2iqMy0NfMkWwhC0
         5V+L1rcN1MGwq2Ick/U93Y1nu0ykl8e/DJ37AB9s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808145709eucas1p2009ff3f720fc3dcdcd04fba30f05da71~4_nAW7cRJ0143101431eucas1p2W;
        Thu,  8 Aug 2019 14:57:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D8.EF.04309.5483C4D5; Thu,  8
        Aug 2019 15:57:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808145709eucas1p2a2ce421fc63e435cc35d63e0fadbc12d~4_m-l9EH21286212862eucas1p2e;
        Thu,  8 Aug 2019 14:57:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190808145708eusmtrp1b0f544ef62b1cb94860b2da9696f78d3~4_m-W4q2J1549215492eusmtrp1_;
        Thu,  8 Aug 2019 14:57:08 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-99-5d4c3845c365
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.DD.04117.4483C4D5; Thu,  8
        Aug 2019 15:57:08 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808145708eusmtip108abce8fda0b7858057d7de4792baa5e~4_m_7MX9_2561925619eusmtip1R;
        Thu,  8 Aug 2019 14:57:08 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] clk: samsung: Change signature of
 exynos5_subcmus_init() function
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <f8358f6b-a9a2-55e8-ab5e-aa64da6a0917@samsung.com>
Date:   Thu, 8 Aug 2019 16:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808144929.18685-1-s.nawrocki@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVYRzuveece447R69L85taH5cmyRVpTmWmlnWNP7TZsiTdcsLy1T0o
        9Y9pyVdmUmRaMnO5W+Qj2TXUla5Y2U35aqFGH2JW9IfvXCfLf8/v+T2/93me7WUIeRNlz0TH
        JfKaOHWMQiojG1/N9bj6cYFh+98UKLjaohqK65/9RnE9PU9o7lfOMMX16kukXFFPq4Qz3G1B
        3OOXn2jO1OXHLffVkr4yVW+fiVBND9ykVXW6TKkqt0GHVDN124Oo0zLvCD4mOpnXuPmck0U1
        v1+QJJSRV4cGC6hUZCSykAUD2BO0+nvSLCRj5LgSQZ+2hRaHWQQjS6USs0qOZxB0D7uuX3QY
        OglRpEWg7fhAicMUguqWkbV3bXA45Jny17AtdoVbFa1rHgTuR/B5pVJqXkixO9zuyEVmzGIf
        mPg6usozDIkdofxtgJnegkPg92g7JUqs4fX9MdIsscDe8Oe7l5kmsB2kzVZRIt4Bz6ZK1sIB
        7qIhrUaPxNTH4d2jNlLENjBhbKBFvA267+SQ4sENBDnNH2lxyFvtbyz9d30E2o0myuxMYGeo
        0buJ9FFYqp+TmGnAVjAwZS2GsIL8xkJCpFnISJeLakdY0BVKRGwP2WMrZB5SFG9oVryhTvGG
        OsX/fUsRqUN2fJIQG8kLHnH8FaWgjhWS4iKVF+Jj69Dqf+peNs42If3ieQPCDFJYsqm7AsPk
        lDpZSIk1IGAIhS07nOwfJmcj1CnXeE18uCYphhcMaCtDKuzY65tGQ+U4Up3IX+L5BF6zvpUw
        FvapiBkcDNn3UOoUGry5d3fwoRMlXl6eaXbD83DibMXB6sW08cnnDu7zGWq2xvLUkDLElOp2
        +HJZwpT+wIuL2rHOB/ZCY2iQ885JD+VIuvJHvdO49GeEP1dWNT3HxjukBznqyk8u02dc2E6X
        uQChN5vODLL1bQut/nJsaeBpQ57j5B4FKUSp3fcSGkH9FwpOuSxLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7ouFj6xBu/261hsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytfh3bSOLA5fH5WsXmT3e32hl
        99i0qpPNo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DJ2X/nNVLCIpeLWzSmsDYzHmbsYOTkkBEwkjh46AWRzcQgJLGWUOPx7
        I2sXIwdQQkpifosSRI2wxJ9rXWwQNa8ZJTYvfsgKkhAWiJeYcHES2CARAV2J9mX7wIqYBa4z
        Sqxev58JJCEk0M8o8anNGsRmEzCU6D3axwhi8wrYSbx69oANZBmLgIrEknPeIGFRgQiJwztm
        QZUISpyc+YQFpIRTwEbi6wtzkDCzgLrEn3mXmCFscYmmLytZIWx5ie1v5zBPYBSahaR7FpKW
        WUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwGrcd+7llB2PXu+BDjAIcjEo8
        vBryPrFCrIllxZW5hxglOJiVRHjvlXnGCvGmJFZWpRblxxeV5qQWH2I0BXptIrOUaHI+MFHk
        lcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgLNxQl9HlsPXMNb23
        E8xy62ccfWjMMr0g4r++srfT1uZt+RqTVpje+Wj64NKWepGF8xMZiz+7xdiomom3sb3cs2by
        qdlHln1yEcj6t7ms/UetxUFdh9/7zAK2XRGuClXuOlC/iJVv19X6GOaYU7pLK/aXPvwUwaL4
        v8bbYrly0HXfvQ5h21p3KbEUZyQaajEXFScCAIG0mE/cAgAA
X-CMS-MailID: 20190808145709eucas1p2a2ce421fc63e435cc35d63e0fadbc12d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438
References: <CGME20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438@eucas1p2.samsung.com>
        <20190808144929.18685-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 16:49, Sylwester Nawrocki wrote:
> In order to make it easier in subsequent patch to create different subcmu
> lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
> an array of pointers to the subcmus initialization function.
> 
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Tested-by: Jaafar Ali <jaafarkhalaf@gmail.com>

I should have also added here
 Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
