Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B94C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5442084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfEMQik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:38:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:17759 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbfEMQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:38:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 09:38:08 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2019 09:38:07 -0700
Date:   Mon, 13 May 2019 09:41:00 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, alex.williamson@redhat.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/4] iommu/vt-d: Handle RMRR with PCI bridge device
 scopes
Message-ID: <20190513094100.6fd1276b@jacob-builder>
In-Reply-To: <20190513071302.30718-4-eric.auger@redhat.com>
References: <20190513071302.30718-1-eric.auger@redhat.com>
        <20190513071302.30718-4-eric.auger@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 09:13:01 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> When reading the vtd specification and especially the
> Reserved Memory Region Reporting Structure chapter,
> it is not obvious a device scope element cannot be a
> PCI-PCI bridge, in which case all downstream ports are
> likely to access the reserved memory region. Let's handle
> this case in device_has_rmrr.
> 
> Fixes: ea2447f700ca ("intel-iommu: Prevent devices with RMRRs from
> being placed into SI Domain")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index e2134b13c9ae..89d82a1d50b1 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -736,12 +736,31 @@ static int iommu_dummy(struct device *dev)
>  	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
>  }
>  
> +static bool
> +is_downstream_to_pci_bridge(struct device *deva, struct device *devb)
> +{
> +	struct pci_dev *pdeva, *pdevb;
> +
is there a more illustrative name for these. i guess deva is is the
bridge dev?
> +	if (!dev_is_pci(deva) || !dev_is_pci(devb))
> +		return false;
> +
> +	pdeva = to_pci_dev(deva);
> +	pdevb = to_pci_dev(devb);
> +
> +	if (pdevb->subordinate &&
> +	    pdevb->subordinate->number <= pdeva->bus->number &&
> +	    pdevb->subordinate->busn_res.end >= pdeva->bus->number)
> +		return true;
> +
> +	return false;
> +}
> +
this seems to be a separate cleanup patch.
>  static struct intel_iommu *device_to_iommu(struct device *dev, u8
> *bus, u8 *devfn) {
>  	struct dmar_drhd_unit *drhd = NULL;
>  	struct intel_iommu *iommu;
>  	struct device *tmp;
> -	struct pci_dev *ptmp, *pdev = NULL;
> +	struct pci_dev *pdev = NULL;
>  	u16 segment = 0;
>  	int i;
>  
> @@ -787,13 +806,7 @@ static struct intel_iommu
> *device_to_iommu(struct device *dev, u8 *bus, u8 *devf goto out;
>  			}
>  
> -			if (!pdev || !dev_is_pci(tmp))
> -				continue;
> -
> -			ptmp = to_pci_dev(tmp);
> -			if (ptmp->subordinate &&
> -			    ptmp->subordinate->number <=
> pdev->bus->number &&
> -			    ptmp->subordinate->busn_res.end >=
> pdev->bus->number)
> +			if (is_downstream_to_pci_bridge(dev, tmp))
>  				goto got_pdev;
>  		}
>  
> @@ -2886,7 +2899,8 @@ static bool device_has_rmrr(struct device *dev)
>  		 */
>  		for_each_active_dev_scope(rmrr->devices,
>  					  rmrr->devices_cnt, i, tmp)
> -			if (tmp == dev) {
> +			if (tmp == dev ||
> +			    is_downstream_to_pci_bridge(dev, tmp)) {
>  				rcu_read_unlock();
>  				return true;
>  			}

[Jacob Pan]
