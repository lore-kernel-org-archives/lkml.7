Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568962084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfDBHxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:53:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfDBHxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:53:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9006990C9B;
        Tue,  2 Apr 2019 07:53:15 +0000 (UTC)
Received: from [10.36.117.163] (ovpn-117-163.ams2.redhat.com [10.36.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3220760BE6;
        Tue,  2 Apr 2019 07:53:09 +0000 (UTC)
Subject: Re: [PATCH 1/1] vfio: Use dev_printk() when possible
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20190330144135.17351-1-helgaas@kernel.org>
 <20190330144135.17351-2-helgaas@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <6366c078-2900-af88-d889-d9aeb3f7497f@redhat.com>
Date:   Tue, 2 Apr 2019 09:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190330144135.17351-2-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 02 Apr 2019 07:53:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Alex,

On 3/30/19 3:41 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use dev_printk() when possible to make messages consistent with other
> device-related messages.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
For the vfio-platform part:
Acked-by: Eric Auger <eric.auger@redhat.com>

For the rest:
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric


> ---
>  drivers/vfio/pci/vfio_pci.c                   | 26 +++++++----------
>  drivers/vfio/pci/vfio_pci_config.c            | 28 ++++++++----------
>  .../platform/reset/vfio_platform_amdxgbe.c    |  5 ++--
>  drivers/vfio/platform/vfio_platform_common.c  | 12 ++++----
>  drivers/vfio/vfio.c                           | 29 +++++++++----------
>  include/linux/pci.h                           |  3 ++
>  6 files changed, 49 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a25659b5a5d1..b0fb4ea3253a 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define dev_fmt pr_fmt
>  
>  #include <linux/device.h>
>  #include <linux/eventfd.h>
> @@ -287,12 +288,11 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  	pci_save_state(pdev);
>  	vdev->pci_saved_state = pci_store_saved_state(pdev);
>  	if (!vdev->pci_saved_state)
> -		pr_debug("%s: Couldn't store %s saved state\n",
> -			 __func__, dev_name(&pdev->dev));
> +		pci_dbg(pdev, "%s: Couldn't store saved state\n", __func__);
>  
>  	if (likely(!nointxmask)) {
>  		if (vfio_pci_nointx(pdev)) {
> -			dev_info(&pdev->dev, "Masking broken INTx support\n");
> +			pci_info(pdev, "Masking broken INTx support\n");
>  			vdev->nointx = true;
>  			pci_intx(pdev, 0);
>  		} else
> @@ -336,8 +336,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  	    IS_ENABLED(CONFIG_VFIO_PCI_IGD)) {
>  		ret = vfio_pci_igd_init(vdev);
>  		if (ret) {
> -			dev_warn(&vdev->pdev->dev,
> -				 "Failed to setup Intel IGD regions\n");
> +			pci_warn(pdev, "Failed to setup Intel IGD regions\n");
>  			goto disable_exit;
>  		}
>  	}
> @@ -346,8 +345,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  	    IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2)) {
>  		ret = vfio_pci_nvdia_v100_nvlink2_init(vdev);
>  		if (ret && ret != -ENODEV) {
> -			dev_warn(&vdev->pdev->dev,
> -				 "Failed to setup NVIDIA NV2 RAM region\n");
> +			pci_warn(pdev, "Failed to setup NVIDIA NV2 RAM region\n");
>  			goto disable_exit;
>  		}
>  	}
> @@ -356,8 +354,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  	    IS_ENABLED(CONFIG_VFIO_PCI_NVLINK2)) {
>  		ret = vfio_pci_ibm_npu2_init(vdev);
>  		if (ret && ret != -ENODEV) {
> -			dev_warn(&vdev->pdev->dev,
> -					"Failed to setup NVIDIA NV2 ATSD region\n");
> +			pci_warn(pdev, "Failed to setup NVIDIA NV2 ATSD region\n");
>  			goto disable_exit;
>  		}
>  	}
> @@ -429,8 +426,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
>  	 * is just busy work.
>  	 */
>  	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
> -		pr_info("%s: Couldn't reload %s saved state\n",
> -			__func__, dev_name(&pdev->dev));
> +		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
>  
>  		if (!vdev->reset_works)
>  			goto out;
> @@ -1255,17 +1251,17 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  static void vfio_pci_request(void *device_data, unsigned int count)
>  {
>  	struct vfio_pci_device *vdev = device_data;
> +	struct pci_dev *pdev = vdev->pdev;
>  
>  	mutex_lock(&vdev->igate);
>  
>  	if (vdev->req_trigger) {
>  		if (!(count % 10))
> -			dev_notice_ratelimited(&vdev->pdev->dev,
> -				"Relaying device request to user (#%u)\n",
> -				count);
> +			pci_notice_ratelimited(pdev,
> +				"Relaying device request to user (#%u)\n", count);
>  		eventfd_signal(vdev->req_trigger, 1);
>  	} else if (count == 0) {
> -		dev_warn(&vdev->pdev->dev,
> +		pci_warn(pdev,
>  			"No device request channel registered, blocked until released by user\n");
>  	}
>  
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index e82b51114687..d639ec508a84 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -412,8 +412,7 @@ static void vfio_bar_restore(struct vfio_pci_device *vdev)
>  	if (pdev->is_virtfn)
>  		return;
>  
> -	pr_info("%s: %s reset recovery - restoring bars\n",
> -		__func__, dev_name(&pdev->dev));
> +	pci_info(pdev, "%s: reset recovery - restoring BARs\n", __func__);
>  
>  	for (i = PCI_BASE_ADDRESS_0; i <= PCI_BASE_ADDRESS_5; i += 4, rbar++)
>  		pci_user_write_config_dword(pdev, i, *rbar);
> @@ -1298,8 +1297,8 @@ static int vfio_cap_len(struct vfio_pci_device *vdev, u8 cap, u8 pos)
>  		else
>  			return PCI_SATA_SIZEOF_SHORT;
>  	default:
> -		pr_warn("%s: %s unknown length for pci cap 0x%x@0x%x\n",
> -			dev_name(&pdev->dev), __func__, cap, pos);
> +		pci_warn(pdev, "%s: unknown length for PCI cap %#x@%#x\n",
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
> +		pci_warn(pdev, "%s: unknown length for PCI ecap %#x@%#x\n",
> +			 __func__, ecap, epos);
>  	}
>  
>  	return 0;
> @@ -1474,8 +1473,7 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
>  		}
>  
>  		if (!len) {
> -			pr_info("%s: %s hiding cap 0x%x\n",
> -				__func__, dev_name(&pdev->dev), cap);
> +			pci_info(pdev, "%s: hiding cap %#x@%#x\n", __func__, cap, pos);
>  			*prev = next;
>  			pos = next;
>  			continue;
> @@ -1486,9 +1484,8 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
>  			if (likely(map[pos + i] == PCI_CAP_ID_INVALID))
>  				continue;
>  
> -			pr_warn("%s: %s pci config conflict @0x%x, was cap 0x%x now cap 0x%x\n",
> -				__func__, dev_name(&pdev->dev),
> -				pos + i, map[pos + i], cap);
> +			pci_warn(pdev, "%s: PCI config conflict @%#x, was cap %#x now cap %#x\n",
> +				 __func__, pos + i, map[pos + i], cap);
>  		}
>  
>  		BUILD_BUG_ON(PCI_CAP_ID_MAX >= PCI_CAP_ID_INVALID_VIRT);
> @@ -1549,8 +1546,8 @@ static int vfio_ecap_init(struct vfio_pci_device *vdev)
>  		}
>  
>  		if (!len) {
> -			pr_info("%s: %s hiding ecap 0x%x@0x%x\n",
> -				__func__, dev_name(&pdev->dev), ecap, epos);
> +			pci_info(pdev, "%s: hiding ecap %#x@%#x\n",
> +				 __func__, ecap, epos);
>  
>  			/* If not the first in the chain, we can skip over it */
>  			if (prev) {
> @@ -1572,9 +1569,8 @@ static int vfio_ecap_init(struct vfio_pci_device *vdev)
>  			if (likely(map[epos + i] == PCI_CAP_ID_INVALID))
>  				continue;
>  
> -			pr_warn("%s: %s pci config conflict @0x%x, was ecap 0x%x now ecap 0x%x\n",
> -				__func__, dev_name(&pdev->dev),
> -				epos + i, map[epos + i], ecap);
> +			pci_warn(pdev, "%s: PCI config conflict @%#x, was ecap %#x now ecap %#x\n",
> +				 __func__, epos + i, map[epos + i], ecap);
>  		}
>  
>  		/*
> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> index 3ddb2704221d..fe95964bc3be 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> @@ -89,7 +89,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>  	} while ((pcs_value & MDIO_CTRL1_RESET) && --count);
>  
>  	if (pcs_value & MDIO_CTRL1_RESET)
> -		pr_warn("%s XGBE PHY reset timeout\n", __func__);
> +		dev_warn(vdev->device, "%s: XGBE PHY reset timeout\n",
> +			 __func__);
>  
>  	/* disable auto-negotiation */
>  	value = xmdio_read(xpcs_regs->ioaddr, MDIO_MMD_AN, MDIO_CTRL1);
> @@ -114,7 +115,7 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>  		usleep_range(500, 600);
>  
>  	if (!count)
> -		pr_warn("%s MAC SW reset failed\n", __func__);
> +		dev_warn(vdev->device, "%s: MAC SW reset failed\n", __func__);
>  
>  	return 0;
>  }
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index c0cd824be2b7..d369d9ae166b 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -12,6 +12,8 @@
>   * GNU General Public License for more details.
>   */
>  
> +#define dev_fmt(fmt)	"VFIO: " fmt
> +
>  #include <linux/device.h>
>  #include <linux/acpi.h>
>  #include <linux/iommu.h>
> @@ -63,7 +65,7 @@ static int vfio_platform_acpi_probe(struct vfio_platform_device *vdev,
>  
>  	adev = ACPI_COMPANION(dev);
>  	if (!adev) {
> -		pr_err("VFIO: ACPI companion device not found for %s\n",
> +		dev_err(dev, "ACPI companion device not found for %s\n",
>  			vdev->name);
>  		return -ENODEV;
>  	}
> @@ -638,7 +640,7 @@ static int vfio_platform_of_probe(struct vfio_platform_device *vdev,
>  	ret = device_property_read_string(dev, "compatible",
>  					  &vdev->compat);
>  	if (ret)
> -		pr_err("VFIO: Cannot retrieve compat for %s\n", vdev->name);
> +		dev_err(dev, "Cannot retrieve compat for %s\n", vdev->name);
>  
>  	return ret;
>  }
> @@ -680,14 +682,14 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>  
>  	ret = vfio_platform_get_reset(vdev);
>  	if (ret && vdev->reset_required) {
> -		pr_err("VFIO: No reset function found for device %s\n",
> -		       vdev->name);
> +		dev_err(dev, "No reset function found for device %s\n",
> +		        vdev->name);
>  		return ret;
>  	}
>  
>  	group = vfio_iommu_group_get(dev);
>  	if (!group) {
> -		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
> +		dev_err(dev, "No IOMMU group for device %s\n", vdev->name);
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
> +	dev_WARN(dev, "Device added to live group %d!\n",
> +		 iommu_group_id(group->iommu_group));
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
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..27854731afc4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2363,4 +2363,7 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  #define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
>  #define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
>  
> +#define pci_notice_ratelimited(pdev, fmt, arg...) \
> +	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
> +
>  #endif /* LINUX_PCI_H */
> 
