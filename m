Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8904C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0F420673
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393066AbfHVVR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:17:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59183 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390412AbfHVVR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:17:59 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7MLHek7059573;
        Fri, 23 Aug 2019 06:17:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 23 Aug 2019 06:17:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7MLHeBZ059570
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 23 Aug 2019 06:17:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
References: <20190820222403.GB8120@kroah.com>
 <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com>
 <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
 <20190822164249.GA12551@kroah.com>
 <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <433f12f7-cc17-c88b-4f26-7f45eee42884@i-love.sakura.ne.jp>
Date:   Fri, 23 Aug 2019 06:17:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/23 2:11, Dmitry Vyukov wrote:
> On Thu, Aug 22, 2019 at 9:42 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>>>> By the way, write_mem() worries me whether there is possibility of replacing
>>>>> kernel code/data with user-defined memory data supplied from userspace.
>>>>> If write_mem() were by chance replaced with code that does
>>>>>
>>>>>    while (1);
>>>>>
>>>>> we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
>>>>> Ditto for replacing local variables with unexpected values...
>>>>
>>>> I'm sorry, I don't really understand what you mean here, but I haven't
>>>> had my morning coffee...  Any hints as to an example?
>>>
>>> Probably similar idea: "lockdown: Restrict /dev/{mem,kmem,port} when the kernel is locked down"
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/char/mem.c?h=next-20190822&id=9b9d8dda1ed72e9bd560ab0ca93d322a9440510e
>>>
>>> Then, syzbot might want to blacklist writing to /dev/mem .
>>
>> syzbot should probably blacklist that now, you can do a lot of bad
>> things writing to that device node :(
> 
> Agree. It wasn't supposed to reach it, but it figured out how to mount
> devfs and then open "./mem"  bypassing all checks. Fortunately there
> is a config to disable /dev/mem, so we are going to turn it off.
> 

Can't we introduce a kernel config which selectively blocks specific actions?
If we don't need to worry about bypassing blacklist checks, we will be able to
enable syz_execute_func() again.

----------
 			ptr = xlate_dev_mem_ptr(p);
 			if (!ptr) {
 				if (written)
 					break;
 				return -EFAULT;
 			}
+#ifndef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
 			copied = copy_from_user(ptr, buf, sz);
+#else
+			copied = 0;
+#endif
 			unxlate_dev_mem_ptr(p, ptr);
----------
