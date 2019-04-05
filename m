Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0C217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XdyKKUmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbfDEItx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:49:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53584 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:49:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190405084950euoutp023592c0a29eee7817a5a910d5092ee426~Sh9mq9f1Q2346123461euoutp02h
        for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2019 08:49:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190405084950euoutp023592c0a29eee7817a5a910d5092ee426~Sh9mq9f1Q2346123461euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554454190;
        bh=U4VJyRIUX4N+ujQAVvD7OEQgLQFDTrqWaq7fN40sblo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XdyKKUmfnrfJaBpFS+N1MqF7yFFhQsyNKxD6sBiglkh5jhPmwh6ce+o+l7Eg9eXye
         OsaOGA2Jfvg9Cpkdjob+MHl1DJCMe+RpGszhpNRfMnyup8EVzl9svKMxFwQnkEjK9L
         ecaBlhqYB5LyfAQqTSpC+38k0j1iqOcLL7/NZp2E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190405084949eucas1p2c8827598489c3d7280713401b08827cd~Sh9l8ztPc1609316093eucas1p2O;
        Fri,  5 Apr 2019 08:49:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 88.53.04377.DA617AC5; Fri,  5
        Apr 2019 09:49:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190405084948eucas1p1a482e6daa4b89cdf261f7bd3a0c8498e~Sh9lRkITP2241122411eucas1p1a;
        Fri,  5 Apr 2019 08:49:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190405084948eusmtrp1b7f40905e7cb600cfa37f795ee7bf3fe~Sh9lDXNpK1694616946eusmtrp1t;
        Fri,  5 Apr 2019 08:49:48 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-8f-5ca716ad30e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 43.33.04146.CA617AC5; Fri,  5
        Apr 2019 09:49:48 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190405084947eusmtip17432c4cc1eca3a25b40bc49560a4ce1e~Sh9kerd_k1639916399eusmtip1K;
        Fri,  5 Apr 2019 08:49:47 +0000 (GMT)
Subject: Re: [PATCH RFC 1/8] soc: samsung: Add exynos chipid driver support
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
Message-ID: <3a381f69-da67-384a-dfe2-22e38c5570f7@samsung.com>
Date:   Fri, 5 Apr 2019 10:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdtdvQg69PLO4+aGAWjth-NzGToJUUPN0Jw6=zTCz9Bbw@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zlnO45mx2n6YqIx/FFKmtGPA5kVGQxEyn5FWrby4CU3ZVPT
        LqjJZF7ykog6vGGWOhWvOZkm5OZdnFppMLyEiqVowQamqeU8Sv57nud7nvd9H/hITDhIOJOR
        sjhGLpNEi7h8vKN/c+xco2NNyPmWGSHdUtxE0NOWZYKuMIwRdO7CKkYbjc08unVhiqA/6Uq5
        dLGxh0M3GmZ49NvpCQ5tSq3l0lXvLTxa+cHAuyoQN5Q3IHGrJoMrbqtOFue0a5DY3Op6i7jL
        9w1joiMTGLm33wN+ROGuT+zkicSWsQpuClIKMpENCdRFGJpaQpmITwqpWgQ7VWk8llgQDG5/
        5rDEjGA2Nx8/jJS+0R24ahCUrY/jLFlDMKpvRlaXPRUAhrafhBU7UGdhemeDsJowagQDbYlq
        fxSX8oFXfTn7AQHlB9Wajb2xJIlT7jC84mGVT1J3YK6/mWAtdjBUsrgftaGCYFeZw7VijHKC
        l5Y6gsVuoF0rxay7gJrlQfHvzIOz/aF+q57HYntYGWg/wC4wUpCNs4E0BNldJh5L8hDMDVQi
        1nUJ9AMThPU6bK9Ok86bla9B2ZwOs8pA2cLXNTv2CFt43VF0IAtAlS5k3e7wR1PEYbEzZC3+
        xfOQSH2kmvpIHfWROur/eysRrkFOTLxCGs4oLsiYJ14KiVQRLwv3ehQjbUV7/2tkd8DSiXTb
        D3sRRSLRccEZzrsQISFJUCRJexGQmMhB4Fq3JwnCJElPGXlMqDw+mlH0olMkLnISPDs2Hyyk
        wiVxzGOGiWXkh68c0sY5BVVMZvFPRxJLGT2+wXnx+iYZx/92Ud/oplYVlb9l/jGq/eJcoVR1
        9g7dUJoIz4/3sr+Fev7qxqLdJtYvh0gTy8eTMl0Co8z3x7ueF6amVWq2dP30sNGUHGR3Pb1b
        7ai36SwMWE2MM6rzXxTcnKauGOebUxjv7+2Bx9yXxe7dcyJcESHx8cDkCsk/bY2z+lsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7prxJbHGBz4o2CxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFtsenyN1eLyrjlsFjPO72OyWHvkLrvF0usXmSxuN65gs1i09Qu7
        ReveI+wOvB5r5q1h9Ni0qpPNY/OSeo++LasYPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIz
        tLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmPrPsOASf8XGc/PZGhhbebsYOTkkBEwk
        5izexd7FyMUhJLCUUWLDujbmLkYOoISUxPwWJYgaYYk/17rYIGpeM0qsP7yfESQhLOAtcWTz
        e1YQW0RAU+L63++sIEXMAqeZJVa/2cYC0dHBJLH6wXwmkCo2AUOJ3qN9YN28AnYSS1Z9ZwfZ
        xiKgInHqlRZIWFQgQuLM+xUsECWCEidnPgGzOQUCJf619rGB2MwC6hJ/5l1ihrDFJZq+rGSF
        sOUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMBo
        3Xbs5+YdjJc2Bh9iFOBgVOLhbWBZFiPEmlhWXJl7iFGCg1lJhFduJVCINyWxsiq1KD++qDQn
        tfgQoynQbxOZpUST84GJJK8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8T
        B6dUA6Noo2RVw6NTVlGpB5Zc/cjr3cTtJWp65my/2dKQ83Ifi5h/hud9Xa3Ps/az6amM2Ww2
        d28LfqoRSfHs13DNXbWusFns0VK11Sf8Lu0s7F2SdfXQy1rRqrhXbBtknyzV93z9tNybra/r
        EGP49NOpKYpsDCJe6k2Rn8NXfzse1Sfiu9WLs0lTXImlOCPRUIu5qDgRAEVhQvbsAgAA
X-CMS-MailID: 20190405084948eucas1p1a482e6daa4b89cdf261f7bd3a0c8498e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2
References: <CGME20190404172224epcas2p21b449c0ae8e36f7e800ae67c18db35a2@epcas2p2.samsung.com>
        <20190404171735.12815-1-s.nawrocki@samsung.com>
        <20190404171735.12815-2-s.nawrocki@samsung.com>
        <CAJKOXPdtdvQg69PLO4+aGAWjth-NzGToJUUPN0Jw6=zTCz9Bbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 08:53, Krzysztof Kozlowski wrote:
> On Thu, 4 Apr 2019 at 19:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>
>> Exynos SoCs have Chipid, for identification of product IDs and SoC
>> revisions. This patch intends to provide initialization code for all
>> these functionalities, at the same time it provides some sysfs entries
>> for accessing these information to user-space.

>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> [m.szyprowski: for suggestion and code snippet of product_id_to_soc_id]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Toy need to add your SoB here.

Will correct that in next iteration.

>> diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
>> new file mode 100644
>> index 000000000000..5cb018807817
>> --- /dev/null
>> +++ b/drivers/soc/samsung/exynos-chipid.c
>> @@ -0,0 +1,111 @@

>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
> 
> I commented Bartlomiej's patch which you included here. I did not
> receive any further feedback from him so I do not know whether he
> agrees with my comments or not... but if you send the same patch again
> without addressing these comments, I feel like ignored.
> 
> I stopped on first ignored comment.
> 
> Therefore please address be sure that you addressed my comments from
> Bartlomiej's patchset. If you do not agree with them, please let me
> know. The comments are here:
> https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=43565&state=*

I will drop that unneeded header inclusion in next iteration.  It was 
just my oversight, I somehow missed your previous comments.  And of
course your reviews are appreciated. 

-- 
Regards,
Sylwester
