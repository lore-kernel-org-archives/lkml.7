Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F9EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EBD2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbfEXLne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:43:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35320 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390920AbfEXLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:43:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2778179wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4MhuplKsh2cfr1c0kMziw9CvqMrJuFy02MaD7UagMkE=;
        b=irDDYA2QPb/+dc2pQyoUub9LteuFt4Kr5AZvGcoJnFvIp5b5l3OQ/uqX+AjOsG59+0
         8j8B/Anu1Fq0YjSeWtP3IKAQTpGS5V/xJDc1+ebWXkoMGr5ZibOigYndt2E+SsUu2mLL
         5jF3LVUM8ac7OtZJTzYVW0xt//gALMGRkS0SxiAzmctM6XfnrebV8Gy3Pe32V5QKoUuk
         ELYiaClGkdTF9CFGEuYQik1/FlCcdJ0DGq+DoupOaKMDkVi+06r43fsX+ncRbtS79Q7f
         ec/5eiGzVY+5mtOcXhPzYp6Y4UK/VkusB02rqFCQ6oShShdIV3dvxMlYzx77eQey4f8e
         Q/jw==
X-Gm-Message-State: APjAAAUiwx95VwrCcUlvVKfTkG/wy+njTBxGbBsysEtA45x0UxJSpBHN
        0wYjB71SOUdtcmgh5bVQnUeH1A==
X-Google-Smtp-Source: APXvYqwZMSr/sYy/ez2SXZXSB3a872fTti61RjoFAUJzrGKSS+yELZ08HOeIEtCBoxG4PlBos2gmkQ==
X-Received: by 2002:a1c:414:: with SMTP id 20mr15495759wme.84.1558698211400;
        Fri, 24 May 2019 04:43:31 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s127sm2254385wmf.48.2019.05.24.04.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 04:43:30 -0700 (PDT)
Date:   Fri, 24 May 2019 13:43:29 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190524114329.hujd3qvtusz6uyfk@butterfly.localdomain>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
 <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
 <20190521124310.GM18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521124310.GM18914@techsingularity.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:43:10PM +0100, Mel Gorman wrote:
> On Tue, May 21, 2019 at 05:01:06AM -0400, Justin Piszcz wrote:
> > On Mon, May 20, 2019 at 7:56 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Sun, May 12, 2019 at 04:27:45AM -0400, Justin Piszcz wrote:
> > > > Hello,
> > > >
> > > > I've turned off zram/zswap and I am still seeing the following during
> > > > periods of heavy I/O, I am returning to 5.0.xx in the meantime.
> > > >
> > > > Kernel: 5.1.1
> > > > Arch: x86_64
> > > > Dist: Debian x86_64
> > > >
> > > > [29967.019411] BUG: unable to handle kernel paging request at ffffea0002030000
> > > > [29967.019414] #PF error: [normal kernel read fault]
> > > > [29967.019415] PGD 103ffee067 P4D 103ffee067 PUD 103ffed067 PMD 0
> > > > [29967.019417] Oops: 0000 [#1] SMP PTI
> > > > [29967.019419] CPU: 10 PID: 77 Comm: khugepaged Tainted: G
> > > >    T 5.1.1 #4
> > > > [29967.019420] Hardware name: Supermicro X9SRL-F/X9SRL-F, BIOS 3.2 01/16/2015
> > > > [29967.019424] RIP: 0010:isolate_freepages_block+0xb9/0x310
> > > > [29967.019425] Code: 24 28 48 c1 e0 06 40 f6 c5 1f 48 89 44 24 20 49
> > > > 8d 45 79 48 89 44 24 18 44 89 f0 4d 89 ee 45 89 fd 41 89 c7 0f 84 ef
> > > > 00 00 00 <48> 8b 03 41 83 c4 01 a9 00 00 01 00 75 0c 48 8b 43 08 a8 01
> > > > 0f 84
> > >
> > > If you have debugging symbols installed, can you translate the faulting
> > > address with the following?
> > >
> > > ADDR=`nm /path/to/vmlinux-or-debuginfo-file | grep "t isolate_freepages_block\$" | awk '{print $1}'`
> > > addr2line -i -e vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))`
> > 
> > Another event this morning, this occurred when copying a single ~25GB
> > backup file from one block device device (3ware HW RAID) to a SW
> > RAID-1 (mdadm):
> > 
> > With this event, it was a fault and khugepaged is not stuck at 100%
> > but this may be related as the stack trace is similar where
> > compaction_alloc is utilizing most of the CPU:
> > https://lkml.org/lkml/2019/5/9/225
> > 
> > # ADDR=`nm /usr/src/linux/vmlinux | grep "t isolate_freepages_block\$"
> > | awk '{print $1}'`
> > # echo $ADDR
> > ffffffff812274f0
> > # addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0x83d))`
> > compaction.c:?
> > # addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0x8d0))`
> > compaction.c:?
> > 
> 
> Please use the offset 0xb9
> 
> addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))
> 
> -- 
> Mel Gorman
> SUSE Labs

Cc'ing myself since i observe such a behaviour sometimes right after KVM
VM is launched. No luck with reproducing it on demand so far, though.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
