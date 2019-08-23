Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C688206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfHWISH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:18:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55645 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733079AbfHWISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:18:06 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7N8Hkr4060905;
        Fri, 23 Aug 2019 17:17:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Fri, 23 Aug 2019 17:17:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7N8HkJw060899
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 23 Aug 2019 17:17:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
References: <20190820222403.GB8120@kroah.com>
 <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
 <20190822133538.GA16793@kroah.com>
 <e8d3ce30-8c61-048e-2606-f8a4e8f08d87@i-love.sakura.ne.jp>
 <20190822164249.GA12551@kroah.com>
 <CACT4Y+Z0yCAwie83Oqd7XBNgQjWtEkuEg5WJCd6rW-ZMWqosxg@mail.gmail.com>
 <433f12f7-cc17-c88b-4f26-7f45eee42884@i-love.sakura.ne.jp>
 <CACT4Y+YCNR5_M29juV9-2UDj55BJVuYbj7bzbjtMDM_odut1Pg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f89b6329-37f5-e0ac-03aa-a58edc4267e4@i-love.sakura.ne.jp>
Date:   Fri, 23 Aug 2019 17:17:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YCNR5_M29juV9-2UDj55BJVuYbj7bzbjtMDM_odut1Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/23 8:59, Dmitry Vyukov wrote:
>> Can't we introduce a kernel config which selectively blocks specific actions?
>> If we don't need to worry about bypassing blacklist checks, we will be able to
>> enable syz_execute_func() again.
> 
> 
> We can consider this, but we need some set of good use cases first.
> For /dev/{mem,kmem} we disable them with config, right?

/dev/{mem,kmem} can be disabled by kernel config options. But

>                                                         That looks
> like the right thing to do because we don't want fuzzer to do anything
> with these files anyway.

I don't think so. To examine as corner as possible (e.g. lock dependency),
I consider that even doing

----------
+#ifdef CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING
+static char dummybuf[PAGE_SIZE];
+#endif
----------

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
+                       copied = copy_from_user(dummybuf, buf, min(sizeof(dummybuf), sz));
+#endif
                        unxlate_dev_mem_ptr(p, ptr);
----------

makes sense, for copy_from_user() might find new lock dependency
which would otherwise be unnoticed.

>                          So this won't be a good use case for
> CONFIG_KERNEL_BUILT_FOR_FUZZ_TESTING.
> Fuzzer can also reliably filter out based on syscall numbers of
> top-level argument values. The potential problem is with (1)
> pointers/indirect memory and (2) where blacklisting some top-level
> argument values would backlist too much (e.g. prohibiting 3rd ioctl
> argument 0 entirely).

I consider that functions that freezes processes/filesystems, 
reboots/shutdowns a system, changes console loglevels can be blocked
as well. Trying to examine up to last-second conditional branches will
catch more bugs (e.g. bugs in error recovery paths).

