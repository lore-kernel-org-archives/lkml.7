Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9952084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfDBPxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDBPxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B86081DE1;
        Tue,  2 Apr 2019 15:53:05 +0000 (UTC)
Received: from treble (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D53DB194B7;
        Tue,  2 Apr 2019 15:53:03 +0000 (UTC)
Date:   Tue, 2 Apr 2019 10:53:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
Message-ID: <20190402155301.fvvt5f3veilixv3j@treble>
References: <20190331214020.836098943@linutronix.de>
 <20190331215136.039902969@linutronix.de>
 <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de>
 <20190402154329.scp7i7uqevubgwrz@treble>
 <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <20190402155149.c23ivzzc5hyykokl@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190402155149.c23ivzzc5hyykokl@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 02 Apr 2019 15:53:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:51:49AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 02, 2019 at 05:48:56PM +0200, Thomas Gleixner wrote:
> > > With the above "(stk <= begin || stk >= end)" check, removing the loop
> > > becomes not all that important since exception stack dumps are quite
> > > rare and not performance sensitive.  With all the macros this code
> > > becomes a little more obtuse, so I'm not sure whether removal of the
> > > loop is a net positive.
> > 
> > What about perf? It's NMI context and probably starts from there. Peter?
> 
> I believe perf unwinds starting from the regs from the context which was
> interrupted by the NMI.

Adding Peter to keep me honest.

-- 
Josh
