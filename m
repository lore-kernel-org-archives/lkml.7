Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0EBC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A711620989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEIKkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:40:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59333 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEIKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:40:43 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x49AeTa9014749;
        Thu, 9 May 2019 19:40:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 09 May 2019 19:40:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x49AeSUU014742
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 9 May 2019 19:40:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+bosgWpJ=s9_hQ-Jg_XJoSHR9S-zC3es-2F=FTRppEncA@mail.gmail.com>
 <CACT4Y+aM0P-G-Oza-oYbyq2firAjvb-nJ0NX21p8U9TL3-FExQ@mail.gmail.com>
 <20190318125019.GA2686@tigerII.localdomain>
 <CACT4Y+ZedhD+=-YyvphZvLCcCF3FM0YAjXX54K2kMkhNmV4axw@mail.gmail.com>
 <20190318140937.GA29374@tigerII.localdomain>
 <CACT4Y+Z_+H09iOPzSzJfs=_D=dczk22gL02FjuZ6HXO+p0kRyA@mail.gmail.com>
 <20190319123500.GA18754@tigerII.localdomain>
 <CACT4Y+ZhHvsVZh1pKzK1tn-P78rOssOz=7eWkXz7z2Sh1JscdA@mail.gmail.com>
 <127c9c3b-f878-174f-7065-66dc50fcabcf@i-love.sakura.ne.jp>
 <20190509095823.GA23572@jagdpanzerIV> <20190509101830.GB23572@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1f0f2e88-a6ed-4bb8-4e91-869708c8dc58@i-love.sakura.ne.jp>
Date:   Thu, 9 May 2019 19:40:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509101830.GB23572@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/05/09 19:18, Sergey Senozhatsky wrote:
> What are these lines right before the kernel panic output?
> TTY writes (user space logging)?

I guess that the user space is calling printf() on stdout
which will be readable as console output.

> 
> 
> 03:54:05 executing program 5:
> syz_mount_image$xfs(&(0x7f0000000000)='xfs\x00', &(0x7f0000000040)='./file0\x00', 0x0, 0x0, 0x0, 0xe003, &(0x7f00000005c0)={[{@nolargeio='nolargeio'}]})
> 
> 03:54:06 executing program 2:
> syz_emit_ethernet(0x66, &(0x7f0000000080)={@local, @random="029cce98941b", [], {@ipv6={0x86dd, {0x0, 0x6, 'v`Q', 0x30, 0x3a, 0xffffffffffffffff, @remote={0xfe, 0x80, [0x29c, 0x0, 0x700, 0x5], 0xffffffffffffffff}, @mcast2={0xff, 0x2, [0x0, 0xfffffffffffff000]}, {[], @icmpv6=@dest_unreach={0xffffff86, 0x0, 0x0, 0x0, [0x7], {0x0, 0x6, "c5961e", 0x0, 0x0, 0x0, @mcast1={0xff, 0x1, [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x3, 0x0, 0x0, 0x8906], 0x8200}, @mcast2}}}}}}}, 0x0)
> 
> [ 2396.035331][T10223] Kernel panic - not syncing: panic_on_warn set ...
> [ 2396.042217][T10223] CPU: 0 PID: 10223 Comm: syz-executor.1 Not tainted 5.1.0-next-20190507 #2
> 
> 
> Hmm... Dunno... Don't really have any explanations yet...
> 
> Can you add
> 
> 	if (oops_in_progress)
> 		return IRQ_HANDLED;
> 
> to you console driver's IRQ handler (xmit TX/RX path)? Just to
> check if this will change anything...

The first userspace timestamp available is

  03:51:19 executing program 2:
  syz_emit_ethernet(0x66, &(0x7f0000000080)={@local, @random="029cce98941b", [], {@ipv6={0x86dd, {0x0, 0x6, 'v`Q', 0x30, 0x3a, 0xffffffffffffffff, @remote={0xfe, 0x80, [0x29c, 0x0, 0x700, 0x5], 0xffffffffffffffff}, @mcast2={0xff, 0x2, [0x0, 0xfffffffffffff000]}, {[], @icmpv6=@dest_unreach={0xffffff86, 0x0, 0x0, 0x0, [0x7], {0x0, 0x6, "c5961e", 0x0, 0x0, 0xf5ffffff00000000, @mcast1={0xff, 0x1, [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x3], 0x8200}, @mcast2}}}}}}}, 0x0)

which means that there was no printk() message for nearly 3 minutes.
Can't be oops_in_progress for such long period.

Since printk() timestamp says that the uptime is nearly 40 minutes, I think
that something changed console loglevel (in a way console_verbose() from
panic() can restore) many minutes ago from the crash...

