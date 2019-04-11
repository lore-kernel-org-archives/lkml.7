Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A9AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C002146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDKWS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:18:57 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:53983 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfDKWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:18:57 -0400
Received: from localhost (unknown [134.134.139.76])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 846A7240003;
        Thu, 11 Apr 2019 22:18:47 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:18:45 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sinan Kaya <okaya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
Message-ID: <20190411221844.GB8692@localhost>
References: <20190411005634.8495-1-okaya@kernel.org>
 <CAGXu5jLU8Nh0+9rMSeOxwv4hUoPFWSiGf_L_SKpSHO_=VZxisg@mail.gmail.com>
 <CAK7LNAQqcKjs6Cnp5fK8OYhj2G_xbXpZc3WtTany3D+=RUpaew@mail.gmail.com>
 <CAGXu5jKnMUH_Gavg+6Q4ft98GxYZ49Z=fzUTHhzkfONSCL4ARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKnMUH_Gavg+6Q4ft98GxYZ49Z=fzUTHhzkfONSCL4ARg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:00:24AM -0700, Kees Cook wrote:
> On Wed, Apr 10, 2019 at 10:34 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Thu, Apr 11, 2019 at 11:47 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 5:56 PM Sinan Kaya <okaya@kernel.org> wrote:
> > > >
> > > > We can't seem to have a kernel with CONFIG_EXPERT set but
> > > > CONFIG_DEBUG_KERNEL unset these days.
> > > >
> > > > While some of the features under the CONFIG_EXPERT require
> > > > CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
> > > >
> > > > It looks like CONFIG_KALLSYMS_ALL is the only feature that
> > > > requires CONFIG_DEBUG_KERNEL.
> > > >
> > > > Select CONFIG_EXPERT when CONFIG_DEBUG_KERNEL is chosen but
> > > > you can still choose CONFIG_EXPERT without CONFIG_DEBUG_KERNEL.
> > > >
> > > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > >
> > > Masahiro, should this go via your tree, or somewhere else?
> >
> >
> > I think somewhere else.
> 
> Okay. Andrew, can you take this?

Echoing my comment from the previous thread: this does not seem like the
right solution to me and it introduces a new problem. Please see my
response to v2 for a quick alternative that would address the underlying
bug, which is that some code generation depends on DEBUG_KERNEL.
