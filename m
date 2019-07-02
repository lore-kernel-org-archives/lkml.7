Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58857C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2561E20673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rkpBBg3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGCBna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:43:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfGCBn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z5Qvl6kc9XmbA0m9wYlQFZjM3E5d4Ibz2pyToD4F6NM=; b=rkpBBg3EbEIpQbQqpkuRmtGXH
        z/Qqd2b1kGLkR2f/RqzKIXRNlbO7l8a7RKV5JaafjSodgNR9NZRJftkg0xj3D8lGTnD5MNru8DE3b
        E4mdJBqucQRo9lFn3kzfQxDyszLIiiWxgK7/MiAsU13+X6LkhSHQERWBiJPGJLaTW0trAGOuV6rmw
        yUCSTg6WqPKoLJWiFKhQ8Shr2EyrjPhssjsSQmcjbK28YC5ceapPS0FJD4AwIcQ6qoLLR5EjGeXTp
        bJxhKAWLghgjoFww33BxMrS9BSdD7GW6rOZ04cbQisyD7vNcaIs/1PwxXngQ2toRdD6LNu1kMzxtp
        VjuOOWm/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiQwB-0001DF-6n; Tue, 02 Jul 2019 22:07:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E21DF9802C5; Wed,  3 Jul 2019 00:07:39 +0200 (CEST)
Date:   Wed, 3 Jul 2019 00:07:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Subject: Re: objtool warnings in prerelease clang-9
Message-ID: <20190702220739.GJ32547@worktop.programming.kicks-ass.net>
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick,

That is good news; and I'll strive to read the email in more detail
in the morning when there is a better chance of me actually
understanding some of it :-)

But his here is something I felt needed clarification:

On Tue, Jul 02, 2019 at 01:53:51PM -0700, Nick Desaulniers wrote:
> Of interest are the disassembled __jump_table entries; in groups of
> three, there is a group for which the second element is duplicated
> with a previous group.  This is bad because (as explained by Peter in
> https://lkml.org/lkml/2019/6/27/118) the triples are in the form (code
> location, jump target, pointer to key).  Duplicate or repeated jump
> targets are unexpected, and will lead to incorrect control flow after
> patching such code locations.

> Also, the jump target should be 0x7 bytes ahead of the location, IIUC.

Even if you mean 'at least' I'm fairly sure this is not correct. The
instruction at the 'code location' is either a jmp.d32 or a nop5 (both 5
bytes). The target must (obviously) be at an instruction boundary, but
really can be anywhere (it is compiler generated after all).

