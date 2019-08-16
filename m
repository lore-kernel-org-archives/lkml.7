Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A5FC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221621874
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHPCdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:25 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37697 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbfHPCdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0TZayJcx_1565922789;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TZayJcx_1565922789)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Aug 2019 10:33:15 +0800
Date:   Fri, 16 Aug 2019 10:33:09 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
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
Message-ID: <20190816023309.GA78614@aaronlu>
References: <20190619183302.GA6775@sinkpad>
 <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
 <bd1f79c0a9aed2dfae3bb9f5df24fcf5528e3864.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1f79c0a9aed2dfae3bb9f5df24fcf5528e3864.camel@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 06:09:28PM +0200, Dario Faggioli wrote:
> On Wed, 2019-08-07 at 10:10 -0700, Tim Chen wrote:
> > On 8/7/19 1:58 AM, Dario Faggioli wrote:
> > 
> > > Since I see that, in this thread, there are various patches being
> > > proposed and discussed... should I rerun my benchmarks with them
> > > applied? If yes, which ones? And is there, by any chance, one (or
> > > maybe
> > > more than one) updated git branch(es)?
> > > 
> > Hi Dario,
> > 
> Hi Tim!
> 
> > Having an extra set of eyes are certainly welcomed.
> > I'll give my 2 cents on the issues with v3.
> > 
> Ok, and thanks a lot for this.
> 
> > 1) Unfairness between the sibling threads
> > -----------------------------------------
> > One sibling thread could be suppressing and force idling
> > the sibling thread over proportionally.  Resulting in
> > the force idled CPU not getting run and stall tasks on
> > suppressed CPU.
> > 
> > 
> > [...]
> >
> > 2) Not rescheduling forced idled CPU
> > ------------------------------------
> > The forced idled CPU does not get a chance to re-schedule
> > itself, and will stall for a long time even though it
> > has eligible tasks to run.
> > 
> > [...]
> > 
> > 3) Load balancing between CPU cores
> > -----------------------------------
> > Say if one CPU core's sibling threads get forced idled
> > a lot as it has mostly incompatible tasks between the siblings,
> > moving the incompatible load to other cores and pulling
> > compatible load to the core could help CPU utilization.
> > 
> > So just considering the load of a task is not enough during
> > load balancing, task compatibility also needs to be considered.
> > Peter has put in mechanisms to balance compatible tasks between
> > CPU thread siblings, but not across cores.
> > 
> > [...]
> >
> Ok. Yes, as said, I've been trying to follow the thread, but thanks a
> lot again for this summary.
> 
> As said, I'm about to have numbers for the repo/branch I mentioned.
> 
> I was considering whether to also re-run the benchmarking campaign with
> some of the patches that floated around within this thread. Now, thanks
> to your summary, I have an even clearer picture about which patch does
> what, and that is indeed very useful.
> 
> I'll see about putting something together. I'm thinking of picking:
> 
> https://lore.kernel.org/lkml/b7a83fcb-5c34-9794-5688-55c52697fd84@linux.intel.com/
> https://lore.kernel.org/lkml/20190725143344.GD992@aaronlu/
> 
> And maybe even (part of):
> https://lore.kernel.org/lkml/20190810141556.GA73644@aaronlu/#t
> 
> If anyone has ideas or suggestions about whether or not this choice
> makes sense, feel free to share. :-)

Makes sense to me.
patch3 in the last link is slightly better than the one in the 2nd link,
so just use that instead.

Thanks,
Aaron

> Also, I only have another week before leaving, so let's see what I
> manage to actually run, and then share here, by then.
> 
> Thanks and Regards
> -- 
> Dario Faggioli, Ph.D
> http://about.me/dario.faggioli
> Virtualization Software Engineer
> SUSE Labs, SUSE https://www.suse.com/
> -------------------------------------------------------------------
> <<This happens because _I_ choose it to happen!>> (Raistlin Majere)
> 


