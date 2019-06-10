Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69162C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD712085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p/11d3fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391259AbfFJPrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:47:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40554 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390445AbfFJPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:47:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFdV6B161235;
        Mon, 10 Jun 2019 15:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=On8N8xLx5bySBhtfklW/jVPpdxRw8n8hUrnegNsG56A=;
 b=p/11d3fZWqgw6ec6faSYbql5IRRZrISP+FormimufKnKfD4oejFLbQaz8rO+MPz90WQH
 CLna2EtuzO9psBaVjiz7fqDeAoQte4NQV1apg4hTTAxccnllpf8kDLezBCyH0kuMShXM
 kN60z3OLNhGI+exe51OHF9g5X2IV3InBDG5BW/zCx7hujEoEF0gDm4QKxhw3WEpDNtqi
 O7v4pnoNCyCrObAeKJUcHvgmJyZAkdqeM7l9QGwrznr2BR/mx3+iJ2r07o9ryWubXCez
 QCZHgwvQ3CCsCfHMWc041w0QAh5xkQI0QlN1YDqgujvEnkI+NMH0kRGezP2tywgLtLhE eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etfrau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:44:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFgjd4157509;
        Mon, 10 Jun 2019 15:44:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jpgxjdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:44:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5AFiUwV024636;
        Mon, 10 Jun 2019 15:44:31 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 08:44:30 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id A93F86A00FC; Mon, 10 Jun 2019 11:45:53 -0400 (EDT)
Date:   Mon, 10 Jun 2019 11:45:53 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] swiotlb: Zero out bounce buffer for untrusted
 device
Message-ID: <20190610154553.GT28796@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603011620.31999-4-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:16:14AM +0800, Lu Baolu wrote:
> This is necessary to avoid exposing valid kernel data to any
> milicious device.

malicious 

> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  kernel/dma/swiotlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f956f785645a..ed41eb7f6131 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -35,6 +35,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/set_memory.h>
> +#include <linux/pci.h>
>  #ifdef CONFIG_DEBUG_FS
>  #include <linux/debugfs.h>
>  #endif
> @@ -560,6 +561,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	 */
>  	for (i = 0; i < nslots; i++)
>  		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +
> +	/* Zero out the bounce buffer if the consumer is untrusted. */
> +	if (dev_is_untrusted(hwdev))
> +		memset(phys_to_virt(tlb_addr), 0, alloc_size);

What if the alloc_size is less than a PAGE? Should this at least have ALIGN or such?

> +
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
>  		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
> -- 
> 2.17.1
> 
