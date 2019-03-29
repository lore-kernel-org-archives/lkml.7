Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7400E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfC2LlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfC2LlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:41:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 084993082E05;
        Fri, 29 Mar 2019 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52BF25C23D;
        Fri, 29 Mar 2019 11:41:04 +0000 (UTC)
Subject: Re: [PATCH 1/2 v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
References: <20190329065649.12468-1-lijiang@redhat.com>
 <20190329065649.12468-2-lijiang@redhat.com> <20190329103958.GC21152@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <16545118-2658-43b5-d43c-cb029c85d2b9@redhat.com>
Date:   Fri, 29 Mar 2019 19:41:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190329103958.GC21152@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 29 Mar 2019 11:41:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月29日 18:39, Borislav Petkov 写道:
> On Fri, Mar 29, 2019 at 02:56:48PM +0800, Lianbo Jiang wrote:
>> When doing kexec_file_load(), the first kernel needs to pass the e820
>> reserved ranges to the second kernel, because some devices may use it
>> in kdump kernel, such as PCI devices.
>>
>> But, the kernel can not exactly match the e820 reserved ranges when
>> walking through the iomem resources via the 'IORES_DESC_NONE', because
>> there are several types of e820 that are described as the 'IORES_DESC_NONE'
>> type. Please refer to the e820_type_to_iores_desc().
>>
>> Therefore, add a new I/O resource descriptor 'IORES_DESC_RESERVED' for
>> the iomem resources search interfaces. It is helpful to exactly match
>> the reserved resource ranges when walking through iomem resources.
>>
>> In addition, since the new descriptor 'IORES_DESC_RESERVED' has been
>> created for the reserved areas, the code originally related to the
>> descriptor 'IORES_DESC_NONE' also need to be updated.
>>
>> Suggested-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/e820.c |  2 +-
>>  arch/x86/mm/ioremap.c  | 16 ++++++++++++++--
>>  include/linux/ioport.h |  1 +
>>  3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 2879e234e193..16fcde196243 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1050,10 +1050,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
>>  	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
>>  	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
>>  	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
>> +	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
>>  	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
>>  	case E820_TYPE_RAM:		/* Fall-through: */
>>  	case E820_TYPE_UNUSABLE:	/* Fall-through: */
>> -	case E820_TYPE_RESERVED:	/* Fall-through: */
>>  	default:			return IORES_DESC_NONE;
>>  	}
>>  }
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 0029604af8a4..5671ec24df49 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -81,9 +81,21 @@ static bool __ioremap_check_ram(struct resource *res)
>>  	return false;
>>  }
>>  
>> -static int __ioremap_check_desc_other(struct resource *res)
> 
> I can see this patch doesn't build even without applying and building
> it.
> 
> How about you build-test your stuff before submitting?
> 
Oh, my God. I made a mistake when i copied the code from another machine.
I will correct this issue and resend the patch v10.

Thanks.
Lianbo
