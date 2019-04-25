Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE6EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A9A20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfDYSse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYSse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2C9988E63;
        Thu, 25 Apr 2019 18:48:33 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD1A60BE5;
        Thu, 25 Apr 2019 18:48:30 +0000 (UTC)
Date:   Thu, 25 Apr 2019 13:48:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Livepatch vs LTO
Message-ID: <20190425184829.wcpgmt3xxuucq4oc@treble>
References: <20190425152628.ogk4woi3omeocwly@treble>
 <18a4eaae-e874-8568-9372-337ea1ce301b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18a4eaae-e874-8568-9372-337ea1ce301b@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 25 Apr 2019 18:48:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:22:23PM -0400, Joe Lawrence wrote:
> On 4/25/19 11:26 AM, Josh Poimboeuf wrote:
> > Hi all,
> > 
> > On IRC, Peter expressed some concern about -flive-patching, specifically
> > that the flag isn't compatible with LTO.
> > 
> > The upstream kernel currently doesn't support LTO, but Android is using
> > it with LLVM:
> > 
> >    https://source.android.com/devices/tech/debug/kcfi
> > 
> > And there seems to be progress being made in that direction for
> > upstream.
> > 
> > Live patching has at least the following issues with LTO:
> > 
> > - For source-based patch generation (klp-convert and friends), the GCC
> >    manual says that -flive-patching is incompatible with LTO.  Does
> >    anybody know if that's a hard incompatibility, or can it be fixed?
> > 
> >    Also, what about the performance implications of this flag with LTO?
> >    Might they become more pronounced?
> > 
> >    Also I wonder if -fdump-ipa-clones works with LTO?
> > 
> >    I also wonder about the future of source-based patch generation with
> >    LLVM.  Will it also have -flive-patching and -fdump-ipa-clones flags?
> > 
> > - For binary-based patch generation (kpatch-build), we currently diff
> >    objects at a per-compilation-unit level.  That would have to be
> >    changed to work on vmlinux.o instead.
> > 
> > - Objtool would also have to be changed to work on vmlinux.o.  It's
> >    currently not optimized for large files, and the per-.o whitelisting
> >    would need to be fixed.  And there may be other issues lurking.
> > 
> > Also, thinking about objtool in this context has given me another idea,
> > which might allow us to get rid of the use of -flive-patching and
> > -fdump-ipa-clones altogether (which are both nasty and way too
> > compiler-dependent):
> 
> Would objtool work around these issues because it would (pending the above
> changes) operate on post-LTO object files?

No, my idea below would work either way (LTO or not).

With the current approach of objtool running per .o file, it could
create a function checksum file per .o file.

With objtool running once on vmlinux.o, it would instead just make one
big function checksum file for vmlinux.o, plus one per kernel module.

> > Since objtool is already reading every function in the kernel, it could
> > create a checksum associated with each function, based on all the
> > instructions (both within the function and any alternatives or other
> > special sections it relies on).  The function checksums could be written
> > to a file.
> > 
> > Then, when a patch file is applied and the kernel rebuilt, the checksum
> > files could be compared to determine exactly which functions have
> > changed at a binary level.
> > 
> > Thoughts?  Any reasons why that wouldn't work?
> 
> This is an interesting option.  Keep in mind, like kpatch-build, it would
> detect changes as a result of source code line number positioning, ie WARN_*
> or might_sleep macros that kpatch-build currently detects and chooses to
> ignore.  Not a big deal, but warts like this start introducing more
> instruction decoding into the process.

True.

> Also, I think a klp-convert type script would still be needed to create
> livepatch symbols and their corresponding sections and relocations, right?

Right.  Unless we did the option I mentioned below where objtool would
become a full kpatch-build replacement.

> However, we might not need manual symbol <obj, pos> annotations to pull this
> off since presumably the object will have already built/linked.  I think.

Actually I'm not sure about that.  Even when analyzing vmlinux.o, the
object hasn't been fully linked so the final addresses aren't known.

> I've only just started looking at klp-convert and asm alternatives, but
> maybe this would also help determine the alteratives-relocation to
> klp_object relationship that we will need if we want klp-convert to create
> klp.arch sections.

TBH, I'm a bit behind on that discussion :-)

> > And, if we wanted to take the idea even further, objtool could have the
> > ability to write the changed functions to a new object file.  Voila, we
> > now pretty much have kpatch-build :-)  (Though whether this is better
> > than source-based patch generation is certainly an open question.)
> 
> Porting objtool to new arches is probably easier than kpatch-build at least.

Yeah.  And there's really a lot of overlap between the two, so it could
potentially be a decent option.

-- 
Josh
