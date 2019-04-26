Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E3C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFFB2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfDZJAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:00:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfDZJAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:00:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04ECAAF8D;
        Fri, 26 Apr 2019 09:00:49 +0000 (UTC)
Date:   Fri, 26 Apr 2019 11:00:48 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     live-patching@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, mliska@suse.cz, hubicka@ucw.cz
Subject: Re: Livepatch vs LTO
In-Reply-To: <20190425152628.ogk4woi3omeocwly@treble>
Message-ID: <alpine.LSU.2.21.1904261054240.27157@pobox.suse.cz>
References: <20190425152628.ogk4woi3omeocwly@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding CCs ]

On Thu, 25 Apr 2019, Josh Poimboeuf wrote:

> Hi all,
> 
> On IRC, Peter expressed some concern about -flive-patching, specifically
> that the flag isn't compatible with LTO.
> 
> The upstream kernel currently doesn't support LTO, but Android is using
> it with LLVM:
> 
>   https://source.android.com/devices/tech/debug/kcfi
> 
> And there seems to be progress being made in that direction for
> upstream.
> 
> Live patching has at least the following issues with LTO:
> 
> - For source-based patch generation (klp-convert and friends), the GCC
>   manual says that -flive-patching is incompatible with LTO.  Does
>   anybody know if that's a hard incompatibility, or can it be fixed?

Honza could know more. It was either that LTO by itself complicates 
things for live patching, or that LTO adds more optimizations which are 
potentially unsafe.

>   Also, what about the performance implications of this flag with LTO?
>   Might they become more pronounced?

It could. Theoretically. The scope for optimizations would be much 
broader.

>   Also I wonder if -fdump-ipa-clones works with LTO?

It should. According to Martin, there is (almost) nothing special about 
LTO. Optimization infrastructure is the same, only the scope is not 
limited to one translation unit.

>   I also wonder about the future of source-based patch generation with
>   LLVM.  Will it also have -flive-patching and -fdump-ipa-clones flags?

Honestly no idea.

> - For binary-based patch generation (kpatch-build), we currently diff
>   objects at a per-compilation-unit level.  That would have to be
>   changed to work on vmlinux.o instead.
> 
> - Objtool would also have to be changed to work on vmlinux.o.  It's
>   currently not optimized for large files, and the per-.o whitelisting
>   would need to be fixed.  And there may be other issues lurking.
> 
> Also, thinking about objtool in this context has given me another idea,
> which might allow us to get rid of the use of -flive-patching and
> -fdump-ipa-clones altogether (which are both nasty and way too
> compiler-dependent):
> 
> Since objtool is already reading every function in the kernel, it could
> create a checksum associated with each function, based on all the
> instructions (both within the function and any alternatives or other
> special sections it relies on).  The function checksums could be written
> to a file.
> 
> Then, when a patch file is applied and the kernel rebuilt, the checksum
> files could be compared to determine exactly which functions have
> changed at a binary level.
> 
> Thoughts?  Any reasons why that wouldn't work?

I think it could work. If nothing else, it would give us the information 
we look for.
 
> And, if we wanted to take the idea even further, objtool could have the
> ability to write the changed functions to a new object file.  Voila, we
> now pretty much have kpatch-build :-)  (Though whether this is better
> than source-based patch generation is certainly an open question.)

...worth of discussion.

Miroslav
