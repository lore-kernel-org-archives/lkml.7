Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D66C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4432E21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EICipj7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgACH7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:59:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46353 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgACH7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 02:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578038343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTkOJXYtsJl5gqpboh4tFkRUS1dSPk+5aoyVvRoTwh8=;
        b=EICipj7SXVtI1aXY605WXJAIR3MgwYMbLQh4zuUNti4uv2SyTJ04oUC676XSC1hP1/wzqY
        gt6wLVTll2xny9Qu5g4tTgR9iR5NFilo2bwAB6DIpFt2+bvm/vx42YiGQqQC2ECslp55WM
        +CChECYa1PjRLrRAdDtJdOur13ik/Ck=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-Dw7--kr7Mu2VFsI80sm5-g-1; Fri, 03 Jan 2020 02:59:02 -0500
X-MC-Unique: Dw7--kr7Mu2VFsI80sm5-g-1
Received: by mail-io1-f71.google.com with SMTP id u6so3836944iog.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 23:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTkOJXYtsJl5gqpboh4tFkRUS1dSPk+5aoyVvRoTwh8=;
        b=XZHlmYC2zHo11A3NIHOpxk56GjwaegTjFU5+trI0+ynzYTCoJ3qXx+xWnQ/jzgfMHv
         ot9M3o1JXpe3TfOiPpAfaYC08nU3DVGYKiLlgJaG+SPAQt9jhqrvu7F+Cps4xVHGdToo
         hu0ln/BQAh33wxscR4OO6Yx2prsLCYpRa72Oo+dv7s0zKqNqc8qGk5Y03tuzCJ5EtMS9
         lfYIjatpXqg6wgEF2OUFLLAj0AWl+TA8cmBl2rUGqTlutfApHFw+uy+7761l+GoO4a47
         bumrQUDmTAehjvbteGK12Ki98X4k5TfwfVoK5zsKv1m4yQKL0yDwuUkNxwovYOrUtmGE
         aC7g==
X-Gm-Message-State: APjAAAWK0hB+L5txfmHKTYdFuLKVYG7rVU1nomVO0PzTRNtMpWz2F08F
        QBxUK/+nuorDQufM3z3vaXuq5J5VO8ZeKdKv7vyOtq+TyUct8MisLa4W6Fe2SCGd7WI/cCdjKaa
        ROQp7nbkODgYEOnHxEJwT5wPsFeKHsKsAwmlFcbPg
X-Received: by 2002:a6b:c742:: with SMTP id x63mr54288773iof.162.1578038342044;
        Thu, 02 Jan 2020 23:59:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGWwoijUrNk3lGb3yHH/OCxGOXCznRhuHJk2kwDaGgB0t1My6xVR0q3HfVpf6GINrQtXIpyWOg9OkGyajeljY=
X-Received: by 2002:a6b:c742:: with SMTP id x63mr54288762iof.162.1578038341758;
 Thu, 02 Jan 2020 23:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com>
In-Reply-To: <20191225192118.283637-1-kasong@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 3 Jan 2020 15:58:50 +0800
Message-ID: <CACPcB9frcWN5vMOtZb4x1FiiyvQYXCyJoRNGeexayuCsKdVZMw@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 3:21 AM Kairui Song <kasong@redhat.com> wrote:
>
> There are reports about kdump hang upon reboot on some HPE machines,
> kernel hanged when trying to shutdown a PCIe port, an uncorrectable
> error occurred and crashed the system.
>
> On the machine I can reproduce this issue, part of the topology
> looks like this:
>
> [0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
>           +-01.0-[02]--
>           +-01.1-[05]--
>           +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
>           +-02.1-[0f]--
>           +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array Gen9 Controllers
>
> When shuting down PCIe port 0000:00:02.2 or 0000:00:02.0, the machine
> will hang, depend on which device is reinitialized in kdump kernel.
>
> If force remove unused device then trigger kdump, the problem will never
> happen:
>
>     echo 1 > /sys/bus/pci/devices/0000\:00\:02.2/0000\:07\:00.0/remove
>     echo c > /proc/sysrq-trigger
>
>     ... Kdump save vmcore through network, the NIC get reinitialized and
>     hpsa is untouched. Then reboot with no problem. (If hpsa is used
>     instead, shutdown the NIC in first kernel will help)
>
> The cause is that some devices are enabled by the first kernel, but it
> don't have the chance to shutdown the device, and kdump kernel is not
> aware of it, unless it reinitialize the device.
>
> Upon reboot, kdump kernel will skip downstream device shutdown and
> clears its bridge's master bit directly. The downstream device could
> error out as it can still send requests but upstream refuses it.
>
> So for kdump, let kernel read the correct hardware power state on boot,
> and always clear the bus master bit of PCI device upon shutdown if the
> device is on. PCIe port driver will always shutdown all downstream
> devices first, so this should ensure all downstream devices have bus
> master bit off before clearing the bridge's bus master bit.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 11 ++++++++---
>  drivers/pci/quirks.c     | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..84a7fd643b4d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -18,6 +18,7 @@
>  #include <linux/kexec.h>
>  #include <linux/of_device.h>
>  #include <linux/acpi.h>
> +#include <linux/crash_dump.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>
> @@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
>          * If this is a kexec reboot, turn off Bus Master bit on the
>          * device to tell it to not continue to do DMA. Don't touch
>          * devices in D3cold or unknown states.
> -        * If it is not a kexec reboot, firmware will hit the PCI
> -        * devices with big hammer and stop their DMA any way.
> +        * If this is kdump kernel, also turn off Bus Master, the device
> +        * could be activated by previous crashed kernel and may block
> +        * it's upstream from shutting down.
> +        * Else, firmware will hit the PCI devices with big hammer
> +        * and stop their DMA any way.
>          */
> -       if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +       if ((kexec_in_progress || is_kdump_kernel()) &&
> +                       pci_dev->current_state <= PCI_D3hot)
>                 pci_clear_master(pci_dev);
>  }
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a088d7d8..c65d11ab3939 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/switchtec.h>
> +#include <linux/crash_dump.h>
>  #include <asm/dma.h>   /* isa_dma_bridge_buggy */
>  #include "pci.h"
>
> @@ -192,6 +193,25 @@ static int __init pci_apply_final_quirks(void)
>  }
>  fs_initcall_sync(pci_apply_final_quirks);
>
> +/*
> + * Read the device state even if it's not enabled. The device could be
> + * activated by previous crashed kernel, this will read and correct the
> + * cached state.
> + */
> +static void quirk_read_pm_state_in_kdump(struct pci_dev *dev)
> +{
> +       u16 pmcsr;
> +
> +       if (!is_kdump_kernel())
> +               return;
> +
> +       if (dev->pm_cap) {
> +               pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +       }
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_read_pm_state_in_kdump);
> +
>  /*
>   * Decoding should be disabled for a PCI device during BAR sizing to avoid
>   * conflict. But doing so may cause problems on host bridge and perhaps other
> --
> 2.24.1
>

Let me make a simplified version of the commit message:

On some HPE machines, If kernel clears the bus master bit of a PCI
bridge, but some downstream device of it is still alive, the
downstream device could error out and crash the system.

Usually this never happen, as PCI devices are always shutdown before
their upstream bridge is shutdown. But in kdump kernel, the real
hardware state is out of sync with the data in kernel, as previous
kernel could enable some hardware and kdump kernel is unaware of it,
so kdump kernel just skipped the downstream device shutdown.

This patch is trying to fix this issue.

