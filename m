Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D192081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCHDPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:15:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:13177 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfCHDPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:15:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 19:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,454,1544515200"; 
   d="scan'208,223";a="122110409"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 19:15:10 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
 <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
Date:   Fri, 8 Mar 2019 11:09:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
Content-Type: multipart/mixed;
 boundary="------------52A37280C28FB8979E38AF0A"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------52A37280C28FB8979E38AF0A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 3/7/19 6:21 PM, James Sewart wrote:
> Hey Lu,
> 
>> On 7 Mar 2019, at 06:31, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> On 3/7/19 2:08 AM, James Sewart wrote:
>>>>>>> -	/*
>>>>>>> -	 * For each rmrr
>>>>>>> -	 *   for each dev attached to rmrr
>>>>>>> -	 *   do
>>>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>>>> -	 *     allocate free domain
>>>>>>> -	 *     allocate page table entries for rmrr
>>>>>>> -	 *     if context not allocated for bus
>>>>>>> -	 *           allocate and init context
>>>>>>> -	 *           set present in root table for this bus
>>>>>>> -	 *     init context with domain, translation etc
>>>>>>> -	 *    endfor
>>>>>>> -	 * endfor
>>>>>>> -	 */
>>>>>>> -	pr_info("Setting RMRR:\n");
>>>>>>> -	for_each_rmrr_units(rmrr) {
>>>>>>> -		/* some BIOS lists non-exist devices in DMAR table. */
>>>>>>> -		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>>>>>> -					  i, dev) {
>>>>>>> -			ret = iommu_prepare_rmrr_dev(rmrr, dev);
>>>>>>> -			if (ret)
>>>>>>> -				pr_err("Mapping reserved region failed\n");
>>>>>>> -		}
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	iommu_prepare_isa();
>>>>>> Why do you want to remove this segment of code?
>>>>> This will only work if the lazy allocation of domains exists, these
>>>>> mappings will disappear once a default domain is attached to a device and
>>>>> then remade by iommu_group_create_direct_mappings. This code is redundant
>>>>> and removing it allows us to remove all the lazy allocation logic.
>>>> No exactly.
>>>>
>>>> We need to setup the rmrr mapping before enabling dma remapping,
>>>> otherwise, there will be a window after dma remapping enabling and
>>>> rmrr getting mapped, during which people might see dma faults.
>>> Do you think this patch instead should be a refactoring to simplify this initial domain setup before the default domain takes over? It seems like duplicated effort to have both lazy allocated domains and externally managed domains. We could allocate a domain here for any devices with RMRR and call get_resv_regions to avoid duplicating RMRR loop.
>>
>> Agree. We should replace the lazy allocated domains with default domain
>> in a clean way. Actually, your patches look great to me. But I do think
>> we need further cleanups. The rmrr code is one example, and the identity
>> domain (si_domain) is another.
>>
>> Do you mind if I work on top of your patches for further cleanups and
>> sign off a v2 together with you?
> 
> Sure, sounds good. I’ll fixup patch 3 and have a go at integrating
> iommu_prepare_isa into get_resv_regions. This should make the initial
> domain logic here quite concise.
> 

Here attached three extra patches which I think should be added before
PATCH 3/4, and some further cleanup changes which you can merge with
PATCH 4/4.

----------------

0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch

These two patches aim to add a generic method for vendor specific iommu
drivers to specify the type of the default domain for a device. Intel
iommu driver will register an ops for this since it already has its own
identity map adjudicator for a long time.

----------------

0008-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch

This aims to address the requirement of rmrr identity map before
enabling DMA remapping. With default domain mechanism, the default
domain will be allocated and attached to the device in bus_set_iommu()
during boot. Move enabling DMA remapping engines after bus_set_iommu()
will fix the rmrr issue.

----------------

0009-return-si_domain-directly.patch

I suggest that we should keep current si_domain implementation since
changing si_domain is not the purpose of this patch set. Please merge
this with PATCH 3/4 if you like it.

----------------

0010-iommu-vt-d-remove-floopy-workaround.patch
0011-iommu-vt-d-remove-prepare-rmrr-helpers.patch
0012-iommu-vt-d-remove-prepare-identity-map-during-boot.patch

Above patches are further cleanups as the result of switching to default
domain. Please consider to merge them with PATCH 4/4.

----------------

I have done some sanity checks on my local machine against all patches.
I can do more tests after you submit a v2.


Best regards,
Lu Baolu



--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.pa";
 filename*1="tch"

From d1625f1e8461cef23bc8697ec51382c47b92fa5a Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Thu, 7 Mar 2019 10:50:27 +0800
Subject: [PATCH 06/12] iommu: Add ops entry for vendor specific default domain
 type

This adds an iommu ops entry for iommu vendor driver to specify
the type of the default domain for each device. This is needed
for the vendor driver, which already has its own logic to
determine the use of identity domain for a long time, when it
switches to apply default domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 12 +++++++++---
 include/linux/iommu.h |  4 ++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 374327018a11..4101f38a7844 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1102,12 +1102,18 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 */
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
+		int domain_type = iommu_def_domain_type;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		if (ops->is_identity_map)
+			domain_type = ops->is_identity_map(dev) ?
+				      IOMMU_DOMAIN_IDENTITY :
+				      IOMMU_DOMAIN_DMA;
+
+		dom = __iommu_domain_alloc(dev->bus, domain_type);
+		if (!dom && domain_type != IOMMU_DOMAIN_DMA) {
 			dev_warn(dev,
 				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-				 iommu_def_domain_type);
+				 domain_type);
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 		}
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e90da6b6f3d1..8e298fd631d0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -184,6 +184,7 @@ struct iommu_resv_region {
  * @domain_window_disable: Disable a particular window for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @is_identity_map: vendor customized identity map adjudicator
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -226,6 +227,9 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	/* Vendor customized identity map adjudicator */
+	bool (*is_identity_map)(struct device *dev);
+
 	unsigned long pgsize_bitmap;
 };
 
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch"

From c178d3d7033ca35e3302e1e6c8d2a4d906814b9a Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Thu, 7 Mar 2019 12:53:12 +0800
Subject: [PATCH 07/12] iommu/vt-d: Add is_identity_map ops entry

This adds the is_identity_map ops entry for Intel IOMMU driver.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 282257e2628d..eb8aca8d1dc9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5181,6 +5181,11 @@ static void intel_iommu_apply_resv_region(struct device *dev,
 	WARN_ON_ONCE(reserve_iova(&dmar_domain->iovad, start, end) == NULL);
 }
 
+static bool intel_iommu_is_identity_map(struct device *dev)
+{
+	return iommu_should_identity_map(dev, 1);
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
@@ -5276,6 +5281,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
+	.is_identity_map	= intel_iommu_is_identity_map,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0008-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0008-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch"

From 7d60445b9ba0c447a3f027470bed7a7c680f73c9 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Thu, 7 Mar 2019 13:14:43 +0800
Subject: [PATCH 08/12] iommu/vt-d: Enable DMA remapping after rmrr mapped

The rmrr devices require identity map of the rmrr regions before
enabling DMA remapping. Otherwise, there will be a window during
which DMA from/to the rmrr regions will be blocked. In order to
alleviate this, we move enabling DMA remapping after all rmrr
regions get mapped.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index eb8aca8d1dc9..9641d75cbfa3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3385,11 +3385,6 @@ static int __init init_dmars(void)
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
-
-		if (!translation_pre_enabled(iommu))
-			iommu_enable_translation(iommu);
-
-		iommu_disable_protect_mem_regions(iommu);
 	}
 
 	return 0;
@@ -4733,7 +4728,6 @@ int __init intel_iommu_init(void)
 		goto out_free_reserved_range;
 	}
 	up_write(&dmar_global_lock);
-	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	swiotlb = 0;
@@ -4756,6 +4750,16 @@ int __init intel_iommu_init(void)
 		register_memory_notifier(&intel_iommu_memory_nb);
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
+
+	/* Finally, we enable the DMA remapping hardware. */
+	for_each_iommu(iommu, drhd) {
+		if (!translation_pre_enabled(iommu))
+			iommu_enable_translation(iommu);
+
+		iommu_disable_protect_mem_regions(iommu);
+	}
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
+
 	intel_iommu_enabled = 1;
 	intel_iommu_debugfs_init();
 
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0009-return-si_domain-directly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0009-return-si_domain-directly.patch"

From 0df12098d4f86354eea458497f171e77f6cf9dee Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Thu, 7 Mar 2019 16:28:57 +0800
Subject: [PATCH 09/12] return si_domain directly

---
 drivers/iommu/intel-iommu.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9641d75cbfa3..b380818878c7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4875,12 +4875,10 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	case IOMMU_DOMAIN_UNMANAGED:
 		flags |= DOMAIN_FLAG_VIRTUAL_MACHINE | DOMAIN_FLAG_INITIALISED;
 		dmar_domain = alloc_domain(flags);
-		if (!dmar_domain) {
-			pr_err("Can't allocate dmar_domain\n");
+		if (!dmar_domain)
 			return NULL;
-		}
+
 		if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-			pr_err("Domain initialization failed\n");
 			domain_exit(dmar_domain);
 			return NULL;
 		}
@@ -4892,30 +4890,15 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		break;
 	case IOMMU_DOMAIN_DMA:
 		dmar_domain = alloc_domain(flags);
-		if (!dmar_domain) {
-			pr_err("Can't allocate dmar_domain\n");
+		if (!dmar_domain)
 			return NULL;
-		}
-		// init domain in device attach when we know IOMMU capabilities
 		break;
 	case IOMMU_DOMAIN_IDENTITY:
-		flags |= DOMAIN_FLAG_STATIC_IDENTITY | DOMAIN_FLAG_INITIALISED;
-		dmar_domain = alloc_domain(flags);
-		if (!dmar_domain) {
-			pr_err("Can't allocate dmar_domain\n");
-			return NULL;
-		}
-		if (si_domain_init(dmar_domain, 0)) {
-			pr_err("Domain initialization failed\n");
-			domain_exit(dmar_domain);
-			return NULL;
-		}
-		break;
+		return &si_domain->domain;
 	default:
 		return NULL;
 	}
 
-	dmar_domain->domain.type = type;
 	return &dmar_domain->domain;
 }
 
@@ -5009,6 +4992,10 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	int prot = 0;
 	int ret;
 
+	/* Don't bother if hardware passthrough used. */
+	if (dmar_domain == si_domain && hw_pass_through)
+		return 0;
+
 	if (iommu_prot & IOMMU_READ)
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0010-iommu-vt-d-remove-floopy-workaround.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0010-iommu-vt-d-remove-floopy-workaround.patch"

From 3c6f73cf3e37f7691150f4639a9012f22ab97ead Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Fri, 8 Mar 2019 09:20:02 +0800
Subject: [PATCH 10/12] iommu/vt-d: remove floopy workaround

---
 drivers/iommu/intel-iommu.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b380818878c7..ceea9be31063 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2687,31 +2687,6 @@ static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
 					  rmrr->end_address);
 }
 
-#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(void)
-{
-	struct pci_dev *pdev;
-	int ret;
-
-	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (!pdev)
-		return;
-
-	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
-
-	if (ret)
-		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
-
-	pci_dev_put(pdev);
-}
-#else
-static inline void iommu_prepare_isa(void)
-{
-	return;
-}
-#endif /* !CONFIG_INTEL_IOMMU_FLPY_WA */
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(struct dmar_domain *si_domain, int hw)
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0011-iommu-vt-d-remove-prepare-rmrr-helpers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0011-iommu-vt-d-remove-prepare-rmrr-helpers.patch"

From fcd893df02b2288c6ee48224d408c30786a48d68 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Fri, 8 Mar 2019 09:26:27 +0800
Subject: [PATCH 11/12] iommu/vt-d: remove prepare rmrr helpers

---
 drivers/iommu/intel-iommu.c | 67 -------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ceea9be31063..aa33f65b32cc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2620,73 +2620,6 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 				DMA_PTE_READ|DMA_PTE_WRITE);
 }
 
-static int domain_prepare_identity_map(struct device *dev,
-				       struct dmar_domain *domain,
-				       unsigned long long start,
-				       unsigned long long end)
-{
-	/* For _hardware_ passthrough, don't bother. But for software
-	   passthrough, we do it anyway -- it may indicate a memory
-	   range which is reserved in E820, so which didn't get set
-	   up to start with in si_domain */
-	if (domain == si_domain && hw_pass_through) {
-		pr_warn("Ignoring identity map for HW passthrough device %s [0x%Lx - 0x%Lx]\n",
-			dev_name(dev), start, end);
-		return 0;
-	}
-
-	pr_info("Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
-		dev_name(dev), start, end);
-
-	if (end < start) {
-		WARN(1, "Your BIOS is broken; RMRR ends before it starts!\n"
-			"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-			dmi_get_system_info(DMI_BIOS_VENDOR),
-			dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	if (end >> agaw_to_width(domain->agaw)) {
-		WARN(1, "Your BIOS is broken; RMRR exceeds permitted address width (%d bits)\n"
-		     "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		     agaw_to_width(domain->agaw),
-		     dmi_get_system_info(DMI_BIOS_VENDOR),
-		     dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	return iommu_domain_identity_map(domain, start, end);
-}
-
-static int iommu_prepare_identity_map(struct device *dev,
-				      unsigned long long start,
-				      unsigned long long end)
-{
-	struct dmar_domain *domain;
-	int ret;
-
-	domain = find_domain(dev);
-	if (!domain)
-		return -ENOMEM;
-
-	ret = domain_prepare_identity_map(dev, domain, start, end);
-	if (ret)
-		domain_exit(domain);
-
-	return ret;
-}
-
-static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
-					 struct device *dev)
-{
-	if (dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO)
-		return 0;
-	return iommu_prepare_identity_map(dev, rmrr->base_address,
-					  rmrr->end_address);
-}
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(struct dmar_domain *si_domain, int hw)
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A
Content-Type: text/x-patch;
 name="0012-iommu-vt-d-remove-prepare-identity-map-during-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0012-iommu-vt-d-remove-prepare-identity-map-during-boot.patc";
 filename*1="h"

From 3d02365161a3b1441aaf1d36940758df2b4f2b1c Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Fri, 8 Mar 2019 09:34:39 +0800
Subject: [PATCH 12/12] iommu/vt-d: remove prepare identity map during boot

---
 drivers/iommu/intel-iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index aa33f65b32cc..e7a94bb927c4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2839,18 +2839,10 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 
 static int __init iommu_prepare_static_identity_mapping(int hw)
 {
-	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	struct device *dev;
-	int i;
-	int ret = 0;
-
-	for_each_pci_dev(pdev) {
-		ret = dev_prepare_static_identity_mapping(&pdev->dev, hw);
-		if (ret)
-			return ret;
-	}
+	int i, ret = 0;
 
 	for_each_active_iommu(iommu, drhd)
 		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
-- 
2.17.1


--------------52A37280C28FB8979E38AF0A--
