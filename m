Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FC02085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfFROKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:10:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18601 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfFROKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:10:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 350FA9F6D931B838D743;
        Tue, 18 Jun 2019 22:10:45 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
 22:10:43 +0800
Date:   Tue, 18 Jun 2019 15:10:31 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 10/22] iommu: Fix compile error without IOMMU_API
Message-ID: <20190618151031.00004bbd@huawei.com>
In-Reply-To: <1560087862-57608-11-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1560087862-57608-11-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2019 06:44:10 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> struct page_response_msg needs to be defined outside CONFIG_IOMMU_API.

What was the error? 

If this is a fix for an earlier patch in this series role it in there
(or put it before it). If more general we should add a fixes tag.

Jonathan
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/linux/iommu.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7a37336..8d766a8 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -189,8 +189,6 @@ struct iommu_sva_ops {
>  	iommu_mm_exit_handler_t mm_exit;
>  };
>  
> -#ifdef CONFIG_IOMMU_API
> -
>  /**
>   * enum page_response_code - Return status of fault handlers, telling the IOMMU
>   * driver how to proceed with the fault.
> @@ -227,6 +225,7 @@ struct page_response_msg {
>  	u64 iommu_data;
>  };
>  
> +#ifdef CONFIG_IOMMU_API
>  /**
>   * struct iommu_ops - iommu ops and capabilities
>   * @capable: check capability


