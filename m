Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D0DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F37F20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbfETL4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:56:12 -0400
Received: from outbound-smtp06.blacknight.com ([81.17.249.39]:35233 "EHLO
        outbound-smtp06.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730534AbfETL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:56:12 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id B003198AF4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:56:10 +0000 (UTC)
Received: (qmail 22741 invoked from network); 20 May 2019 11:56:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 May 2019 11:56:10 -0000
Date:   Mon, 20 May 2019 12:56:08 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190520115608.GK18914@techsingularity.net>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 04:27:45AM -0400, Justin Piszcz wrote:
> Hello,
> 
> I've turned off zram/zswap and I am still seeing the following during
> periods of heavy I/O, I am returning to 5.0.xx in the meantime.
> 
> Kernel: 5.1.1
> Arch: x86_64
> Dist: Debian x86_64
> 
> [29967.019411] BUG: unable to handle kernel paging request at ffffea0002030000
> [29967.019414] #PF error: [normal kernel read fault]
> [29967.019415] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
> [29967.019417] Oops: 0000 [#1] SMP PTI
> [29967.019419] CPU: 10 PID: 77 Comm: khugepaged Tainted: G
>    T 5.1.1 #4
> [29967.019420] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
> [29967.019424] RIP: 0010:isolate_freepages_block+0xb9/0x310
> [29967.019425] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
> 8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
> 00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
> 0f 84

If you have debugging symbols installed, can you translate the faulting
address with the following?

ADDR=`nm /path/to/vmlinux-or-debuginfo-file | grep "t isolate_freepages_block\$" | awk '{print $1}'`
addr2line -i -e vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))`

I haven't seen this particular error before so I want to see if the
faulting address could have anything to do with the randomising of
struct fields. Similarly a full dmesg log would be nice so I can see
what your memory layout looks like.

Thanks Justin.

-- 
Mel Gorman
SUSE Labs
