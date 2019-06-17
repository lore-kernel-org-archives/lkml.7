Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD8EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409352084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q59yzKe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFQMJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:09:27 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41473 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:09:27 -0400
Received: by mail-vk1-f193.google.com with SMTP id u64so1054226vku.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gpyAa7zV7fyBCRlwDGVRWJq9atFmE6fJx/pXuup/sE=;
        b=Q59yzKe9V6rBfaQdqwaMEW0R/3+01aq75KAa9RI20ZluoKMGkTW6xB6T9JQOu61uvb
         boaLaj4zmKOX72mGuWz77hVlasQIQ34CLYbV1JdEWxz4T49BbbDJtxdVEnh18OTcJZvm
         w6R6SgmCV+NHDvtC+qlJz43QuMjRfr/9Md4Mr2i8ROD1BXL5uZ7dlPTgdgedRuuCcipz
         X20fx854fkd3WbuRIxikz2EtazP0jD6feSuDZePY61hGidMSPbpOdZT8UOBoqvs4s2nj
         kph933FNPrLakWL3PFvmMVKXNRx8TukSBK9I/2MPcOkazb1jv9ob4l+L4VFOk/gpv5ui
         RlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gpyAa7zV7fyBCRlwDGVRWJq9atFmE6fJx/pXuup/sE=;
        b=MBP1hv/pPxR56I8sMbPLUbleaaX5tkcXsNhDPB/mR5Av5MJB8Ys8QUjHdedtVoBm0A
         eWkWprq55UJF35S55CIEVXYyIVer+OMPF9jQZRusZqBwqL9Ol46WVR293aaLZHrKiomV
         qoerKEOQNGmIgvaRmbxUL7AzAEQgYmyqTxaII8nWsTBotda1P4wd8RNJt9LBhw9v0BXB
         k18kB2RMixlyR6I+CSMhT4zMTAafCzwgbiJtAmP1u+GGvRuFazbHmj81EWlxvOROOh8y
         MYzu6n0NL34RD9jbnaX0G26/yazR9a/DPXIWe0Zlvf9MZ+su0xCi/bMyyFDzszYcC1Xa
         BhTQ==
X-Gm-Message-State: APjAAAVH2/q0I3GHYUuKdxOHCy/v7xxv1XFDTjmpDCTKfMBBb00KDorE
        BjTyQcqdYZj1Voe7kWNbRq2VqT1ShFrphTSmZsrqemFo
X-Google-Smtp-Source: APXvYqxTMho86rWtW4BrH8nhXDlvVIPRv44h3DVGVA8gD7nzPgdP5khssHIkBYJzXFfdXeQTVL5SYD26xY0M8JE+joY=
X-Received: by 2002:a1f:8744:: with SMTP id j65mr43630289vkd.17.1560773365525;
 Mon, 17 Jun 2019 05:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190616134813.4094-1-ttayar@habana.ai>
In-Reply-To: <20190616134813.4094-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 17 Jun 2019 15:08:59 +0300
Message-ID: <CAFCwf11aXwM57rXbunROFzB-EVkCFH6St1=C13-x4N99+STXTw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Allow accessing host mapped addresses via debugfs
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 4:48 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> Allows using the addr/data32 debugfs nodes to access a device VA of a
> host mapped memory when the IOMMU is disabled.
>
> Due to the possible large amount of a user host mapped memory, the
> driver doesn't maintain a database with the host addresses per device VA.
> When the IOMMU is disabled, this missing info is being overcome by
> simply using phys_to_virt(). However, this is not useful when the IOMMU
> is enabled, and thus the enforced limitation.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  .../ABI/testing/debugfs-driver-habanalabs     | 11 ++++--
>  drivers/misc/habanalabs/debugfs.c             | 35 ++++++++++++-------
>  drivers/misc/habanalabs/goya/goya.c           | 19 +++++++---
>  3 files changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
> index 2f5b80be07a3..18191c2becab 100644
> --- a/Documentation/ABI/testing/debugfs-driver-habanalabs
> +++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
> @@ -3,7 +3,10 @@ Date:           Jan 2019
>  KernelVersion:  5.1
>  Contact:        oded.gabbay@gmail.com
>  Description:    Sets the device address to be used for read or write through
> -                PCI bar. The acceptable value is a string that starts with "0x"
> +                PCI bar, or the device VA of a host mapped memory to be read or
> +                written directly from the host. The latter option is allowed
> +                only when the IOMMU is disabled.
> +                The acceptable value is a string that starts with "0x"
>
>  What:           /sys/kernel/debug/habanalabs/hl<n>/command_buffers
>  Date:           Jan 2019
> @@ -33,10 +36,12 @@ Contact:        oded.gabbay@gmail.com
>  Description:    Allows the root user to read or write directly through the
>                  device's PCI bar. Writing to this file generates a write
>                  transaction while reading from the file generates a read
> -                transcation. This custom interface is needed (instead of using
> +                transaction. This custom interface is needed (instead of using
>                  the generic Linux user-space PCI mapping) because the DDR bar
>                  is very small compared to the DDR memory and only the driver can
> -                move the bar before and after the transaction
> +                move the bar before and after the transaction.
> +                If the IOMMU is disabled, it also allows the root user to read
> +                or write from the host a device VA of a host mapped memory
>
>  What:           /sys/kernel/debug/habanalabs/hl<n>/device
>  Date:           Jan 2019
> diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
> index 886f8ea82499..17974919b760 100644
> --- a/drivers/misc/habanalabs/debugfs.c
> +++ b/drivers/misc/habanalabs/debugfs.c
> @@ -500,6 +500,25 @@ static ssize_t mmu_write(struct file *file, const char __user *buf,
>         return -EINVAL;
>  }
>
> +static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
> +{
> +       struct asic_fixed_properties *prop = &hdev->asic_prop;
> +
> +       if (!hdev->mmu_enable)
> +               goto out;
> +
> +       if (hdev->dram_supports_virtual_memory &&
> +                       addr >= prop->va_space_dram_start_address &&
> +                       addr < prop->va_space_dram_end_address)
> +               return true;
> +
> +       if (addr >= prop->va_space_host_start_address &&
> +                       addr < prop->va_space_host_end_address)
> +               return true;
> +out:
> +       return false;
> +}
> +
>  static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
>                                 u64 *phys_addr)
>  {
> @@ -573,7 +592,6 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
>  {
>         struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
>         struct hl_device *hdev = entry->hdev;
> -       struct asic_fixed_properties *prop = &hdev->asic_prop;
>         char tmp_buf[32];
>         u64 addr = entry->addr;
>         u32 val;
> @@ -582,11 +600,8 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
>         if (*ppos)
>                 return 0;
>
> -       if (addr >= prop->va_space_dram_start_address &&
> -                       addr < prop->va_space_dram_end_address &&
> -                       hdev->mmu_enable &&
> -                       hdev->dram_supports_virtual_memory) {
> -               rc = device_va_to_pa(hdev, entry->addr, &addr);
> +       if (hl_is_device_va(hdev, addr)) {
> +               rc = device_va_to_pa(hdev, addr, &addr);
>                 if (rc)
>                         return rc;
>         }
> @@ -607,7 +622,6 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
>  {
>         struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
>         struct hl_device *hdev = entry->hdev;
> -       struct asic_fixed_properties *prop = &hdev->asic_prop;
>         u64 addr = entry->addr;
>         u32 value;
>         ssize_t rc;
> @@ -616,11 +630,8 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
>         if (rc)
>                 return rc;
>
> -       if (addr >= prop->va_space_dram_start_address &&
> -                       addr < prop->va_space_dram_end_address &&
> -                       hdev->mmu_enable &&
> -                       hdev->dram_supports_virtual_memory) {
> -               rc = device_va_to_pa(hdev, entry->addr, &addr);
> +       if (hl_is_device_va(hdev, addr)) {
> +               rc = device_va_to_pa(hdev, addr, &addr);
>                 if (rc)
>                         return rc;
>         }
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index e8b3a31d211f..ce127a6f606f 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -14,6 +14,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/hwmon.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iommu.h>
>
>  /*
>   * GOYA security scheme:
> @@ -3941,10 +3942,11 @@ static void goya_clear_sm_regs(struct hl_device *hdev)
>  }
>
>  /*
> - * goya_debugfs_read32 - read a 32bit value from a given device address
> + * goya_debugfs_read32 - read a 32bit value from a given device or a host mapped
> + *                       address.
>   *
>   * @hdev:      pointer to hl_device structure
> - * @addr:      address in device
> + * @addr:      device or host mapped address
>   * @val:       returned value
>   *
>   * In case of DDR address that is not mapped into the default aperture that
> @@ -3985,6 +3987,10 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
>                 }
>                 if (ddr_bar_addr == U64_MAX)
>                         rc = -EIO;
> +
> +       } else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
> +               *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
> +
>         } else {
>                 rc = -EFAULT;
>         }
> @@ -3993,10 +3999,11 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
>  }
>
>  /*
> - * goya_debugfs_write32 - write a 32bit value to a given device address
> + * goya_debugfs_write32 - write a 32bit value to a given device or a host mapped
> + *                        address.
>   *
>   * @hdev:      pointer to hl_device structure
> - * @addr:      address in device
> + * @addr:      device or host mapped address
>   * @val:       returned value
>   *
>   * In case of DDR address that is not mapped into the default aperture that
> @@ -4037,6 +4044,10 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
>                 }
>                 if (ddr_bar_addr == U64_MAX)
>                         rc = -EIO;
> +
> +       } else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
> +               *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
> +
>         } else {
>                 rc = -EFAULT;
>         }
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
