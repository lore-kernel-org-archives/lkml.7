Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1193A2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfFTKDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:03:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64167 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:03:11 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5KA33mw058292;
        Thu, 20 Jun 2019 19:03:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Thu, 20 Jun 2019 19:03:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5KA2w9u058271
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 20 Jun 2019 19:03:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] hung_task: recover hung task warnings in next check
 interval
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        dvyukov@google.com
Cc:     linux-kernel@vger.kernel.org
References: <1561010100-14080-1-git-send-email-laoar.shao@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e5c695c9-2006-f2cb-e3e2-7ea8ee465817@i-love.sakura.ne.jp>
Date:   Thu, 20 Jun 2019 19:02:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561010100-14080-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/20 14:55, Yafang Shao wrote:
> When sys_hung_task_warnings reaches 0, the hang task messages will not
> be reported any more.

It is a common mistake that sys_hung_task_warnings is already 0 when
a real problem which should be reported occurred.

> 
> If the user want to get more hung task messages, he must reset
> kernel.hung_task_warnings to a postive integer or -1 with sysctl.

People are setting sys_hung_task_warnings to -1 in order to make sure
that the messages are printed.

> This is not a good way for the user.

But I don't think we should reset automatically.

> We'd better reset hung task warnings in the kernel, and then the user
> don't need to pay attention to this value.

I suggest changing the default value of sys_hung_task_warnings to -1.

> 
> With this patch, hung task warnings will be reset with
> sys_hung_task_warnings setting in evenry check interval.

Since it is uncommon that the messages are printed for more than 10
times for one check_hung_uninterruptible_tasks() call, this patch is
effectively changing to always print the messages (in other words,
setting -1).
