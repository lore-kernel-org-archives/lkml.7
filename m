Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E372C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D384720830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfCYWAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:00:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbfCYWAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:00:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56EC9C05FFCE;
        Mon, 25 Mar 2019 22:00:03 +0000 (UTC)
Received: from [10.36.117.163] (ovpn-117-163.ams2.redhat.com [10.36.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 926DE173D9;
        Mon, 25 Mar 2019 22:00:01 +0000 (UTC)
Subject: Re: [PATCH] vfio: Use dev_printk() when possible
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20190325194220.5873-1-helgaas@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9f4e9d19-8d82-bff0-a627-f82757d1da59@redhat.com>
Date:   Mon, 25 Mar 2019 22:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190325194220.5873-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 25 Mar 2019 22:00:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
On 3/25/19 8:42 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use dev_printk() when possible to make messages consistent with other
> device-related messages>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/vfio/pci/vfio_pci.c                   |  8 ++---
>  drivers/vfio/pci/vfio_pci_config.c            | 29 +++++++++----------
>  .../platform/reset/vfio_platform_amdxgbe.c    |  5 ++--
>  drivers/vfio/platform/vfio_platform_common.c  | 12 ++++----
>  drivers/vfio/vfio.c                           | 29 +++++++++----------
>  5 files changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a25659b5a5d1..a538fd995429 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -287,8 +287,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  	pci_save_state(pdev);
>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)
> -		pr_debug("%s: Couldn't store %s saved state\n",
> -			 __func__, dev_name(&pdev->dev));
> +		dev_dbg(&pdev->dev, "%s: Couldn't store saved state\n",
> +			__func__);
>  
>  	if (likely(!nointxmask)) {
>  		if (vfio_pci_nointx(pdev)) {
> @@ -429,8 +429,8 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  	 * is just busy work.
>  	 */
>  	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
> -		pr_info("%s: Couldn't reload %s saved state\n",
> -			__func__, dev_name(&pdev->dev));
> +		dev_info(&pdev->dev, "%s: Couldn't reload saved state\n",
> +			 __func__);
>  
>  		if (!vdev->reset_works)
>  			goto out;
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index e82b51114687..44d865576a92 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -412,8 +412,7 @@ static void vfio_bar_restore(struct vfio_pci_device *vdev)
>  	if (pdev->is_virtfn)
>  		return;
>  
> -	pr_info("%s: %s reset recovery - restoring bars\n",
> -		__func__, dev_name(&pdev->dev));
> +	dev_info(&pdev->dev, "%s: reset recovery - restoring BARs\n", __func__);
>  
>  	for (i = PCI_BASE_ADDRESS_0; i <= PCI_BASE_ADDRESS_5; i += 4, rbar++)
>  		pci_user_write_config_dword(pdev, i, *rbar);
> @@ -1298,8 +1297,8 @@ static int vfio_cap_len(struct vfio_pci_device *vdev, u8 cap, u8 pos)
>  		else
>  			return PCI_SATA_SIZEOF_SHORT;
>  	default:
> -		pr_warn("%s: %s unknown length for pci cap 0x%x@0x%x\n",
> -			dev_name(&pdev->dev), __func__, cap, pos);
> +		dev_warn(&pdev->dev, "%s: unknown length for PCI cap %#x@%#x\n",
> +			 __func__, cap, pos);
>  	}
>  
>  	return 0;
> @@ -1372,8 +1371,8 @@ static int vfio_ext_cap_len(struct vfio_pci_device *vdev, u16 ecap, u16 epos)
>  		}
>  		return PCI_TPH_BASE_SIZEOF;
>  	default:
> -		pr_warn("%s: %s unknown length for pci ecap 0x%x@0x%x\n",
> -			dev_name(&pdev->dev), __func__, ecap, epos);
> +		dev_warn(&pdev->dev, "%s: unknown length for PCI ecap %#x@%#x\n",
> +			 __func__, ecap, epos);
>  	}
>  
>  	return 0;
> @@ -1474,8 +1473,8 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
>  		}
>  
>  		if (!len) {
> -			pr_info("%s: %s hiding cap 0x%x\n",
> -				__func__, dev_name(&pdev->dev), cap);
> +			dev_info(&pdev->dev, "%s: hiding cap %#x@%#x\n",
> +				 __func__, cap, pos);
>  			*prev = next;
>  			pos = next;
>  			continue;
> @@ -1486,9 +1485,8 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
>  			if (likely(map[pos + i] == PCI_CAP_ID_INVALID))
>  				continue;
>  
> -			pr_warn("%s: %s pci config conflict @0x%x, was cap 0x%x now cap 0x%x\n",
> -				__func__, dev_name(&pdev->dev),
> -				pos + i, map[pos + i], cap);
> +			dev_warn(&pdev->dev, "%s: PCI config conflict @%#x, was cap %#x now cap %#x\n",
> +				 __func__, pos + i, map[pos + i], cap);
>  		}
>  
>  		BUILD_BUG_ON(PCI_CAP_ID_MAX >= PCI_CAP_ID_INVALID_VIRT);
> @@ -1549,8 +1547,8 @@ static int vfio_ecap_init(struct vfio_pci_device *vdev)
>  		}
>  
>  		if (!len) {
> -			pr_info("%s: %s hiding ecap 0x%x@0x%x\n",
> -				__func__, dev_name(&pdev->dev), ecap, epos);
> +			dev_info(&pdev->dev, "%s: hiding ecap %#x@%#x\n",
> +				 __func__, ecap, epos);
>  
>  			/* If not the first in the chain, we can skip over it */
>  			if (prev) {
> @@ -1572,9 +1570,8 @@ static int vfio_ecap_init(struct vfio_pci_device *vdev)
>  			if (likely(map[epos + i] == PCI_CAP_ID_INVALID))
>  				continue;
>  
> -			pr_warn("%s: %s pci config conflict @0x%x, was ecap 0x%x now ecap 0x%x\n",
> -				__func__, dev_name(&pdev->dev),
> -				epos + i, map[epos + i], ecap);
> +			dev_warn(&pdev->dev, "%s: PCI config conflict @%#x, was ecap %#x now ecap %#x\n",
> +				 __func__, epos + i, map[epos + i], ecap);
>  		}
>  
>  		/*
> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> index 3ddb2704221d..5ee06f1ff597 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> @@ -89,7 +89,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>  	} while ((pcs_value & MDIO_CTRL1_RESET) && --count);
>  
>  	if (pcs_value & MDIO_CTRL1_RESET)
> -		pr_warn("%s XGBE PHY reset timeout\n", __func__);
> +		dev_warn(&vdev->device, "%s XGBE PHY reset timeout\n",
vdev->device
> +			 __func__);
>  
>  	/* disable auto-negotiation */
>  	value = xmdio_read(xpcs_regs->ioaddr, MDIO_MMD_AN, MDIO_CTRL1);
> @@ -114,7 +115,7 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>  		usleep_range(500, 600);
>  
>  	if (!count)
> -		pr_warn("%s MAC SW reset failed\n", __func__);
> +		dev_warn(&vdev->device, "%s MAC SW reset failed\n", __func__);
vdev->device
>  
>  	return 0;
>  }
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index c0cd824be2b7..438aa40c5bde 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -63,7 +63,7 @@ static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>  
>  	adev = ACPI_COMPANION(dev);
>  	if (!adev) {
> -		pr_err("VFIO: ACPI companion device not found for %s\n",
> +		dev_err(dev, "VFIO: ACPI companion device not found for %s\n",
>  			vdev->name);
nit: for VFIO platform devices vdev->name and dev_name(dev) are the
same. But for amba devices they are different I think so it looks
sensible to keep both names at the moment.

Thanks

Eric
>  		return -ENODEV;
>  	}
> @@ -638,7 +638,8 @@ static int vfio_platform_of_probe(struct vfio_platform_device *vdev,
>  	ret = device_property_read_string(dev, "compatible",
>  					  &vdev->compat);
>  	if (ret)
> -		pr_err("VFIO: Cannot retrieve compat for %s\n", vdev->name);
> +		dev_err(dev, "VFIO: Cannot retrieve compat for %s\n",
> +			vdev->name);
>  
>  	return ret;
>  }
> @@ -680,14 +681,15 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  
>  	ret = vfio_platform_get_reset(vdev);
>  	if (ret && vdev->reset_required) {
> -		pr_err("VFIO: No reset function found for device %s\n",
> -		       vdev->name);
> +		dev_err(dev, "VFIO: No reset function found for device %s\n",
> +		        vdev->name);
>  		return ret;
>  	}
>  
>  	group = vfio_iommu_group_get(dev);
>  	if (!group) {
> -		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
> +		dev_err(dev, "VFIO: No IOMMU group for device %s\n",
> +			vdev->name);
>  		ret = -EINVAL;
>  		goto put_reset;
>  	}
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a3030cdf3c18..7fb68968097a 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -704,8 +704,8 @@ static int vfio_group_nb_add_dev(struct vfio_group *group, struct device *dev)
>  		return 0;
>  
>  	/* TODO Prevent device auto probing */
> -	WARN(1, "Device %s added to live group %d!\n", dev_name(dev),
> -	     iommu_group_id(group->iommu_group));
> +	dev_WARN(dev, "Device added to live group %d!\n",> +		 iommu_group_id(group->iommu_group));
>  
>  	return 0;
>  }
> @@ -748,25 +748,22 @@ static int vfio_iommu_group_notifier(struct notifier_block *nb,
>  		 */
>  		break;
>  	case IOMMU_GROUP_NOTIFY_BIND_DRIVER:
> -		pr_debug("%s: Device %s, group %d binding to driver\n",
> -			 __func__, dev_name(dev),
> -			 iommu_group_id(group->iommu_group));
> +		dev_dbg(dev, "%s: group %d binding to driver\n", __func__,
> +			iommu_group_id(group->iommu_group));
>  		break;
>  	case IOMMU_GROUP_NOTIFY_BOUND_DRIVER:
> -		pr_debug("%s: Device %s, group %d bound to driver %s\n",
> -			 __func__, dev_name(dev),
> -			 iommu_group_id(group->iommu_group), dev->driver->name);
> +		dev_dbg(dev, "%s: group %d bound to driver %s\n", __func__,
> +			iommu_group_id(group->iommu_group), dev->driver->name);
>  		BUG_ON(vfio_group_nb_verify(group, dev));
>  		break;
>  	case IOMMU_GROUP_NOTIFY_UNBIND_DRIVER:
> -		pr_debug("%s: Device %s, group %d unbinding from driver %s\n",
> -			 __func__, dev_name(dev),
> -			 iommu_group_id(group->iommu_group), dev->driver->name);
> +		dev_dbg(dev, "%s: group %d unbinding from driver %s\n",
> +			__func__, iommu_group_id(group->iommu_group),
> +			dev->driver->name);
>  		break;
>  	case IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER:
> -		pr_debug("%s: Device %s, group %d unbound from driver\n",
> -			 __func__, dev_name(dev),
> -			 iommu_group_id(group->iommu_group));
> +		dev_dbg(dev, "%s: group %d unbound from driver\n", __func__,
> +			iommu_group_id(group->iommu_group));
>  		/*
>  		 * XXX An unbound device in a live group is ok, but we'd
>  		 * really like to avoid the above BUG_ON by preventing other
> @@ -830,8 +827,8 @@ int vfio_add_group_dev(struct device *dev,
>  
>  	device = vfio_group_get_device(group, dev);
>  	if (device) {
> -		WARN(1, "Device %s already exists on group %d\n",
> -		     dev_name(dev), iommu_group_id(iommu_group));
> +		dev_WARN(dev, "Device already exists on group %d\n",
> +			 iommu_group_id(iommu_group));
>  		vfio_device_put(device);
>  		vfio_group_put(group);
>  		return -EBUSY;
> 
