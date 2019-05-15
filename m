Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E2C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08B520881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="oeDGU3G/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEOSMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:12:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38430 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfEOSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:12:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so1116396edl.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRze2NwhKxUmrX+tzMEVzIsVCeW3eu3pdWGyD6SSofc=;
        b=oeDGU3G/EXvFp7MfI+JKrqpXLbgsT6KAvUNZwN8SvRY8NFh8phZ9eN40SJQs3yP2fF
         xQNVjFfygUwrlQzRAqlFFs3367XKy6ATqv70WcrTiffrGv7U/o3QoC81OUCvJzdZRG8p
         fqksNru7bvmonPrCDmNwVrVxLr0kycm3ve3KadWmE1UFyAX2ZtlcSctN9f0/UTLoaQED
         uqdMTABej7gKmQzFPgmWzXufN8r0wCE/82Oi8MK3COsE69Q3aMhsB5hZM2JLeEJBuvHb
         A5JnLn4InCloW4LPV1lgyTA4tT/OifK8s0UGspOPwh+TZm33S8DDhDFfnfUf5QC8KTZX
         SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRze2NwhKxUmrX+tzMEVzIsVCeW3eu3pdWGyD6SSofc=;
        b=Uxk/V7zPHOIsoah++KmzZz4N2201VhrY7qGsuJLgKSQyPfdj7VCFf96969KlJvXMpj
         NRfXqt2pz/gwMPKqG3jp8WYg5oawUlYycJDEDSViUvN1brAHWoyyt4FwCw5vr9/oGSBQ
         E/0+/FLkNLNJw9bKL8Sg+AVz98gzwTdMATKRhs4aJ2V27oV9Nri2m2SrbO3oJp9NpncL
         MHthjj+z+bFe9q05uitPUmMT3jfSmlLrcYSm8AwsSmyU1bbwyzYYN/uIALEJf2uEuDzY
         zibSL49kGrBjQgqibv8cM65zufMfb3wlKtKJpE7XvvLZsiXeYAZL1YAYvc1kBrdtt7CQ
         NkxQ==
X-Gm-Message-State: APjAAAWJpwRgQ7nmdqNFI/c8l72xmTHzJPkrMXR9gx3XllHbmobYaRUq
        QEWzW61kFKVZDoT8aONYsPfLu2eNt6wl/S1q/obbGA==
X-Google-Smtp-Source: APXvYqziaXhGwhi8bJ4LWNTeRpPXVwzEAL199XnjwVbC6ahkOtixM/ml3bxeFuTijrrGJ9mfac3GS9qVcSia6Y2UUt0=
X-Received: by 2002:a17:906:5c0f:: with SMTP id e15mr34389391ejq.151.1557943929264;
 Wed, 15 May 2019 11:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com> <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
In-Reply-To: <76dfe7943f2a0ceaca73f5fd23e944dfdc0309d1.camel@intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 15 May 2019 14:11:58 -0400
Message-ID: <CA+CK2bCKcJjXo7BGAVxvbQNYQFSDVLH5aB=S9yTmZWEfexOvtg@mail.gmail.com>
Subject: Re: [v5 0/3] "Hotremove" persistent memory
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>, "bp@suse.de" <bp@suse.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Pavel,
>
> I am working on adding this sort of a workflow into a new daxctl command
> (daxctl-reconfigure-device)- this will allow changing the 'mode' of a
> dax device to kmem, online the resulting memory, and with your patches,
> also attempt to offline the memory, and change back to device-dax.
>
> In running with these patches, and testing the offlining part, I ran
> into the following lockdep below.
>
> This is with just these three patches on top of -rc7.
>
>
> [  +0.004886] ======================================================
> [  +0.001576] WARNING: possible circular locking dependency detected
> [  +0.001506] 5.1.0-rc7+ #13 Tainted: G           O
> [  +0.000929] ------------------------------------------------------
> [  +0.000708] daxctl/22950 is trying to acquire lock:
> [  +0.000548] 00000000f4d397f7 (kn->count#424){++++}, at: kernfs_remove_by_name_ns+0x40/0x80
> [  +0.000922]
>               but task is already holding lock:
> [  +0.000657] 000000002aa52a9f (mem_sysfs_mutex){+.+.}, at: unregister_memory_section+0x22/0xa0

I have studied this issue, and now have a clear understanding why it
happens, I am not yet sure how to fix it, so suggestions are welcomed
:)

Here is the problem:

When we offline pages we have the following call stack:

# echo offline > /sys/devices/system/memory/memory8/state
ksys_write
 vfs_write
  __vfs_write
   kernfs_fop_write
    kernfs_get_active
     lock_acquire                       kn->count#122 (lock for
"memory8/state" kn)
    sysfs_kf_write
     dev_attr_store
      state_store
       device_offline
        memory_subsys_offline
         memory_block_action
          offline_pages
           __offline_pages
            percpu_down_write
             down_write
              lock_acquire              mem_hotplug_lock.rw_sem

When we unbind dax0.0 we have the following  stack:
# echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
drv_attr_store
 unbind_store
  device_driver_detach
   device_release_driver_internal
    dev_dax_kmem_remove
     remove_memory                      device_hotplug_lock
      try_remove_memory                 mem_hotplug_lock.rw_sem
       arch_remove_memory
        __remove_pages
         __remove_section
          unregister_memory_section
           remove_memory_section        mem_sysfs_mutex
            unregister_memory
             device_unregister
              device_del
               device_remove_attrs
                sysfs_remove_groups
                 sysfs_remove_group
                  remove_files
                   kernfs_remove_by_name
                    kernfs_remove_by_name_ns
                     __kernfs_remove    kn->count#122

So, lockdep found the ordering issue with the above two stacks:

1. kn->count#122 -> mem_hotplug_lock.rw_sem
2. mem_hotplug_lock.rw_sem -> kn->count#122
