Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DAA2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfCYGxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbfCYGxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E8243082204;
        Mon, 25 Mar 2019 06:53:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 556A860BF7;
        Mon, 25 Mar 2019 06:53:07 +0000 (UTC)
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com> <20190322192800.GM12472@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
Date:   Mon, 25 Mar 2019 14:53:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190322192800.GM12472@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 25 Mar 2019 06:53:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年03月23日 03:28, Borislav Petkov 写道:
> On Thu, Mar 21, 2019 at 06:33:08PM +0800, Lianbo Jiang wrote:
>> When doing kexec_file_load, the first kernel needs to pass the e820
> 
> Please end function names with parentheses.
> 
>> reserved ranges to the second kernel.
> 
> ... because... ?
> 
>> But kernel can not exactly match the e820 reserved ranges
>      ^
>      the
> 
>> when walking through the iomem resources with the descriptor
>> 'IORES_DESC_NONE', because several e820 types( e.g.
>> E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
>> _TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'.
>> It may pass these four types to the kdump kernel, that is not desired result.
> 
> Rewrite that sentence.
> 
>> So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
>> for the iomem resources search interfaces. It is helpful to exactly
>> match the reserved resource ranges when walking through iomem resources.
>>
>> In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
>> these code originally related to the descriptor 'IORES_DESC_NONE' need to
> 
> "the code"
> 
>> be updated.
> 
>> Otherwise, it will be easily confused and also cause some errors.
> 
> What errors?
> 
>> Because the 'E820_TYPE_RESERVED' type is converted to the new
>> descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
>> changed.
> 
> That sentence I cannot parse.

Thanks for your comment. I will improve the patch log next post.

> 
>> Suggested-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  arch/x86/kernel/e820.c | 2 +-
>>  include/linux/ioport.h | 1 +
>>  kernel/resource.c      | 6 +++---
>>  3 files changed, 5 insertions(+), 4 deletions(-)
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
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index da0ebaec25f0..6ed59de48bd5 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -133,6 +133,7 @@ enum {
>>  	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
>>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>>  	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
>> +	IORES_DESC_RESERVED			= 8,
>>  };
>>  
>>  /* helpers to define resources */
> 
> IORES_DESC_RESERVED is supposed to represent E820_TYPE_RESERVED. And if> that is the case, then all three hunks below look wrong to me. If you
> want to pass E820_TYPE_RESERVED ranges, then do that explicitly.

In this function, i printed its values, and only got the value of reserved
type, so i changed the IORES_DESC_NONE to the IORES_DESC_RESERVED.

In addition, after the new descriptor 'IORES_DESC_RESERVED' is introduced,
the IORES_DESC_NONE does not include the IORES_DESC_RESERVED any more, it
could miss to handle the value of the reserved type.

Do you mean i should never touch the three chunks? If i made a mistake, i
will remove this changes next post.

Thanks.
Lianbo

> 
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index e81b17b53fa5..ee7348761858 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -990,7 +990,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
>>  	res->start = start;
>>  	res->end = end;
>>  	res->flags = type | IORESOURCE_BUSY;
>> -	res->desc = IORES_DESC_NONE;
>> +	res->desc = IORES_DESC_RESERVED;
>>  
>>  	while (1) {
>>  
>> @@ -1025,7 +1025,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
>>  				next_res->start = conflict->end + 1;
>>  				next_res->end = end;
>>  				next_res->flags = type | IORESOURCE_BUSY;
>> -				next_res->desc = IORES_DESC_NONE;
>> +				next_res->desc = IORES_DESC_RESERVED;
>>  			}
>>  		} else {
>>  			res->start = conflict->end + 1;
>> @@ -1488,7 +1488,7 @@ static int __init reserve_setup(char *str)
>>  			res->start = io_start;
>>  			res->end = io_start + io_num - 1;
>>  			res->flags |= IORESOURCE_BUSY;
>> -			res->desc = IORES_DESC_NONE;
>> +			res->desc = IORES_DESC_RESERVED;
>>  			res->child = NULL;
>>  			if (request_resource(parent, res) == 0)
>>  				reserved = x+1;
>> -- 
>> 2.17.1
>>
> 
