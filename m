Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EC2C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3348620825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GZ/H3rR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEGSMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:12:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2316 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:12:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd1ca870000>; Tue, 07 May 2019 11:12:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 11:12:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 May 2019 11:12:15 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 18:12:15 +0000
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call
 hmm_range_unregister()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-5-rcampbell@nvidia.com>
 <CAFqt6zbhLQuw2N5-=Nma-vHz1BkWjviOttRsPXmde8U1Oocz0Q@mail.gmail.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <fa2078fd-3ec7-5503-94d7-c4d1a766029a@nvidia.com>
Date:   Tue, 7 May 2019 11:12:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbhLQuw2N5-=Nma-vHz1BkWjviOttRsPXmde8U1Oocz0Q@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557252743; bh=4sryYpBiNg4XxjM8zLEdkqZ8Dj/ZnD7DO4AYpsXPphY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GZ/H3rR/FDVS4uZ/9gaPXJwIfOeK9Rc/JUQV331+m673Nrcdfxw9Ri+Pv003fgeT/
         NnX9BCVqu86s9oVw8qBofRpZhewvm9GsINKZzZ8Cax3R0DFaui9YYJIfXGvh9DeUci
         aYDoX3nzO4jYeNxx2EtZYEy5wxuosyjMLorsS+vFOaoEMUlVuxiIqMh/LkqpmP4RVp
         aJ4gBG2V/AJzS5U0XxSkYNWAdQ/8h/idPLKj82lrCOynwUrcJgJZdsQON5OprxwU/M
         KwId2544mF3Ku5qM9XmHl6pAWwLBcdvVAIZDY0DS2dkJPFxHFiJlFguYJeH4Rlx//6
         Q8i2Qus/oydqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/19 6:15 AM, Souptick Joarder wrote:
> On Tue, May 7, 2019 at 5:00 AM <rcampbell@nvidia.com> wrote:
>>
>> From: Ralph Campbell <rcampbell@nvidia.com>
>>
>> The helper function hmm_vma_fault() calls hmm_range_register() but is
>> missing a call to hmm_range_unregister() in one of the error paths.
>> This leads to a reference count leak and ultimately a memory leak on
>> struct hmm.
>>
>> Always call hmm_range_unregister() if hmm_range_register() succeeded.
> 
> How about * Call hmm_range_unregister() in error path if
> hmm_range_register() succeeded* ?

Sure, sounds good.
I'll include that in v2.

>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Souptick Joarder <jrdr.linux@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>   include/linux/hmm.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
>> index 35a429621e1e..fa0671d67269 100644
>> --- a/include/linux/hmm.h
>> +++ b/include/linux/hmm.h
>> @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>>                  return (int)ret;
>>
>>          if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
>> +               hmm_range_unregister(range);
>>                  /*
>>                   * The mmap_sem was taken by driver we release it here and
>>                   * returns -EAGAIN which correspond to mmap_sem have been
>> @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>>
>>          ret = hmm_range_fault(range, block);
>>          if (ret <= 0) {
>> +               hmm_range_unregister(range);
> 
> what is the reason to moved it up ?

I moved it up because the normal calling pattern is:
     down_read(&mm->mmap_sem)
     hmm_vma_fault()
         hmm_range_register()
         hmm_range_fault()
         hmm_range_unregister()
     up_read(&mm->mmap_sem)

I don't think it is a bug to unlock mmap_sem and then unregister,
it is just more consistent nesting.

>>                  if (ret == -EBUSY || !ret) {
>>                          /* Same as above, drop mmap_sem to match old API. */
>>                          up_read(&range->vma->vm_mm->mmap_sem);
>>                          ret = -EBUSY;
>>                  } else if (ret == -EAGAIN)
>>                          ret = -EBUSY;
>> -               hmm_range_unregister(range);
>>                  return ret;
>>          }
>>          return 0;
>> --
>> 2.20.1
>>
