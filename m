Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5EC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE562073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5Jbii9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfLLTzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:55:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36713 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfLLTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:55:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so1404804pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TLCOxEuE47kolkwbHmkJmj7IG2EMMJZxExvD4wbLras=;
        b=N5Jbii9lOcX8HpdB4OvQNSGLnmOeT6+/+rlmV3f2zodsX95/IUChnGHQM5ZR9+7otx
         xCv/jmEbc6D93pFCnCpXU2SDw93JebTnMOgIuJ8ohn6QjYcL69Xjt3FqJzI3CVS4nRQH
         dADcWC3VtCEZek6JWFoIvthRNIVETi0gLpefyHByeARkuqPnRxYLMzsYiTzOzVg31tfq
         96TlL/xxXNaX2fQL+xu6IO8Y8p/8MMwUJ/7l+NfyTuhTMzsDds+ZEGokpkgCOXhaXCFH
         DVWOptf/VRWwif3t/hocRA2xwwTLgxuIoHH49eObl34a++JppwPR8IgcvfeN0I67KWsr
         t1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TLCOxEuE47kolkwbHmkJmj7IG2EMMJZxExvD4wbLras=;
        b=XVlTIqQCju6kfGYyDiGIUcsN369eDzc9K7JFYPCcN5KjxwS1Hrv0SFLMp2n5KRAI68
         K+kqVW1nzFTbNBRnUlWfjYI75eyAHxi3ueAyavnbZTsmRtpGCeYrNX7SnQYDONXCTMIU
         fLtDuF6vK5Aq9IiQvbWjEONWihKcWFAd++jsnQizAe6hHkdf1M7dtuUpVMCobz4ur31J
         Ej9heQNBb6IwGpzixprHfa5FVH3nU2PZhYph7K1E6Su08696bk5i7zBy/IhahDNOr6Hz
         Nn/oanc45xZMUHr3q618rFJbkHU+KXLXQIee30bWCG062FaDuoX3/fy5MBmSN4rA2RlR
         P0OQ==
X-Gm-Message-State: APjAAAXiAGNsbaMLdf+nPMqq5ioiX1xcbds1JTOUxx0vFX11i0Mgwzb+
        tWBs02eDAb7YyLfDK6aGIImA6w==
X-Google-Smtp-Source: APXvYqzP+jxLfixRO0D1nTZH+cRkJXpZ998x7ZGYoS+/0WJqNhlcS/ivhuQFxS8xf2CuDrwiSQmJSw==
X-Received: by 2002:a65:640e:: with SMTP id a14mr11505680pgv.402.1576180507093;
        Thu, 12 Dec 2019 11:55:07 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id g10sm7549833pgh.35.2019.12.12.11.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:55:06 -0800 (PST)
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
Date:   Thu, 12 Dec 2019 14:55:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 12/12/19 1:49 PM, Liran Alon wrote:
> 
> 
>> On 12 Dec 2019, at 20:47, Liran Alon <liran.alon@oracle.com> wrote:
>>
>>
>>
>>> On 12 Dec 2019, at 20:22, Barret Rhoden <brho@google.com> wrote:
>>>
>>> This change allows KVM to map DAX-backed files made of huge pages with
>>> huge mappings in the EPT/TDP.
>>
>> This change isn’t only relevant for TDP. It also affects when KVM use shadow-paging.
>> See how FNAME(page_fault)() calls transparent_hugepage_adjust().

Cool, I'll drop references to the EPT/TDP from the commit message.

>>> DAX pages are not PageTransCompound.  The existing check is trying to
>>> determine if the mapping for the pfn is a huge mapping or not.
>>
>> I would rephrase “The existing check is trying to determine if the pfn
>> is mapped as part of a transparent huge-page”.

Can do.

>>
>>> For
>>> non-DAX maps, e.g. hugetlbfs, that means checking PageTransCompound.
>>
>> This is not related to hugetlbfs but rather THP.

I thought that PageTransCompound also returned true for hugetlbfs (based 
off of comments in page-flags.h).  Though I do see the comment about the 
'level == PT_PAGE_TABLE_LEVEL' check excluding hugetlbfs pages.

Anyway, I'll remove the "e.g. hugetlbfs" from the commit message.

>>
>>> For DAX, we can check the page table itself.
>>>
>>> Note that KVM already faulted in the page (or huge page) in the host's
>>> page table, and we hold the KVM mmu spinlock.  We grabbed that lock in
>>> kvm_mmu_notifier_invalidate_range_end, before checking the mmu seq.
>>>
>>> Signed-off-by: Barret Rhoden <brho@google.com>
>>
>> I don’t think the right place to change for this functionality is transparent_hugepage_adjust()
>> which is meant to handle PFNs that are mapped as part of a transparent huge-page.
>>
>> For example, this would prevent mapping DAX-backed file page as 1GB.
>> As transparent_hugepage_adjust() only handles the case (level == PT_PAGE_TABLE_LEVEL).
>>
>> As you are parsing the page-tables to discover the page-size the PFN is mapped in,
>> I think you should instead modify kvm_host_page_size() to parse page-tables instead
>> of rely on vma_kernel_pagesize() (Which relies on vma->vm_ops->pagesize()) in case
>> of is_zone_device_page().
>> The main complication though of doing this is that at this point you don’t yet have the PFN
>> that is retrieved by try_async_pf(). So maybe you should consider modifying the order of calls
>> in tdp_page_fault() & FNAME(page_fault)().
>>
>> -Liran
> 
> Or alternatively when thinking about it more, maybe just rename transparent_hugepage_adjust()
> to not be specific to THP and better handle the case of parsing page-tables changing mapping-level to 1GB.
> That is probably easier and more elegant.

I can rename it to hugepage_adjust(), since it's not just THP anymore.

I was a little hesitant to change the this to handle 1 GB pages with 
this patchset at first.  I didn't want to break the non-DAX case stuff 
by doing so.

Specifically, can a THP page be 1 GB, and if so, how can you tell?  If 
you can't tell easily, I could walk the page table for all cases, 
instead of just zone_device().

I'd also have to drop the "level == PT_PAGE_TABLE_LEVEL" check, I think, 
which would open this up to hugetlbfs pages (based on the comments).  Is 
there any reason why that would be a bad idea?

Thanks,

Barret

