Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC345C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C9620883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfE1Mph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:45:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfE1Mpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:45:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E964D6CFA5;
        Tue, 28 May 2019 12:45:34 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ED87194A0;
        Tue, 28 May 2019 12:45:30 +0000 (UTC)
Date:   Tue, 28 May 2019 20:45:26 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4] vmcore: Add a kernel parameter novmcoredd
Message-ID: <20190528124526.GA11184@dhcp-128-65.nay.redhat.com>
References: <20190528111856.7276-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528111856.7276-1-kasong@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 28 May 2019 12:45:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/19 at 07:18pm, Kairui Song wrote:
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
>  			/sys/module/printk/parameters/console_suspend) to
>  			turn on/off it dynamically.
>  
> +	novmcoredd	[KNL,KDUMP]
> +			Disable device dump. Device dump allows drivers to
> +			append dump data to vmcore so you can collect driver
> +			specified debug info. The drivers could append the
> +			data without any limit, and the data is stored in
> +			memory, this may bring a significant memory stress.
> +			Disable device dump can help save memory but driver
> +			debug data will be no longer available.
> +			Only available when CONFIG_PROC_VMCORE_DEVICE_DUMP
> +			is set.
> +
>  	noaliencache	[MM, NUMA, SLAB] Disables the allocation of alien
>  			caches in the slab allocator.  Saves per-node memory,
>  			but will impact performance.
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 817c02b13b1d..62b19162d198 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -57,7 +57,8 @@ config PROC_VMCORE_DEVICE_DUMP
>  	  snapshot.
>  
>  	  If you say Y here, the collected device dumps will be added
> -	  as ELF notes to /proc/vmcore.
> +	  as ELF notes to /proc/vmcore. You can still disabled device
> +	  dump by command line option 'novmcoredd'.
>  
>  config PROC_SYSCTL
>  	bool "Sysctl support (/proc/sys)" if EXPERT
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
>  	size_t data_size;
>  	int ret;
>  
> +	if (vmcoredd_disabled) {
> +		pr_err_once("Device dump is disabled\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!data || !strlen(data->dump_name) ||
>  	    !data->vmcoredd_callback || !data->size)
>  		return -EINVAL;
> -- 
> 2.21.0
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
