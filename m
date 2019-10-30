Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87316CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50528205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2w0T/n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfJ3RpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:45:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbfJ3RpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572457500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNO/CUUGCo/7bROHXKMU3mQ4pgifuylbmZ7CpRkXffI=;
        b=X2w0T/n9wCyjMfUb+SbhfYxk86RU6flmwBZ/G5+ZbynzCuS/w7XNbvWA2Wg57z7tU69baa
        /6teyuCcQ7eYdhH0cCl6IgnrsGjcL0ygVJ39fcj2VZ8VkeO1Je9V/G58IoB4O8KAYUPLh5
        j9xUAuCOu9+irtM0vEErLUoVJVhEo1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-FTdKIhYkOrifUHVxTwYiRQ-1; Wed, 30 Oct 2019 13:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9A2107ACC0;
        Wed, 30 Oct 2019 17:44:43 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 409F219757;
        Wed, 30 Oct 2019 17:44:42 +0000 (UTC)
Date:   Wed, 30 Oct 2019 13:44:40 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191030174440.GI1686@pauld.bos.csb>
References: <20191024123844.GB2708@pauld.bos.csb>
 <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
 <564ca629-5c34-dbd1-8e64-2da6910b18a3@arm.com>
 <bf96be8a-2358-b9ab-b8eb-d0b8b94ed0d7@arm.com>
 <20191030171914.GF1686@pauld.bos.csb>
 <CAKfTPtDVJH_eGiHCyz1Boz4m0tqMP3rgbSoudZ+9kPXB4_aGnQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDVJH_eGiHCyz1Boz4m0tqMP3rgbSoudZ+9kPXB4_aGnQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FTdKIhYkOrifUHVxTwYiRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 06:28:50PM +0100 Vincent Guittot wrote:
> On Wed, 30 Oct 2019 at 18:19, Phil Auld <pauld@redhat.com> wrote:
> >
> > Hi,
> >
> > On Wed, Oct 30, 2019 at 05:35:55PM +0100 Valentin Schneider wrote:
> > >
> > >
> > > On 30/10/2019 17:24, Dietmar Eggemann wrote:
> > > > On 30.10.19 15:39, Phil Auld wrote:
> > > >> Hi Vincent,
> > > >>
> > > >> On Mon, Oct 28, 2019 at 02:03:15PM +0100 Vincent Guittot wrote:
> > > >
> > > > [...]
> > > >
> > > >>>> When you say slow versus fast wakeup paths what do you mean? I'm=
 still
> > > >>>> learning my way around all this code.
> > > >>>
> > > >>> When task wakes up, we can decide to
> > > >>> - speedup the wakeup and shorten the list of cpus and compare onl=
y
> > > >>> prev_cpu vs this_cpu (in fact the group of cpu that share their
> > > >>> respective LLC). That's the fast wakeup path that is used most of=
 the
> > > >>> time during a wakeup
> > > >>> - or start to find the idlest CPU of the system and scan all doma=
ins.
> > > >>> That's the slow path that is used for new tasks or when a task wa=
kes
> > > >>> up a lot of other tasks at the same time
> > > >
> > > > [...]
> > > >
> > > > Is the latter related to wake_wide()? If yes, is the SD_BALANCE_WAK=
E
> > > > flag set on the sched domains on your machines? IMHO, otherwise tho=
se
> > > > wakeups are not forced into the slowpath (if (unlikely(sd))?
> > > >
> > > > I had this discussion the other day with Valentin S. on #sched and =
we
> > > > were not sure how SD_BALANCE_WAKE is set on sched domains on
> > > > !SD_ASYM_CPUCAPACITY systems.
> > > >
> > >
> > > Well from the code nobody but us (asymmetric capacity systems) set
> > > SD_BALANCE_WAKE. I was however curious if there were some folks who s=
et it
> > > with out of tree code for some reason.
> > >
> > > As Dietmar said, not having SD_BALANCE_WAKE means you'll never go thr=
ough
> > > the slow path on wakeups, because there is no domain with SD_BALANCE_=
WAKE for
> > > the domain loop to find. Depending on your topology you most likely w=
ill
> > > go through it on fork or exec though.
> > >
> > > IOW wake_wide() is not really widening the wakeup scan on wakeups usi=
ng
> > > mainline topology code (disregarding asymmetric capacity systems), wh=
ich
> > > sounds a bit... off.
> >
> > Thanks. It's not currently set. I'll set it and re-run to see if it mak=
es
> > a difference.
>=20
> Because the fix only touches the slow path and according to Valentin
> and Dietmar comments on the wake up path, it would mean that your UC
> creates regularly some new threads during the test ?
>=20

I believe it is not creating any new threads during each run.=20


> >
> >
> > However, I'm not sure why it would be making a difference for only the =
cgroup
> > case. If this is causing issues I'd expect it to effect both runs.
> >
> > In general I think these threads want to wake up the last cpu they were=
 on.
> > And given there are fewer cpu bound tasks that CPUs that wake cpu shoul=
d,
> > more often than not, be idle.
> >
> >
> > Cheers,
> > Phil
> >
> >
> >
> > --
> >

--=20

