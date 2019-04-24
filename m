Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30389206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zve1s9ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfDXIK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:10:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37904 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfDXIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:10:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190424081023euoutp01ff7bc3f2af3b2710faddafff2004ecad~YWrl5oY8U1810718107euoutp01m
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:10:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190424081023euoutp01ff7bc3f2af3b2710faddafff2004ecad~YWrl5oY8U1810718107euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556093423;
        bh=GEsqOXMrECh6cwyp8/WLytlYTmzJJXGufR01sxb+3XA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Zve1s9ekDmXDZaOBrFP049o58y44tNE6DHGFPV7T8XjLMnZ34P5anBtodw/7bzAQt
         RC+OQrHm4PViP+mV02TEDcJGu/4WwYEymORiGd3hBx7vCUc1Bxw9pNQP1opv8thTxH
         z6Rg0ZIuEt8xY2trA0W3VCmAEY5cmt/GtBXL/E8Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190424081023eucas1p2f6f7bce38eca4e6175488c6cb8ffa6f9~YWrlLfhE42717827178eucas1p2X;
        Wed, 24 Apr 2019 08:10:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.B3.04377.EE910CC5; Wed, 24
        Apr 2019 09:10:22 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190424081022eucas1p144890137465baf0d4169054b68e2983e~YWrkZJyKg2554125541eucas1p1F;
        Wed, 24 Apr 2019 08:10:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190424081022eusmtrp1489ce7813bb6fbaf7d3a9cf1f6d52ed8~YWrkLBy6T0345603456eusmtrp1c;
        Wed, 24 Apr 2019 08:10:22 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-01-5cc019eefdb3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1B.2D.04140.DE910CC5; Wed, 24
        Apr 2019 09:10:21 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190424081021eusmtip1ed3800c41567f07d9192d605727dcdc1~YWrjjAJQt0594005940eusmtip1P;
        Wed, 24 Apr 2019 08:10:21 +0000 (GMT)
Subject: Re: [PATCH RFC 4/8] soc: samsung: Add Exynos Adaptive Supply
 Voltage driver
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <1d2238be-1758-2413-42f1-d571706de766@samsung.com>
Date:   Wed, 24 Apr 2019 10:11:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc9v8bcQs9HmiDWECCkfQCh-Ktzk9Vqq01ccUm7UG54uQ@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3vvdhWv/JzFTvaikURGDy3kRmEFChMK9Z+wMuyWF3u4OXbV
        tILsMZuPzAx1LjU1K5sr09LVwoqlzlq4JMpSbMIGYaEQDaJ3btfK/77zne9853xwaEI+QEXQ
        BzU5vE7DZSmlwWR3/1fXqqn5j9PWdhlj2Q5jO8UO+95T7OXeQYo97/lIsC7XbRnb6XlNsS9t
        dVLW6HooYW/2jsnYq8NDEnb0ZKuUbe7yyVh9T69sC6OyNFiQqtNcLFXdaTmhKr9rRqrPnYuT
        qV3BmzL4rIN5vG5N3N7gA57CJkL7kMp/XThBFSIzWYKCaMDroWO4gSpBwbQctyJoq29FYuFD
        cKavZabzGUF168C/Eb2+lBAb1xGcP/tsRjWJ4MVEm8yvCsc74N6rfsKP5+IVMPzzS0BEYCcB
        1lpDwEqKo+FcX/n0QppmcBw8P5Xjp0kcCeXuqoDPPJwK7v7blB8zOAye1noDo0E4BSq9EwGe
        wAo45bsxg5eAdbIucB3gdzK41XxN4vcHHA8nPZFignD44LgrE/FCcF4sI0X9aQRlD0ZlYlGB
        wO1oRKJqIzxxDFF+I2I6TbttjUhvhQFzERL9Q+HNZJh4QyhUdtcQIs2AoUguqpfBd3ONRMQR
        UOr9TVYgpWlWMtOsNKZZaUz/9zYi0owUfK6gzuSFGA1/ZLXAqYVcTebq/dnqTjT9X85fDt89
        ZPuxz44wjZQhTHLIozQ5xeUJBWo7AppQzmXWW6cpJoMrOMrrstN1uVm8YEcLaFKpYI7NGd8t
        x5lcDn+Y57W87m9XQgdFFKKlCbUddGwSY9eMJ1KLdoZbG+uX96gNIx3eWMtI1NvRIsOxVO2G
        saaGmGrL0MpvxeopF52IB48PVH2K/4o+LN5msBQ75Z7NtqS4kEzFngStY1yROuUY9B5Kvx+a
        dcm4rmhR3ubtiXO0F1J05ZM9Cb/k3KMrSW67T280ufNPdytJ4QAXHUXoBO4PhumRrlsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7pvJQ/EGCy4ZmmxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyWHvkLrvF0usXmSxuN65gs1i09Qu7
        ReveI+wOvB5r5q1h9Ni0qpPNY/OSeo++LasYPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeNywkLlgH2vFtYaXrA2Mq1i6GDk5JARM
        JFpbu5lBbCGBpYwSv88IdjFyAMWlJOa3KEGUCEv8udbF1sXIBVTymlFi6vQ/YL3CAmESV/e0
        sYPYIgKaEtf/fmcFKWIWOM0ssfrNNhaIjg4miRcdC8E2sAkYSvQe7WME2cArYCdxpqkEJMwi
        oCrRd38q2CBRgQiJM+9XgC3gFRCUODnzCZjNKRAoMenJS1YQm1lAXeLPvEvMELa4RNOXlVBx
        eYntb+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMFq3
        Hfu5ZQdj17vgQ4wCHIxKPLwBPPtjhFgTy4orcw8xSnAwK4nwmmwHCvGmJFZWpRblxxeV5qQW
        H2I0BXpuIrOUaHI+MJHklcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+Lg
        lGpgVHSW54h5sKHp9UGHuO6lh7fsYf7WVrViVYDF3QXZIWWLDt7bGVltt3SjwPbnTO8STvgr
        J5asWmlxdMGeJvtLoj67vnQsYZ7buV30TvRylcTCwn67rzYb7yV6/qh/FZ8yQ0LQbb1t95xJ
        xacSlaX6fKKX6a+sl2u/x8axIi3XTXlrPNtq23kJSizFGYmGWsxFxYkAslKD3ewCAAA=
X-CMS-MailID: 20190424081022eucas1p144890137465baf0d4169054b68e2983e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8
References: <CGME20190404172238epcas2p21ef28f46b728127dcd6e8ee72752a1b8@epcas2p2.samsung.com>
        <20190404171735.12815-1-s.nawrocki@samsung.com>
        <20190404171735.12815-5-s.nawrocki@samsung.com>
        <CAJKOXPc9v8bcQs9HmiDWECCkfQCh-Ktzk9Vqq01ccUm7UG54uQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 12:50, Krzysztof Kozlowski wrote:
>> +static int exynos5422_asv_get_table(void)
>> +{
>> +       unsigned int reg = exynos_chipid_read(EXYNOS_CHIPID_REG_PKG_ID);
>
> One more thought: you read this register multiple times in the same
> function. I think it is not needed - just read once, store the value
> and use the helpers to parse it.

Yes, I have noticed that as well. I'm not sure though if it is worth 
to additionally cache registers manually like this when we use the 
regmap.  I have already converted that code to use the regmap API for 
v2.  And these are barely few registers reads at the driver 
initialization time, not any hot path.

-- 
Thanks,
Sylwester
