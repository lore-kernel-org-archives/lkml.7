Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB94EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847FE222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 02:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSC4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:56:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:49607 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSC4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:56:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 18:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="416044730"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Dec 2019 18:56:46 -0800
Date:   Thu, 19 Dec 2019 10:56:45 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, cai@lca.pw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mm: remove dead code totalram_pages_set()
Message-ID: <20191219025645.GA5741@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191218005543.24146-1-richardw.yang@linux.intel.com>
 <20795dc0-8f6c-73cd-c98f-636f4ac59154@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20795dc0-8f6c-73cd-c98f-636f4ac59154@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 09:46:58AM +0100, David Hildenbrand wrote:
>On 18.12.19 01:55, Wei Yang wrote:
>> No one uses totalram_pages_set(), just remove it.
>> 
>> Fixes: ca79b0c211af ("mm: convert totalram_pages and totalhigh_pages
>> variables to atomic")
>
>Hi Wei, thanks for the update.
>
>We should really avoid "Fixes" tags here. This is neither a bugfix nor a
>compile fix.
>

Agree, when I pick up this tags, I am a little not sure whether this is
correct.

>@Andrew, can you fix that up to:
>"Last user was removed in commit ca79b0c211af ("mm: convert
>totalram_pages and totalhigh_pages variables to atomic")."
>

Hmm... this one is not that exact. This function is introduced in commit
ca79b0c211af and no one use it on its birth.

Maybe we need to change it to:

    totalram_pages_set() is introduced in commit ca79b0c211af ("mm: convert
    totalram_pages and totalhigh_pages variables to atomic"), but no one
    use it.

Thanks for your comments:-)

>Cheers!
>
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> 
>> ---
>> v2: fix typo and points which commit introduce it.
>> ---
>>  include/linux/mm.h | 5 -----
>>  1 file changed, 5 deletions(-)
>> 
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 74232b28949b..4cf023c4c6b3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -70,11 +70,6 @@ static inline void totalram_pages_add(long count)
>>  	atomic_long_add(count, &_totalram_pages);
>>  }
>>  
>> -static inline void totalram_pages_set(long val)
>> -{
>> -	atomic_long_set(&_totalram_pages, val);
>> -}
>> -
>>  extern void * high_memory;
>>  extern int page_cluster;
>>  
>> 
>
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
