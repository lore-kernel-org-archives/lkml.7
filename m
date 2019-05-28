Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFD5C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D700120675
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 03:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfE1DXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 23:23:06 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52677 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfE1DXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 23:23:05 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4S3LsiP018860;
        Tue, 28 May 2019 12:21:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Tue, 28 May 2019 12:21:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4S3Lo5X018841
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 28 May 2019 12:21:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20190528002412.1625-1-dima@arista.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
Date:   Tue, 28 May 2019 12:21:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528002412.1625-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/28 9:24, Dmitry Safonov wrote:
> Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> Make sysrq print the headers unsuppressed instead of changing
> console_loglevel.

I think that kdb also wants to use KERN_UNSUPPRESSED for making sure
that messages are printed. But that user calls dump function which is
indirectly calling printk() many times. Thus, I think that we need a
way to explicitly pass "how the message should be treated" as a
function argument.

What I suggested in my proposal ("printk: Introduce "store now but print later" prefix." at
https://lore.kernel.org/lkml/1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/T/#u )
is "whether the caller wants to defer printing to consoles regarding
this printk() call". And your suggestion is "whether the caller wants
to apply ignore_loglevel regarding this printk() call".

