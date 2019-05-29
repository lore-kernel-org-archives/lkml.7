Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14352C07542
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAFD217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2E6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:58:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33166 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfE2E6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:58:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id w1so1092847ljw.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePGVAC0GNzUZZi8eiSYsJvmbAo5ymaerGq4lv8lKk4c=;
        b=iyHRVqvZBRvqcqUGmQ3YgkqZFu8Z5MaEL0TFBpzg3kE+MBA+qMfPIXmK25atKxti78
         rlFLK1x/PIrWO4DR9ZyGf6g5uKNwsjNF9MNrcs+aEx6DPXZ/I9baFAVx7dXqA+/8tcfm
         26BlPtHRbMlurN3u5m/u199QorongZ5DsYrCs7MQBWB03PYMkrqPRDSBl42oMUmYItdo
         24j+0WdAS14F49EMcZDi+bqDZ8VkCeFHaWoSgvN+axz36kvBLd3GqIsDL0J9+dRyvWWb
         J/vtyFyAk9Wou9f1A/N9sRBJUYp+wvN3xwMAQ5nLr8KS3p/b5tLZsI4AvrGC9BTmZQ2Z
         XLRw==
X-Gm-Message-State: APjAAAVohFwkSmKunhg5sC1oSXH23tavrM3fVI4rsDZEGf7VuUPjVOgL
        /742Vqx9i05AGqHGAwVkQSAajy9+SpUWLuS8TvudRQ==
X-Google-Smtp-Source: APXvYqwTGyPTj0EJgY0RuUWu8GMZyOowrbszRu0R0TdFn2PDGBmjoBv1NtDQlYfPkAEIirjzwLr6LRgZX1KyvR3ZcRE=
X-Received: by 2002:a2e:9e14:: with SMTP id e20mr11944731ljk.172.1559105897613;
 Tue, 28 May 2019 21:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190528111856.7276-1-kasong@redhat.com>
In-Reply-To: <20190528111856.7276-1-kasong@redhat.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 29 May 2019 10:28:05 +0530
Message-ID: <CACi5LpNae1PuW48ceH6+-t7TokT8yQeKKLt5eNYUNMMAvnV0cQ@mail.gmail.com>
Subject: Re: [PATCH v4] vmcore: Add a kernel parameter novmcoredd
To:     Kairui Song <kasong@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 4:52 PM Kairui Song <kasong@redhat.com> wrote:
>
> Since commit 2724273e8fd0 ("vmcore: add API to collect hardware dump in
> second kernel"), drivers is allowed to add device related dump data to
> vmcore as they want by using the device dump API. This have a potential
> issue, the data is stored in memory, drivers may append too much data
> and use too much memory. The vmcore is typically used in a kdump kernel
> which runs in a pre-reserved small chunk of memory. So as a result it
> will make kdump unusable at all due to OOM issues.
>
> So introduce new 'novmcoredd' command line option. User can disable
> device dump to reduce memory usage. This is helpful if device dump is
> using too much memory, disabling device dump could make sure a regular
> vmcore without device dump data is still available.
>
> Signed-off-by: Kairui Song <kasong@redhat.com>
>
> ---
>  Update from V3:
>   - Use novmcoredd instead of vmcore_device_dump. Use
>     vmcore_device_dump and make it off by default is confusing,
>     novmcoredd is a cleaner way to let user space be able to disable
>     device dump to save memory.
>
>  Update from V2:
>   - Improve related docs
>
>  Update from V1:
>   - Use bool parameter to turn it on/off instead of letting user give
>     the size limit. Size of device dump is hard to determine.
>
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  fs/proc/Kconfig                                 |  3 ++-
>  fs/proc/vmcore.c                                |  8 ++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 138f6664b2e2..1b900d262680 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2872,6 +2872,17 @@
>                         /sys/module/printk/parameters/console_suspend) to
>                         turn on/off it dynamically.
>
> +       novmcoredd      [KNL,KDUMP]
> +                       Disable device dump. Device dump allows drivers to
> +                       append dump data to vmcore so you can collect driver
> +                       specified debug info. The drivers could append the
> +                       data without any limit, and the data is stored in
> +                       memory, this may bring a significant memory stress.
> +                       Disable device dump can help save memory but driver
> +                       debug data will be no longer available.
> +                       Only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
> +                       is set.
> +
>         noaliencache    [MM, NUMA, SLAB] Disables the allocation of alien
>                         caches in the slab allocator.  Saves per-node memory,
>                         but will impact performance.
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 817c02b13b1d..62b19162d198 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -57,7 +57,8 @@ config PROC_VMCORE_DEVICE_DUMP
>           snapshot.
>
>           If you say Y here, the collected device dumps will be added
> -         as ELF notes to /proc/vmcore.
> +         as ELF notes to /proc/vmcore. You can still disabled device
> +         dump by command line option 'novmcoredd'.
>
>  config PROC_SYSCTL
>         bool "Sysctl support (/proc/sys)" if EXPERT
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3fe90443c1bb..e815fd035fc0 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
>  /* Device Dump list and mutex to synchronize access to list */
>  static LIST_HEAD(vmcoredd_list);
>  static DEFINE_MUTEX(vmcoredd_mutex);
> +
> +static bool vmcoredd_disabled;
> +core_param(novmcoredd, vmcoredd_disabled, bool, 0);
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>
>  /* Device Dump Size */
> @@ -1451,6 +1454,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>         size_t data_size;
>         int ret;
>
> +       if (vmcoredd_disabled) {
> +               pr_err_once("Device dump is disabled\n");
> +               return -EINVAL;
> +       }
> +
>         if (!data || !strlen(data->dump_name) ||
>             !data->vmcoredd_callback || !data->size)
>                 return -EINVAL;
> --
> 2.21.0

LGTM, so:

Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
