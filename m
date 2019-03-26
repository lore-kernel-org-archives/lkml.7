Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B41FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B421741
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfCZWZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:25:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfCZWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:25:51 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8uVt-0007UD-Ki; Tue, 26 Mar 2019 23:25:45 +0100
Date:   Tue, 26 Mar 2019 23:25:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Andi Kleen <andi@firstfloor.org>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
In-Reply-To: <20190326213803.GN18020@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-3-andi@firstfloor.org> <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de> <20190326213803.GN18020@tassilo.jf.intel.com>
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

Andi.

On Tue, 26 Mar 2019, Andi Kleen wrote:
> On Tue, Mar 26, 2019 at 06:03:59PM +0100, Thomas Gleixner wrote:
> > On Thu, 21 Mar 2019, Andi Kleen wrote:
> > 
> > > With gcc 8 toplevel assembler statements that do not mark themselves
> > > as .text may end up in other sections.
> > 
> > Which is clearly a change in behaviour. Is that intended or just yet
> > another feature of GCC?
> 
> I'm not sure it's a new behavior, but I've seen it first
> with gcc 8.

Ok.
 
> > Your subject says: 'x86, lto:'
> > 
> > So is this a LTO related problem or is the section randomization
> > independent of LTO?
> 
> The basic behavior is independent of LTO, but I've only seen
> failures with LTO. But I believe in theory it could lead
> to failures even without LTO.

Well, we better should know the real reason for this wreckage. I mean, the
default section for text is suprisingly .text. I don't see a reason why
this would be any different for an assembly function implemented in a C
file.

So the question is whether GCC does something silly in general which gets
'repaired' silentely by the linker or whether it's just an LTO issue.

If it's the former, then we must backport those fixes.

Could you please verify with the GCC people as you seem to have a
reproducer of some sort.

Thanks,

	tglx
