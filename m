Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3865CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A10820818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QR0eZq93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfHFOQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:16:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zO8VA8eX4wC7dRJeySQSxsRPrO+enpiYoyXKbRd3Ah4=; b=QR0eZq93VudrR3V1sn01qUGTp
        7YpSYFDVy1rT2i1JWIuEcHExlrCLneGqqKg5TW1zggG1C0Qil1nuxqt2FMgEcd4/HRpk66HLS31cn
        Vjm6pS00r1EDZxCaD3id3vUOEQ/2jriTfAGGpV7G/Yxbt/KA4DAosItfmD87UjTPsn2dfx2brbI+D
        wF6dH4/ltbVujPJZXhRTyDCGDQLE7k1g7bn3Zf4BkStw3Y3YQ5iO0RqDxvCcpZpNPAfqn4E4JWWL4
        vM2LVyG/R8a2ndDDmAYys1j+CnrDVDS6J8XsnfxAcFl4Bp0BOHSS3TtkrRFSfW8uCKRgjji8bIosH
        kK68KZK/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hv0GD-0003Jd-1c; Tue, 06 Aug 2019 14:16:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3ADC3077DD;
        Tue,  6 Aug 2019 16:15:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26633201B4C6E; Tue,  6 Aug 2019 16:16:17 +0200 (CEST)
Date:   Tue, 6 Aug 2019 16:16:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190806141617.GR2332@hirez.programming.kicks-ass.net>
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <CAERHkrtJ3f1ggfG7Qo-KnznGo66p0Y3E0sAfb3ki6U=ADT6__g@mail.gmail.com>
 <54fa27ff-69a7-b2ac-6152-6915f78a57f9@linux.alibaba.com>
 <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDPdUp3Nb7hYjEiTpJTMVrKJyw2JDKP5EEphMjV-PAYpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 08:24:17AM -0400, Vineeth Remanan Pillai wrote:
> Peter's rebalance logic actually takes care of most of the runq
> imbalance caused
> due to cookie tagging. What we have found from our testing is, fairness issue is
> caused mostly due to a Hyperthread going idle and not waking up. Aaron's 3rd
> patch works around that. As Julien mentioned, we are working on a per thread
> coresched idle thread concept. The problem that we found was, idle thread causes
> accounting issues and wakeup issues as it was not designed to be used in this
> context. So if we can have a low priority thread which looks like any other task
> to the scheduler, things becomes easy for the scheduler and we achieve security
> as well. Please share your thoughts on this idea.

What accounting in particular is upset? Is it things like
select_idle_sibling() that thinks the thread is idle and tries to place
tasks there?

It should be possible to change idle_cpu() to not report a forced-idle
CPU as idle.

(also; it should be possible to optimize select_idle_sibling() for the
core-sched case specifically)

> The results are encouraging, but we do not yet have the coresched idle
> to not spin 100%. We will soon post the patch once it is a bit more
> stable for running the tests that we all have done so far.

There's play_idle(), which is the entry point for idle injection.

In general, I don't particularly like 'fake' idle threads, please be
very specific in describing what issues it works around such that we can
look at alternatives.
