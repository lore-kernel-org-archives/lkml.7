Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323D1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08226217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 10:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfHYKfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 06:35:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61765 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYKfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 06:35:31 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7PAZHWP067210;
        Sun, 25 Aug 2019 19:35:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sun, 25 Aug 2019 19:35:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7PAZH03067207
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 25 Aug 2019 19:35:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
 <20190825095908.GA116866@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cfc26ac5-b674-5d42-05f8-c978613aaf29@i-love.sakura.ne.jp>
Date:   Sun, 25 Aug 2019 19:35:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825095908.GA116866@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/25 18:59, Ingo Molnar wrote:
>> @@ -132,8 +132,10 @@ static ssize_t read_mem(struct file *file, char __user *buf,
>>  #endif
>>  
>>  	bounce = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> -	if (!bounce)
>> -		return -ENOMEM;
>> +	if (!bounce) {
>> +		err = -ENOMEM;
>> +		goto failed;
>> +	}
> 
> Yeah, so while I agree with the more consistent handling of partial 
> reads, I'd suggest the following changes:
> 
>  - Please don't use this 4-line error handling variant, use the old short 
>    2-line pattern instead. There's no real reason to keep 'err' as a 
>    flag, the 'failed' branch will know that 'err' is the error return if 
>    there's been no progress.

The caller might guarantee count > 0, but for robustness, I decided to
choose 4-line error handling here because I merged the normal and the
failure path control flow; read will remain 0 if count == 0, and thus
err should remain 0.

> 
>  - We should probably separate out a third 'fatal error' variant: for 
>    example if copying to user-space generates a page fault, then we 
>    clearly should not pretend that all is fine and return a short read 
>    even if we made some progress, a -EFAULT is more informative, as we 
>    might have corrupted (overran) some user buffer on the failed copy as 
>    well, and ran off the end into the first unmapped user area.

Is it possible that copy_from_user() corrupts user buffer in a way that userspace
cannot retry when kernel responded with "there was a short write"? It seems that
these functions are difficult to return appropriate errors...

> 
>  - As for the patch series maybe it might make sense to separate the 
>    fixes from the semantic changes, in case there's any breakage. I.e. 
>    first fix the bug minimally, then add the other changes in a separate 
>    commit. If any of them causes problems with applications we'll have a 
>    more precise bisection result.

Yes. I think for now we should just make these functions killable. Then, we
can try changing return code for partial read/write. If no breakage report,
we can make these functions interruptible.

> 
>  - Likewise, the changing of the write side interruptability of /dev/mem 
>    should probably be a separate patch as well.
> 
> I can factor out such a series if you don't have the time, but feel free 
> to do it yourself, this is your bug report and your patch. :)

You can do it. It's a syzbot's bug report. I just forwarded it. ;-)

