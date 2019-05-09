Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB35C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA71208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEIK1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:27:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51452 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:27:04 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x49AQJ0k008063;
        Thu, 9 May 2019 19:26:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Thu, 09 May 2019 19:26:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x49AQJmY008060
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 9 May 2019 19:26:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <201903180527.x2I5RQVp009981@www262.sakura.ne.jp>
 <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
 <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
 <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
 <20190509095823.GA23572@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c7d1a923-a1cd-ca1e-e842-dd32b219c12f@i-love.sakura.ne.jp>
Date:   Thu, 9 May 2019 19:26:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509095823.GA23572@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/09 18:58, Sergey Senozhatsky wrote:
>> +#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
>> +static int initial_loglevel;
>> +static void check_loglevel(struct timer_list *timer)
>> +{
>> +	if (console_loglevel < initial_loglevel)
>> +		panic("Console loglevel changed (%d->%d)!", initial_loglevel,
>> +		      console_loglevel);
>> +	mod_timer(timer, jiffies + HZ);
>> +}
>> +static int __init loglevelcheck_init(void)
>> +{
>> +	static DEFINE_TIMER(timer, check_loglevel);
>> +
>> +	initial_loglevel = console_loglevel;
>> +	mod_timer(&timer, jiffies + HZ);
>> +	return 0;
>> +}
>> +late_initcall(loglevelcheck_init);
>> +#endif
> 
> I suppose this patch is for internal testing at Google only. I don't
> think we can consider upstreaming it.

Right. There is CONFIG_DEBUG_AID_FOR_SYZBOT option for testing at linux-next.git only.



> 
>> By the way, recently we are hitting false positives caused by "WARNING:"
>> string from not WARN() messages but plain printk() messages (e.g.
>>
>>   https://syzkaller.appspot.com/bug?id=31bdef63e48688854fde93e6edf390922b70f8a4
>>   https://syzkaller.appspot.com/bug?id=faae4720a75cadb8cd0dbda5c4d3542228d37340
>>
>> ) and we need to avoid emitting "WARNING:" string from plain printk() messages
>> during fuzzing testing. I guess we want to add something like
>> CONFIG_DEBUG_AID_FOR_SYZBOT to all kernels in order to mask such string...
> 
> I thought that we have MSG_FORMAT_SYSLOG exactly for things like these,
> so you can look at actual message level <%d> and then decide if it's a
> warning or a false alarm.

Since syzbot needs to use console output, message level is not available.

> 
> These are pr_info() level messages, but the text contains "WARNING: "
> 
> [..]
> pvr2_trace(PVR2_TRACE_ERROR_LEGS,
> 	   "WARNING: Detected a wedged cx25840 chip; the device will not work.");
> [..]
> 
> I would suggest to fix pvrusb2-i2c-core.c. I don't think we really
> want to $text =~ s/WARNING//g in printk.

Of course, I don't want to try $text =~ s/WARNING//g in printk().
What I meant is guard the callers like
https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git/commit/?h=next-tomoyo&id=5c6b31e31adc31bd12636b196d3311f845dcc9d8
using a kernel config option which will be acceptable for upstreaming, for
we need to apply to all kernels which syzbot is testing.

