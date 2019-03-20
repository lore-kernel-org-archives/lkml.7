Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7165C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EEB2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W8uI6sdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCTWWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:22:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56380 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfCTWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BYzz+wefXr4lloqI93uXDNGiX+SSPf7icG7IRc4Yt04=; b=W8uI6sdXml3fAevCDrWwImtHG
        fw27fYYpuql/HGmotiTsTisODfKQkxqg2wPPIx0Mbg6Zh/GLXGNOiGPblPryAXvx5viQ152N2gxKY
        X3ygJiAZGjzfy3Nz7TIE72mvDVbp1lANpWZYK6fGKPd+XNC4eYgQ0iBsnBg10ox9DGC91PcCHqP1H
        Gn7MXCZqHCjtp4Z3wFej6xchuOHrN28Gc3kPhfckj0z1wznaxt83uiOYROXL1oSQbDF632woyqzBh
        BeTLxeR/QW6G68NlFMoKkz3WVYn2yE/6T6lEXbqPEJMyv7am9Avr+qzt4ndMkYRTIHBu9S/0LsA2P
        BlAVDPP7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6jbK-0002LJ-IW; Wed, 20 Mar 2019 22:22:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93BA8984EED; Wed, 20 Mar 2019 23:22:20 +0100 (CET)
Date:   Wed, 20 Mar 2019 23:22:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190320222220.GA2490@worktop.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.441549378@infradead.org>
 <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:47:28PM -0700, Stephane Eranian wrote:

> Right now, if I do:
> 
> echo 0 > /sys/bus/event_source/devices/cpu/allow_tsx_force_abort
> 
> Then I don't have the guarantee on when there will be no abort when I
> return from the echo.  the MSR is accessed only on PMU scheduling. I
> would expect a sysadmin to want some guarantee if this is to be
> switched on/off at runtime. If not, then having a boot time option is
> better in my opinion.

Something like cycling the nmi watchdog or:

  perf stat -a -e cycles sleep 1

should be enough to force reschedule the events on every CPU.

Again, I'm not adverse to 'fixing' this if it can be done with limited
LoC. But I don't really see this as critical.

> This other bit I noticed is that cpuc->tfa_shadow is used to avoid the
> wrmsr(), but I don't see the code that makes sure the init value (0)
> matches the value of the MSR.  Is this MSR guarantee to be zero on
> reset? 

That was my understanding.

> How about on kexec()?

Good point, we might want to fix that.
