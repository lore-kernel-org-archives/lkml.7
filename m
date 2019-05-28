Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D3C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3220883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1KQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:16:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59231 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfE1KQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:16:00 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4SAFvSC051587;
        Tue, 28 May 2019 19:15:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Tue, 28 May 2019 19:15:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4SAFknH051539
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 28 May 2019 19:15:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
 <20190528084825.GA9676@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
Date:   Tue, 28 May 2019 19:15:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528084825.GA9676@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/28 17:51, Sergey Senozhatsky wrote:
>> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
>> context information. But doesn't such attempt resemble find_printk_buffer() ?
> 
> Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
> line is hardly possible. At the same time I'd really prefer not
> to have buffering for sysrq.

I don't think it is hardly possible. And I really prefer having
deferred printing for SysRq.

SysRq is triggered by writing to /proc/sysrq-trigger or typing special keys
on the keyboard. This means that SysRq can be triggered by administrator's
will, and SysRq can be repeated/retried by administrator's will. Therefore,
allowing SysRq-t to write to consoles after leaving the atomic context is
an improvement. My proposal allows deferred printing for SysRq, dump_header()
and warn_alloc(). We can try to wake up console_writer kernel thread upon
leaving the atomic context. If the kernel is unhealthy enough to make
console_writer kernel thread defunctional, administrator can issue other
SysRq in order to forcibly write to consoles.

Is the attempt of making printk() completely asynchronous going to be resumed?
I think that "automatically asynchronous" won't be accepted, and I think that
at best "explicitly asynchronous" (by allowing the caller to explicitly say
it using printk() argument) is possible. (Maybe "asynchronous by default" and
"explicitly synchronous" is possible. But "explicitly synchronous" would be
told by using printk() argument rather than by implicit/global printk context
information...)

Anyway, forcing SysRq output to apply ignore_loglevel will be doable using
printk() argument.

