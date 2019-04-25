Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60919C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB70520678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfDYS7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:59:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60322 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:59:25 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hJjaY-000834-8H; Thu, 25 Apr 2019 20:59:18 +0200
Date:   Thu, 25 Apr 2019 20:59:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Mel Gorman <mgorman@techsingularity.net>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
In-Reply-To: <20190425185343.GA122353@gmail.com>
Message-ID: <alpine.DEB.2.21.1904252054560.1768@nanos.tec.linutronix.de>
References: <cover.1556025155.git.vpillai@digitalocean.com> <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com> <20190424140013.GA14594@sinkpad> <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com> <20190425095508.GA8387@gmail.com>
 <20190425144619.GX18914@techsingularity.net> <20190425185343.GA122353@gmail.com>
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

On Thu, 25 Apr 2019, Ingo Molnar wrote:
> * Mel Gorman <mgorman@techsingularity.net> wrote:
> > I don't have the data in a format that can be present everything in a clear
> > format but here is an attempt anyway. This is long but the central point
> > that when when a machine is lightly loaded, HT Off generally performs
> > better than HT On and even when heavily utilised, it's still not a
> > guaranteed loss. I only suggest reading after this if you have coffee
> > and time. Ideally all this would be updated with a comparison to core
> > scheduling but I may not get it queued on my test grid before I leave
> > for LSF/MM and besides, the authors pushing this feature should be able
> > to provide supporting data justifying the complexity of the series.
> 
> BTW., a side note: I'd suggest introducing a runtime toggle 'nosmt' 
> facility, i.e. turn a system between SMT and non-SMT execution runtime, 
> with full reversability between these states and no restrictions.

It exists already: /sys/devices/system/cpu/smt/control

Setting it to off will offline all siblings, on will online them again.

Thanks,

	tglx
