Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE08DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9B822CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfHVOBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:01:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59231 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfHVOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:01:21 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7ME14I4050794;
        Thu, 22 Aug 2019 23:01:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Thu, 22 Aug 2019 23:01:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7ME14Oi050789
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 22 Aug 2019 23:01:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20190820222403.GB8120@kroah.com>
 <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
Date:   Thu, 22 Aug 2019 23:00:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822133538.GA16793@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/22 22:35, Greg Kroah-Hartman wrote:
> On Thu, Aug 22, 2019 at 06:59:25PM +0900, Tetsuo Handa wrote:
>> Tetsuo Handa wrote:
>>> Greg Kroah-Hartman wrote:
>>>> Oh, nice!  This shouldn't break anything that is assuming that the read
>>>> will complete before a signal is delivered, right?
>>>>
>>>> I know userspace handling of "short" reads is almost always not there...
>>>
>>> Since this check will give up upon SIGKILL, userspace won't be able to see
>>> the return value from read(). Thus, returning 0 upon SIGKILL will be safe. ;-)
>>> Maybe we also want to add cond_resched()...
>>>
>>> By the way, do we want similar check on write_mem() side?
>>> If aborting "write to /dev/mem" upon SIGKILL (results in partial write) is
>>> unexpected, we might want to ignore SIGKILL for write_mem() case.
>>> But copying data from killed threads (especially when killed by OOM killer
>>> and userspace memory is reclaimed by OOM reaper before write_mem() returns)
>>> would be after all unexpected. Then, it might be preferable to check SIGKILL
>>> on write_mem() side...
>>>
>>
>> Ha, ha. syzbot reported the same problem using write_mem().
>> https://syzkaller.appspot.com/text?tag=CrashLog&x=1018055a600000
>> We want fatal_signal_pending() check on both sides.
> 
> Ok, want to send a patch for that?

Yes. But before sending a patch, I'm trying to dump values using debug printk().

> 
> And does anything use /dev/mem anymore?  I think X stopped using it a
> long time ago.
> 
>> By the way, write_mem() worries me whether there is possibility of replacing
>> kernel code/data with user-defined memory data supplied from userspace.
>> If write_mem() were by chance replaced with code that does
>>
>>    while (1);
>>
>> we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
>> Ditto for replacing local variables with unexpected values...
> 
> I'm sorry, I don't really understand what you mean here, but I haven't
> had my morning coffee...  Any hints as to an example?

Probably similar idea: "lockdown: Restrict /dev/{mem,kmem,port} when the kernel is locked down"

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/char/mem.c?h=next-20190822&id=9b9d8dda1ed72e9bd560ab0ca93d322a9440510e

Then, syzbot might want to blacklist writing to /dev/mem .
