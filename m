Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11401C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EAE2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbfDYBuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:50:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:43976 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387652AbfDYBuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:50:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="138605892"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2019 18:50:47 -0700
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
Date:   Thu, 25 Apr 2019 09:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/25 5:18, Thomas Gleixner wrote:
> On Mon, 22 Apr 2019, Aubrey Li wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5ad92419be19..d5a9c5ddd453 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -208,6 +208,7 @@ config X86
>>  	select USER_STACKTRACE_SUPPORT
>>  	select VIRT_TO_BUS
>>  	select X86_FEATURE_NAMES		if PROC_FS
>> +	select PROC_PID_ARCH_STATUS		if PROC_FS
> 
> Can you please stop mixing arch and proc code? There is no point in
> enabling this on x86 right away.
> 
>> +
>> +config PROC_PID_ARCH_STATUS
>> +	bool "Enable /proc/<pid>/arch_status file"
> 
> Why is this switchable? x86 selects it if PROC_FS is enabled and all other
> architectures are absolutely not interested in this.

Above and this, I was trying to avoid an empty arch_file on other architectures.
In previous proposal the entry only exists on the platform with AVX512.

> 
>> +	default n
>> +	help
>> +	  Provides a way to examine process architecture specific information.
>> +	  See <file:Documentation/filesystems/proc.txt> for more information.
> 
> Which contains zero information about this file when only this patch is
> applied. 
> 
>> @@ -94,6 +94,7 @@
>>  #include <linux/sched/debug.h>
>>  #include <linux/sched/stat.h>
>>  #include <linux/posix-timers.h>
>> +#include <linux/processor.h>
> 
> That include is required because it does NOT contain anything useful for
> this, right?
> 
>> +/*
>> + * Add support for task architecture specific output in /proc/pid/arch_status.
>> + * task_arch_status() must be defined in asm/processor.h
>> + */
>> +#ifdef CONFIG_PROC_PID_ARCH_STATUS
>> +# ifndef task_arch_status
>> +# define task_arch_status(m, task)
>> +# endif
> 
> What exactly is the point of this macro mess? If an architecture selects
> CONFIG_PROC_PID_ARCH_STATUS then it has to provide proc_task_arch_status()
> and the prototype should be in include/linux/proc_fs.h.

I was trying to address Andy's last comments. If we have the prototype in 
include/linux/proc_fs.h, we'll have a weak function definition in fs/proc/array.c,
which bloats other architectures.

In that way proc_task_arch_status() should be defined in asm/processor.h,
but proc_task_arch_status() has four parameters, I don't want unnecessary
"struct pid_namespace *ns" and "struct pid *pid" leaked into arch headers,
so I defined task_arch_status(m, task) to avoid that.

> 
>> +static int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
>> +				struct pid *pid, struct task_struct *task)
>> +{
>> +	task_arch_status(m, task);
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PROC_PID_ARCH_STATUS */
> 
> Thanks,
> 
> 	tglx
> 

Thanks,
-Aubrey
