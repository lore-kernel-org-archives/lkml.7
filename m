Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA6C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809F52073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CvI1PNus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfDKTzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:55:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43500 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:55:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3BJsmvC161616;
        Thu, 11 Apr 2019 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VL9345aOgMK3qVvpbctwi4u+WOPjOP1EyqDU/Uq/IHI=;
 b=CvI1PNus22oPdlmttC8NmMTuSQCQfYZXYYTZZYMEDGk+LVf8F3uQifjL3+ae3eUJhBJL
 kvEXDL+gCtsl/va/a1JvqlT1n5dSjkt0qUPMxCjsrpUJlRtYPiNS96Ul1K3OlsUHgkLq
 LQM4pxKZiBi9SE8KfMti0fvBCYlV9JtvYEHwixrh5TRaEzGeJ5dgZqCaYhxmAYOAnQzO
 H62NNA7UF2KnUkpmtEyop9AbboLFKxHcJygCCFP0lY4DLj1uVZFhyxfnFfNhemFacqWK
 crL/ZbSdOr4gmDKv/RCA05Mrp53psKeV6H7ESQMGkrMWZnODRgHs/NdxgCH4zYOGZQru vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmeu6d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 19:55:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3BJrgnH177322;
        Thu, 11 Apr 2019 19:55:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2rt9uptesc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 19:55:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3BJtQ5Z014619;
        Thu, 11 Apr 2019 19:55:26 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 12:55:26 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id B1C3A6A00C3; Thu, 11 Apr 2019 15:55:28 -0400 (EDT)
Date:   Thu, 11 Apr 2019 15:55:28 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        joe.jin@oracle.com, srinivas.eeda@oracle.com
Subject: Re: [PATCH 1/1] swiotlb: dump used and total slots when swiotlb
 buffer is full
Message-ID: <20190411195528.GB6033@char.us.oracle.com>
References: <1554426925-2431-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554426925-2431-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904110132
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904110132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:15:25AM +0800, Dongli Zhang wrote:
> So far the kernel only prints the requested size if swiotlb buffer if full.
> It is not possible to know whether it is simply an out of buffer, or it is
> because swiotlb cannot allocate buffer with the requested size due to
> fragmentation.
> 
> As 'io_tlb_used' is available since commit 71602fe6d4e9 ("swiotlb: add
> debugfs to track swiotlb buffer usage"), both 'io_tlb_used' and
> 'io_tlb_nslabs' are printed when swiotlb buffer is full.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Applied. Will send git pull shortly.
> ---
>  kernel/dma/swiotlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 53012db..3f43b37 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -540,7 +540,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  not_found:
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> -		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
> +		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu, used %lu\n",
> +			 size, io_tlb_nslabs, io_tlb_used);
>  	return DMA_MAPPING_ERROR;
>  found:
>  	io_tlb_used += nslots;
> -- 
> 2.7.4
> 
