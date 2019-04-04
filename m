Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D7C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B621A2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfDDOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:51:44 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:50432 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728647AbfDDOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:51:43 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id C3iKhU0zJiLOmC3iOhoes4; Thu, 04 Apr 2019 16:51:41 +0200
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
To:     Alexander Potapenko <glider@google.com>,
        syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        mchehab@kernel.org, mchehab@s-opensource.com, mkl@pengutronix.de,
        Networking <netdev@vger.kernel.org>, socketcan@hartkopp.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000001c2b95057ad0935b@google.com>
 <000000000000462a4105848c8e12@google.com>
 <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <be750b12-ba3d-ecb4-541a-ca3669bb75d7@xs4all.nl>
Date:   Thu, 4 Apr 2019 16:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=VnXmDSc_QNqyEv7f7iwHXC6taBq1t55fHWZpLZ0EdiNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB4KEf5NAKsqemRpImhd1HXlnd6UwelePbBojk1goLetWk1/HmlujcMr48V5kEVzXAMAREDHeTmHXJ5bMHo4XV7bM/Un5yoCPq6oR1LYK1JnMcqUNGGx
 MROVgXOvom3aPGX7cxog/7hMspbcrw2yctvKRex75hQ2JvcIPMFUfBy61pDet7lYA7CVQHgzctYtcP6/Ad7PdFIFsweJ0x9cKuQ+Oxj7oMy9+et3K1gYKMBu
 Ib0ekAzhqKWP33FSkbfuh2ZXbg8sI7wzb8RmdT7xADekbSJbzmGWJYRBJnTJIYmQPBWmh+SHiJr5J2PrRLIUcxfpZIsRwMzy5VRokUw0QNBY9OrrLrBPYc9+
 IqvBrqXvo/Cprhq4qSxUKtCKtCPlppQ/yObIpI2bt6TkpcLaBP0YAKifN4qoJIAecp/TI2+LxbcTSfAfuAOAgwkkEMaTPTyqsk8uWCJvRnyHBkgIN97jFell
 ekzshOjg9J9ke5OIcEmibDx48C2oXT3Qkcq0lEI1y9vmu+bQ838eHGwpjtqGkl+t3TSTlVLVZ2/2+FamBa3uBHiHCpV6ZED1ds9peixiVALk4wJo4zm/4cJh
 mZg1PNyy1k94Owb5KMbVBd0u
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 4:47 PM, Alexander Potapenko wrote:
> On Wed, Mar 20, 2019 at 9:35 PM syzbot
> <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has bisected this bug to:
>>
>> commit 6d469a202ee73196d0df76025af80bd6a379e658
>> Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>> Date:   Sun May 14 17:07:21 2017 +0000
>>
>>      Merge tag 'v4.12-rc1' into patchwork
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12639fd7200000
>> start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
>> git tree:       upstream
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15639fd7200000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11639fd7200000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6c0effb5877f6b0344e2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312062b400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131bd093400000
>>
>> Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
>> Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000462a4105848c8e12%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
> 
> I believe this bug is caused by vivid_vid_cap_s_selection() calling
> kfree(dev->bitmap_cap).
> This makes little sense, as dev->bitmap_cap seems to be allocated
> using vzalloc().
> 

Yup, that should be vfree. There was a similar problem with bitmap_out that
I fixed, but it looks I missed this one. Can you make a patch?

Thanks,

	Hans
