Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEBF2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCEMSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:18:07 -0500
Received: from foss.arm.com ([217.140.101.70]:47694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfCEMSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:18:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C155A78;
        Tue,  5 Mar 2019 04:18:06 -0800 (PST)
Received: from [10.163.1.8] (unknown [10.163.1.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C73A3F706;
        Tue,  5 Mar 2019 04:18:01 -0800 (PST)
Subject: Re: [PATCH] mm/hmm: fix unused variable warnings
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190304200026.1140281-1-arnd@arndb.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <be817f74-3441-47c1-6958-233d6e1172c4@arm.com>
Date:   Tue, 5 Mar 2019 17:48:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190304200026.1140281-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/2019 01:30 AM, Arnd Bergmann wrote:
> When CONFIG_HUGETLB_PAGE is disabled, the only use of the variable 'h'
> is compiled out, and the compiler thinks it is unnecessary:
> 
> mm/hmm.c: In function 'hmm_range_snapshot':
> mm/hmm.c:1015:19: error: unused variable 'h' [-Werror=unused-variable]
>     struct hstate *h = hstate_vma(vma);

After doing some Kconfig hacks like (ARCH_WANT_GENERAL_HUGETLB = n) on an
X86 system I got (HUGETLB_PAGE = n and HMM = y) config. But was unable to
hit the build error. Helper is_vm_hugetlb_page() seems to always return
false when HUGETLB_PAGE = n. Would not the compiler remove the entire code
block including the declaration for 'h' ?

#ifdef CONFIG_HUGETLB_PAGE
#include <linux/mm.h>
static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
{
        return !!(vma->vm_flags & VM_HUGETLB);
}
#else
static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
{
        return false;
}
#endif
