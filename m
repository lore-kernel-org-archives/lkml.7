Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75CC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE352084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URTrCFk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfGTLKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 07:10:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfGTLKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 07:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CSpqqObHAXL3FQ2tTs5Na9vOWdPfphA5nFF5rAves+c=; b=URTrCFk4EzVMuy5SsviQyIhiZ
        FihaCwluGuw0RwVRDexdapCcVI+KG+Njug+HVIrcUZ5OCnmGj5pjGBBP9wC8zHw3leY5a4neaDP1c
        wfiICAFvyStwamBskit2b6OqtZMhXWmRcGhH+IRpEfzkoLHkbzbmBHnopniT85knl355H+QHVpJ7O
        xP50SIi5BdiU8K7WfvtezZnPF2nkQ3KWC+549GtpMA1vgn/uyHvyt6WYG0KdNniWFuHYh54IVwnPC
        2Xx3aXLFrV1OngTv6az97LW4LTzRje0IMM4O72j+REw5kL8NfPVY0qFUfbA3GL7NbNvbJ21oVAOAm
        RZhbIe9UA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1honFn-0007Jx-Ud; Sat, 20 Jul 2019 11:10:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CABF20BAF36C; Sat, 20 Jul 2019 13:10:13 +0200 (CEST)
Date:   Sat, 20 Jul 2019 13:10:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
Message-ID: <20190720111013.GQ3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
 <20190719184538.GA20324@hermes.olymp>
 <2ed44afa-4528-a785-f188-2daf24343f97@redhat.com>
 <CAHk-=wioLqXBWWQywZGfxumsY_H6dFE3R=+WJ3mAL_WYV1fm9Q@mail.gmail.com>
 <87h87hksim.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h87hksim.fsf@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 09:41:05AM +0100, Luis Henriques wrote:
> [   39.801179] ==================================================================
> [   39.801973] BUG: KASAN: use-after-free in rwsem_down_write_slowpath (/home/miguel/kernel/linux/kernel/locking/rwsem.c:669 /home/miguel/kernel/linux/kernel/locking/rwsem.c:1125) 

That's rwsem_can_spin_on_owner(), specifically line 669 seems to suggest
owner_on_cpu().

So we'd somehow have a dead owner; I'm not immediately seeing how that
can happen.

