Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB0C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E330A2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfEUMnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:43:14 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:50523 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfEUMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:43:13 -0400
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id B674F1C1C4C
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:43:11 +0100 (IST)
Received: (qmail 31860 invoked from network); 21 May 2019 12:43:11 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 May 2019 12:43:11 -0000
Date:   Tue, 21 May 2019 13:43:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190521124310.GM18914@techsingularity.net>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
 <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:01:06AM -0400, Justin Piszcz wrote:
> On Mon, May 20, 2019 at 7:56 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Sun, May 12, 2019 at 04:27:45AM -0400, Justin Piszcz wrote:
> > > Hello,
> > >
> > > I've turned off zram/zswap and I am still seeing the following during
> > > periods of heavy I/O, I am returning to 5.0.xx in the meantime.
> > >
> > > Kernel: 5.1.1
> > > Arch: x86_64
> > > Dist: Debian x86_64
> > >
> > > [29967.019411] BUG: unable to handle kernel paging request at ffffea0002030000
> > > [29967.019414] #PF error: [normal kernel read fault]
> > > [29967.019415] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
> > > [29967.019417] Oops: 0000 [#1] SMP PTI
> > > [29967.019419] CPU: 10 PID: 77 Comm: khugepaged Tainted: G
> > >    T 5.1.1 #4
> > > [29967.019420] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
> > > [29967.019424] RIP: 0010:isolate_freepages_block+0xb9/0x310
> > > [29967.019425] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
> > > 8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
> > > 00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
> > > 0f 84
> >
> > If you have debugging symbols installed, can you translate the faulting
> > address with the following?
> >
> > ADDR=`nm /path/to/vmlinux-or-debuginfo-file | grep "t isolate_freepages_block\$" | awk '{print $1}'`
> > addr2line -i -e vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))`
> 
> Another event this morning, this occurred when copying a single ~25GB
> backup file from one block device device (3ware HW RAID) to a SW
> RAID-1 (mdadm):
> 
> With this event, it was a fault and khugepaged is not stuck at 100%
> but this may be related as the stack trace is similar where
> compaction_alloc is utilizing most of the CPU:
> https://lkml.org/lkml/2019/5/9/225
> 
> # ADDR=`nm /usr/src/linux/vmlinux | grep "t isolate_freepages_block\$"
> | awk '{print $1}'`
> # echo $ADDR
> ffffffff812274f0
> # addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0x83d))`
> compaction.c:?
> # addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0x8d0))`
> compaction.c:?
> 

Please use the offset 0xb9

addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))

-- 
Mel Gorman
SUSE Labs
