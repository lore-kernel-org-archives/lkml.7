Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7120700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfC0Vzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:55:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51767 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0Vzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:55:51 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h9GWO-0002vQ-U5; Wed, 27 Mar 2019 22:55:45 +0100
Date:   Wed, 27 Mar 2019 22:55:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
In-Reply-To: <20190327204049.GW18020@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1903272217240.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-3-andi@firstfloor.org> <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de> <20190326213803.GN18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de> <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
 <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de> <20190327145918.GU18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903271600050.1789@nanos.tec.linutronix.de> <20190327154522.GV18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903271958320.1789@nanos.tec.linutronix.de>
 <20190327204049.GW18020@tassilo.jf.intel.com>
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

On Wed, 27 Mar 2019, Andi Kleen wrote:
> > 
> > It's static so it's scope is within the file and whatever GCC does with
> > that C function it has to respect that it accesses static data. If that's
> > not true then this really needs to be fixed at the compiler side and not in
> > the kernel.
> 
> Ok so you did the statics with undefined size, so kind of an extern static. 
> That's a weird construct (not sure if it's even allowed in standard C), but
> somehow it seems to work in gcc with the inline assembler.

Strict C89 does not allow that, but it does not allow a lot of other things
the kernel does.

> I checked the code general and with the .globl in NATIVE_LABEL the

With or without? I removed that as well.

> generated assembler looks like it should work even for LTO yes.
> 
> I guess it's an interesting alternative to making them all global.
> Maybe that will work for more cases too.

Pretty much preferred over making static stuff global all over the place.

Thanks,

	tglx
