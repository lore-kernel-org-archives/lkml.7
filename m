Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB6C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B7C218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfIIU51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:57:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51977 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfIIU51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:57:27 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x89KvPPi038871;
        Tue, 10 Sep 2019 05:57:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Tue, 10 Sep 2019 05:57:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x89KvPGd038866
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 10 Sep 2019 05:57:25 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] mm: avoid slub allocation while holding list_lock
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190909061016.173927-1-yuzhao@google.com>
 <20190909160052.cxpfdmnrqucsilz2@box>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <e5e25aa3-651d-92b4-ac82-c5011c66a7cb@I-love.SAKURA.ne.jp>
Date:   Tue, 10 Sep 2019 05:57:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909160052.cxpfdmnrqucsilz2@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/10 1:00, Kirill A. Shutemov wrote:
> On Mon, Sep 09, 2019 at 12:10:16AM -0600, Yu Zhao wrote:
>> If we are already under list_lock, don't call kmalloc(). Otherwise we
>> will run into deadlock because kmalloc() also tries to grab the same
>> lock.
>>
>> Instead, allocate pages directly. Given currently page->objects has
>> 15 bits, we only need 1 page. We may waste some memory but we only do
>> so when slub debug is on.
>>
>>   WARNING: possible recursive locking detected
>>   --------------------------------------------
>>   mount-encrypted/4921 is trying to acquire lock:
>>   (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437
>>
>>   but task is already holding lock:
>>   (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb
>>
>>   other info that might help us debug this:
>>    Possible unsafe locking scenario:
>>
>>          CPU0
>>          ----
>>     lock(&(&n->list_lock)->rlock);
>>     lock(&(&n->list_lock)->rlock);
>>
>>    *** DEADLOCK ***
>>
>> Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Looks sane to me:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Really?

Since page->objects is handled as bitmap, alignment should be BITS_PER_LONG
than BITS_PER_BYTE (though in this particular case, get_order() would
implicitly align BITS_PER_BYTE * PAGE_SIZE). But get_order(0) is an
undefined behavior.
