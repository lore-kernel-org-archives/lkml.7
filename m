Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149AC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFF5218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfGDWda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 18:33:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60177 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 18:33:29 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hjAI7-0000yJ-UW; Fri, 05 Jul 2019 00:33:24 +0200
Date:   Fri, 5 Jul 2019 00:33:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
In-Reply-To: <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com>
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

On Thu, 4 Jul 2019, Mathieu Desnoyers wrote:
> ----- On Jul 4, 2019, at 5:10 PM, Thomas Gleixner tglx@linutronix.de wrote:
> >
> > num_online_cpus() is racy today vs. CPU hotplug operations as
> > long as you don't hold the hotplug lock.
> 
> Fair point, AFAIU none of the loads performed within num_online_cpus()
> seem to rely on atomic nor volatile accesses. So not using a volatile
> access to load the cached value should not introduce any regression.
> 
> I'm concerned that some code may rely on re-fetching of the cached
> value between iterations of a loop. The lack of READ_ONCE() would
> let the compiler keep a lifted load within a register and never
> re-fetch, unless there is a cpu_relax() or a barrier() within the
> loop.

If someone really wants to write code which can handle concurrent CPU
hotplug operations and rely on that information, then it's probably better
to write out:

     ncpus = READ_ONCE(__num_online_cpus);

explicitely along with a big fat comment.

I can't figure out why one wants to do that and how it is supposed to work,
but my brain is in shutdown mode already :)

I'd rather write a proper kernel doc comment for num_online_cpus() which
explains what the constraints are instead of pretending that the READ_ONCE
in the inline has any meaning.

Thanks,

	tglx
