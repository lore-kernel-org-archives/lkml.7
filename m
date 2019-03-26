Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71F120811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfCZX2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:28:22 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53538 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731619AbfCZX2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:28:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 05E5D22BFC;
        Tue, 26 Mar 2019 19:28:16 -0400 (EDT)
Date:   Wed, 27 Mar 2019 10:28:19 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     syzbot <syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com>
cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        funaho@jurai.org, geert@linux-m68k.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: rcu detected stall in __perf_sw_event
In-Reply-To: <00000000000036e81e058507565b@google.com>
Message-ID: <alpine.LNX.2.21.1903271021290.994@nippy.intranet>
References: <00000000000036e81e058507565b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, syzbot wrote:

> syzbot has bisected this bug to:
> 
> commit cf85d89562f39cc7ae73de54639f1915a9195b7a
> Author: Finn Thain <fthain@telegraphics.com.au>
> Date:   Fri May 25 07:34:36 2018 +0000
> 
>    m68k/mac: Enable PDMA for PowerBook 500 series
> 

Looks like a false positive. But if you really are running syzkaller on a 
PowerBook 500, you'll want to check that you have an FPU, otherwise a CPU 
erratum will probably mess up your results.

-- 

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1226cb8b200000
> start commit:   b0314565 Merge tag 'for_linus' of git://git.kernel.org/pub..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1126cb8b200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1626cb8b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
> dashboard link: https://syzkaller.appspot.com/bug?extid=a41ac89a0712acde0e84
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1707cd2f400000
> 
> Reported-by: syzbot+a41ac89a0712acde0e84@syzkaller.appspotmail.com
> Fixes: cf85d89562f3 ("m68k/mac: Enable PDMA for PowerBook 500 series")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
