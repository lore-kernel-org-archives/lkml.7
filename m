Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55858C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F41D20656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfLDUwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:52:31 -0500
Received: from relay.sw.ru ([185.231.240.75]:50772 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbfLDUwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:52:31 -0500
Received: from [192.168.15.5]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1icbcl-0001ny-LQ; Wed, 04 Dec 2019 23:51:51 +0300
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Dmitry Vyukov <dvyukov@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, ghalat@redhat.com,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000002cfc3a0598d42b70@google.com>
 <CAKMK7uFAfw4M6B8WaHx6FBkYDmUBTQ6t3D8RE5BbMt=_5vyp9A@mail.gmail.com>
 <CACT4Y+aV9vzJ6gs9r2RAQP+dQ_vkOc5H6hWu-prF1ECruAE_5w@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6632ddb6-37bf-dc42-e355-2443c17e6da0@virtuozzo.com>
Date:   Wed, 4 Dec 2019 23:49:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aV9vzJ6gs9r2RAQP+dQ_vkOc5H6hWu-prF1ECruAE_5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/19 9:33 AM, Dmitry Vyukov wrote:
> On Tue, Dec 3, 2019 at 11:37 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>>
>> On Tue, Dec 3, 2019 at 11:25 PM syzbot
>> <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10bfe282e00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4455ca3b3291de891abc
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11181edae00000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105cbb7ae00000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com
>>>
>>> ==================================================================
>>> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
>>> BUG: KASAN: slab-out-of-bounds in fbcon_get_font+0x2b2/0x5e0
>>> drivers/video/fbdev/core/fbcon.c:2465
>>> Read of size 16 at addr ffff888094b0aa10 by task syz-executor414/9999
>>
>> So fbcon allocates some memory, security/tomoyo goes around and frees
>> it, fbcon goes boom because the memory is gone. I'm kinda leaning
>> towards "not an fbcon bug". Adding relevant security folks and mailing
>> lists.
>>
>> But from a very quick look in tomoyo it loosk more like "machine on
>> fire, random corruption all over". No idea what's going on here.
> 
> Hi Daniel,
> 
> This is an out-of-bounds access, not use-after-free.
> I don't know why we print the free stack at all (maybe +Andrey knows),
> but that's what KASAN did from day one. I filed
> https://bugzilla.kernel.org/show_bug.cgi?id=198425 which I think is a
> good idea, I will add your confusion as a data point :)

Because we have that information (free stack) and it usually better to provide
all the information we have rather than hide it. You never known what information
might be needed to fix the bug.
Free memory might be reused and what we report as OOB might be an UAF and free stack
could be useful in such case.
