Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B936C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F4B2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 12:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfHRMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 08:02:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:48445 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRMCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 08:02:09 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7IC1aC2002066;
        Sun, 18 Aug 2019 07:01:37 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x7IC1ZQg002061;
        Sun, 18 Aug 2019 07:01:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 18 Aug 2019 07:01:35 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: optimise WARN_ON()
Message-ID: <20190818120135.GV31406@gate.crashing.org>
References: <20190817090442.C5FEF106613@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817090442.C5FEF106613@localhost.localdomain>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 09:04:42AM +0000, Christophe Leroy wrote:
> Unlike BUG_ON(x), WARN_ON(x) uses !!(x) as the trigger
> of the t(d/w)nei instruction instead of using directly the
> value of x.
> 
> This leads to GCC adding unnecessary pair of addic/subfe.

And it has to, it is passed as an "r" to an asm, GCC has to put the "!!"
value into a register.

> By using (x) instead of !!(x) like BUG_ON() does, the additional
> instructions go away:

But is it correct?  What happens if you pass an int to WARN_ON, on a
64-bit kernel?

(You might want to have 64-bit generate either tw or td.  But, with
your __builtin_trap patch, all that will be automatic).


Segher
