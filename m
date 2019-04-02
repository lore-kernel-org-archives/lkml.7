Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE62420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfDBMCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfDBMCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:02:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6904120276;
        Tue,  2 Apr 2019 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1D3F848D9;
        Tue,  2 Apr 2019 12:02:08 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v10] x86/mm, resource: add a new I/O resource
 descriptor 'IORES_DESC_RESERVED'
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
References: <20190329123914.20939-1-lijiang@redhat.com>
 <20190329123914.20939-2-lijiang@redhat.com> <20190402090652.GD6826@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <c94f887e-2ac8-49c6-e02c-92453e1ad894@redhat.com>
Date:   Tue, 2 Apr 2019 20:02:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190402090652.GD6826@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 02 Apr 2019 12:02:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年04月02日 17:06, Borislav Petkov 写道:
> On Fri, Mar 29, 2019 at 08:39:13PM +0800, Lianbo Jiang wrote:
>> -static int __ioremap_check_desc_other(struct resource *res)
>> +/*
>> + * Originally, these areas described as IORES_DESC_NONE are not mapped
>> + * as encrypted when using ioremap(), for example, E820_TYPE_{RESERVED,
>> + * RESERVED_KERN,RAM,UNUSABLE}, etc. It checks for a resource that is
>> + * not described as IORES_DESC_NONE, which can make sure the reserved
>> + * areas are not mapped as encrypted when using ioremap().
>> + *
>> + * Now IORES_DESC_RESERVED has been created for the reserved areas so
>> + * the check needs to be expanded so that these areas are not mapped
>> + * encrypted when using ioremap().
>> + */
>> +static int __ioremap_check_desc_none_and_reserved(struct resource *res)
>>  {
>> -	return (res->desc != IORES_DESC_NONE);
>> +	return ((res->desc != IORES_DESC_NONE) &&
> 
> Why is this still checking IORES_DESC_NONE when the idea is to have this
> specific IORES_DESC_RESERVED for all marked as *reserved* regions in
> e820 which should not be mapped encrypted?
> 
> IOW, which regions are still marked as IORES_DESC_NONE and should not be
> mapped encrypted?
> 
Thanks for your comment.

These regions(E820_TYPE_{RESERVED_KERN,RAM,UNUSABLE}) are still marked as
IORES_DESC_NONE and should not be mapped encrypted when using ioremap().
Please refer to the following function.

static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
{
        switch (entry->type) {
        case E820_TYPE_ACPI:            return IORES_DESC_ACPI_TABLES;
        case E820_TYPE_NVS:             return IORES_DESC_ACPI_NV_STORAGE;
        case E820_TYPE_PMEM:            return IORES_DESC_PERSISTENT_MEMORY;
        case E820_TYPE_PRAM:            return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
	case E820_TYPE_RESERVED:        return IORES_DESC_RESERVED;
        case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
        case E820_TYPE_RAM:             /* Fall-through: */
        case E820_TYPE_UNUSABLE:        /* Fall-through: */
        default:                        return IORES_DESC_NONE;
        }
}


Thanks.
Lianbo
