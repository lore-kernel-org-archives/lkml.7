Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD06C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE96621900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1iNrkrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfCVQkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:40:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfCVQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9fj/qDq9IBKm7XJP3WHetNUk3xdI2f6m9PtXxsbQwPA=; b=H1iNrkrqoTj/9Qz5bdHXJ0Ub4
        nHTaOEiYaBjTn7CLdRXEr3grlaX2L9oRTSJkWBRdEJFYBcl751TM7wQb3UBCUMHa/dcgEKsK7pg/4
        1WiMx1n6a/I1ESsUiUJ6YMUGUGSYKtvnrefrww/NPJPslzNi8nR0l90AYMTzfa7NpQg9tZOsB03Vq
        K0JzQdk+wl4LoZhDp+yi80cTfIZcZmLu7OH1L/mE4CwqHPla24729GZCkfY8H1fvO0SNY/9Abk6ah
        NGKnKL0pDIvQYItubop/0VLT5BVUZhhRC0fp88IkAWJDxmS6wHWE4MgKakd2hvyLZUoTyLT6uBeKs
        6BFqySZkg==;
Received: from [31.161.229.66] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7ND6-0003QH-Ew; Fri, 22 Mar 2019 16:40:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19562984EEA; Fri, 22 Mar 2019 17:39:54 +0100 (CET)
Date:   Fri, 22 Mar 2019 17:39:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andi Kleen <andi@firstfloor.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 01/17] kbuild: Disable -Waddress-of-packed-member for gcc
 9
Message-ID: <20190322163954.GG7905@worktop.programming.kicks-ass.net>
References: <20190321220009.29334-1-andi@firstfloor.org>
 <20190321220009.29334-2-andi@firstfloor.org>
 <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a31L6ddJ1JPpygHqeVspExv7eaKWsLQ5pb+T8LAF2Zjtw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 02:58:51PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 21, 2019 at 11:00 PM Andi Kleen <andi@firstfloor.org> wrote:
> >
> > From: Andi Kleen <ak@linux.intel.com>
> >
> > This warning is very noisy in a default build with gcc 9.
> > Move it into W=2 only.
> >
> > Cc: arnd@arndb.de
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> I think W=2 is too aggressive. On many architectures, this finds
> real bugs and the false positives tend to be trivial to fix
> (by removing the bogus __packed annotation), which improves
> the generated code in the process.
> 
> Moving it to W=1 for the moment is probably fine, but ideally
> I think we should fix the kernel to behave according to the
> C standard.

Lol... we're actively moving away from the C standard on many places.

Why does the silly compiler think it is a problem to take the address of
a member of a packed structure? That sounds like something that's
perfectly fine and useful.
