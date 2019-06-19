Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B4C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E16620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="boobkESB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfFSJR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:17:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35919 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfFSJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:17:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190619091756euoutp024740b918bc3c1a0f2890372d648ebbd6~pjujj5RW61942219422euoutp02p
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:17:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190619091756euoutp024740b918bc3c1a0f2890372d648ebbd6~pjujj5RW61942219422euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560935876;
        bh=tkIJ6Zdk/r4opylr6EAzPBGo0oQmTLvcNpJPcBJpEcA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=boobkESBTTT8izIV5hAugqN3CjPDR0jVkm8uDBSWwKrvS49mWUY6GiSGr4x3IfTmB
         HFPkylAIygkGnfCg630V2rvIPzAQDM0D4Id+1lXCUbiggHAnv0G31IaXc034NyzyLI
         y2kk55jjXDWjmdNqLzXSez/fHKwFWYWcg6T8aofo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190619091755eucas1p2c7036ec9b6c8be09b2cf2f8a5ae6f103~pjuihnVfu2998329983eucas1p2G;
        Wed, 19 Jun 2019 09:17:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DA.9D.04377.3CDF90D5; Wed, 19
        Jun 2019 10:17:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190619091754eucas1p2edbfee21d2ec8feacc183927de9a0eae~pjuhufNCy2132521325eucas1p2l;
        Wed, 19 Jun 2019 09:17:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190619091754eusmtrp196587f03ea943b7a4b68b6e3d4d171c5~pjuhfdH3d0190801908eusmtrp1L;
        Wed, 19 Jun 2019 09:17:54 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-0a-5d09fdc3d42f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.B8.04140.2CDF90D5; Wed, 19
        Jun 2019 10:17:54 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190619091753eusmtip1fa0a4c315cf7b4226f56c37589e72378~pjugkhlax2980129801eusmtip1b;
        Wed, 19 Jun 2019 09:17:53 +0000 (GMT)
Subject: Re: [RFT 02/10] clk: samsung: Add bus clock for GPU/G3D on
 Exynos4412
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <97cf3337-44da-b5b0-0b45-e44ef5c90615@samsung.com>
Date:   Wed, 19 Jun 2019 11:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618190534.4951-3-krzk@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUxTWRj19q0Fiq8FwxecjGOjiZiouOZGjdHESd4/ifNDU0O06hMN0Gof
        RdEQEUShrcqgE51ChIgIVg1aCEgVFwQKkoANCAbEusW6IWLrymbbVyO5f879vnPuOSe5LKE6
        R8eyu3RpgkGnTVHTYWRty/fOeffG5InxtUWAj3W0yfBYYQuDr52povDQBQvCvT4PhSdq/yVw
        SVMHhbs/D9G40F1AYsvRUQqfePGOwJ2dVxlsf9FD4WHLEwp3OYppfKbzlgxfaRpgcHmvS4Zd
        9//G93u9NM5taGLweM81Etscowi/GW4lVwN/+exlxI/8KET80KNchm/4Ukry9dYBhrfb8mm+
        7stTinebnTK++vxBvrs1m+KP19gQ77X/mRChCVu5XUjZlS4YFqzaErazaNBD7i5B++pvPkdZ
        /mNCcha4JdDv+c6YUBir4ioRNA9bCeniQ9BRZw6yVJwXQUlf+i/FwLc+JJEqEHi7ykKKQQTv
        i1voACuKS4D3+e+oAI7m4qB37CsVIBGci4aRLjMZWNDcQjjWfDxooeBWwfilHFkAk9xs+Hiq
        J/jQNG4j+OrtIY4S2v5/GdTK/THOPssLcgguBrJ9FykJz4C6weJgIuAes3Dz4SGZlHstmKpc
        odZR8NZZw0j4D2g/aSElQQ4Cy41+RroUIHA7S0OKFXDP6fJbsH6LOKhyLJDGa6C5/QMZGAMX
        CY8GlVKISCisPU1IYwXkHVFJ7FkwYjsdihML5pcTZAFSWydVs06qY51Ux/rbtxSRNhQjGMXU
        JEFcpBP2zhe1qaJRlzR/mz7Vjvw/t33c6buOHKNbGxHHInWEgvOyiSpKmy5mpDYiYAl1tCI8
        R56oUmzXZuwXDPrNBmOKIDai6SypjlEcmPJ0k4pL0qYJyYKwWzD82spYeWwW0lQsDb/zsVy5
        OK+oIX/TbWrm5w3L64+a1fod6w9nxP+X2ZHVvawyd0tEfE3PMs+JU/80RbUaybLItMyE6PRP
        1Zk1erZa09Vnyp1z8Ea2vU/vKHe47657KJIXpyaLylee/ornE0Weeev3/GVi4pQzdA+S28I1
        FZqcI5Wl7teevYJRTYo7tQvnEgZR+xPtrR3etQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTURzAObuP3VmD21Q8GGRdiDJoNnXtGCZ9ES5GURkUltitLiq6zXY3
        yz6UVPYwNV1WNs2tSCN7zlapOKGL+SpaPpplLp8gIWZl2UutzRHI+fKD/+/HOQf+FKZwEKFU
        us7IG3RcJkMG4C/mWj1rxVlZ8rrH3WGo8FW7BM2aW6TIXvaAQJPVBQD1fhsj0N8nJRiyNr8i
        UM/3SRKZB4pxVHBmhkAXRsYx5HI9lKLaETeBvhR8IFB3QwWJylxNEnSv2SNFVb2dEtTZEY86
        eqdIlOdslqI5tx1HNQ0zAH380oZvguzdyruA/fPbDNjJt3lS1jltw9l6i0fK1tacI9mn04ME
        O3C+VcI+unmc7Wk7QbBFjhrATtUu27Y4SRlr0JuM/PI0vWDcyOxRoUilKgYpI6NjlKooTfKG
        SDUTERd7kM9Mz+YNEXH7lGnlE2N4lhUcqW8cBrnekw9kFKSjoednn5cDKAVdBWCRWIrlA8o7
        CIXWU4zfCYQz7nzS74wDeOX1MOEbBNJb4cV3/RIfB9HhsHf2B+GTMPoNCW+Jbwh/YQewrGAY
        81kkrYKFz4vmr5bTcXDuzsn5GqdXws+lbtLHwfRuWN6Qi/udJbD96ug8y7xPrRw6O+9g9Co4
        U9mF+TkEnvh2m/BzGHw6UYEVA4VlQW5ZkFgWJJYFiQ3gNSCINwnaVK0QqRQ4rWDSpSoP6LW1
        wLsxT1p+OepA/qdEEdAUYBbL6z5TyQqCyxZytCKAFMYEyRedlCUr5Ae5nKO8QZ9iMGXyggjU
        3s+VYKHBB/Te/dMZU1RqlQbFqDRRmqj1iAmRn6Wf7VXQqZyRz+D5LN7wv5NQstBcUJEqjnwP
        cVS3JXQ7u4OtN0wZMcUR239nfV1eGV2iv2w/HNLXyt1fe8dqtbcZpxN6LomaXeJU4NIq86Bt
        s3l112B4Y9oml8Rmix9LURx6vyKg0910Xbf/fWbfosIzOTsCkzhh8nRYoro/TDmalHhtKO+R
        Z3RLF0M6jyW+3KmmnAwupHGqNZhB4P4BuA4FGkcDAAA=
X-CMS-MailID: 20190619091754eucas1p2edbfee21d2ec8feacc183927de9a0eae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190618190558epcas3p211c71991aba4f3a2273be82be41324a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190618190558epcas3p211c71991aba4f3a2273be82be41324a8
References: <20190618190534.4951-1-krzk@kernel.org>
        <CGME20190618190558epcas3p211c71991aba4f3a2273be82be41324a8@epcas3p2.samsung.com>
        <20190618190534.4951-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 21:05, Krzysztof Kozlowski wrote:
> Add ID and gate for bus clock for GPU (Mali 400) on Exynos4412.

Patch applied to clk/samsung tree, thanks.
