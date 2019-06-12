Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6731C2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437919AbfFLKGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:06:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50835 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406059AbfFLKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:06:36 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5CA6WK8026578;
        Wed, 12 Jun 2019 19:06:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 12 Jun 2019 19:06:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5CA6WC4026573
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 12 Jun 2019 19:06:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Petr Mladek <pmladek@suse.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
 <20190528084825.GA9676@jagdpanzerIV>
 <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
 <20190607170922.GA17017@xo-6d-61-c0.localdomain>
 <b28da439-1d2c-9a1c-17be-fa8b8476d313@i-love.sakura.ne.jp>
 <20190611151018.gvjazu4vedw2h2qh@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8184c8d0-8b72-53f3-1176-a895f369e60d@i-love.sakura.ne.jp>
Date:   Wed, 12 Jun 2019 19:06:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611151018.gvjazu4vedw2h2qh@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/12 0:10, Petr Mladek wrote:
> On Sat 2019-06-08 11:45:45, Tetsuo Handa wrote:
>> On 2019/06/08 2:09, Pavel Machek wrote:
>>> On Tue 2019-05-28 19:15:43, Tetsuo Handa wrote:
>>>> On 2019/05/28 17:51, Sergey Senozhatsky wrote:
>>>>>> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
>>>>>> context information. But doesn't such attempt resemble find_printk_buffer() ?
>>>>>
>>>>> Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
>>>>> line is hardly possible. At the same time I'd really prefer not
>>>>> to have buffering for sysrq.
>>>>
>>>> I don't think it is hardly possible. And I really prefer having
>>>> deferred printing for SysRq.
> 
>>>
>>> Well, magic SysRq was meant for situation where system is in weird/broken state.
>>> "Give me backtrace where it is hung", etc. Direct printing is more likely to work
>>> in that cases.
>>
>> Magic SysRq from keyboard is for situation where system is in weird/broken state.
>>
>> But I want to use Magic SysRq from /proc for situation where system is not fatally
>> weird/broken state. I have trouble getting SysRq-t from /proc when something bad
>> happened (e.g. some health check process did not return for 60 seconds). Since
>> /proc/pid/wchan shows only 1 line, it is useless for understanding why that process
>> got stuck. If direct printing is enforced, "echo t > /proc/sysrq-trigger" might take
>> many minutes. If direct printing is not enforced, "echo t > /proc/sysrq-trigger"
>> should complete within less than one second. If syslog is working (which is almost
>> equivalent to being able to write to /proc/sysrq-trigger), the latter is more helpful
>> for taking snapshots for multiple times (e.g. 5 times with 10 seconds interval) in
>> order to understand why that process got stuck. That's why I added
> 
> This looks like a very specific use case. But the proposal changes
> the behavior for anyone. I am not persuaded that everyone would
> appreciate the change.
> 
> OK, it takes 60 seconds when the messages appear on the console and
> 1 second when they are just stored to the syslog.
> 
> Why the system is configured to show all messages on the console
> when syslog is enough?

We are talking about two things.

First thing is about whether we should automatically add KERN_UNSUPPRESSED
to all printks down the op_p->handler() line. I initially thought that we
should automatically add KERN_UNSUPPRESSED, but I realized that we should
not do it. I want to allow users to configure not to show all messages
on the console when syslog is enough.

> 
> If sysrq is the preferred interface, it might be used also the other
> way. I mean to increase console_loglevel to hide all messages on
> the console, trigger output of the system state and eventually
> decrease the loglevel again.

Right. Some distributions do the opposite thing in order to speed up
the boot sequence; increase console_loglevel to hide most of messages
on the console by default. We can trigger "SysRq-9" -> "SysRq-t" ->
"SysRq-4" from keyboard in order to print all SysRq-t messages to
the consoles when we need to do.

Since vkdb_printf() uses CONSOLE_LOGLEVEL_SILENT, KERN_UNSUPPRESSED alone
is not sufficient for avoid playing with console loglevel for tree wide.
If we want to get rid of temporary manipulation of console loglevel for
only SysRq, introducing KERN_UNSUPPRESSED would be OK. But we want to get
rid of temporary manipulation of console loglevel for tree wide, don't we?
If yes, I think that we will need per context "always print to consoles" /
"never print to consoles" / "print to consoles based on console loglevel"
control, for explicitly passing that control to foo()->dump_stack()->printk()
will be (not impossible but) a huge change.

> 
>> Also, regarding Magic SysRq from keyboard case, my intent is to allow SysRq
>> to just store the messages to printk() buffer, in order to avoid stalls and
>> take better snapshots for multiple times. And my intent of
>>
>>   And I really prefer having deferred printing for SysRq.
> 
> Always deferring printk() for everyone is not acceptable. It is one
> extreme between printk() reliability and speed in favor of the speed.
> But many people prefer reliability (high chance to see messages
> when the system goes down.

Second thing is about whether we can defer console_unlock() from specific
callers.

What I suggest is to enforce "never deferred" on e.g. SysRq-h and enforce
"always deferred" on e.g. SysRq-t. Since console_unlock() enforces flushing
of printk() buffer, users can trigger "SysRq-t" -> "SysRq-h" when SysRq-t
failed to flush printk() buffer.

> 
> IMHO, the only acceptable solution need to be configurable:
> 
>    + never deffer (debugging corner cases?)
>    + avoid softlockup (default on normal systems?)
>    + guarantee max time (throughput oriented systems)
>    + always deffer (real time, special usecases)

Is this about only SysRq messages? Or any printk() messages?
If this is about SysRq messages, I don't think "always defer" is
possible. We need a way to force flushing of printk() buffer when
"always deferred" SysRq messages did not get printed to consoles.

> 
> It might be based on Sergey's patchsets adding the offload logic
> into console_unlock().
> 
> IMHO, the most problematic thing is how to define the limit
> (lines?, characters?, time?). A limit bases on the data amount
> would also depend on console speed. Time based limit would be
> better but measuring time in console_unlock() is problematic
> (atomic context, possible deadlocks).

Which patch does "Sergey's patchsets adding the offload logic into
console_unlock()" refer to? As far as I am aware, any attempt to
"almost always" offload to a in_task() context will be unlikely
accepted (like Andrew Morton worried at
https://lkml.kernel.org/r/20160404155149.a3e3307def2d1315e2099c63@linux-foundation.org ).
I'm not expecting that we can define the limit appropriately, for
the amount of data which needs to be printed on to console is
unpredictable.

My should_defer_output() attempt offloads only when the caller is willing
to defer console_unlock(). oom_kill_process() and warn_alloc() would
generate less amount of data than SysRq-t, but these callers cannot make
forward progress until printk() returns. Thus, should_defer_output() helps
avoiding stalls at at least oom_kill_process() and warn_alloc() because
deferred printk() allows __ratelimit() based on e.g. frequency, amount of
data which is waiting for being printed to consoles. And per context
"defer printing to consoles if oops is not in progress but the caller is
willing to defer printing to consoles" control should be viable.

