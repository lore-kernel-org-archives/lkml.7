Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CE4C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7294A20449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfIDKUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:20:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56439 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:20:01 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84AJlJ4065553;
        Wed, 4 Sep 2019 19:19:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 04 Sep 2019 19:19:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84AJlAg065549
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 4 Sep 2019 19:19:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] /dev/mem: Bail out upon SIGKILL.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
References: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190826132916.GB12281@kroah.com>
 <87bb0adb-1d36-6481-6845-a93e5a3e5d17@i-love.sakura.ne.jp>
Message-ID: <5ea28431-c677-0552-41aa-1c67779e2248@i-love.sakura.ne.jp>
Date:   Wed, 4 Sep 2019 19:19:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87bb0adb-1d36-6481-6845-a93e5a3e5d17@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping? Syzbot is still reporting this problem.

On 2019/08/26 22:44, Tetsuo Handa wrote:
> On 2019/08/26 22:29, Greg Kroah-Hartman wrote:
>> On Mon, Aug 26, 2019 at 10:13:25PM +0900, Tetsuo Handa wrote:
>>> syzbot found that a thread can stall for minutes inside read_mem() or
>>> write_mem() after that thread was killed by SIGKILL [1]. Reading from
>>> iomem areas of /dev/mem can be slow, depending on the hardware.
>>> While reading 2GB at one read() is legal, delaying termination of killed
>>> thread for minutes is bad. Thus, allow reading/writing /dev/mem and
>>> /dev/kmem to be preemptible and killable.
>>>
>>>   [ 1335.912419][T20577] read_mem: sz=4096 count=2134565632
>>>   [ 1335.943194][T20577] read_mem: sz=4096 count=2134561536
>>>   [ 1335.978280][T20577] read_mem: sz=4096 count=2134557440
>>>   [ 1336.011147][T20577] read_mem: sz=4096 count=2134553344
>>>   [ 1336.041897][T20577] read_mem: sz=4096 count=2134549248
>>>
>>> Theoretically, reading/writing /dev/mem and /dev/kmem can become
>>> "interruptible". But this patch chose "killable". Future patch will make
>>> them "interruptible" so that we can revert to "killable" if some program
>>> regressed.
>>>
>>> [1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e
>>>
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>> Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
>>> ---
>>>  drivers/char/mem.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>
>> What changed from previous versions?
>>
>> That goes below the --- line at the very least.
> 
> (1) Moved fatal_signal_pending() test to end of iteration.
> (2) Added need_resched() test before cond_resched().
> (3) Removed -EINTR assignment because end of iteration means
>     that at least one byte was processed (sz > 0).
> 
>>
>> thanks,
>>
>> greg k-h
>>
> 
