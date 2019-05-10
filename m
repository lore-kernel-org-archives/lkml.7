Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9636AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67278205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEJLRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:17:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46150 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfEJLRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:17:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so2864365pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qU0tD7CT9Jm6uTpFuovdKUn0C14kT62XFFwJuIH/foI=;
        b=kY0Owjt4IP0FW7PkfXhYGVua1AhZsADMH1vHshvJwhsNT5kot5+3bi+ix6qeSTYzly
         /ykDUXIyuzO3hzsdkD9SRZrOrQurBCbAaDZgYcVjtT3DT+R0sx8r6y8L1pY4RwHHYcCj
         yqrKpVb25HfNO98SDMimSOTsbPXwySpz6uzpPs6hb2m6r/atFWZDxEDCn12YfuzhzInB
         BmusOOWGeFJVuDE+lQxUss427jDASGui1sshSIFhCyMp9XiMqbDRpE5eRy5R4lHe52HE
         nOFVWII09MWYmqLgZrTA30qm6SEv2Al6p3EMLoe2exRhIf8ORR7Lz1jYJcPsE0Slvekz
         kxew==
X-Gm-Message-State: APjAAAVyVe3oPYs1T0OV15uuk2PsllKS/x4oKiSUqui+eYl+3mCuhvnW
        SlC5oSyl68qsrUkmoWLKvTP7CX958lM=
X-Google-Smtp-Source: APXvYqyLlkU59Hz/VAMMpcr4TvIoLz9Fngzmojb8lnLlu0nkRmpen8xsdXs6sBFaFfviP8dTsioz0Q==
X-Received: by 2002:aa7:800e:: with SMTP id j14mr12906339pfi.157.1557487040094;
        Fri, 10 May 2019 04:17:20 -0700 (PDT)
Received: from localhost.localdomain ([110.227.183.79])
        by smtp.gmail.com with ESMTPSA id g2sm8819491pfd.134.2019.05.10.04.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 04:17:18 -0700 (PDT)
Subject: Re: [RFC PATCH] vmcore: Add a kernel cmdline device_dump_limit
To:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>
References: <20190510102051.25647-1-kasong@redhat.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <4f453ec6-67a6-2c8f-2aab-acb54ae55645@redhat.com>
Date:   Fri, 10 May 2019 16:47:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190510102051.25647-1-kasong@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

Thanks for the patch. Please see my comments in-line:

On 05/10/2019 03:50 PM, Kairui Song wrote:
> Device dump allow drivers to add device related dump data to vmcore as
> they want. This have a potential issue, the data is stored in memory,
> drivers may append too much data and use too much memory. The vmcore is
> typically used in a kdump kernel which runs in a pre-reserved small
> chunk of memory. So as a result it will make kdump unusable at all due
> to OOM issues.
> 
> So introduce new device_dump_limit= kernel parameter, and set the
> default limit to 0, so device dump is not enabled unless user specify
> the accetable maxiam 

       ^^^^ acceptable maximum

> memory usage for device dump data. In this way user
> will also have the chance to adjust the kdump reserved memory
> accordingly.

Hmmm., this doesn't give much confidence with the 
PROC_VMCORE_DEVICE_DUMP feature in its current shape. Rather shouldn't 
we be enabling config PROC_VMCORE_DEVICE_DUMP only under EXPERT mode for 
now, considering that this feature needs further thrashing and testing 
with real setups including platforms where drivers append large amounts 
of data to vmcore:

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 817c02b13b1d..c47a12cf7fc0 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -45,7 +45,7 @@ config PROC_VMCORE
          Exports the dump image of crashed kernel in ELF format.

  config PROC_VMCORE_DEVICE_DUMP
-       bool "Device Hardware/Firmware Log Collection"
+       bool "Device Hardware/Firmware Log Collection" if EXPERT
         depends on PROC_VMCORE
         default n
         help
@@ -59,6 +59,12 @@ config PROC_VMCORE_DEVICE_DUMP
           If you say Y here, the collected device dumps will be added
           as ELF notes to /proc/vmcore.

+         Considering that there can be device drivers which append
+         large amounts of data to vmcore, you should say N here unless
+         you are reserving a large chunk of memory for crashdump
+         kernel, because otherwise the crashdump kernel might become
+         unusable due to OOM issues.
+

May be you can add a 'Fixes:' tag here.

> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>   fs/proc/vmcore.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 3fe90443c1bb..e28695ef2439 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -53,6 +53,9 @@ static struct proc_dir_entry *proc_vmcore;
>   /* Device Dump list and mutex to synchronize access to list */
>   static LIST_HEAD(vmcoredd_list);
>   static DEFINE_MUTEX(vmcoredd_mutex);
> +
> +/* Device Dump Limit */
> +static size_t vmcoredd_limit;
>   #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>   
>   /* Device Dump Size */
> @@ -1465,6 +1468,11 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>   	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
>   			    PAGE_SIZE);
>   
> +	if (vmcoredd_orig_sz + data_size >= vmcoredd_limit) {
> +		ret = -ENOMEM;

Should we be adding a WARN() here to let the user know that the device 
dump data will not be available in vmcore?

> +		goto out_err;
> +	}
> +
>   	/* Allocate buffer for driver's to write their dumps */
>   	buf = vmcore_alloc_buf(data_size);
>   	if (!buf) {
> @@ -1502,6 +1510,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>   	return ret;
>   }
>   EXPORT_SYMBOL(vmcore_add_device_dump);
> +
> +static int __init parse_vmcoredd_limit(char *arg)
> +{
> +	char *end;
> +
> +	if (!arg)
> +		return -EINVAL;
> +	vmcoredd_limit = memparse(arg, &end);
> +	return end > arg ? 0 : -EINVAL;
> +
> +}
> +__setup("device_dump_limit=", parse_vmcoredd_limit);

We should be adding this boot argument and its description to 
'Documentation/admin-guide/kernel-parameters.txt'

>   #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
>   
>   /* Free all dumps in vmcore device dump list */
> 

Thanks,
Bhupesh
