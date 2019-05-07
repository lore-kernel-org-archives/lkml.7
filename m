Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B08C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A462053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfEGRKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:10:46 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47114 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbfEGRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:10:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TR7KsnZ_1557249036;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TR7KsnZ_1557249036)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 May 2019 01:10:41 +0800
Subject: Re: [v2 PATCH] mm: thp: fix false negative of shmem vma's THP
 eligibility
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, rientjes@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
References: <1556037781-57869-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190423175252.GP25106@dhcp22.suse.cz>
 <5a571d64-bfce-aa04-312a-8e3547e0459a@linux.alibaba.com>
 <859fec1f-4b66-8c2c-98ee-2aee9358a81a@linux.alibaba.com>
 <20190507104709.GP31017@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ec8a65c7-9b0b-9342-4854-46c732c99390@linux.alibaba.com>
Date:   Tue, 7 May 2019 10:10:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190507104709.GP31017@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/19 3:47 AM, Michal Hocko wrote:
> [Hmm, I thought, Hugh was CCed]
>
> On Mon 06-05-19 16:37:42, Yang Shi wrote:
>>
>> On 4/28/19 12:13 PM, Yang Shi wrote:
>>>
>>> On 4/23/19 10:52 AM, Michal Hocko wrote:
>>>> On Wed 24-04-19 00:43:01, Yang Shi wrote:
>>>>> The commit 7635d9cbe832 ("mm, thp, proc: report THP eligibility
>>>>> for each
>>>>> vma") introduced THPeligible bit for processes' smaps. But, when
>>>>> checking
>>>>> the eligibility for shmem vma, __transparent_hugepage_enabled() is
>>>>> called to override the result from shmem_huge_enabled().  It may result
>>>>> in the anonymous vma's THP flag override shmem's.  For example,
>>>>> running a
>>>>> simple test which create THP for shmem, but with anonymous THP
>>>>> disabled,
>>>>> when reading the process's smaps, it may show:
>>>>>
>>>>> 7fc92ec00000-7fc92f000000 rw-s 00000000 00:14 27764 /dev/shm/test
>>>>> Size:               4096 kB
>>>>> ...
>>>>> [snip]
>>>>> ...
>>>>> ShmemPmdMapped:     4096 kB
>>>>> ...
>>>>> [snip]
>>>>> ...
>>>>> THPeligible:    0
>>>>>
>>>>> And, /proc/meminfo does show THP allocated and PMD mapped too:
>>>>>
>>>>> ShmemHugePages:     4096 kB
>>>>> ShmemPmdMapped:     4096 kB
>>>>>
>>>>> This doesn't make too much sense.  The anonymous THP flag should not
>>>>> intervene shmem THP.  Calling shmem_huge_enabled() with checking
>>>>> MMF_DISABLE_THP sounds good enough.  And, we could skip stack and
>>>>> dax vma check since we already checked if the vma is shmem already.
>>>> Kirill, can we get a confirmation that this is really intended behavior
>>>> rather than an omission please? Is this documented? What is a global
>>>> knob to simply disable THP system wise?
>>> Hi Kirill,
>>>
>>> Ping. Any comment?
>> Talked with Kirill at LSFMM, it sounds this is kind of intended behavior
>> according to him. But, we all agree it looks inconsistent.
>>
>> So, we may have two options:
>>      - Just fix the false negative issue as what the patch does
>>      - Change the behavior to make it more consistent
>>
>> I'm not sure whether anyone relies on the behavior explicitly or implicitly
>> or not.
> Well, I would be certainly more happy with a more consistent behavior.
> Talked to Hugh at LSFMM about this and he finds treating shmem objects
> separately from the anonymous memory. And that is already the case
> partially when each mount point might have its own setup. So the primary
> question is whether we need a one global knob to controll all THP
> allocations. One argument to have that is that it might be helpful to
> for an admin to simply disable source of THP at a single place rather
> than crawling over all shmem mount points and remount them. Especially
> in environments where shmem points are mounted in a container by a
> non-root. Why would somebody wanted something like that? One example
> would be to temporarily workaround high order allocations issues which
> we have seen non trivial amount of in the past and we are likely not at
> the end of the tunel.

Shmem has a global control for such use. Setting shmem_enabled to 
"force" or "deny" would enable or disable THP for shmem globally, 
including non-fs objects, i.e. memfd, SYS V shmem, etc.

>
> That being said I would be in favor of treating the global sysfs knob to
> be global for all THP allocations. I will not push back on that if there
> is a general consensus that shmem and fs in general are a different
> class of objects and a single global control is not desirable for
> whatever reasons.

OK, we need more inputs from Kirill, Hugh and other folks.

>
> Kirill, Hugh othe folks?

