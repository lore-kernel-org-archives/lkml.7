Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68EDC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E52077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="frJKjwFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfLDNSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:18:45 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:13851 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfLDNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:18:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D8AF9467CA;
        Wed,  4 Dec 2019 14:18:42 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=frJKjwFt;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EIqWR5aWcPAF; Wed,  4 Dec 2019 14:18:41 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id BE2FA44746;
        Wed,  4 Dec 2019 14:18:32 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id EC98F360608;
        Wed,  4 Dec 2019 14:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575465512; bh=IKSdOffMMCGw4BKLa9MTKdFtfJNsTX9WSr6dGqHn/g4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=frJKjwFt6rB457iADirl6My28RdJmsbR31/M+st6rbeAkliu7b/3kmLdCxyW62zCN
         j7Sr1oKys01bpK8z8xzh3s1kXh+HQOVehS8ZiosK9VB4rMZOw/sThilyRG8pTQKl0e
         n4AsVcxAdxWwIqDO8em4ciUk92BUSVYlnLHlafZ8=
Subject: Re: [PATCH 7/8] drm/ttm: Introduce a huge page aligning TTM range
 manager.
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
 <20191203132239.5910-8-thomas_os@shipmail.org>
 <39b9d651-6afd-1926-7302-aa2a8d4ca626@amd.com>
 <7223bee1-cb3f-3d88-a70b-f4e1a5088b76@shipmail.org>
 <f87a03da-ea9d-fe2b-8069-8fe0bda57c12@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <6ae46281-195c-2803-fc3d-16e7bc830639@shipmail.org>
Date:   Wed, 4 Dec 2019 14:18:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f87a03da-ea9d-fe2b-8069-8fe0bda57c12@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 1:16 PM, Christian König wrote:
> Am 04.12.19 um 12:45 schrieb Thomas Hellström (VMware):
>> On 12/4/19 12:13 PM, Christian König wrote:
>>> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>>
>>>> Using huge page-table entries require that the start of a buffer 
>>>> object
>>>> is huge page size aligned. So introduce a ttm_bo_man_get_node_huge()
>>>> function that attempts to accomplish this for allocations that are 
>>>> larger
>>>> than the huge page size, and provide a new range-manager instance that
>>>> uses that function.
>>>
>>> I still don't think that this is a good idea.
>>
>> Again, can you elaborate with some specific concerns?
>
> You seems to be seeing PUD as something optional.
>
>>>
>>> The driver/userspace should just use a proper alignment if it wants 
>>> to use huge pages.
>>
>> There are drawbacks with this approach. The TTM alignment is a hard 
>> constraint. Assume that you want to fit a 1GB buffer object into 
>> limited VRAM space, and _if possible_ use PUD size huge pages. Let's 
>> say there is 1GB available, but not 1GB aligned. The proper alignment 
>> approach would fail and possibly start to evict stuff from VRAM just 
>> to be able to accomodate the PUD alignment. That's bad. The approach 
>> I suggest would instead fall back to PMD alignment and use 2MB page 
>> table entries if possible, and as a last resort use 4K page table 
>> entries.
>
> And exactly that sounds like a bad idea to me.
>
> Using 1GB alignment is indeed unrealistic in most cases, but for 2MB 
> alignment we should really start to evict BOs.
>
> Otherwise the address space can become fragmented and we won't be able 
> de-fragment it in any way.

Ah, I see, Yeah that's the THP tradeoff between fragmentation and 
memory-usage. From my point of view, it's not self-evident that either 
approach is the best one, but the nice thing with the suggested code is 
that you can view it as an optional helper. For example, to avoid 
fragmentation and have a high huge-page hit ratio for 2MB pages, You'd 
either inflate the buffer object size to be 2MB aligned, which would 
affect also system memory, or you'd set the TTM memory alignment to 2MB. 
If in addition you'd like "soft" (non-evicting) alignment also for 1GB 
pages, you'd also hook up the new range manager. I figure different 
drivers would want to use different strategies.

In any case, vmwgfx would, due to its very limited VRAM size, want to 
use the "soft" alignment provided by this patch, but if you don't see 
any other drivers wanting that, I could definitely move it to vmwgfx.

/Thomas



