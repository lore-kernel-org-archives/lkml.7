Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D146C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A85F206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uWXrChd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfDXG5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:57:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfDXG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9sCcMDZYcNbtZeaitLjtchqK2NzmLraxRXKnsFI1R5E=; b=uWXrChd3swoKeFX4KwO3kZrLb
        dEgXwQCMc1qT/EhMXMTE1XsxE+5SJOGU9hYAFY/EPN7q4+onrZWQU86Ql8VD30iHC7pvBihzx+bpZ
        YytJt6kJeq3XnzYpp6tyYEL9sFh96Axe46MRV5A2+aGYmAZWWBPvddC2/fsHiW1LIv0M/pVWNMIsQ
        JeHJPXCihMucO/87qVf/PkRlf1d6tcBLA5L4kVtOZOtdkG7hXIQz/KfHU97ANqfapPlfH1DSQIJoh
        65ZFAT3TPdw/VJpjDT3thNSrb1UCu/PDWiMxAjGxiYVt4KILZXhfRDCt2cmrIeBf/W7/lmso33jtx
        3gvrPNtXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBqd-0007kx-NO; Wed, 24 Apr 2019 06:57:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1200629BC277F; Wed, 24 Apr 2019 08:57:38 +0200 (CEST)
Date:   Wed, 24 Apr 2019 08:57:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Does vdso_install attempt to re-compile objects under root
 privilege?
Message-ID: <20190424065738.GD4038@hirez.programming.kicks-ass.net>
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
 <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:38:35PM -0700, Linus Torvalds wrote:

> So anybody who builds the kernel as root is doing something seriously
> wrong, in my opinion.

Some of my test boxes don't have a user account... if they fall over,
I'll just re-image them.

So I've been doing it wrong?
