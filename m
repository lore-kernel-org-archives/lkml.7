Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84124C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3CB20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIxPvMaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfFQOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:19:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PbadsapuC96G3asDDoCig5IowNNX/GZR59JhY/lLDv8=; b=iIxPvMaEuEdzB1xmbsoBvUapz
        Hyl2muQT/PksGbl8Qgjo6GcbYBgHCAul3xo28kcFNQdShXk1avoyUsqB7pSIF7mKJOPzZTNsQobad
        lZL2XPBtKSRpFF7OkHiPgZG88BHlTJylP14QLcTk4DhSa+76Lpex3ix87W7WIrh0+FIbA0RsxOcP5
        jaL7bgM7verzXxBYsUbm4T/neS+5T0E9oXqX882paOeBbB4CXqd1L9CwbTAfcXUXKZVDBgv6gvrhD
        XLOAR35+ilhiAPjLRIm7KwOzTJrAtQurnDQ4zoelmAu6JwJAJP1ZN4YmzuPtGUZ0Cdfimkoforlz9
        mUahbUnbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcsTQ-00084G-IE; Mon, 17 Jun 2019 14:19:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C07E201F45FA; Mon, 17 Jun 2019 16:19:03 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:19:03 +0200
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
Subject: Re: [PATCH v4 0/5] x86/umwait: Enable user wait instructions
Message-ID: <20190617141903.GC3436@hirez.programming.kicks-ass.net>
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <20190611090145.GU3436@hirez.programming.kicks-ass.net>
 <20190611173733.GB180343@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611173733.GB180343@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:37:34AM -0700, Fenghua Yu wrote:
> On Tue, Jun 11, 2019 at 11:01:45AM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 07, 2019 at 03:00:32PM -0700, Fenghua Yu wrote:
> > > Today, if an application needs to wait for a very short duration
> > > they have to have spinloops. Spinloops consume more power and continue
> > > to use execution resources that could hurt its thread siblings in a core
> > > with hyperthreads. New instructions umonitor, umwait and tpause allow
> > > a low power alternative waiting at the same time could improve the HT
> > > sibling perform while giving it any power headroom. These instructions
> > > can be used in both user space and kernel space.
> > > 
> > > A new MSR IA32_UMWAIT_CONTROL allows kernel to set a time limit in
> > > TSC-quanta that prevents user applications from waiting for a long time.
> > > This allows applications to yield the CPU and the user application
> > > should consider using other alternatives to wait.
> > 
> > I'm confused on the purpose of this control; what do we win by limiting
> > this time?
> 
> In previous patches, there is no time limit (max time is 0 which means no
> time limit).
> 
> Andy Lutomirski proposed to set the time limit:
> 
> https://lkml.org/lkml/2019/2/26/735
> 
> "So I propose setting the timeout to either 100 microseconds or 100k
> "cycles" by default.  In the event someone determines that they save
> materially more power or gets materially better performance with a
> longer timeout, we can revisit the value."
> 
> Does it make sense?

You quoted exactly the wrong part of that message; Andy's concern was
with NOHZ_FULL. And I think we should preserve that concern in both the
code and Changelog introducing this limit.
