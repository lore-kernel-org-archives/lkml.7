Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76239C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F93820862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfEOOeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:34:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59681 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfEOOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:34:17 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4FEWZXf001426;
        Wed, 15 May 2019 23:32:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Wed, 15 May 2019 23:32:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4FEWLke001195
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 15 May 2019 23:32:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Monitor change of console loglevel.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <1557501546-10263-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190514091917.GA26804@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3e2cf31d-25af-e7c3-b308-62f64d650974@i-love.sakura.ne.jp>
Date:   Wed, 15 May 2019 23:32:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514091917.GA26804@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/14 18:19, Sergey Senozhatsky wrote:
> On (05/11/19 00:19), Tetsuo Handa wrote:
>> We are seeing syzbot reports [1] where printk() messages prior to panic()
>> are missing for unknown reason. To test whether it is due to some testcase
>> changing console loglevel, let's panic() as soon as console loglevel has
>> changed. This patch is intended for testing on linux-next.git only, and
>> will be removed after we found what is wrong.
> 
> Clone linux-next, apply the patch, push to a github/gitlab repo,
> configure syzbot to pull from github/gitlab?

I think that it is practically impossible to do so from the point of
view of automation.

>                                              Adding temp patches
> to linux-next is hard and apparently not exactly what linux-next
> is used for these days.

Currently Andrew Morton is carrying "linux-next.git only" patches
(a.k.a. CONFIG_DEBUG_AID_FOR_SYZBOT patches) via mmotm tree.

It would be nice if linux-next.git can directly import temp patches
using "quilt push -a" on patches from a subversion repository. Then,
we can casually add/remove/update temp patches like this.

