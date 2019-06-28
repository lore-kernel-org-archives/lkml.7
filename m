Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0434C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C40C2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF1Bxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF1Bxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:53:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5210886668;
        Fri, 28 Jun 2019 01:53:30 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41FAF608A7;
        Fri, 28 Jun 2019 01:53:29 +0000 (UTC)
Date:   Thu, 27 Jun 2019 20:53:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Michael Forney <mforney@mforney.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        elftoolchain-developers@lists.sourceforge.net
Subject: Re: [PATCH 1/2] objtool: Rename elf_open to prevent conflict with
 libelf from elftoolchain
Message-ID: <20190628015326.z64wbie7ex5pfs2v@treble>
References: <20190616231500.8572-1-mforney@mforney.org>
 <20190628002208.v6brs6b6hf7b6sth@treble>
 <CAGw6cBuaMoZQK-hV+Ztg5uFqPU3dY6L7um1bzsxVPQfaX4JA7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGw6cBuaMoZQK-hV+Ztg5uFqPU3dY6L7um1bzsxVPQfaX4JA7g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 01:53:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 05:52:53PM -0700, Michael Forney wrote:
> On 2019-06-27, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Sun, Jun 16, 2019 at 04:14:59PM -0700, Michael Forney wrote:
> >> Signed-off-by: Michael Forney <mforney@mforney.org>
> >> ---
> >>  tools/objtool/check.c | 2 +-
> >>  tools/objtool/elf.c   | 2 +-
> >>  tools/objtool/elf.h   | 2 +-
> >>  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > Sorry for the delay, I was out for a bit and I'm still trying to get
> > caught back up on email.
> 
> No worries :)
> 
> > These patches look fine.  I'll try to send them on to the -tip tree
> > shortly.
> 
> Thanks!
> 
> > Just curious, have you done much testing with the elftoolchain version
> > of libelf and objtool?  So far objtool has only been successfully used
> > with the elfutils version, so I'm just curious how compatible your
> > libelf is with the elfutils version.
> 
> I'm not affiliated with elftoolchain, I am just trying it out on my
> system as an alternative to elfutils libelf for its clean codebase
> that doesn't use many GNU C extensions.
> 
> I've done some basic testing to make sure that the .o files after
> being processed with `objtool generate --no-fp --retpoline` match
> between elfutils and elftoolchain. I noticed two differences, one of
> which was due to a bug in elftoolchain that has since been fixed, and
> the other is with the offset of SHT_NOBITS section after rewriting[0],
> which I think doesn't matter.

Awesome, that gives me a lot more confidence.  Thanks!

-- 
Josh
