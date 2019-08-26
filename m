Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E0C20828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfHZKkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:40:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65245 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfHZKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:40:47 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7QAeVjp024432;
        Mon, 26 Aug 2019 19:40:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Mon, 26 Aug 2019 19:40:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7QAeVPi024428
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 26 Aug 2019 19:40:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
 <20190823091636.GA10064@gmail.com>
 <CAHk-=wj=HcHWjrrNRmZ_hxEdBBrvUnPNFCw37EAu8_qJn71saQ@mail.gmail.com>
 <20190824161432.GA25950@gmail.com>
 <CAHk-=whFQNkqPJ5zA1xAyvgtCPLN2C4xeJ181rU3k6bG+2zugg@mail.gmail.com>
 <20190824202224.GA5286@gmail.com>
 <ab9ccf3c-6b87-652e-b305-41f2c2d1b2ae@i-love.sakura.ne.jp>
 <CAHk-=wgR=moYe2Jx8wobx9Vzxj55DGPwU9VEjZ+7gUrVYySMzQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <92919086-0a7e-520d-0465-b9e3051e965a@i-love.sakura.ne.jp>
Date:   Mon, 26 Aug 2019 19:40:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgR=moYe2Jx8wobx9Vzxj55DGPwU9VEjZ+7gUrVYySMzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/26 1:54, Linus Torvalds wrote:
> On Sat, Aug 24, 2019 at 10:50 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> @@ -142,7 +144,7 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>>                 sz = size_inside_page(p, count);
>>                 cond_resched();
>>                 err = -EINTR;
>> -               if (fatal_signal_pending(current))
>> +               if (signal_pending(current))
>>                         goto failed;
>>
>>                 err = -EPERM;
> 
> So from a "likelihood of breaking" standpoint, I'd really like to make
> sure that the "signal_pending()" checks come at the *end* of the loop.
> 
> That way, if somebody is doing a 4-byte read from MMIO, he'll never see -EINTR.
> 
> I'm specifically thinking of tools like user-space 'lspci' etc, which
> I wouldn't be surprised could happen.
> 
> Also, just in case things break, I do agree with Ingo that this should
> be split up into several patches.

Thinking from how read_mem() returns error code instead of returning bytes
already processed, any sane users will not try to read so much memory (like 2GB).
If userspace programs want to read so much memory, there must have been attempts
to improve performance. I guess that userspace program somehow knows which region
to read and tries to read only meaningful pages (which would not become hundreds MB).
Thus, I don't think we want to make /dev/{mem,kmem} intrruptible. Just making killable
in case insane userspace program (like fuzzer) tried to read/write so much memory
will be sufficient...

