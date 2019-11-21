Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C19C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD68208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F8g/GMpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUNCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:02:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B1S/RbG0mP8J1IB0KFt0SKFJ/tSYiGvhULraSpUjZyE=; b=F8g/GMpQrUzwWumbKVkmS444s
        IVnz8zjLuDL+v3FOLLsPh8ERT8if0ZsH9vcjJTzfWMXb5eJo9WRTGrDh1sYAuDjwSVVP+sc+t4xrR
        NfSEbSQd7A4ApmzH7dedKV4llOC6RN9qZx+gnuzByNNvPUqQOQd/nrcpBAyxOuvwPc+Wesjv2zTGj
        0UowrJKTVzUbqQMqSURe4gSKeVO68TVCDeUQSoM6nIPwFf80LN/AK8nsVevF4FeNEJ88RZz3n5tCe
        cbB7SIdOnXw2FVj0U7CRsYQBNaSsMxgB/mYQVO0kDW/UaZ/aMUmMi0/fLl8TY+/yiCAoetF6yaLrF
        /+7ASkRGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXm5r-00062g-Ax; Thu, 21 Nov 2019 13:01:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3266330068E;
        Thu, 21 Nov 2019 14:00:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10AA0201DD6AF; Thu, 21 Nov 2019 14:01:53 +0100 (CET)
Date:   Thu, 21 Nov 2019 14:01:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121130153.GS4097@hirez.programming.kicks-ass.net>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121060444.GA55272@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:04:44AM +0100, Ingo Molnar wrote:
> * Fenghua Yu <fenghua.yu@intel.com> wrote:

> > +	split_lock_detect
> > +			[X86] Enable split lock detection
> > +			This is a real time or debugging feature. When enabled
> > +			(and if hardware support is present), atomic
> > +			instructions that access data across cache line
> > +			boundaries will result in an alignment check exception.
> > +			When triggered in applications the kernel will send
> > +			SIGBUS. The kernel will panic for a split lock in
> > +			OS code.
> 
> It would be really nice to be able to enable/disable this runtime as 
> well, has this been raised before, and what was the conclusion?

It has, previous versions had that. Somehow a lot of things went missing
and we're back to a broken neutered useless mess.

The problem appears to be that due to hardware design the feature cannot
be virtualized, and instead of then disabling it when a VM runs/exists
they just threw in the towel and went back to useless mode.. :-(

This feature MUST be default enabled, otherwise everything will
be/remain broken and we'll end up in the situation where you can't use
it even if you wanted to.

Imagine the BIOS/EFI/firmware containing an #AC exception. At that point
the feature becomes useless, because you cannot enable it without your
machine dying.

Now, from long and painful experience we all know that if a BIOS can be
wrong, it will be. Therefore this feature will be/is useless as
presented.

And I can't be arsed to look it up, but we've been making this very same
argument since very early (possible the very first) version.

So this version goes straight into the bit bucket. Please try again.
