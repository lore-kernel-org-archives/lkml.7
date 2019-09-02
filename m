Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426DC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22D3216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfIBLL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:11:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:37712 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbfIBLL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:11:27 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x82BB7FG023249;
        Mon, 2 Sep 2019 06:11:07 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x82BB5Mw023248;
        Mon, 2 Sep 2019 06:11:05 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 2 Sep 2019 06:11:05 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Alastair D'Silva" <alastair@au1.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc: Convert ____flush_dcache_icache_phys() to C
Message-ID: <20190902111105.GX31406@gate.crashing.org>
References: <de7a813c71c4823797bb351bea8be15acae83be2.1565970465.git.christophe.leroy@c-s.fr> <9887dada07278cb39051941d1a47d50349d9fde0.camel@au1.ibm.com> <a0ad8dd8-2f5d-256d-9e88-e9c236335bb8@c-s.fr> <fcc94e7f347c3759a1698444239a7250b22cde7d.camel@au1.ibm.com> <87imqbtqlw.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imqbtqlw.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 11:48:59AM +1000, Michael Ellerman wrote:
> "Alastair D'Silva" <alastair@au1.ibm.com> writes:
> > On Wed, 2019-08-21 at 22:27 +0200, Christophe Leroy wrote:
> >> Can we be 100% sure that GCC won't add any code accessing some
> >> global data or stack while the Data MMU is OFF ?
> >
> > +mpe
> >
> > I'm not sure how we would go about making such a guarantee, but I've
> > tied every variable used to a register and addr is passed in a
> > register, so there is no stack usage, and every call in there only
> > operates on it's operands.
> 
> That's not safe, I can believe it happens to work but the compiler
> people will laugh at us if it ever breaks.

Yes.  Sorry.

> Let's leave it in asm.

+1

The asm is simpler, more readable, more maintainable, and perhaps more
performant even.  Plus the being-laughed-at issue.


Segher
