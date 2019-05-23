Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1738C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C6520881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D5CUV9HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfEWFfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:35:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43562 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEWFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:35:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190523053515euoutp025d84c6c694797a42a777bb65fca21e3b~hORa43Ph21560815608euoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:35:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190523053515euoutp025d84c6c694797a42a777bb65fca21e3b~hORa43Ph21560815608euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1558589715;
        bh=gPaeOPeAy+SCHwNWglSiXOmUaID43N80JI9hQwAPuEs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D5CUV9HIuwWtJyRwwGb0iNTFNqY0VQSkq6+pquk6qWq1qwafXeHPdM4O1NDEiEiqn
         jAT3DFwIdrVkXq3biNuLjTI3Ey0/qcPBoGnpvOoHiST9sMlXFnQuNEqdTyxZm3ZoaR
         40ymijvUmEXMK5uubKT08MfRLuReJEFM14lG3Duw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190523053514eucas1p1f1d23fd3ca299a4acedd08d175974f8d~hORZw5IY_2901129011eucas1p17;
        Thu, 23 May 2019 05:35:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.46.04298.21136EC5; Thu, 23
        May 2019 06:35:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190523053513eucas1p1078d4f2cb308d9e79e4edef9adaf49dc~hORY7W82t2901229012eucas1p1n;
        Thu, 23 May 2019 05:35:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190523053513eusmtrp1f0cd137533c806dcf0f77924f6a512c5~hORYtU5GR3054330543eusmtrp1J;
        Thu, 23 May 2019 05:35:13 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-12-5ce631125843
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.EB.04146.11136EC5; Thu, 23
        May 2019 06:35:13 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190523053513eusmtip1d5a9726961a4037d0915ebfa6c2a104b~hORYXSmQc1674916749eusmtip1E;
        Thu, 23 May 2019 05:35:13 +0000 (GMT)
Subject: Re: [PATCH] swiotlb: sync buffer when mapping FROM_DEVICE
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0c79721a-11cb-c945-5626-3d43cc299fe6@samsung.com>
Date:   Thu, 23 May 2019 07:35:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3e2szmaHafmk5XCzKgkbVQ0W0hZ4b50JQxroMsdneim7HjJ
        +tDIEbq0vIDptLKk5jVJdIiC4sSGWuqmgRdCHZuFYGhLhlqZ2+nit99z/T//l5eD8ZtZgZwU
        VSapVsnSBDiXaXy3OnyYL5yXHhlv8BHVN/YzREsjfQxRTY9Y9LrWgUS6tXpMNNZZjYt6l+ys
        02xJ07MmJCmbMCBJ16QGl7z92sGQLDummBJna9Bl/Ab3lJxMS8km1RFRCVyF5dMsI6Oddzvv
        aTVLg1xcHfLiAHEMSjcGMTfziToEHz8c0CHuJn9HULTqRHTgRFBS/BjXIY5nYmYuhM4bECzX
        OHA6WESg7TF5VvkS0ZBX+MLDfkQMrOSPst1NGNGDwGBzIXcBJ4SgW9ThbuYRUWD4MepRYBKh
        4LIo3OhPSOGl80+HDwxU2plu9iLE0GjTerZgRDDktVdhNAfAlP05wy0FRDcbTOMrOG3zHMxM
        V2A0+8KCuY1N8x4YKitk0gN5COaGm9l0UIhg7H4ForvE0Ge2sNwXYcRBaOmMoNNnYMaiYdCv
        4g0Tiz70Ed5QanyC0Wke5D/g0937QW9+80+2d9SKFSOBfos1/RY7+i129P91axCzAQWQWZQy
        maSEKjInnJIpqSxVcnhiurIVbX6ioV/mbx1oxXrLhAgOEmznKU44pHyWLJvKVZoQcDCBH29o
        0Cbl8+Sy3DukOj1enZVGUia0m8MUBPDubpu9ySeSZZlkKklmkOq/VQbHK1CDuj5/Ka9LslkL
        Knu714LXMyOntfsiHVwsxlC1Qxwux4yJu3Icr1J/GtNdZQnr2kdLw9m6uHLJw/cll5S2MEFo
        0WR87YWj56OvVq0dTx056Xd2p128MT4Zl4Rfj5JEhsTOt7UUuPbazP3XFua8g63yewPTyouW
        Sps6qMX/ynxsmIBJKWTCQ5iakv0GsMTKrUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7qChs9iDO72SlusXH2UyeLD+cNM
        Fgv2W1ssW/yU0aLr10pmi8u75rBZHPzwhNWB3WPNvDWMHpNvLGf02H2zgc1j47sdTB4fn95i
        8fi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEv4+LdB0wFW3krmufOYW1g/M7VxcjBISFgInH/oXIXIxeHkMBSRokVK94zdjFyAsVlJE5O
        a2CFsIUl/lzrYoMoes0oMWfGUjaQhLCAk0Rzz0JmEFtEwF3ia8cFdpAiZoGDjBJ7tvWyQHS0
        MUvs2HqUBaSKTcBQouttF1g3r4CdxPI/F9hAzmARUJX4fjEDJCwqECNxYuoWdogSQYmTM5+A
        tXIKWEusftQCdh2zgJnEvM0PmSFseYnmrbOhbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiy
        ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzD6th37uXkH46WNwYcYBTgYlXh4M8yfxgixJpYV
        V+YeYpTgYFYS4T196lGMEG9KYmVValF+fFFpTmrxIUZToN8mMkuJJucDE0NeSbyhqaG5haWh
        ubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG6G3b5VS9K9wfcu3atXPhrctbnMQS
        /vgdvtzJVGBUoOUZ5/z80y2u4K+r5352Pvv4lYOcSUbrzZ2t4Tov1AOLRNS36+2KX/VWxY11
        cUjcA25HX0PFNPNvQQx2TL9Y5byV86svzzga9qJIZ4OOUoKUSeDuJXYlC/1rNfboT5l9L8Bq
        pcqkx/eVWIozEg21mIuKEwG5w3z51AIAAA==
X-CMS-MailID: 20190523053513eucas1p1078d4f2cb308d9e79e4edef9adaf49dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b
References: <20190522072018.10660-1-horia.geanta@nxp.com>
        <20190522123243.GA26390@lst.de>
        <6cbe5470-16a6-17e9-337d-6ba18b16b6e8@arm.com>
        <20190522130921.GA26874@lst.de>
        <fdfd7318-7999-1fe6-01b6-ae1fb7ba8c30@arm.com>
        <20190522133400.GA27229@lst.de>
        <CGME20190522135556epcas2p34e0c14f2565abfdccc7035463f60a71b@epcas2p3.samsung.com>
        <ed26de5e-aee4-4e19-095c-cc551012d475@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2019-05-22 15:55, Robin Murphy wrote:
> On 22/05/2019 14:34, Christoph Hellwig wrote:
>> On Wed, May 22, 2019 at 02:25:38PM +0100, Robin Murphy wrote:
>>> Sure, but that should be irrelevant since the effective problem here 
>>> is in
>>> the sync_*_for_cpu direction, and it's the unmap which nobbles the 
>>> buffer.
>>> If the driver does this:
>>>
>>>     dma_map_single(whole buffer);
>>>     <device writes to part of buffer>
>>>     dma_unmap_single(whole buffer);
>>>     <contents of rest of buffer now undefined>
>>>
>>> then it could instead do this and be happy:
>>>
>>>     dma_map_single(whole buffer, SKIP_CPU_SYNC);
>>>     <device writes to part of buffer>
>>>     dma_sync_single_for_cpu(updated part of buffer);
>>>     dma_unmap_single(whole buffer, SKIP_CPU_SYNC);
>>>     <contents of rest of buffer still valid>
>>
>> Assuming the driver knows how much was actually DMAed this would
>> solve the issue.  Horia, does this work for you?
>
> Ohhh, and now I've just twigged what you were suggesting - your 
> DMA_ATTR_PARTIAL flag would mean "treat this as a read-modify-write of 
> the buffer because we *don't* know exactly which parts the device may 
> write to". So indeed if we did go down that route we wouldn't need any 
> of the sync stuff I was worrying about (but I might suggest naming it 
> DMA_ATTR_UPDATE instead). Apologies for being slow :)

Don't we have DMA_BIDIRECTIONAL for such case? Maybe we should update 
documentation a bit to point that DMA_FROM_DEVICE expects the whole 
buffer to be filled by the device?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

