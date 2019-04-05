Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275A5C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0002121855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfDEV4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:56:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49995 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEV4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:56:35 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCWp3-0005dD-HH; Fri, 05 Apr 2019 23:56:29 +0200
Date:   Fri, 5 Apr 2019 23:56:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V2 20/29] x86/dumpstack/64: Speedup
 in_exception_stack()
In-Reply-To: <20190405215520.wsevtopb63oetkfd@treble>
Message-ID: <alpine.DEB.2.21.1904052355570.1802@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150930.219316964@linutronix.de> <20190405215520.wsevtopb63oetkfd@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019, Josh Poimboeuf wrote:
> On Fri, Apr 05, 2019 at 05:07:18PM +0200, Thomas Gleixner wrote:
> > The current implementation of in_exception_stack() iterates over the
> > exception stacks array. Most of the time this is an useless exercise, but
> > even for the actual use cases (perf and ftrace) it takes at least 2
> > iterations to get to the NMI stack.
> > 
> > As the exception stacks and the guard pages are page aligned the loop can
> > be avoided completely.
> > 
> > Add a initial check whether the stack pointer is inside the full exception
> > stack area and leave early if not.
> > 
> > Create a lookup table which describes the stack area. The table index is
> > the page offset from the beginning of the exception stacks. So for any
> > given stack pointer the page offset is computed and a lookup in the
> > description table is performed. If it is inside a guard page, return. If
> > not, use the descriptor to fill in the info structure.
> > 
> > The table is filled at compile time and for the !KASAN case the interesting
> > page descriptors exactly fit into a single cache line. Just the last guard
> > page descriptor is in the next cacheline, but that should not be accessed
> > in the regular case.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > V2: Simplify the macro maze
> 
> This is indeed a little better.  It's friday, have an ack.
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> I don't like the clever ISTACK_* macro naming however...

Come on it's friday, time for a little bikeshedding :)
