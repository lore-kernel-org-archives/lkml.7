Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A0C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2E20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfDQKHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:07:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:16363 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfDQKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:07:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 03:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,361,1549958400"; 
   d="scan'208";a="141385871"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2019 03:07:19 -0700
Subject: Re: [PATCH v15 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190416063250.7514-1-aubrey.li@linux.intel.com>
 <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a3c19a36-9b0b-e48b-6d1f-9f4b654df615@linux.intel.com>
Date:   Wed, 17 Apr 2019 18:07:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/17 7:01, Andrew Morton wrote:
> On Tue, 16 Apr 2019 14:32:48 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
> 
>> The architecture specific information of the running processes could
>> be useful to the userland. Add support to examine process architecture
>> specific information externally.
> 
> The implementation looks just fine to me.  Have you had any feedback on
> the overall desirability of adding this feature?
> 
This is orientated by the customer's complain. When the customer colocated
their latency critical tasks with AVX512 tasks, the latency critical tasks
were affected due to core frequency slowing down by AVX512 use. So we propose
this interface for the user space tools to identify AVX512 using task and
apply user space dispatching policy. We may have subsequent effort based on
this proposal.

>> --- a/fs/proc/array.c
>> +++ b/fs/proc/array.c
>> @@ -96,6 +96,11 @@
>>  #include <asm/processor.h>
>>  #include "internal.h"
>>  
>> +/* Add support for architecture specific output in /proc/pid/status */
>> +#ifndef	arch_proc_pid_status
>> +#define	arch_proc_pid_status(m, task)
>> +#endif
> 
> To this I suggest adding
> 
> /* arch_proc_pid_status() must be defined in asm/processor.h */
> 
> Because we've regularly had different architectures defining such things
> in different headers, resulting in a mess.

Thanks, I'll add it in the next version.
-Aubrey
