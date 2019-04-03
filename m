Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB14C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17F0206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="soQxy0id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDCPlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:41:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51376 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:41:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190403154122euoutp025c1c3780d5a1ba1741b74d02c882ece2~SASWv3wTx1531415314euoutp02k
        for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2019 15:41:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190403154122euoutp025c1c3780d5a1ba1741b74d02c882ece2~SASWv3wTx1531415314euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554306082;
        bh=ClUJNA6j/J8ST034JDmWsyEuaajkX0GcAU+mpoRgxKk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=soQxy0idiRQx/p7XlgJKJvY5HED5Lq6+6lukGjOLvpHHYwTZmCM/oeYgwQ2Ahb9mI
         nAwzleIBSiS7faHbWwq62ruETMtzUxVHcU30dG5LPmvADg0uKzyTRD3KFw4decIJ50
         5fCfeAVfSL/IpvL/Wg896FqtVq0MKWEWg9dHbNsM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190403154122eucas1p1e2601ca870af1d29ae9eab8ec99b0348~SASWEpb3j1945919459eucas1p1Q;
        Wed,  3 Apr 2019 15:41:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BF.44.04298.124D4AC5; Wed,  3
        Apr 2019 16:41:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190403154121eucas1p19fe2435950e3cfbc9a9edbcea43a7c7c~SASVSrA661956219562eucas1p1m;
        Wed,  3 Apr 2019 15:41:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190403154120eusmtrp176088ca5f32c73ea92c7626f1a7b5db6~SASVEnR5j2580625806eusmtrp1D;
        Wed,  3 Apr 2019 15:41:20 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-7a-5ca4d421ebb6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D9.CE.04146.024D4AC5; Wed,  3
        Apr 2019 16:41:20 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190403154120eusmtip1ff894b2cf985f08dded7849b0e02de9a~SASUpqfHP0741107411eusmtip1a;
        Wed,  3 Apr 2019 15:41:20 +0000 (GMT)
Subject: Re: [PATCH 2/7] da8xx-fb: pass struct device to DMA API functions
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a4201146-6260-03a8-554f-4d4f0a5dd2b9@samsung.com>
Date:   Wed, 3 Apr 2019 17:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190321225235.30648-3-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3cuOw4nZ9PwTa1wWEGUKRWcUqSbdepTFGHUusw8qOTUdtxK
        +5CFeNm8lLrCYWU61CmFLC+pqTnzljPxkihSBrMSaRappeYsj2eC337P//k/PBceApE2Yl5E
        dGwCo4pVxMhwEVrbsdC323fIKA+wp/lTQ3M/cMpU2S6gilqCKLNtGKOepRpRqiv7J0YNNhTi
        lEXfBKg3PfkINV9lww6J6MHhfoSuN3wU0uaKDJwe13UK6JfGO3TeSBmgG0eTcXrGvOU0cUEU
        HMHERGsY1Z6Qq6KogpZMLH4cuVVt0KHJIAvRAoKA5D7Ym3xSC0SElCwHsLJvScgHswBmTBU4
        gxkAG+8+FWiBy2pFl8WE8IkyAGfbSpwuO4AN1sVVlzt5Ck5PtyAce5Ay+GWqF3AmhHwugGPm
        GsAlcPIgfJBWAbhBxGQITNff4GSU9IMGy1+MkzeS52GOdQcni0kJ7C6YQDl2IQPgu9ZSnGNk
        hd8WF2I8b4V19sLV4SA5IIQfqtOF/NTHYEfeHODZHU51Vjt1H9iTl4nyBS8AdKRPOqvrACzL
        W8Z5VxBs6+zHeD4M2+c6UP56bnDELuE7u8Hc2kfOo4pheqqUd2+HVaVV+Fovbb3JaaHhkk1+
        H/ga1q1mWLeOYd06RQCpAJ6MmlVGMmxgLHPTn1UoWXVspP+1OKUZrLxUz3Lnr1dgbiDcAkgC
        yFzF85VGuRRTaNhEpQVAApF5iK05RXKpOEKRmMSo4q6o1DEMawHeBCrzFN/e8PmilIxUJDDX
        GSaeUa1lBYSLVzLI3vZYvujXxkgcB15HSU6UhIWqcVfvb3/iz443O+LsM17lurr3hWf+helN
        E3TPWO3vzdNZl0BxjK1rcnGsO+po6K7wyoWvreBe/3xTLquXPtzUXO6TdMT/kzXiieNcQf1p
        R8rY/u9C0lvvNiQ5nl8TXOOi2Rs+OqO7PJ2iqVaqZCgbpQjciahYxX9S6qNLTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7oKV5bEGMx6b2lx5et7NouVq48y
        WSzYb22x6fE1VouFbUtYLE70fWC1uLxrDpvFoal7GS0OnJ7CbPFjw2NWBy6Py9cuMnvsnHWX
        3WPTqk42j/vdx5k8Ni+p95h8Yzmjx+6bDWwenzfJBXBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXM3N/DWnCfuWLLrG6WBsZe5i5GTg4JAROJ
        E4dWgtlCAksZJQ7/LOhi5ACKy0gcX18GUSIs8edaF1sXIxdQyWtGid0d3xhBEsICXhLv3u0H
        6xURUJJ4+uosI0TRSkaJE5ens4M4zAJrmSTuT21jBaliE7CSmNi+ihFkA6+AnUTH1EKQMIuA
        isSsQ7/BSkQFIiRuPexgAbF5BQQlTs58AmZzChhInDq4jA3EZhbQk9hx/RcrhC0vsf3tHOYJ
        jIKzkLTMQlI2C0nZAkbmVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGxt+3Yz807GC9tDD7E
        KMDBqMTD+2P1khgh1sSy4srcQ4wSHMxKIrxn+hfECPGmJFZWpRblxxeV5qQWH2I0BXpiIrOU
        aHI+MC3klcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgXFiRca2q
        VujbBcOw1y1ptitqS19bq2zxZk4LbTGL+CRw9WdKnc9Ks/+/Pto76aU1ZbwN/vhVdnaDg9Hr
        SsWI/isRUtnPmfKcTk7Mypj1XGf/lhPvZQ3n8DQzejKveK8ieHm75psbSuevp8/UbfI7bl56
        cstv+/O13pxBC0LOK37KrlveGZChxFKckWioxVxUnAgAccdjRdMCAAA=
X-CMS-MailID: 20190403154121eucas1p19fe2435950e3cfbc9a9edbcea43a7c7c
X-Msg-Generator: CA
X-RootMTR: 20190321225309epcas1p311c1b22b7f1a15815765ffa12217f740
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321225309epcas1p311c1b22b7f1a15815765ffa12217f740
References: <20190321225235.30648-1-hch@lst.de>
        <CGME20190321225309epcas1p311c1b22b7f1a15815765ffa12217f740@epcas1p3.samsung.com>
        <20190321225235.30648-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/21/2019 11:52 PM, Christoph Hellwig wrote:
> The DMA API generally relies on a struct device to work properly, and
> only barely works without one for legacy reasons.  Pass the easily
> available struct device from the platform_device to remedy this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
