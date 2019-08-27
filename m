Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6905B2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfH0Jdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:33:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:35302 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfH0Jdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:33:31 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1i2Xqa-0000bE-FK; Tue, 27 Aug 2019 12:33:04 +0300
Subject: Re: [PATCH 1/2] riscv: Add memmove string operation.
To:     Nick Hu <nickhu@andestech.com>
Cc:     =?UTF-8?B?QWxhbiBRdWV5LUxpYW5nIEthbyjpq5jprYHoia8p?= 
        <alankao@andestech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "Anup.Patel@wdc.com" <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        =?UTF-8?B?6Zui6IG3Wm9uZyBab25nLVhpYW4gTGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
References: <cover.1565161957.git.nickhu@andestech.com>
 <a6c24ce01dc40da10d58fdd30bc3e1316035c832.1565161957.git.nickhu@andestech.com>
 <09d5108e-f0ba-13d3-be9e-119f49f6bd85@virtuozzo.com>
 <20190827090738.GA22972@andestech.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <92dd5f5f-c8a2-53c3-4d61-44acc4366844@virtuozzo.com>
Date:   Tue, 27 Aug 2019 12:33:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827090738.GA22972@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/19 12:07 PM, Nick Hu wrote:
> Hi Andrey
> 
> On Thu, Aug 22, 2019 at 11:59:02PM +0800, Andrey Ryabinin wrote:
>> On 8/7/19 10:19 AM, Nick Hu wrote:
>>> There are some features which need this string operation for compilation,
>>> like KASAN. So the purpose of this porting is for the features like KASAN
>>> which cannot be compiled without it.
>>>
>>
>> Compilation error can be fixed by diff bellow (I didn't test it).
>> If you don't need memmove very early (before kasan_early_init()) than arch-specific not-instrumented memmove()
>> isn't necessary to have.
>>
>> ---
>>  mm/kasan/common.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> index 6814d6d6a023..897f9520bab3 100644
>> --- a/mm/kasan/common.c
>> +++ b/mm/kasan/common.c
>> @@ -107,6 +107,7 @@ void *memset(void *addr, int c, size_t len)
>>  	return __memset(addr, c, len);
>>  }
>>  
>> +#ifdef __HAVE_ARCH_MEMMOVE
>>  #undef memmove
>>  void *memmove(void *dest, const void *src, size_t len)
>>  {
>> @@ -115,6 +116,7 @@ void *memmove(void *dest, const void *src, size_t len)
>>  
>>  	return __memmove(dest, src, len);
>>  }
>> +#endif
>>  
>>  #undef memcpy
>>  void *memcpy(void *dest, const void *src, size_t len)
>> -- 
>> 2.21.0
>>
>>
>>
> I have confirmed that the string operations are not used before kasan_early_init().
> But I can't make sure whether other ARCHs would need it before kasan_early_init().
> Do you have any idea to check that? Should I cc all other ARCH maintainers?
 

This doesn't affect other ARCHes in any way. If other arches have their own not-instrumented
memmove implementation (and they do), they will continue to be able to use it early.
