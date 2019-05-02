Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5A520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l/qtAsPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEBPyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:54:40 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42827 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEBPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:54:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so2514920otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEew1Olq/3yX7Jk5X3KVQichukbbRYn348zBto8NbGk=;
        b=l/qtAsPAilsFN9GFnTDJXUqqxoRw+RgeUo6XZJsy11pBhIPXZGMzGF9+cbUADCM0B4
         8iGGS9XFOfiMSc18kxqUi/FrQbB8BGPoeqIiCS4NxCBkSswNMUAa08zk6l4P2My0dOe0
         04E1cGuNmL/RZr/cQrVby9FjQmJi3SNN4ZD7VrtcPpCjFU0qQFhIMUAeLHgFXIB5XF0A
         3qGq7yAL6+K8T9hFUj5c1u1FxvQCOQOavF3lz8czs9YLvxDB9NJyVd/IBFCfKZyRk6aU
         5iTinm6ydcZDpVFf4A+TbuJ8GCfB0rySLRIrUaqnFCnNAjD46wWnjao2EdlBw4Hpis2C
         t6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEew1Olq/3yX7Jk5X3KVQichukbbRYn348zBto8NbGk=;
        b=sL0AEUg+UJEWf6qmu8UPzRPpE23xn+ivpdXn+FllvhsgvSjbNl7H+tOOsKIm637mo/
         quOnlBIl+8gzCNMdCR6v9fzH6QEDiF+ob9fQcgynrck50NofGpvUK6uiy71cAAi645uU
         3e1gIDJs4ZXw6y4uWW6PayxBOtCtEW3HSjKLuwHqMW5difzj7Ra3uFQpz3Tfhqpvadwi
         hk42vL315gds/fwnsyUiRnN2Cj0QDqpF5IqbY1MqxXUpSXd40YcN7qjZW3BV+kIkUqES
         OoJ0cG01GFSvhqy2fGvr55oiRU0WQHahMuZIDM6xn454xeEl9O/iRJjl+GucltPq+5VH
         7RyQ==
X-Gm-Message-State: APjAAAW0zwBCG32nUxFCg/HXsXI4J1310Xr7YyTqqCRhTo7klIYmX/d6
        Mk0/CXalg01K4fyvyU1xESyUUpLAV8z3yautqfi4Fw==
X-Google-Smtp-Source: APXvYqzTa2L8Y3hvzATDf0GPOGP2MovJVdb2TkdVVwyYLpPc2dggi9AbseY9kp1r15MyCVm90wXUgeQ6+oMS2GDxWaE=
X-Received: by 2002:a9d:7ad1:: with SMTP id m17mr2061812otn.367.1556812476635;
 Thu, 02 May 2019 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com> <20190501191846.12634-3-pasha.tatashin@soleen.com>
In-Reply-To: <20190501191846.12634-3-pasha.tatashin@soleen.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 May 2019 08:54:25 -0700
Message-ID: <CAPcyv4iPzpP-gzuDtPB2ixd6_uTuO8-YdVSfGw_Dq=igaKuOEg@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 12:19 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> It is now allowed to use persistent memory like a regular RAM, but
> currently there is no way to remove this memory until machine is
> rebooted.
>
> This work expands the functionality to also allows hotremoving
> previously hotplugged persistent memory, and recover the device for use
> for other purposes.
>
> To hotremove persistent memory, the management software must first
> offline all memory blocks of dax region, and than unbind it from
> device-dax/kmem driver. So, operations should look like this:
>
> echo offline > echo offline > /sys/devices/system/memory/memoryN/state
> ...
> echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
>
> Note: if unbind is done without offlining memory beforehand, it won't be
> possible to do dax0.0 hotremove, and dax's memory is going to be part of
> System RAM until reboot.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/dax/dax-private.h |  2 +
>  drivers/dax/kmem.c        | 99 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 97 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index a45612148ca0..999aaf3a29b3 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -53,6 +53,7 @@ struct dax_region {
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
>   * @ref: pgmap reference count (driver owned)
>   * @cmp: @ref final put completion (driver owned)
> + * @dax_mem_res: physical address range of hotadded DAX memory
>   */
>  struct dev_dax {
>         struct dax_region *region;
> @@ -62,6 +63,7 @@ struct dev_dax {
>         struct dev_pagemap pgmap;
>         struct percpu_ref ref;
>         struct completion cmp;
> +       struct resource *dax_kmem_res;
>  };
>
>  static inline struct dev_dax *to_dev_dax(struct device *dev)
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 4c0131857133..72b868066026 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -71,21 +71,112 @@ int dev_dax_kmem_probe(struct device *dev)
>                 kfree(new_res);
>                 return rc;
>         }
> +       dev_dax->dax_kmem_res = new_res;
>
>         return 0;
>  }
>
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +static int
> +check_devdax_mem_offlined_cb(struct memory_block *mem, void *arg)
> +{
> +       /* Memory block device */
> +       struct device *mem_dev = &mem->dev;
> +       bool is_offline;
> +
> +       device_lock(mem_dev);
> +       is_offline = mem_dev->offline;
> +       device_unlock(mem_dev);
> +
> +       /*
> +        * Check that device-dax's memory_blocks are offline. If a memory_block
> +        * is not offline a warning is printed and an error is returned.
> +        */
> +       if (!is_offline) {
> +               /* Dax device device */
> +               struct device *dev = (struct device *)arg;
> +               struct dev_dax *dev_dax = to_dev_dax(dev);
> +               struct resource *res = &dev_dax->region->res;
> +               unsigned long spfn = section_nr_to_pfn(mem->start_section_nr);
> +               unsigned long epfn = section_nr_to_pfn(mem->end_section_nr) +
> +                                                      PAGES_PER_SECTION - 1;
> +               phys_addr_t spa = spfn << PAGE_SHIFT;
> +               phys_addr_t epa = epfn << PAGE_SHIFT;
> +
> +               dev_err(dev,
> +                       "DAX region %pR cannot be hotremoved until the next reboot. Memory block [%pa-%pa] is not offline.\n",
> +                       res, &spa, &epa);
> +
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dev_dax_kmem_remove(struct device *dev)
> +{
> +       struct dev_dax *dev_dax = to_dev_dax(dev);
> +       struct resource *res = dev_dax->dax_kmem_res;
> +       resource_size_t kmem_start;
> +       resource_size_t kmem_size;
> +       unsigned long start_pfn;
> +       unsigned long end_pfn;
> +       int rc;
> +
> +       kmem_start = res->start;
> +       kmem_size = resource_size(res);
> +       start_pfn = kmem_start >> PAGE_SHIFT;
> +       end_pfn = start_pfn + (kmem_size >> PAGE_SHIFT) - 1;
> +
> +       /*
> +        * Keep hotplug lock while checking memory state, and also required
> +        * during __remove_memory() call. Admin can't change memory state via
> +        * sysfs while this lock is kept.
> +        */
> +       lock_device_hotplug();
> +
> +       /*
> +        * Walk and check that every singe memory_block of dax region is
> +        * offline. Hotremove can succeed only when every memory_block is
> +        * offlined beforehand.
> +        */
> +       rc = walk_memory_range(start_pfn, end_pfn, dev,
> +                              check_devdax_mem_offlined_cb);
> +
> +       /*
> +        * If admin has not offlined memory beforehand, we cannot hotremove dax.
> +        * Unfortunately, because unbind will still succeed there is no way for
> +        * user to hotremove dax after this.
> +        */
> +       if (rc) {
> +               unlock_device_hotplug();
> +               return rc;
> +       }
> +
> +       /* Hotremove memory, cannot fail because memory is already offlined */
> +       __remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +       unlock_device_hotplug();

Currently the kmem driver can be built as a module, and I don't see a
need to drop that flexibility. What about wrapping these core
routines:

    unlock_device_hotplug
    __remove_memory
    walk_memory_range
    lock_device_hotplug

...into a common exported (gpl) helper like:

    int try_remove_memory(int nid, struct resource *res)

Because as far as I can see there's nothing device-dax specific about
this "try remove iff offline" functionality outside of looking up the
related 'struct resource'. The check_devdax_mem_offlined_cb callback
can be made generic if the callback argument is the resource pointer.
