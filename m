Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7DAC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C22166E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ee01PXdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfFSO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:27:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50970 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:27:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JEJnSt019625;
        Wed, 19 Jun 2019 14:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yttiPRpSZZrH5iMOgXU87rDYVYrhNSlNRuXPD3dcjrE=;
 b=ee01PXdUFHKCRVZQBbEAuCNZzx/GyLgDcSp/TKtQkXY2DMJxqiwBR1/8P0+sL4K7a7B5
 XBiVILXz095aw8/e6KKqFdA92dOWJ9NRuqgr3rzp/z5XdzYzghRlSDmatpVrzRNszK9L
 IA7sytloqzLGbCju3v6Y+DAtd1dkwMsoJy+qeIbqYkrDQau5vE+Tq1tbXa/ZUbqGM6T2
 vRv1dnJOcHl5uvsyOSEbxBMlJSVlD+OWu8UlPgmk5QI2J8Fq5K95dgsj/UPmz39xrdUU
 uM1ORIHpFA675tloJYNLnO0fWJkls2vhwdz7OkpFgWmyaSZBm9OfHBVa/rC2fGJjLrA+ PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t7809btkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 14:26:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JEQTAe194064;
        Wed, 19 Jun 2019 14:26:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t77ynvp68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 14:26:57 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5JEQm9v015046;
        Wed, 19 Jun 2019 14:26:48 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 07:26:47 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 434C96A0136; Wed, 19 Jun 2019 10:28:12 -0400 (EDT)
Date:   Wed, 19 Jun 2019 10:28:12 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: fix phys_addr_t overflow warning
Message-ID: <20190619142812.GM10432@char.us.oracle.com>
References: <20190617132946.2817440-1-arnd@arndb.de>
 <alpine.DEB.2.21.1906170913080.2072@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906170913080.2072@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 09:13:16AM -0700, Stefano Stabellini wrote:
> On Mon, 17 Jun 2019, Arnd Bergmann wrote:
> > On architectures that have a larger dma_addr_t than phys_addr_t,
> > the swiotlb_tbl_map_single() function truncates its return code
> > in the failure path, making it impossible to identify the error
> > later, as we compare to the original value:
> > 
> > kernel/dma/swiotlb.c:551:9: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
> >         return DMA_MAPPING_ERROR;
> > 
> > Use an explicit typecast here to convert it to the narrower type,
> > and use the same expression in the error handling later.
> > 
> > Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>

queued.
> 
> 
> > ---
> > I still think that reverting the original commit would have
> > provided clearer semantics for this corner case, but at least
> > this patch restores the correct behavior.
> > ---
> >  drivers/xen/swiotlb-xen.c | 2 +-
> >  kernel/dma/swiotlb.c      | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index d53f3493a6b9..cfbe46785a3b 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -402,7 +402,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
> >  
> >  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
> >  				     attrs);
> > -	if (map == DMA_MAPPING_ERROR)
> > +	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return DMA_MAPPING_ERROR;
> >  
> >  	dev_addr = xen_phys_to_bus(map);
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index e906ef2e6315..a3be651973ad 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -548,7 +548,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> >  	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> >  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
> >  			 size, io_tlb_nslabs, tmp_io_tlb_used);
> > -	return DMA_MAPPING_ERROR;
> > +	return (phys_addr_t)DMA_MAPPING_ERROR;
> >  found:
> >  	io_tlb_used += nslots;
> >  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> > @@ -666,7 +666,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
> >  	/* Oh well, have to allocate and map a bounce buffer. */
> >  	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> >  			*phys, size, dir, attrs);
> > -	if (*phys == DMA_MAPPING_ERROR)
> > +	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
> >  		return false;
> >  
> >  	/* Ensure that the address returned is DMA'ble */
> > -- 
> > 2.20.0
> > 
