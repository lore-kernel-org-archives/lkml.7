Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F3C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19CF2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a7YFIco7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFPGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:06:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35372 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAFPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1Hy7rL5lKVG+BbappkxvNtg+NY3Qm8VQqVEeiRUmLRI=; b=a7YFIco7xYYRt8i7Yx8+DHdpc
        +YX/QCBmYhbrIj8ngbtLB2aJy7GndbuuUXpEFjLecmsCR53LdxN9cOqY/gQDFlg/dvXYGMzPetO39
        DvPIG1ocIzokp3NgqWiaq1oxWAmkGRXtXnkBVsuQ0Y4+osvl1l6Dsj7rknircJ4BT4mPR6QMcZ3L0
        SpHNsk+xgBA0jQFOKUyh6AUSlKjoM4aHOK0HhqD7UHn5wh20JAt6ohWXowSS6q81bjpNyroxSyvHd
        xqYtAVWYUVq26rI0ZFzQOf8/8jdDmudCi0EHHId7Ukz7yGIYulxnhbEec1X81KQ9CqJ+zQIpbaoFU
        7cdBVHCeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioTwy-00014b-PJ; Mon, 06 Jan 2020 15:05:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E3003007F2;
        Mon,  6 Jan 2020 16:04:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 451D92B284504; Mon,  6 Jan 2020 16:05:46 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:05:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 0/2] x86/context-tracking: Remove last remaining calls to
 exception_enter/exception_exit()
Message-ID: <20200106150546.GS2810@hirez.programming.kicks-ass.net>
References: <20191227163612.10039-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227163612.10039-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 05:36:10PM +0100, Frederic Weisbecker wrote:
> Thanks to the cleanups from Andy Lutomirski over the years, those calls
> can now be removed. This will allow for nice things in the future for
> x86 support on full nohz:
> 
> * Remove TIF_NOHZ and use a per-cpu switch to enable, disable context
>   tracking.
> 
> * Avoid context tracking on housekeepers.
> 
> * Dynamically enable/disable context tracking on CPU on runtime and
>   therefore allow runtime enable/disable of nohz_full
> 
> * Make nohz_full a property of cpuset.
> 
> Frederic Weisbecker (2):
>   x86/context-tracking: Remove exception_enter/exit() from
>     do_page_fault()
>   x86/context-tracking: Remove exception_enter/exit() from
>     KVM_PV_REASON_PAGE_NOT_PRESENT async page fault

Thanks, these look good to me.

Did I tell you about my 'TODO' item vs text_poke_sync() ? Basically, we
can avoid sending the IPI to NOHZ_FULL user CPUs, provided we make their
enter_from_user_mode() do the sync_core().
