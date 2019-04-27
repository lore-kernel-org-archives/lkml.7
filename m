Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB338C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF82087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfD0Wdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 18:33:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57312 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD0Wdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 18:33:41 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3RMX5IO080649;
        Sun, 28 Apr 2019 07:33:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sun, 28 Apr 2019 07:33:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3RMX0QS080634
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 28 Apr 2019 07:33:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
To:     David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, Cong Wang <xiyou.wangcong@gmail.com>,
        syzbot <syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com>,
        ddstreet@ieee.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000007d22100573d66078@google.com>
 <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg>
 <4684eef5-ea50-2965-86a0-492b8b1e4f52@I-love.SAKURA.ne.jp>
 <9d430543-33c3-0d9b-dc77-3a179a8e3919@I-love.SAKURA.ne.jp>
 <920ebaf1-ee87-0dbb-6805-660c1cbce3d0@I-love.SAKURA.ne.jp>
 <cc054b5c-4e95-8d30-d4bf-9c85f7e20092@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <15b353e9-49a2-f08b-dc45-2e9bad3abfe2@i-love.sakura.ne.jp>
Date:   Sun, 28 Apr 2019 07:33:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cc054b5c-4e95-8d30-d4bf-9c85f7e20092@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/04/28 2:16, David Ahern wrote:
> On 4/26/19 7:43 AM, Tetsuo Handa wrote:
>> This bug is the top crasher for syzbot and thus we want to fix. I need your
>> response regarding commit caacf05e5ad1abf0 ("ipv4: Properly purge netdev
>> references on uncached routes.") why you chose "a loopback device in that
>> namespace".
>>
>> On 2019/04/16 23:00, Tetsuo Handa wrote:
>>> Hello, David S. Miller.
>>>
>>> I have a question regarding rt_flush_dev() introduced by commit caacf05e5ad1abf0
>>> ("ipv4: Properly purge netdev references on uncached routes.") which went to
>>> Linux 3.6-rc1. That commit started replacing "a device to unregister" with
>>> "a loopback device in that namespace", but there is no description why that
>>> commit chose "a loopback device in that namespace". If a device to unregister
>>> is "a loopback device in that namespace" itself, rt_flush_dev() becomes a no-op
>>> because dev == net->loopback_dev from the beginning. Apart from a problem that
>>> usage count keeps increasing because dev_put(rt->dst.dev) is not called after
>>> rt->dst.dev was replaced with a loopback device, replacing "a device to unregister"
>>> with "a loopback device in init namespace" (like shown below) avoids this problem.
>>>
> 
> Moving resource use to the init namespace is not really solving the core
> problem. It would be better to understand what changes are needed to the
> shutdown sequence of a namespace to ensure proper cleanup.

I know.

> 
> In this case why are dst entries not getting cleaned up? This one is
> referring to entries on the uncached list. What is using the dst entry
> and why isn't it getting released?
> 

I'm waiting for davem why it is safe to move the dst entry from
"a device to unregister" to "a loopback device in that namespace".
I'm waiting for an explanation how the dst entry which was moved to
"a loopback device in that namespace" is released (i.e. what the
expected shutdown sequence is).

