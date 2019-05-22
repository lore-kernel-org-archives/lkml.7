Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD764C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD65F2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfEVSos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:44:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfEVSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:44:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id r18so1477643pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r9tffKpSR5//URn23d6p6EwP5wm+2fCjodocbQEgccA=;
        b=pgktC7ufNXsZeXQspOl0RqFobN7vQ9YD8hhksJDnwHTb6yU6sZX5BbJAvb0GVWwB11
         BbzCMzxXIAXm+jlG4ApHlfIB71Hj6s3dkDVZszCG1gy7zRghomj6R6h+s81Q1qIe67LD
         hY+djMkNG7v0ZzjpF5ZXdWEThGkTGEG7hjYDrWo/lB53K2udm6+JITEOHdAXulqjcw1J
         id7kCD9oM/iEkU4A+jBjy4kRVDFAYpCfu32fxsew6YhNJ30fy/MW15/y+0vAxC+aDCwm
         ajFz+vWXJnNbOdsyUgKzEdpTblQyW7bT/Lf7NOz6/SDp8Tc2UNunFidlW6U6PiI0GsY+
         46+g==
X-Gm-Message-State: APjAAAU7lRIIIAtlJYm9nZY44iprhKhd/80ZzkWBIdgfPbZuHw35BzKD
        jTUqvN6i50a4Vr/BvH7CAavZNg==
X-Google-Smtp-Source: APXvYqz6Rgt4Rk3Sy2SLlwM2P9mp8rH8Sma820ndwxMk3MfkPcbR3wNuoWV53gO1JWjuPN2xxb0rcw==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr89267682pla.239.1558550687269;
        Wed, 22 May 2019 11:44:47 -0700 (PDT)
Received: from localhost.localdomain ([110.227.182.225])
        by smtp.gmail.com with ESMTPSA id l65sm42599576pfb.7.2019.05.22.11.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:44:46 -0700 (PDT)
Subject: Re: [PATCH v2] vmcore: Add a kernel cmdline vmcore_device_dump
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
References: <20190520061834.32231-1-kasong@redhat.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <0c0fb7af-f386-bde1-46f6-1afa29782243@redhat.com>
Date:   Thu, 23 May 2019 00:14:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190520061834.32231-1-kasong@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2019 11:48 AM, Kairui Song wrote:
> Since commit 2724273e8fd0 ('vmcore: add API to collect hardware dump in
> second kernel'), drivers is allowed to add device related dump data to
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
> ---
>   Update from V1:
>    - Use bool parameter to turn it on/off instead of letting user give
>      the size limit. Size of device dump is hard to determine.
> 
>   Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
>   fs/proc/vmcore.c                                | 13 +++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 43176340c73d..2d48e39fd080 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5062,6 +5062,21 @@
>   			decrease the size and leave more room for directly
>   			mapped kernel RAM.
>   
> +	vmcore_device_dump=
> +			[VMCORE]
> +			Format: {"off" | "on"}
> +			If CONFIG_PROC_VMCORE_DEVICE_DUMP is set,
> +			this parameter allows enable or disable device dump
> +			for vmcore.

We can add a simpler description here, something like:
			Depends on CONFIG_PROC_VMCORE_DEVICE_DUMP

> +			Device dump allows drivers to append dump data to
> +			vmcore so you can collect driver specified debug info.
> +			Note that the drivers could append the data without
> +			any limit, and the data is stored in memory, this may
> +			bring a significant memory stress. If you want to turn
> +			on this option, make sure you have reserved enough memory
> +			with crashkernel= parameter.
> +			default: off

... and massage the rest of text accordingly.

Better to also modify the help text for 'PROC_VMCORE_DEVICE_DUMP' config 
option defined in 'fs/proc/Kconfig'. Something like:

config PROC_VMCORE_DEVICE_DUMP
	bool "Device Hardware/Firmware Log Collection"
<..snip..>	
	  If you say Y here, the collected device dumps will be added
	  as ELF notes to /proc/vmcore.

	  If this option is selected, device dump collection can still be 
disabled by passing vmcore_device_dump=off to the kernel.

See config INTEL_IOMMU_DEFAULT_ON in 'drivers/iommu/Kconfig' as an example.

>   	vmcp_cma=nn[MG]	[KNL,S390]
>   			Sets the memory size reserved for contiguous memory
>   			allocations for the vmcp device driver.
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3fe90443c1bb..d1b608b0efad 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,6 +53,8 @@ static struct proc_dir_entry *proc_vmcore;
>   /* Device Dump list and mutex to synchronize access to list */
>   static LIST_HEAD(vmcoredd_list);
>   static DEFINE_MUTEX(vmcoredd_mutex);
> +
> +static bool vmcoredd_enabled;
>   #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>   
>   /* Device Dump Size */
> @@ -1451,6 +1453,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>   	size_t data_size;
>   	int ret;
>   
> +	if (!vmcoredd_enabled) {
> +		pr_err_once("Device dump is disabled\n");
> +		return -EINVAL;
> +	}
> +
>   	if (!data || !strlen(data->dump_name) ||
>   	    !data->vmcoredd_callback || !data->size)
>   		return -EINVAL;
> @@ -1502,6 +1509,12 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>   	return ret;
>   }
>   EXPORT_SYMBOL(vmcore_add_device_dump);
> +
> +static int __init vmcoredd_parse_cmdline(char *arg)
> +{
> +	return kstrtobool(arg, &vmcoredd_enabled);
> +}
> +__setup("vmcore_device_dump=", vmcoredd_parse_cmdline);
>   #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>   
>   /* Free all dumps in vmcore device dump list */
> 

Thanks,
Bhupesh
