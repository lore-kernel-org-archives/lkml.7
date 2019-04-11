Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40D720850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfDKWeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:34:36 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50693 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfDKWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:34:36 -0400
Received: from localhost (unknown [134.134.139.76])
        (Authenticated sender: josh@joshtriplett.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B1810200008;
        Thu, 11 Apr 2019 22:34:26 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:34:24 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
Message-ID: <20190411223423.GD8692@localhost>
References: <20190410224213.20651-1-okaya@kernel.org>
 <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
 <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
 <CAGXu5jLc_Z=TiNsMd40GN8-0D117RVbdD7Hy4MzjPQNbFf=bcg@mail.gmail.com>
 <FF2E07CA-99D7-4F9C-B281-425897535C84@joshtriplett.org>
 <e901a9cc-f335-fb31-535c-97dce2ca8f5b@kernel.org>
 <20190411221645.GA8692@localhost>
 <CAGXu5jKa4dUuCxc1kPdRGH5qrXeH0y09hnScb41-SQDo_amv8Q@mail.gmail.com>
 <c3d57b73-c282-6114-52a8-2375b5dd0b61@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d57b73-c282-6114-52a8-2375b5dd0b61@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 06:27:04PM -0400, Sinan Kaya wrote:
> On 4/11/2019 6:21 PM, Kees Cook wrote:
> > > Proposed alternative plan: let's add a new symbol, something like
> > > DEBUG_MISC ("Miscellaneous debug code that should be under a more
> > > specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
> > > "default DEBUG_KERNEL" but allow itself to be turned off, and then
> > > mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
> > > "#ifdef CONFIG_DEBUG_MISC".
> > > 
> > > Does that sound like an appropriately rapid solution for this bug?
> > Sure, that sounds fine to me. Sinan can you take care of that for v4?
> 
> Sure, let me work on this.

Thank you both! I really appreciate that.
