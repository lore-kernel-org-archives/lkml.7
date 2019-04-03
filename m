Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD3FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E452075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fqtub7A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDCPmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:42:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51634 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:42:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190403154224euoutp0205cecaef45a866500adde48dfe9b8ac2~SATP8fSi21582315823euoutp02a
        for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2019 15:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190403154224euoutp0205cecaef45a866500adde48dfe9b8ac2~SATP8fSi21582315823euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554306144;
        bh=V16lzcU5NxAayAoz/ELKkYUWam8HsfaVjtMLHCfE/F8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fqtub7A92Y2ii/5VNPTUhlFOU6v6IHaXOb2vtYjgemZ/uGnA/0eqn8mdd9D82kACK
         7YSQV8A4dFOwBWya6ZJPNexdz4h64M64r2V47ZXcxrBzfZihUp/mXYvBL1OT9EDGvh
         ttifpBtyGvGgcwXpsCEU/x6AZEghmDTXj+JlNreg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190403154223eucas1p2ce4842a48d76157307bb315c68b12148~SATPOxZXw1438314383eucas1p2g;
        Wed,  3 Apr 2019 15:42:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.67.04325.F54D4AC5; Wed,  3
        Apr 2019 16:42:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190403154222eucas1p1bcbe78c07a58dd7660786d0d5463f123~SATOd8luh1945919459eucas1p1t;
        Wed,  3 Apr 2019 15:42:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190403154222eusmtrp117192f510a4e9d268c7364f05732ba4d~SATOPoIN_2635626356eusmtrp1c;
        Wed,  3 Apr 2019 15:42:22 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-b2-5ca4d45f7fc6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.6E.04140.E54D4AC5; Wed,  3
        Apr 2019 16:42:22 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190403154221eusmtip2a9aa86516b8f6b3120f3a678654fabf3~SATNxuiO90857908579eusmtip2V;
        Wed,  3 Apr 2019 15:42:21 +0000 (GMT)
Subject: Re: [PATCH 4/7] pxa3xx-gcu: pass struct device to dma_mmap_coherent
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <728de1c2-0408-9a12-ca00-87e9dd09bcfe@samsung.com>
Date:   Wed, 3 Apr 2019 17:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190321225235.30648-5-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7rxV5bEGJx6xmFx5et7NouVq48y
        WSzYb22x6fE1VouFbUtYLE70fWC1uLxrDpvFoal7GS0OnJ7CbPFjw2NWBy6Py9cuMnvsnHWX
        3WPTqk42j/vdx5k8Ni+p95h8Yzmjx+6bDWwenzfJBXBEcdmkpOZklqUW6dslcGUcbV7AWrCX
        qWLRpRcsDYwdTF2MHBwSAiYS878wdjFycQgJrGCU2NC+ngXC+cIosW/2ffYuRk4g5zOjxIQ3
        ySA2SMOe43+hOpYzSpycupgdwnnLKNF8t5MZpEpYwEfi6rTDYLaIgJLE01dnwTqYBdYySdze
        tJURJMEmYCUxsX0VmM0rYCex5PxsVhCbRUBFYtrhfmaQ+0QFIiT6z6hDlAhKnJz5hAXE5hQw
        kNh38DxYOTOQfWTRHChbXmL72znMILskBM6xS7yds44R4mwXiTPdL1kgbGGJV8e3sEPYMhKn
        J/ewQDSsY5T42/ECqns7o8Tyyf/YIKqsJQ4fv8gKYTtKPN/Qxw4JPT6JG28FITbzSUzaNp0Z
        Iswr0dEmBFGtJrFh2QY2mF1dO1dClXhIXJvsO4FRcRaS12YheWcWkncWMDKvYhRPLS3OTU8t
        Ns5LLdcrTswtLs1L10vOz93ECExSp/8d/7qDcd+fpEOMAhyMSjy8P1YviRFiTSwrrsw9xCjB
        wawkwnumf0GMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6p
        Bsag6OqLmTUFq2QuHtz5cs8Rl4C5vu+WJqRLNP5bxPom/tNGp8O2JTZqfvd9ny65+Jlfz+cx
        U0zbrGf90fYXe6Y6R/n5ZcpOev359P6Vyn++8q12XigT8EFTsLou9uDMJdurlhY07BBvDtTI
        Dme4an7GZ9HtXuf4pyu+tu+ftH4SZ2bw8f+7RFcosRRnJBpqMRcVJwIAUwIHJ04DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7pxV5bEGDw4LGhx5et7NouVq48y
        WSzYb22x6fE1VouFbUtYLE70fWC1uLxrDpvFoal7GS0OnJ7CbPFjw2NWBy6Py9cuMnvsnHWX
        3WPTqk42j/vdx5k8Ni+p95h8Yzmjx+6bDWwenzfJBXBE6dkU5ZeWpCpk5BeX2CpFG1oY6Rla
        WugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUcbV7AWrCXqWLRpRcsDYwdTF2MnBwSAiYS
        e47/Zexi5OIQEljKKLHh1R72LkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpSY3XGcGSQhLOAjcXXa
        YTBbREBJ4umrs4wgtpDASkaJV7eDQRqYBdYySdyf2sYKkmATsJKY2L4KrIhXwE5iyfnZYHEW
        ARWJaYf7wQaJCkRI3HrYwQJRIyhxcuYTMJtTwEBi38HzYPXMAnoSO67/grLlJba/ncM8gVFw
        FpKWWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw+rYd+7llB2PXu+BDjAIc
        jEo8vD9WL4kRYk0sK67MPcQowcGsJMJ7pn9BjBBvSmJlVWpRfnxRaU5q8SFGU6AnJjJLiSbn
        AxNDXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYOTqkGRkb/RYbV4jv1
        p37nnXP+MJOCSfE9jXjrtUfv178Qa3AtebuzzHeGZ7P5vreMWuY7tKd0J03zXHNM4EjVnCkF
        PT7ryie8uhyY48Im8Om2i1z0z03MvUIXl3188D8pMGJRbLr6lhU/N2eEKzGbn7y0dscd62MS
        m7/ZP6r1lnwZNyFy7wsP/tPmz5VYijMSDbWYi4oTAW+BOKvUAgAA
X-CMS-MailID: 20190403154222eucas1p1bcbe78c07a58dd7660786d0d5463f123
X-Msg-Generator: CA
X-RootMTR: 20190321225324epcas4p19c9de95eddcbd41dd65d665387a74007
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190321225324epcas4p19c9de95eddcbd41dd65d665387a74007
References: <20190321225235.30648-1-hch@lst.de>
        <CGME20190321225324epcas4p19c9de95eddcbd41dd65d665387a74007@epcas4p1.samsung.com>
        <20190321225235.30648-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/21/2019 11:52 PM, Christoph Hellwig wrote:
> Just like we do for all other DMA operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
