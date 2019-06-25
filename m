Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDCC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561447787;
	bh=R4jNzRQw37JgF7x95aIa/iCUdU/hLNUV6njbwOGFUoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wHlevZq00q01WVNQFk+P0yAVDtX+wpB9nXQaZQpgkjFXOIfjsXi03oissecRb61gC
	 BTCm7Nw2Nwiz2nz5dJWvwU/S/fn3KyU36V3wxaDiEOAfVPpvYECKLQzKB0n+dUou2G
	 lcrh4SdS4R8ZpC6ksM8ANIlXAVkqhoh2jlYgfvzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfFYH3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfFYH3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:29:45 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5588A20652;
        Tue, 25 Jun 2019 07:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561447784;
        bh=R4jNzRQw37JgF7x95aIa/iCUdU/hLNUV6njbwOGFUoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHYNPRO/hinfLrR7z1SR0mHpmHIrfaRWS31ESWqPRJaJ8Ehpq9EOUe2Bb5a00iCi0
         9/N26lribFV1OcOLiKsUZJepFIlOjVDFsbK8cqLDnZW7f49yMOOPPc/hec7bkMx0sa
         UV3xp5worvMmtfKMzi1SJeJBIXvxvmJHzB2s2pzA=
Date:   Tue, 25 Jun 2019 00:29:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     bpf@vger.kernel.org
Cc:     syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [net/bpf] Re: WARNING in mark_lock
Message-ID: <20190625072942.GB30940@sol.localdomain>
References: <0000000000005aedf1058c1bf7e8@google.com>
 <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+bpf list]

On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> On Mon, 24 Jun 2019, syzbot wrote:
> 
> > Hello,
> 
> CC++ Peterz 
> 
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=99c104b0092a557b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a861f52659ae2596492b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b24f6a00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com

The syz repro looks bpf related, and essentially the same repro is in lots of
other open syzbot reports which I've assigned to the bpf subsystem...
https://lore.kernel.org/lkml/20190624050114.GA30702@sol.localdomain/

{"threaded":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfmt_misc":true,"close_fds":true,"tmpdir":true,"segv":true}
bpf$MAP_CREATE(0x0, &(0x7f0000000280)={0xf, 0x4, 0x4, 0x400, 0x0, 0x1}, 0x3c)
socket$rxrpc(0x21, 0x2, 0x800000000a)
r0 = socket$inet6_tcp(0xa, 0x1, 0x0)
setsockopt$inet6_tcp_int(r0, 0x6, 0x13, &(0x7f00000000c0)=0x100000001, 0x1d4)
connect$inet6(r0, &(0x7f0000000140), 0x1c)
bpf$MAP_CREATE(0x0, &(0x7f0000000000)={0x5}, 0xfffffffffffffdcb)
bpf$MAP_CREATE(0x2, &(0x7f0000003000)={0x3, 0x0, 0x77fffb, 0x0, 0x10020000000, 0x0}, 0x2c)
setsockopt$inet6_tcp_TCP_ULP(r0, 0x6, 0x1f, &(0x7f0000000040)='tls\x00', 0x4)
