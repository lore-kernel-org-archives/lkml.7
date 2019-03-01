Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AF1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F335120851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfCAKci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:32:38 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:23150 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCAKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:32:38 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x21AVx5x012699;
        Fri, 1 Mar 2019 19:31:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 01 Mar 2019 19:31:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x21AVxEo012696
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 1 Mar 2019 19:31:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Remove no longer used LOG_PREFIX.
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b830aae9-766f-54d2-840b-f70da3d1215d@i-love.sakura.ne.jp>
Date:   Fri, 1 Mar 2019 19:31:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can this patch go to Linux 5.1?

On 2019/02/22 18:59, Tetsuo Handa wrote:
> When commit 5becfb1df5ac8e49 ("kmsg: merge continuation records while
> printing") introduced LOG_PREFIX, we used KERN_DEFAULT etc. as a flag
> for setting LOG_PREFIX in order to tell whether to call cont_add()
> (i.e. whether to append the message to "struct cont").
> 
> But since commit 4bcc595ccd80decb ("printk: reinstate KERN_CONT for
> printing continuation lines") inverted the behavior (i.e. don't append
> the message to "struct cont" unless KERN_CONT is specified) and commit
> 5aa068ea4082b39e ("printk: remove games with previous record flags")
> removed the last LOG_PREFIX check, setting LOG_PREFIX via KERN_DEFAULT
> etc. is no longer meaningful.
> 
> Therefore, we can remove LOG_PREFIX and make KERN_DEFAULT empty string.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/kern_levels.h | 2 +-
>  include/linux/printk.h      | 1 -
>  kernel/printk/printk.c      | 6 +-----
>  3 files changed, 2 insertions(+), 7 deletions(-)
