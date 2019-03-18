Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7295C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9656E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SRscWw6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCRKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:49:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55094 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfCRKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=37iKTTycHgymG5vLs1/cC5jMxScUAYgMDd+1fPYQgiI=; b=SRscWw6yzfrhbqlbVoToNhpKL
        QW9CUhFZ41g19HDiiyvQ+3jtMH7RMOQ2sDS/pBthA4ta3cTSbuvkJlHmioW7vvNjjqx/2wnpO2xHn
        zyiBGJZ9VVD6Guu2bpETfQThsYOhRh0uYk2ufzM+SkPL8H6fK2jICB7k64LIwUmN7gH4If/hjRA9P
        /xFqXk9Nf7BLdX36iOrQdwd+C2qH+Wp9Emy9K0gVA2jh1uVnshmhHbr9Z0346rV/3kOvgddLwxCW3
        2tLezhKTUqUDSj77nSk3Pwgy4RT3ugqN6UnebrCa/O0a3oLrlM+qKrG+5hJpHrguMEadgdxyR8H8Q
        lDTSQ0y3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5pp8-0001bW-3L; Mon, 18 Mar 2019 10:48:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 988BA20A0FF8B; Mon, 18 Mar 2019 11:48:52 +0100 (CET)
Date:   Mon, 18 Mar 2019 11:48:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     chenjie6@huawei.com, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, mingo@redhat.com, zengweilin@huawei.com
Subject: Re: [PATCH] futex:fix robust futex alignment exception
Message-ID: <20190318104852.GL6058@hirez.programming.kicks-ass.net>
References: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
 <20190315084131.GS5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903171534590.9068@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903171534590.9068@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 03:36:35PM +0100, Thomas Gleixner wrote:
> On Fri, 15 Mar 2019, Peter Zijlstra wrote:

> > That is; why aren't there any alignment tests anywhere? Or am I just
> > gone blind?
> 
> uaddrs for the futex syscalls are checked in get_futex_key().

blind it is...

Thanks!
