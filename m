Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCEB21852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCNOMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:12:53 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:27348 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfCNOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:12:51 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2EECm0H079546;
        Thu, 14 Mar 2019 23:12:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Thu, 14 Mar 2019 23:12:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2EECmbv079543
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 14 Mar 2019 23:12:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
X-Mozilla-News-Host: news://news.gmane.org:119
In-Reply-To: <20190308150914.ifqp36en3pyd4ljy@pathway.suse.cz>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Calvin Owens <calvinowens@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Message-ID: <c7a9c83c-524d-c0da-a355-6cd4b7ec690c@I-love.SAKURA.ne.jp>
Date:   Thu, 14 Mar 2019 23:12:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek wrote:
> It might be even more straightforward when the per-console value
> defines the effective console level. I mean the following semantic:
> 
>    + "console_loglevel" would define the default loglevel used
>      by consoles at runtime.
> 
>    + the per-console loglevel could override the default
>      console_loglevel.
> 
>    + We would need a custom handler for the sysctl "console_loglevel".
>      It would write the given value to the global console_loglevel
>      variable and for all already registered consoles (con->loglevel).

But some functions change console_loglevel without sysctl (e.g.
console_verbose() when reporting hung tasks and panic()). Should
con->loglevel be changed (which might result in too much messages to
slow consoles) when console_loglevel changes?

> 
>      The value will be used also for all newly registered consoles
>      when they do not have any custom one.
> 
> 
>    + The handler for "loglevel" early param should behave the same
>      as the sysctl handler.
> 
> 
> IMHO, there is no perfect solution. The advantage of the above
> proposal is that you "see" and "use" exactly what you "set".
