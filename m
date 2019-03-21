Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A10218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfCUIOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:14:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31116 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:14:03 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2L8E0QI099400;
        Thu, 21 Mar 2019 17:14:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Thu, 21 Mar 2019 17:14:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126094122116.bbtec.net [126.94.122.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2L8Dt6k099331
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 21 Mar 2019 17:14:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: ratelimit API: was: [RFC PATCH] printk: Introduce "store now but
 print later" prefix.
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
 <20190306100404.jzfk7oqsh3turqth@pathway.suse.cz>
 <0fc95fee-8b6e-5ff0-9a91-9e0ea66028f3@i-love.sakura.ne.jp>
 <20190320152516.3gbmaj5xoyxkivyt@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0316a449-e7ef-7ca5-2569-f3f2ebebbde9@i-love.sakura.ne.jp>
Date:   Thu, 21 Mar 2019 17:13:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320152516.3gbmaj5xoyxkivyt@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/21 0:25, Petr Mladek wrote:
>> This requires serialization among threads using "rs". I already
>> proposed ratelimit_reset() for memcg's OOM problem at
>> https://lkml.kernel.org/r/201810180246.w9I2koi3011358@www262.sakura.ne.jp
>> but it was not accepted.
> 
> IMHO, the main problem was that the patch tried to work around
> the ratelimit API weakness by a custom code.
> 
> I believe that using an improved/extended ratelimit API with
> a sane semantic would be more acceptable.
> 

Michal, are you OK to use ratelimit_reset() in out_of_memory()
if ratelimit_reset() is accepted?

> 
>>> It means that it makes sense to enable the related
>>> ratelimited messages again because they would describe
>>> another problem.
>>
>> ___ratelimit() could also check number of not-yet-flushed
>> printk() records (e.g. log_next_seq - console_seq <= $some_threshold).
> 
> The number is almost useless without more information, for example,
> how fast the consoles are, how many lines will get filtered
> by a console_loglevel, if the console_sem owner is sleeping,
> how many messages are being added by other CPUs.
> 
> I believe that we do not really need it. The ratelimit_reset()
> user should know when the messages can get skipped because
> they describe the same situation again and again.

If printk() becomes asynchronous (either my "synchronous by default +
console_writer kernel thread" or John's "asynchronous by default +
printk kernel thread" is accepted), there will be little delay between
___ratelimit() and ratelimit_reset() enough to make ratelimit_reset()
unnecessary. Also, "number of not-yet-flushed printk() records" will
become meaningful if printk() becomes asynchronous.

But "how fast the consoles" depends on what consoles will be added/removed
during messages are flushed, "how many lines will get filtered by a
console_loglevel" depends on whether someone will change it during
messages are flushed, "how many messages are being added by other CPUs
during the console_sem owner is sleeping" (or "how many bytes which will
need to be written to consoles") depends on stress at that moment. None of
these example information will be reliable for making ___ratelimit() decision.

