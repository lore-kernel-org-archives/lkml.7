Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC91C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C7920693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfGaWjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:39:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33338 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfGaWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:39:19 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsxFX-0000Hx-Ig; Thu, 01 Aug 2019 00:39:12 +0200
Date:   Thu, 1 Aug 2019 00:39:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zebediah Figura <z.figura12@gmail.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
In-Reply-To: <306b3332-0065-59dc-e6d6-ee3c8a67ef53@gmail.com>
Message-ID: <alpine.DEB.2.21.1908010038040.1788@nanos.tec.linutronix.de>
References: <20190730220602.28781-1-krisman@collabora.com> <20190730220602.28781-2-krisman@collabora.com> <20190731120600.GT31381@hirez.programming.kicks-ass.net> <306b3332-0065-59dc-e6d6-ee3c8a67ef53@gmail.com>
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

On Wed, 31 Jul 2019, Zebediah Figura wrote:
> On 7/31/19 7:06 AM, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2019 at 06:06:02PM -0400, Gabriel Krisman Bertazi wrote:
> > > This is a new futex operation, called FUTEX_WAIT_MULTIPLE, which allows
> > > a thread to wait on several futexes at the same time, and be awoken by
> > > any of them.  In a sense, it implements one of the features that was
> > > supported by pooling on the old FUTEX_FD interface.
> > > 
> > > My use case for this operation lies in Wine, where we want to implement
> > > a similar interface available in Windows, used mainly for event
> > > handling.  The wine folks have an implementation that uses eventfd, but
> > > it suffers from FD exhaustion (I was told they have application that go
> > > to the order of multi-milion FDs), and higher CPU utilization.
> > 
> > So is multi-million the range we expect for @count ?
> > 
> 
> Not in Wine's case; in fact Wine has a hard limit of 64 synchronization
> primitives that can be waited on at once (which, with the current user-side
> code, translates into 65 futexes). The exhaustion just had to do with the
> number of primitives created; some programs seem to leak them badly.

And how is the futex approach better suited to 'fix' resource leaks?

Thanks,

	tglx


