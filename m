Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B5EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F54A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cJs/S3RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404582AbfFKIu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:50:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52018 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404014AbfFKIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W5BCsZ11cu/muoctLKzUvYQT4Bdgm1EjcXqbdS9h1gY=; b=cJs/S3RPMoSbdZQ7O+Cht1Nc6
        59hVY/SnabfhOrRCVxcaDKspR7cgNmk3/KVOYFUrcsLxiKopNLsqI16YrK6SjmEGXXZQyzObWAiT4
        o88FJhRXV0d7zDYYNuoskiAdJDX08GMn/rZ9uUeKgZXVkCf+6PdbnJ9hYUZq81VoyjHgQSOFh1j98
        noPJvmihtKSMKPBWMrZUnnD/NI+7lHhNkhH2hrT0a6wlqfkr3sUyQjaVLLKZo+GKPWn7ikW00cWVJ
        dp/NCR9ocIrQsBdopX4RYy/oXo8jNYlbxpQcj9VeY8vgSD4cRUdHQdv6Rwcm+Yo4GK27jzmsoZL63
        VsVbTtkxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hacUI-0003Yd-4W; Tue, 11 Jun 2019 08:50:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B869D202173E2; Tue, 11 Jun 2019 10:50:36 +0200 (CEST)
Date:   Tue, 11 Jun 2019 10:50:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
Message-ID: <20190611085036.GS3436@hirez.programming.kicks-ass.net>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:00:34PM -0700, Fenghua Yu wrote:
> umwait or tpause allows processor to enter a light-weight
> power/performance optimized state (C0.1 state) or an improved
> power/performance optimized state (C0.2 state) for a period
> specified by the instruction or until the system time limit or until
> a store to the monitored address range in umwait.
> 
> IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> on the processor and set maximum time the processor can reside in
> C0.1 or C0.2.
> 
> By default C0.2 is enabled so the user wait instructions can enter the
> C0.2 state to save more power with slower wakeup time.
> 
> Default maximum umwait time is 100000 cycles. A later patch provides
> a sysfs interface to adjust this value.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/asm/msr-index.h |  4 +++
>  arch/x86/power/Makefile          |  1 +
>  arch/x86/power/umwait.c          | 56 ++++++++++++++++++++++++++++++++

Why is this in power/, this isn't in the least related to
suspend/hybernate. arch/x86/kernel/cpu/ might be a better place for
instruction support.
