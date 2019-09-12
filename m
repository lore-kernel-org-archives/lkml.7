Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D7C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A387820830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfILMr5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:47:57 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:65204 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730454AbfILMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:47:56 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18464153-1500050 
        for multiple; Thu, 12 Sep 2019 13:47:50 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Wilck <Martin.Wilck@suse.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wjKv_Zw2zGHduyrQH_VQzxXYzwKdwwzzpsdnsdx=EK30Q@mail.gmail.com>
Cc:     Michal Koutny <MKoutny@suse.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "leho@kraav.com" <leho@kraav.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
 <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
 <20190910142047.GB3029@papaya>
 <3dcff41048621ff440687dd6691aae31a8647a1e.camel@suse.com>
 <CAHk-=wjKv_Zw2zGHduyrQH_VQzxXYzwKdwwzzpsdnsdx=EK30Q@mail.gmail.com>
Message-ID: <156829246802.4926.7844021009098193103@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: 5.3-rc3: Frozen graphics with kcompactd migrating i915 pages
Date:   Thu, 12 Sep 2019 13:47:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2019-09-12 12:59:25)
> On Thu, Sep 12, 2019 at 12:51 PM Martin Wilck <Martin.Wilck@suse.com> wrote:
> >
> > Is there an alternative to reverting aa56a292ce62 ("drm/i915/userptr:
> > Acquire the page lock around set_page_dirty()")? And if we do, what
> > would be the consequences? Would other patches need to be reverted,
> > too?
> 
> Looking at that commit, and the backtrace of the lockup, I think that
> reverting it is the correct thing to do.
> 
> You can't take the page lock in invalidate_range(), since it's called
> from try_to_unmap(), which is called with the page lock already held.
> 
> So commit aa56a292ce62 is just fundamentally completely wrong and
> should be reverted.

There's still the dilemma that we get called without the page lock, but
at this moment in time in order to hit 5.3, it needs a revert sent
directly to Linus.
-Chris
