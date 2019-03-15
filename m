Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C149C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5BD218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="km68X5eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfCOJZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=meiT0XD+ijzgQZqi3Uj3kl0F9QLBEdO3L89tPQOWNN8=; b=km68X5ehR6WVbMvujQbHeDW8w
        4JKRTxJh66oEbiaYw3zc8ofgiSsuOSOH4McBSkI94GmthCrYvETxXA3NH5GpFJ2HpgsDNebLknMNx
        xGwm1SVbwIbvUKO7xrCbbof41wpKQVLaqINWAYob1hnCNpeMq62NkHiO6w2bM5h/CXPwlik4HaCaP
        6Ny42jGSnE9ODRif00csG15IS2/3Sp1RqgjFiWLgK/LJQcVOgPGjryotOrNxND3jusb8B+Mm2X4gV
        0pQiC1JoXSZMSagIWmV95aZYfHu0mi514TtSo9wtgku2XVVAsrCDMC20zB2LZ3SylN2994HiYS7i5
        rDUdMZ09w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4j5n-0003DB-MG; Fri, 15 Mar 2019 09:25:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC77821A7734B; Fri, 15 Mar 2019 10:25:29 +0100 (CET)
Date:   Fri, 15 Mar 2019 10:25:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>, x86@kernel.org
Subject: Re: [PATCH 2/2] Revert "x86/hpet: Reduce HPET counter read
 contention"
Message-ID: <20190315092529.GU5996@hirez.programming.kicks-ass.net>
References: <1552552932-21821-1-git-send-email-zhenzhong.duan@oracle.com>
 <1552552932-21821-2-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552552932-21821-2-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 04:42:12PM +0800, Zhenzhong Duan wrote:
> This reverts commit f99fd22e4d4bc84880a8a3117311bbf0e3a6a9dc.
> 
> It's unnecessory after commit "acpi_pm: Fix bootup softlockup due to PMTMR
> counter read contention", the simple HPET access code could be restored.
> 
> On a general system with good TSC, TSC is the final default clocksource.
> So the potential performce loss is only at bootup stage before TSC
> replacing HPET, we didn't observe obvious delay of bootup.

The timeline here is:

 - Len took out SKX from native_calibrate_tsc
   b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake Xeon")

   This causes the TSC to run through the calibration code, which
   completes _after_ SMP bringup.

 - This then caused HPET to be used during SMP bringup, which resulted
   in Waiman doing the patch you now propose removing.

   Because large (multi-socket) SKX machines would barely boot.

   f99fd22e4d4b ("x86/hpet: Reduce HPET counter read contention")

 - Now, I figured that was all crazy to begin with, and introduced
   clocksource_tsc_early, such that we can run at the guestimate TSC
   frequency until we've completed calibration and then swap to the real
   TSC clocksource.

   aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
   (and assorted fixes)

This means that we now only use HPET for a very short time in early
boot, _IFF_ TSC is stable.

Now, given the amount of wreckage we still see with TSC, I'm very
reluctant to revert this patch. Because the moment TSC goes out the
window, we're back on HPET, and this patch does make a huge difference.

Yes, its sad, gross and nasty... but the same is true for TSC still being
a trainwreck.

So NAK.
