Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9900FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F55214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfF1DqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:46:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfF1DqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:46:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEEA72B;
        Thu, 27 Jun 2019 20:46:10 -0700 (PDT)
Received: from [10.162.40.144] (p8cg001049571a15.blr.arm.com [10.162.40.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965093F706;
        Thu, 27 Jun 2019 20:46:08 -0700 (PDT)
Subject: Re: [RFC 1/2] arm64/mm: Change THP helpers to comply with generic MM
 semantics
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1561639696-16361-1-git-send-email-anshuman.khandual@arm.com>
 <1561639696-16361-2-git-send-email-anshuman.khandual@arm.com>
 <7F685152-7C6C-4E99-99DF-03DDD03D6094@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5c490be8-5ac1-0a3a-32cf-d4e692fc59b5@arm.com>
Date:   Fri, 28 Jun 2019 09:16:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7F685152-7C6C-4E99-99DF-03DDD03D6094@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2019 09:01 PM, Zi Yan wrote:
> On 27 Jun 2019, at 8:48, Anshuman Khandual wrote:
> 
>> pmd_present() and pmd_trans_huge() are expected to behave in the following
>> manner during various phases of a given PMD. It is derived from a previous
>> detailed discussion on this topic [1] and present THP documentation [2].
>>
>> pmd_present(pmd):
>>
>> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
>> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
>>
>> pmd_trans_huge(pmd):
>>
>> - Returns true if pmd refers to system RAM and is a trans huge mapping
>>
>> -------------------------------------------------------------------------
>> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
>> -------------------------------------------------------------------------
>> |	Mapped		|	Yes		|	Yes		|
>> -------------------------------------------------------------------------
>> |	Splitting	|	Yes		|	Yes		|
>> -------------------------------------------------------------------------
>> |	Migration/Swap	|	No		|	No		|
>> -------------------------------------------------------------------------
>>
>> The problem:
>>
>> PMD is first invalidated with pmdp_invalidate() before it's splitting. This
>> invalidation clears PMD_SECT_VALID as below.
>>
>> PMD Split -> pmdp_invalidate() -> pmd_mknotpresent -> Clears PMD_SECT_VALID
>>
>> Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
>> on the PMD entry. It will need another bit apart from PMD_SECT_VALID to re-
>> affirm pmd_present() as true during the THP split process. To comply with
>> above mentioned semantics, pmd_trans_huge() should also check pmd_present()
>> first before testing presence of an actual transparent huge mapping.
>>
>> The solution:
>>
>> Ideally PMD_TYPE_SECT should have been used here instead. But it shares the
>> bit position with PMD_SECT_VALID which is used for THP invalidation. Hence
>> it will not be there for pmd_present() check after pmdp_invalidate().
>>
>> PTE_SPECIAL never gets used for PMD mapping i.e there is no pmd_special().
>> Hence this bit can be set on the PMD entry during invalidation which can
>> help in making pmd_present() return true and in recognizing the fact that
>> it still points to memory.
>>
>> This bit is transient. During the split is process it will be overridden
>> by a page table page representing the normal pages in place of erstwhile
>> huge page. Other pmdp_invalidate() callers always write a fresh PMD value
>> on the entry overriding this transient PTE_SPECIAL making it safe. In the
>> past former pmd_[mk]splitting() functions used PTE_SPECIAL.
>>
>> [1]: https://lkml.org/lkml/2018/10/17/231
> 
> Just want to point out that lkml.org link might not be stable.
> This one would be better: https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/

Sure will update the link in the commit. Thanks !
