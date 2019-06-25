Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E7C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E27208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZ6nyqWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfFYLGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:06:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sbf9yRDP3Yzox0S3HTAkQI1gSEm+BLTKu1+5U9y62Ds=; b=KZ6nyqWzVS/mces8IJ/ntqeC6
        NlAedHLBNhw8tgPVLOHyPmc67fReCz9H1GO6o/17vuCyKV7oygqx4hhakmfIRSfqa45/pcU54I+6f
        IVmWmJjV8MrN9AbVDoki3Iv5Q5CDrs5YOIdcxAxbLeSTPimbZyBfooaqK9StpUgRCxQXJuDqjYMwN
        5w176CxZvh/ITDB5gKVrtoxGi4+uF4HRfAR/gTuwsntniRFJU5oFlSS8ed4i4FUkcjrddi5By1Zsr
        KEzJO6i7VQD943msjYVUQwJC7oW1r5iSpnAgnniIg+5RKXTknnSEnpA1OCKEU9vT+qBTDOZ7Fv+m4
        kESo63FOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfjH9-0004O2-8p; Tue, 25 Jun 2019 11:06:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2A4A209FD684; Tue, 25 Jun 2019 13:06:09 +0200 (CEST)
Date:   Tue, 25 Jun 2019 13:06:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in mark_lock
Message-ID: <20190625110609.GA3463@hirez.programming.kicks-ass.net>
References: <0000000000005aedf1058c1bf7e8@google.com>
 <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
 <20190625110301.GX3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625110301.GX3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:03:01PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> > On Mon, 24 Jun 2019, syzbot wrote:
> 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000

syzcaller folks; why doesn't the above link include the actual kernel
boot, but only the userspace bits starting at syzcaller start?

I was trying to figure out the setup, but there's not enough information
here.
