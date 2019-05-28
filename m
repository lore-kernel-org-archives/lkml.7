Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC40C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B912E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfE1IDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:03:01 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55478 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfE1IDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:03:00 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4S82x0a078820;
        Tue, 28 May 2019 17:02:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Tue, 28 May 2019 17:02:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4S82wUl078817
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 28 May 2019 17:02:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
Date:   Tue, 28 May 2019 17:02:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528042208.GD26865@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/28 13:22, Sergey Senozhatsky wrote:
> On (05/28/19 12:21), Tetsuo Handa wrote:
> [..]
>> What I suggested in my proposal ("printk: Introduce "store now but print later" prefix." at
>> https://lore.kernel.org/lkml/1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/T/#u )
>> is "whether the caller wants to defer printing to consoles regarding
>> this printk() call". And your suggestion is "whether the caller wants
>> to apply ignore_loglevel regarding this printk() call".
> 
> I'm not sure about "store now but print later" here. What Dmitry is
> talking about:
> 
>      bump console_loglevel on *this* particular CPU only,
>      not system-wide.
>      /* Which is implemented in a form of - all messages from this-CPU
>       * only should be printed regardless the loglevel, the rest should
>       * pass the usual suppress_message_printing() check. */

Dmitry's patch is changing only the header line (in other words, per printk() call).
Since op_p->handler(key) is out of KERN_UNSUPPRESSED effect, the body lines might
not be printed. I think that we need a way to pass KERN_UNSUPPRESSED from printk()
calls invoked from op_p->handler(key).

You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
context information. But doesn't such attempt resemble find_printk_buffer() ?
