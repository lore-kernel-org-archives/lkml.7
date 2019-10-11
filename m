Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E98ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557622190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfJKAhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:37:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:33030 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfJKAhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:37:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 17:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="194182012"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2019 17:37:15 -0700
Date:   Fri, 11 Oct 2019 08:36:58 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        cai@lca.pw, shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/2] mm/rmap.c: don't reuse anon_vma if we just want a
 copy
Message-ID: <20191011003658.GA30885@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191010135825.28153-1-richardw.yang@linux.intel.com>
 <2a8a03bb-de72-62b0-1cb6-bc9b3b68b258@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8a03bb-de72-62b0-1cb6-bc9b3b68b258@yandex-team.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 06:29:32PM +0300, Konstantin Khlebnikov wrote:
>On 10/10/2019 16.58, Wei Yang wrote:
>> Before commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
>> hierarchy"), anon_vma_clone() doesn't change dst->anon_vma. While after
>> this commit, anon_vma_clone() will try to reuse an exist one on forking.
>> 
>> But this commit go a little bit further for the case not forking.
>> anon_vma_clone() is called from __vma_split(), __split_vma(), copy_vma()
>> and anon_vma_fork(). For the first three places, the purpose here is get
>> a copy of src and we don't expect to touch dst->anon_vma even it is
>> NULL. While after that commit, it is possible to reuse an anon_vma when
>> dst->anon_vma is NULL. This is not we intend to have.
>
>In all these cases dst->anon_vma is a copy of src->anon_vma except
>anon_vma_fork where dst_>anon_vma explicitly set to NULL before call.
>
>So reuse == true iff (!dst->anon_vma && src->anon_vma)
>

What if src->anon_vma is NULL?

>> 
>> This patch stop reuse anon_vma for non-fork cases.
>> 
>> Fix commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
>> hierarchy")
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>   include/linux/rmap.h | 3 ++-
>>   mm/mmap.c            | 6 +++---
>>   mm/rmap.c            | 7 ++++---
>>   3 files changed, 9 insertions(+), 7 deletions(-)
>> 
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 988d176472df..963e6ab09b9b 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -142,7 +142,8 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
>>   void anon_vma_init(void);	/* create anon_vma_cachep */
>>   int  __anon_vma_prepare(struct vm_area_struct *);
>>   void unlink_anon_vmas(struct vm_area_struct *);
>> -int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
>> +int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src,
>> +		   bool reuse);
>>   int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
>>   static inline int anon_vma_prepare(struct vm_area_struct *vma)
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 93f221785956..21e94f8ac4c7 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -791,7 +791,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>>   			int error;
>>   			importer->anon_vma = exporter->anon_vma;
>> -			error = anon_vma_clone(importer, exporter);
>> +			error = anon_vma_clone(importer, exporter, false);
>>   			if (error)
>>   				return error;
>>   		}
>> @@ -2666,7 +2666,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
>>   	if (err)
>>   		goto out_free_vma;
>> -	err = anon_vma_clone(new, vma);
>> +	err = anon_vma_clone(new, vma, false);
>>   	if (err)
>>   		goto out_free_mpol;
>> @@ -3247,7 +3247,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>>   		new_vma->vm_pgoff = pgoff;
>>   		if (vma_dup_policy(vma, new_vma))
>>   			goto out_free_vma;
>> -		if (anon_vma_clone(new_vma, vma))
>> +		if (anon_vma_clone(new_vma, vma, false))
>>   			goto out_free_mempol;
>>   		if (new_vma->vm_file)
>>   			get_file(new_vma->vm_file);
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index d9a23bb773bf..f729e4013613 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -258,7 +258,8 @@ static inline void unlock_anon_vma_root(struct anon_vma *root)
>>    * good chance of avoiding scanning the whole hierarchy when it searches where
>>    * page is mapped.
>>    */
>> -int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>> +int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src,
>> +		   bool reuse)
>>   {
>>   	struct anon_vma_chain *avc, *pavc;
>>   	struct anon_vma *root = NULL;
>> @@ -286,7 +287,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>>   		 * will always reuse it. Root anon_vma is never reused:
>>   		 * it has self-parent reference and at least one child.
>>   		 */
>> -		if (!dst->anon_vma && anon_vma != src->anon_vma &&
>> +		if (reuse && !dst->anon_vma && anon_vma != src->anon_vma &&
>>   				anon_vma->degree < 2)
>>   			dst->anon_vma = anon_vma;
>>   	}
>> @@ -329,7 +330,7 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
>>   	 * First, attach the new VMA to the parent VMA's anon_vmas,
>>   	 * so rmap can find non-COWed pages in child processes.
>>   	 */
>> -	error = anon_vma_clone(vma, pvma);
>> +	error = anon_vma_clone(vma, pvma, true);
>>   	if (error)
>>   		return error;
>> 

-- 
Wei Yang
Help you, Help me
