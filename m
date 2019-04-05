Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A3C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE182063F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfDERye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:54:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49436 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfDERye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:54:34 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCT2s-0001Si-VD; Fri, 05 Apr 2019 19:54:31 +0200
Date:   Fri, 5 Apr 2019 19:54:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
In-Reply-To: <1554393113.wbjxx9ccdx.astroid@bobo.none>
Message-ID: <alpine.DEB.2.21.1904051952160.1802@nanos.tec.linutronix.de>
References: <20190404120704.18479-1-npiggin@gmail.com> <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de> <1554393113.wbjxx9ccdx.astroid@bobo.none>
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

On Fri, 5 Apr 2019, Nicholas Piggin wrote:
> Thomas Gleixner's on April 5, 2019 12:36 am:
> > On Thu, 4 Apr 2019, Nicholas Piggin wrote:
> > 
> >> I've been looking at ways to fix suspend breakage with CPU0 as a
> >> nohz CPU. I started looking at various things like allowing CPU0
> >> to take over do_timer again temporarily or allowing nohz full
> >> to be stopped at runtime (that is quite a significant change for
> >> little real benefit). The problem then was having the housekeeping
> >> CPU go offline.
> >> 
> >> So I decided to try just allowing the freeze to occur on non-zero
> >> CPU. This seems to be a lot simpler to get working, but I guess
> >> some archs won't be able to deal with this? Would it be okay to
> >> make it opt-in per arch?
> > 
> > It needs to be opt in. x86 will fall on its nose with that.
> 
> Okay I can add that.
> 
> > Now the real interesting question is WHY do we need that at all?
> 
> Why full nohz for CPU0? Basically this is how their job system was
> written and used, testing nohz full was a change that came much later 
> as an optimisation.
> 
> I don't think there is a fundamental reason an equivalent system
> could not be made that uses a different CPU for housekeeping, but I
> was assured the change would be quite difficult for them.
> 
> If we can support it, it seems nice if you can take a particular
> configuration and just apply nohz_full to your application processors
> without any other changes.

This wants an explanation in the patches. And patch 4 has in the changelog:

   nohz_full has been successful at significantly reducing jitter for a
   large supercomputer customer, but their job control system requires CPU0
   to be for housekeeping.

which just makes me dazed and confused :)

Other than some coherent explanation and making it opt in, I don't think
there is a fundamental issue with that.

Thanks,

	tglx
