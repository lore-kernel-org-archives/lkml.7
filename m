Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C64C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8795A214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 14:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfIOOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 10:14:24 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53701 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfIOOOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:14:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0TcNDfjk_1568556842;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TcNDfjk_1568556842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 Sep 2019 22:14:08 +0800
Date:   Sun, 15 Sep 2019 22:14:02 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190915141402.GA1349@aaronlu>
References: <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu>
 <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu>
 <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 07:12:52AM +0800, Aubrey Li wrote:
> On Thu, Sep 12, 2019 at 8:04 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> >
> > On Wed, Sep 11, 2019 at 09:19:02AM -0700, Tim Chen wrote:
> > > On 9/11/19 7:02 AM, Aaron Lu wrote:
> > > I think Julien's result show that my patches did not do as well as
> > > your patches for fairness. Aubrey did some other testing with the same
> > > conclusion.  So I think keeping the forced idle time balanced is not
> > > enough for maintaining fairness.
> >
> > Well, I have done following tests:
> > 1 Julien's test script: https://paste.debian.net/plainh/834cf45c
> > 2 start two tagged will-it-scale/page_fault1, see how each performs;
> > 3 Aubrey's mysql test: https://github.com/aubreyli/coresched_bench.git
> >
> > They all show your patchset performs equally well...And consider what
> > the patch does, I think they are really doing the same thing in
> > different ways.
> 
> It looks like we are not on the same page, if you don't mind, can both of
> you rebase your patchset onto v5.3-rc8 and provide a public branch so I
> can fetch and test it at least by my benchmark?

I'm using the following branch as base which is v5.1.5 based:
https://github.com/digitalocean/linux-coresched coresched-v3-v5.1.5-test

And I have pushed Tim's branch to:
https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-tim

Mine:
https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-core_vruntime

The two branches both have two patches I have sent previouslly:
https://lore.kernel.org/lkml/20190810141556.GA73644@aaronlu/
Although it has some potential performance loss as pointed out by
Vineeth, I haven't got time to rework it yet.
