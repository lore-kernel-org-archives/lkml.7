Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0522C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FE020861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfFQVJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:09:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45710 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFQVJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:09:04 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcys2-0005WT-Rm; Mon, 17 Jun 2019 23:08:55 +0200
Date:   Mon, 17 Jun 2019 23:08:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/3] watchdog/softlockup: Make softlockup reports more
 reliable and useful
In-Reply-To: <20190605140954.28471-1-pmladek@suse.com>
Message-ID: <alpine.DEB.2.21.1906172307260.1963@nanos.tec.linutronix.de>
References: <20190605140954.28471-1-pmladek@suse.com>
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

On Wed, 5 Jun 2019, Petr Mladek wrote:

> Hi,
> 
> we were analyzing logs with several softlockup reports in flush_tlb_kernel_range().
> They were confusing. Especially it was not clear whether it was deadlock,
> livelock, or separate softlockups.
> 
> It went out that even a simple busy loop:
> 
> 	while (true)
> 	      cpu_relax();
> 
> is able to produce several softlockups reports:
> 
> [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
> [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
> 
> 
> I tried to understand the tricky watchdog code and produced two patches
> that would be helpful to debug the original real bug:
> 
>    1st patch prevents restart of the watchdog from unrelated locations.
> 
>    2nd patch helps to distinguish several possible situations by
>    regular reports.
> 
>    3rd patch can be used for testing the problem.
> 
> 
> The watchdog code might deserve even more clean up. Anyway, I would
> like to hear other's opinion first.

Anything which improves debugability is welcome. Unfortunately you missed
to add an example of the output after these patches are applied.

Thanks,

	tglx

