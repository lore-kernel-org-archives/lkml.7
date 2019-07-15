Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469DDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239C02081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfGOSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 14:41:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbfGOSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:41:10 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn5uN-0003zm-5u; Mon, 15 Jul 2019 20:41:07 +0200
Date:   Mon, 15 Jul 2019 20:41:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andrew Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop
 targets
In-Reply-To: <8736j7gsza.fsf@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com> <8736j7gsza.fsf@linux.intel.com>
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

On Mon, 15 Jul 2019, Andi Kleen wrote:
> Uros Bizjak <ubizjak@gmail.com> writes:
> 
> > Recent patch [1] disabled a self-snoop feature on a list of processor
> > models with a known errata, so we are confident that the feature
> > should work on remaining models also for other purposes than to speed
> > up MTRR programming.
> 
> MTRR is very different than TLBs.
> 
> >From my understanding not flushing with PAT is only safe everywhere when
> the memory is only used for coherent devices (like the Internal GPU on
> Intel CPUs). We don't have any infrastructure to track or enforce
> this unfortunately.

Right, we don't know where the PAT invocation comes from and whether they
are safe to omit flushing the cache. The module load code would be one
obvious candidate.

But unless there is some really worthwhile speedup, e.g. for boot, then
adding some flag to let CPA know about the safe 'no flush' operation might
be not worth it.

Thanks,

	tglx
