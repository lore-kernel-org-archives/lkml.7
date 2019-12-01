Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1749FC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70322084E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfLABRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:17:52 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55022 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfLABRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:17:51 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xB11HnPK006289;
        Sun, 1 Dec 2019 10:17:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Sun, 01 Dec 2019 10:17:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xB11Hh7Y006132
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 1 Dec 2019 10:17:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from
 list_slab_objects() V2
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>
Cc:     Yu Zhao <yuzhao@google.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20190914000743.182739-1-yuzhao@google.com>
 <20191108193958.205102-1-yuzhao@google.com>
 <20191108193958.205102-2-yuzhao@google.com>
 <alpine.DEB.2.21.1911092024560.9034@www.lameter.com>
 <20191109230147.GA75074@google.com>
 <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
 <20191110184721.GA171640@google.com>
 <alpine.DEB.2.21.1911111543420.10669@www.lameter.com>
 <alpine.DEB.2.21.1911111553020.15366@www.lameter.com>
 <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <54b6c6a1-f9e4-5002-c828-3084c5203489@i-love.sakura.ne.jp>
Date:   Sun, 1 Dec 2019 10:17:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/01 8:09, Andrew Morton wrote:
>> Perform the allocation in free_partial() before the list_lock is taken.
> 
> No response here?  It looks a lot simpler than the originally proposed
> patch?
> 
>> --- linux.orig/mm/slub.c	2019-10-15 13:54:57.032655296 +0000
>> +++ linux/mm/slub.c	2019-11-11 15:52:11.616397853 +0000
>> @@ -3690,14 +3690,15 @@ error:
>>  }
>>
>>  static void list_slab_objects(struct kmem_cache *s, struct page *page,
>> -							const char *text)
>> +					const char *text, unsigned long *map)
>>  {
>>  #ifdef CONFIG_SLUB_DEBUG
>>  	void *addr = page_address(page);
>>  	void *p;
>> -	unsigned long *map = bitmap_zalloc(page->objects, GFP_ATOMIC);

Changing from !(__GFP_IO | __GFP_FS) allocation to

>> +
>>  	if (!map)
>>  		return;
>> +
>>  	slab_err(s, page, text, s->name);
>>  	slab_lock(page);
>>
>> @@ -3723,6 +3723,11 @@ static void free_partial(struct kmem_cac
>>  {
>>  	LIST_HEAD(discard);
>>  	struct page *page, *h;
>> +	unsigned long *map = NULL;
>> +
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);

__GFP_IO | __GFP_FS allocation.
How is this path guaranteed to be safe to perform __GFP_IO | __GFP_FS reclaim?

>> +#endif
>>
>>  	BUG_ON(irqs_disabled());
>>  	spin_lock_irq(&n->list_lock);

