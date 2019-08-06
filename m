Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC76C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25002089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565102173;
	bh=kCYuK7jsaRb+EulCep8i2uBtT2+apq+LDv+IlfpiwtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cq1qqEpFfi7Nl/S/f/bLwmMfnTAZ1FvW2TrrJam0MMzC0jla2VPH4eZz87QSzOK8s
	 f5mojsha592Z6YC5fe3oZBGmosM+2fPdol1uXBjqyrY7NOlspBcJQowcLoROddmq/o
	 qNE5pAWhJ2oZTGsv0oLJEcJAiIE7DuLMPt98IDjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfHFOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:36:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbfHFOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:36:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E64CAE1B;
        Tue,  6 Aug 2019 14:36:10 +0000 (UTC)
Date:   Tue, 6 Aug 2019 16:36:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190806143608.GE11812@dhcp22.suse.cz>
References: <d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com>
 <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806142728.GA12107@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-08-19 10:27:28, Johannes Weiner wrote:
> On Tue, Aug 06, 2019 at 11:36:48AM +0200, Vlastimil Babka wrote:
> > On 8/6/19 3:08 AM, Suren Baghdasaryan wrote:
> > >> @@ -1280,3 +1285,50 @@ static int __init psi_proc_init(void)
> > >>         return 0;
> > >>  }
> > >>  module_init(psi_proc_init);
> > >> +
> > >> +#define OOM_PRESSURE_LEVEL     80
> > >> +#define OOM_PRESSURE_PERIOD    (10 * NSEC_PER_SEC)
> > > 
> > > 80% of the last 10 seconds spent in full stall would definitely be a
> > > problem. If the system was already low on memory (which it probably
> > > is, or we would not be reclaiming so hard and registering such a big
> > > stall) then oom-killer would probably kill something before 8 seconds
> > > are passed.
> > 
> > If oom killer can act faster, than great! On small embedded systems you probably
> > don't enable PSI anyway?
> > 
> > > If my line of thinking is correct, then do we really
> > > benefit from such additional protection mechanism? I might be wrong
> > > here because my experience is limited to embedded systems with
> > > relatively small amounts of memory.
> > 
> > Well, Artem in his original mail describes a minutes long stall. Things are
> > really different on a fast desktop/laptop with SSD. I have experienced this as
> > well, ending up performing manual OOM by alt-sysrq-f (then I put more RAM than
> > 8GB in the laptop). IMHO the default limit should be set so that the user
> > doesn't do that manual OOM (or hard reboot) before the mechanism kicks in. 10
> > seconds should be fine.
> 
> That's exactly what I have experienced in the past, and this was also
> the consistent story in the bug reports we have had.
> 
> I suspect it requires a certain combination of RAM size, CPU speed,
> and IO capacity: the OOM killer kicks in when reclaim fails, which
> happens when all scanned LRU pages were locked and under IO. So IO
> needs to be slow enough, or RAM small enough, that the CPU can scan
> all LRU pages while they are temporarily unreclaimable (page lock).
> 
> It may well be that on phones the RAM is small enough relative to CPU
> size.
> 
> But on desktops/servers, we frequently see that there is a wider
> window of memory consumption in which reclaim efficiency doesn't drop
> low enough for the OOM killer to kick in. In the time it takes the CPU
> to scan through RAM, enough pages will have *just* finished reading
> for reclaim to free them again and continue to make "progress".
> 
> We do know that the OOM killer might not kick in for at least 20-25
> minutes while the system is entirely unresponsive. People usually
> don't wait this long before forcibly rebooting. In a managed fleet,
> ssh heartbeat tests eventually fail and force a reboot.
> 
> I'm not sure 10s is the perfect value here, but I do think the kernel
> should try to get out of such a state, where interacting with the
> system is impossible, within a reasonable amount of time.
> 
> It could be a little too short for non-interactive number-crunching
> systems...

Would it be possible to have a module with tunning knobs as parameters
and hook into the PSI infrastructure? People can play with the setting
to their need, we wouldn't really have think about the user visible API
for the tuning and this could be easily adopted as an opt-in mechanism
without a risk of regressions.

I would really love to see a simple threshing watchdog like the one you
have proposed earlier. It is self contained and easy to play with if the
parameters are not hardcoded.

-- 
Michal Hocko
SUSE Labs
