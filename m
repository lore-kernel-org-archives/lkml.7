Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D7D2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfCFTFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfCFTE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:04:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4D4CC057F4D;
        Wed,  6 Mar 2019 19:04:59 +0000 (UTC)
Received: from treble (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07FD419007;
        Wed,  6 Mar 2019 19:04:58 +0000 (UTC)
Date:   Wed, 6 Mar 2019 13:04:57 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] x86/unwind/orc: Fix ORC unwind table alignment
Message-ID: <20190306190457.lj46nmqfxvixjnfj@treble>
References: <d55027ee95fe73e952dcd8be90aebd31b0095c45.1551892041.git.jpoimboe@redhat.com>
 <CAKwvOdmHe-bkt34E5yf81GoiFRHR8EPnu8wqk2aD2u8P_4Q5jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmHe-bkt34E5yf81GoiFRHR8EPnu8wqk2aD2u8P_4Q5jQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 06 Mar 2019 19:04:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:44:01AM -0800, Nick Desaulniers wrote:
> On Wed, Mar 6, 2019 at 9:08 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > The .orc_unwind section is a packed array of 6-byte structs.  It's
> > currently aligned to 6 bytes, which is causing warnings in the LLD
> > linker.
> >
> > Six isn't a power of two, so it's not a valid alignment value.  The
> > actual alignment doesn't matter much because it's an array of packed
> > structs.  An alignment of two is sufficient.  In reality it always gets
> > aligned to four bytes because it comes immediately after the
> > 4-byte-aligned .orc_unwind_ip section.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/218
> > Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
> 
> Thanks for the patch Josh, we appreciate it.  It looks like
> ee9f8fce9964 landed in v4.14-rc1.  Should we CC stable?

Yes, that would be a good idea.

Can the tip maintainers please add

  Cc: stable@vger.kernel.org

when merging?

-- 
Josh
