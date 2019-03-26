Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfCZNxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:53:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:53:07 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8mVk-0006E4-Nf; Tue, 26 Mar 2019 14:53:05 +0100
Date:   Tue, 26 Mar 2019 14:53:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] cpu/hotplug: Create SMT sysfs interface for all arches
In-Reply-To: <20190326133236.lylrrbacznezybjm@treble>
Message-ID: <alpine.DEB.2.21.1903261452290.1789@nanos.tec.linutronix.de>
References: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com> <alpine.DEB.2.21.1903242104280.1798@nanos.tec.linutronix.de> <20190326133236.lylrrbacznezybjm@treble>
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

On Tue, 26 Mar 2019, Josh Poimboeuf wrote:
> On Sun, Mar 24, 2019 at 09:13:18PM +0100, Thomas Gleixner wrote:
> > Second thoughts. I'm not really convinced that changing the meaning of
> > notsupported and in fact overloading it, is the right thing to do.
> > notsupported means now:
> > 
> >   CPU does not support it - OR - architecture does not support it
> > 
> > That's not pretty and we are surely not short of state space. There are
> > several options for handling this:
> > 
> >  1) Do not expose the state file, just expose the active file
> > 
> >  2) Expose the state file, but return -ENOTSUPP or some other sensible error
> >     code
> > 
> >  3) Expose the state file and let show return 'notimplemented' which is
> >     more accurate. That wouldn't even require to expand the state space
> >     enum. It just can be returned unconditionally.
> 
> Makes sense.  I like #3.  I can post another version.

Yes, please.

Thanks,

	tglx
