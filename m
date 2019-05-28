Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B350C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C02206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfE1PV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:21:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51032 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfE1PV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:21:57 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4SFLt65048096;
        Wed, 29 May 2019 00:21:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Wed, 29 May 2019 00:21:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4SFLtIf048093
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 29 May 2019 00:21:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV> <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <e564ee00-6a93-defd-4eab-e306bbfe8b01@i-love.sakura.ne.jp>
 <20190528150345.di2knfzmqfbwro3y@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e0016343-2091-2478-dde3-3136a60b0942@i-love.sakura.ne.jp>
Date:   Wed, 29 May 2019 00:21:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528150345.di2knfzmqfbwro3y@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/29 0:03, Petr Mladek wrote:
>> But is context dependent buffer large enough to hold SysRq-t output?
>> I think that only main logbuf can become large enough to hold SysRq-t output.
> 
> SysRq messages are stored directly into the main log buffer.
> 
> The limited per-CPU buffers are needed only in printk_safe
> and NMI context. We discussed it here because KERN_UNSUPPRESSED
> allows to pass the information even from this context.
> 
>> We can add KERN_UNSUPPRESSED to SysRq's header line. But I don't think
>> that we can automatically add KERN_UNSUPPRESSED to SysRq's body lines
>> based on some context information. If we want to avoid manipulating
>> console_loglevel, we need to think about how to make sure that
>> KERN_UNSUPPRESSED is added to all lines from such context without
>> overflowing capacity of that buffer.
> 
> We could set this context in printk_context per-CPU variable.
> 
> Then we could easily add the set per-message flag in
> vprintk_store() for the normal/atomic context. And we
> could store an extra KERN_UNSUPPRESSED in printk_safe_log_store()
> for printk_safe and NMI context.

Now I got what you are trying to do. Borrow per-CPU printk_context
flags for automatically prefixing KERN_UNSUPPRESSED, based on an
assumption that any message sent during that per-CPU printk_context
flag set is important enough. Then, what we need to be careful is
nesting of setting/clearing of that flag, for NMI handler might be
called during SysRq operation is in progress. We unconditionally
prefix KERN_UNSUPPRESSED if NMI?

