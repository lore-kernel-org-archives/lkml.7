Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E326FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17B62133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391386AbfEXMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:55:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390974AbfEXMzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 461A681127;
        Fri, 24 May 2019 12:55:07 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6334D6A96A;
        Fri, 24 May 2019 12:55:00 +0000 (UTC)
Date:   Fri, 24 May 2019 20:54:56 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH v3] vmcore: Add a kernel parameter vmcore_device_dump
Message-ID: <20190524125456.GA3342@dhcp-128-65.nay.redhat.com>
References: <20190524062922.26399-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524062922.26399-1-kasong@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 24 May 2019 12:55:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/19 at 02:29pm, Kairui Song wrote:
> Since commit 2724273e8fd0 ("vmcore: add API to collect hardware dump in
> second kernel"), drivers is allowed to add device related dump data to
> vmcore as they want by using the device dump API. This have a potential
> issue, the data is stored in memory, drivers may append too much data
> and use too much memory. The vmcore is typically used in a kdump kernel
> which runs in a pre-reserved small chunk of memory. So as a result it
> will make kdump unusable at all due to OOM issues.
> 
> So introduce new vmcore_device_dump= kernel parameter, and disable
> device dump by default. User can enable it only if device dump data is
> required for debugging, and have the chance to increase the kdump
> reserved memory accordingly before device dump fails kdump.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> 
> ---
> 
>  Update from V2:
>   - Improve related docs
> 
>  Update from V1:
>   - Use bool parameter to turn it on/off instead of letting user give
>     the size limit. Size of device dump is hard to determine.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  fs/proc/Kconfig                                 |  6 ++++--
>  fs/proc/vmcore.c                                | 13 +++++++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 138f6664b2e2..3706ad9e1d97 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5078,6 +5078,20 @@
>  			decrease the size and leave more room for directly
>  			mapped kernel RAM.
>  
> +	vmcore_device_dump=	[KNL,KDUMP]
> +			Format: {"off" | "on"}
> +			Depends on CONFIG_PROC_VMCORE_DEVICE_DUMP.
> +			This parameter allows enable or disable device dump
> +			for vmcore on kernel start-up.
> +			Device dump allows drivers to append dump data to
> +			vmcore so you can collect driver specified debug info.
> +			Note that the drivers could append the data without
> +			any limit, and the data is stored in memory, this may
> +			bring a significant memory stress. If you want to turn
> +			on this option, make sure you have reserved enough memory
> +			with crashkernel= parameter.
> +			default: off
> +
>  	vmcp_cma=nn[MG]	[KNL,S390]
>  			Sets the memory size reserved for contiguous memory
>  			allocations for the vmcp device driver.
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 817c02b13b1d..1a7a38976bb0 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -56,8 +56,10 @@ config PROC_VMCORE_DEVICE_DUMP
>  	  recovery kernel's initramfs to collect its underlying device
>  	  snapshot.
>  
> -	  If you say Y here, the collected device dumps will be added
> -	  as ELF notes to /proc/vmcore.
> +	  If you say Y here, a new kernel parameter 'vmcore_device_dump'
> +	  will be available. You can then enable device dump by passing

"a new kernel parameter 'vmcore_device_dump' will be available" is not
necessary, "new" is a not a clear word.  I suggest to remove this
sentence.

s/You can then/You can

Otherwise:

Acked-by: Dave Young <dyoung@redhat.com>


> +	  'vmcore_device_dump=on' to kernel, the collected device dumps
> +	  will be added as ELF notes to /proc/vmcore.
>  
>  config PROC_SYSCTL
>  	bool "Sysctl support (/proc/sys)" if EXPERT
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3fe90443c1bb..d1b608b0efad 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,6 +53,8 @@ static struct proc_dir_entry *proc_vmcore;
>  /* Device Dump list and mutex to synchronize access to list */
>  static LIST_HEAD(vmcoredd_list);
>  static DEFINE_MUTEX(vmcoredd_mutex);
> +
> +static bool vmcoredd_enabled;
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  
>  /* Device Dump Size */
> @@ -1451,6 +1453,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	size_t data_size;
>  	int ret;
>  
> +	if (!vmcoredd_enabled) {
> +		pr_err_once("Device dump is disabled\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!data || !strlen(data->dump_name) ||
>  	    !data->vmcoredd_callback || !data->size)
>  		return -EINVAL;
> @@ -1502,6 +1509,12 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return ret;
>  }
>  EXPORT_SYMBOL(vmcore_add_device_dump);
> +
> +static int __init vmcoredd_parse_cmdline(char *arg)
> +{
> +	return kstrtobool(arg, &vmcoredd_enabled);
> +}
> +__setup("vmcore_device_dump=", vmcoredd_parse_cmdline);
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>  
>  /* Free all dumps in vmcore device dump list */
> -- 
> 2.21.0
> 

Thanks
Dave
