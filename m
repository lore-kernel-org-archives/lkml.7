Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A24C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98985222A4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574136393;
	bh=h3O05lBsTS2ujFG2b7XJbkSMdiqsVY8miz0OJT9ljAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UIjkK/hVTQjngfP0fTFBGmUWO7mstMk9yQWXLX7z6ju1U0z4F4lX/BL2PV/6iiqbm
	 Ifu2A0A5D3+6HIZuibaesYASTRZxmMEl7kPR0Uf1V2XhZlbqkRvQDzpQH2VpmaSsZo
	 VhPXTT+RSu1/yoCGB0RiI2rhvJcl0MZQek57zvBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKSEGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfKSEGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:06:32 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26BC522316;
        Tue, 19 Nov 2019 04:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574136391;
        bh=h3O05lBsTS2ujFG2b7XJbkSMdiqsVY8miz0OJT9ljAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+wRyXD2zkHzq/hfU2wpIHEKPrRjEnfGHdPYpW6XIAGvEiJnMIO1aOU38pEBXDBJf
         3dZtX+Fxj4RlMNrhWsb05DRyCbiqi9cngiD2oWhJz18y/EVOPgYUjdzC5iFJaYuj3/
         VnSB9m7TpKXSzZSzP1klBNd6sjyAafs5+BJnsBKw=
Date:   Mon, 18 Nov 2019 20:06:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+a0fc447639c6ffa66b59@syzkaller.appspotmail.com>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in pagemap_pmd_range
Message-ID: <20191119040629.GA163020@sol.localdomain>
References: <000000000000ca5b3f0596a21e0c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ca5b3f0596a21e0c@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trimmed down ridiculous Cc list]

On Tue, Nov 05, 2019 at 03:52:08PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    51309b9d Add linux-next specific files for 20191105
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ad1658e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
> dashboard link: https://syzkaller.appspot.com/bug?extid=a0fc447639c6ffa66b59
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e5f92e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c65bcce00000
> 
> The bug was bisected to:
> 
> commit 181be542ef3c9ca495500143d4c23f4d58beb5ab
> Author: Steven Price <steven.price@arm.com>
> Date:   Mon Nov 4 22:57:54 2019 +0000
> 
>     mm: pagewalk: allow walking without vma
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11341968e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=13341968e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15341968e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a0fc447639c6ffa66b59@syzkaller.appspotmail.com
> Fixes: 181be542ef3c ("mm: pagewalk: allow walking without vma")
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8839 Comm: syz-executor009 Not tainted 5.4.0-rc6-next-20191105
> #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:pmd_trans_huge_lock include/linux/huge_mm.h:219 [inline]
> RIP: 0010:pagemap_pmd_range+0x83/0x1e40 fs/proc/task_mmu.c:1373

From some quick tests, this seems to have been fixed by
mm-pagewalk-allow-walking-without-vma-v15
(http://lkml.kernel.org/r/20191101140942.51554-13-steven.price@arm.com).
And it's consistent with syzbot last seeing this crash on next-20191105.

As this fix will be folded in, let's invalidate this syzbot bug report:

#syz invalid
