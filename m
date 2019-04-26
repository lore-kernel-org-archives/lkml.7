Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1825C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEB5206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDZO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:27:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:56348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbfDZO1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:27:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D84FAF50;
        Fri, 26 Apr 2019 14:27:29 +0000 (UTC)
Subject: Re: [PATCH] bcache: avoid clang -Wunintialized warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190322143507.1256436-1-arnd@arndb.de>
 <20190425180853.GA4507@archlinux-i9>
 <44474338-8031-13eb-1e95-376c1036b611@suse.de>
 <20190426130134.GB12483@archlinux-i9>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <b2f72346-47e1-0a47-64bc-d35490e60818@suse.de>
Date:   Fri, 26 Apr 2019 22:27:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426130134.GB12483@archlinux-i9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/26 9:01 下午, Nathan Chancellor wrote:
> On Fri, Apr 26, 2019 at 10:43:01AM +0800, Coly Li wrote:
>> On 2019/4/26 2:08 上午, Nathan Chancellor wrote:
>>> On Fri, Mar 22, 2019 at 03:35:00PM +0100, Arnd Bergmann wrote:
>>>> clang has identified a code path in which it thinks a
>>>> variable may be unused:
>>>>
>>>> drivers/md/bcache/alloc.c:333:4: error: variable 'bucket' is used uninitialized whenever 'if' condition is false
>>>>       [-Werror,-Wsometimes-uninitialized]
>>>>                         fifo_pop(&ca->free_inc, bucket);
>>>>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
>>>>  #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
>>>>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/md/bcache/util.h:189:6: note: expanded from macro 'fifo_pop_front'
>>>>         if (_r) {                                                       \
>>>>             ^~
>>>> drivers/md/bcache/alloc.c:343:46: note: uninitialized use occurs here
>>>>                         allocator_wait(ca, bch_allocator_push(ca, bucket));
>>>>                                                                   ^~~~~~
>>>> drivers/md/bcache/alloc.c:287:7: note: expanded from macro 'allocator_wait'
>>>>                 if (cond)                                               \
>>>>                     ^~~~
>>>> drivers/md/bcache/alloc.c:333:4: note: remove the 'if' if its condition is always true
>>>>                         fifo_pop(&ca->free_inc, bucket);
>>>>                         ^
>>>> drivers/md/bcache/util.h:219:27: note: expanded from macro 'fifo_pop'
>>>>  #define fifo_pop(fifo, i)       fifo_pop_front(fifo, (i))
>>>>                                 ^
>>>> drivers/md/bcache/util.h:189:2: note: expanded from macro 'fifo_pop_front'
>>>>         if (_r) {                                                       \
>>>>         ^
>>>> drivers/md/bcache/alloc.c:331:15: note: initialize the variable 'bucket' to silence this warning
>>>>                         long bucket;
>>>>                                    ^
>>>>
>>>> This cannot happen in practice because we only enter the loop
>>>> if there is at least one element in the list.
>>>>
>>>> Slightly rearranging the code makes this clearer to both the
>>>> reader and the compiler, which avoids the warning.
>>>>
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>  drivers/md/bcache/alloc.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
>>>> index 5002838ea476..f8986effcb50 100644
>>>> --- a/drivers/md/bcache/alloc.c
>>>> +++ b/drivers/md/bcache/alloc.c
>>>> @@ -327,10 +327,11 @@ static int bch_allocator_thread(void *arg)
>>>>  		 * possibly issue discards to them, then we add the bucket to
>>>>  		 * the free list:
>>>>  		 */
>>>> -		while (!fifo_empty(&ca->free_inc)) {
>>>> +		while (1) {
>>>>  			long bucket;
>>>>  
>>>> -			fifo_pop(&ca->free_inc, bucket);
>>>> +			if (!fifo_pop(&ca->free_inc, bucket))
>>>> +				break;
>>>>  
>>>>  			if (ca->discard) {
>>>>  				mutex_unlock(&ca->set->bucket_lock);
>>>> -- 
>>>> 2.20.0
>>>>
>>>
>>> Hi all,
>>>
>>> Could someone please review/pick this up? This is one of two remaining
>>> -Wsometimes-uninitialized warnings among arm, arm64, and x86_64
>>> all{yes,mod}config and I'd like to get it turned on as soon as possible
>>> to catch more bugs.
>>
>> Hi Nathan,
>>
>> It is in Jens' block tree for-next branch already, for Linux v5.2 merge
>> window.
>>
>> Thanks.
>>
>> -- 
>>
>> Coly Li
> 
> Hi Coly,
> 
> Thank you for the reply and heads up, it hadn't hit -next when I sent
> that message and I didn't check Jens' tree.
> 
> I appreciate you picking it up!

Hi Nathan,

You are welcome, and thanks for the contribution to make bcache better :-)

-- 

Coly Li
