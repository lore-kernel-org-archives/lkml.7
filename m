Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAEC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE34A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0FxU1eur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbfFJPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:54:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390688AbfFJPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:54:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFmjtK178711;
        Mon, 10 Jun 2019 15:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=sGeDZEXiTbWUX+C0aVsHqVqc7158BC9dfhfY1759JRg=;
 b=0FxU1euriaqeQNAqHFDRaTcsFY0Wx6qQwGB1pIOwrZdFWUc7HF/ySyK2AFMOtB/qClrv
 orCRhD6pVAmN83MilUCdT4aJ10BqakXOlWLbXaodmT704rhWtf3bhCyb9KuDRjSiqnf/
 /zmRidKFos+pvcclfZxeyfZVTAJTOA1X/oEinabCtblFtIFt3fQM/t7qiKFdu0E9HpON
 hkiVpgBZzGrIUwFxZov0nv7FutqwA0iAJjNoXOblS82ym3s+dVn0CLaJ/Kg9XN0ETKjz
 sTgRiyyeafOS+i356dqXg6edhyOoXcm55zoydwPlnWoJkILIrNVRNX90cuQVPr1EF/rm FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t05nqfpxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:53:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFqppZ058810;
        Mon, 10 Jun 2019 15:53:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t04hxusqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:53:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5AFrStP014233;
        Mon, 10 Jun 2019 15:53:29 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 08:53:28 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 7B8526A00FC; Mon, 10 Jun 2019 11:54:51 -0400 (EDT)
Date:   Mon, 10 Jun 2019 11:54:51 -0400
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v4 5/9] iommu/vt-d: Don't switch off swiotlb if use
 direct dma
Message-ID: <20190610155451.GU28796@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603011620.31999-6-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=959 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:16:16AM +0800, Lu Baolu wrote:
> The direct dma implementation depends on swiotlb. Hence, don't
> switch of swiotlb since direct dma interfaces are used in this

s/of/off/

> driver.

But I think you really want to leave the code as is but change
the #ifdef to check for IOMMU_BOUNCE_PAGE and not CONFIG_SWIOTLB.

As one could disable IOMMU_BOUNCE_PAGE.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d5a6c8064c56..235837c50719 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4625,9 +4625,6 @@ static int __init platform_optin_force_iommu(void)
>  		iommu_identity_mapping |= IDENTMAP_ALL;
>  
>  	dmar_disabled = 0;
> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
> -	swiotlb = 0;
> -#endif
>  	no_iommu = 0;
>  
>  	return 1;
> @@ -4765,9 +4762,6 @@ int __init intel_iommu_init(void)
>  	}
>  	up_write(&dmar_global_lock);
>  
> -#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
> -	swiotlb = 0;
> -#endif
>  	dma_ops = &intel_dma_ops;
>  
>  	init_iommu_pm_ops();
> -- 
> 2.17.1
> 
