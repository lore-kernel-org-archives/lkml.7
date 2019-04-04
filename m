Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BA1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F04A2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDDOgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:36:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDDOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:36:32 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hC3TY-0003oC-Kt; Thu, 04 Apr 2019 16:36:20 +0200
Date:   Thu, 4 Apr 2019 16:36:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
In-Reply-To: <20190404120704.18479-1-npiggin@gmail.com>
Message-ID: <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
References: <20190404120704.18479-1-npiggin@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Nicholas Piggin wrote:

> I've been looking at ways to fix suspend breakage with CPU0 as a
> nohz CPU. I started looking at various things like allowing CPU0
> to take over do_timer again temporarily or allowing nohz full
> to be stopped at runtime (that is quite a significant change for
> little real benefit). The problem then was having the housekeeping
> CPU go offline.
> 
> So I decided to try just allowing the freeze to occur on non-zero
> CPU. This seems to be a lot simpler to get working, but I guess
> some archs won't be able to deal with this? Would it be okay to
> make it opt-in per arch?

It needs to be opt in. x86 will fall on its nose with that.

Now the real interesting question is WHY do we need that at all?

Thanks,

	tglx
