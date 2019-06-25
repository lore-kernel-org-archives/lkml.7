Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84506C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BC7213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RRdkM+k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfFYOBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:01:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3PwAJTk+sBAtZBFdoInQvViDTwMss4ggvuDLkO528o0=; b=RRdkM+k8boZ+7CU1YF7K5iZbr
        NbapzGr+V4hA8g0ypn2aLr7G4woPUR7CB6AC2XW6Q9jhCJdsFbhgnnId0OZI4NCf+eQtE1DSZ47Fs
        SeKtO1sT3k+Co4WIUOA+2K3y0Ff0ckmHJksEVk/qIc0rxFzc8+Ngt4lgo7nIR8tav8gFRc3Dp3kGO
        BFQY19wvdnxhLuEhl/ke6dEnTiQDdCuuaiI46ARZHLooqCfrhLuHdwB/2F3gtxnFk4Xzw0lErOdp9
        dZTcNQRNZQ48xY0ko2kpezSMMzLbdP/cX6VMCh7Ox3WFKWJAwoAzIAyEswpEQ8kZ444zYzPvP+Hh0
        rhcuizvgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfm0p-0006aX-27; Tue, 25 Jun 2019 14:01:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65DCF202B4821; Tue, 25 Jun 2019 16:01:29 +0200 (CEST)
Date:   Tue, 25 Jun 2019 16:01:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in mark_lock
Message-ID: <20190625140129.GB3419@hirez.programming.kicks-ass.net>
References: <0000000000005aedf1058c1bf7e8@google.com>
 <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
 <20190625110301.GX3419@hirez.programming.kicks-ass.net>
 <20190625110609.GA3463@hirez.programming.kicks-ass.net>
 <CACT4Y+ZR9T9jGqx2aEijAzA8XP3W5gtGWtgubjW-WXBMirEAqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZR9T9jGqx2aEijAzA8XP3W5gtGWtgubjW-WXBMirEAqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:07:42PM +0200, Dmitry Vyukov wrote:
> On Tue, Jun 25, 2019 at 1:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 25, 2019 at 01:03:01PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> > > > On Mon, 24 Jun 2019, syzbot wrote:
> > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
> >
> > syzcaller folks; why doesn't the above link include the actual kernel
> > boot, but only the userspace bits starting at syzcaller start?
> >
> > I was trying to figure out the setup, but there's not enough information
> > here.
> 
> Hi Peter,
> 
> Usually there is too much after-boot output, so boot output is evicted
> anyway even if was preserved initially. Also usually it's not
> important (this is the first time this comes up). And also
> structurally boot is a separate procedure in syzkaller VM abstraction,
> a machine is booted, output is analyzed for potential crashes, then
> the machine is considered in a known good state and then some workload
> is started as a separate procedure and new output capturing starts
> from this point again.

Ah, for my own machines I spool all serial console output to a file,
everything is preserved until logrotate kills it after a week or so.

There is no distinction between boot and anything else, everything that
goes to serial (and I make sure everything does) lands together.

> What info are you interested in? Can if be obtained after boot?

I was interested in the kernel commandline; and in particular the
nohz_full configuration if any.

