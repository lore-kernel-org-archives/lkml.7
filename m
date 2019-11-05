Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340E7CA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E7620717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBgezIEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfKEHbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:31:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20722 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387600AbfKEHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572939066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHReKse73AQnSHcme7E8f8Vyl/mg0rmuMzvQCRAY+aE=;
        b=FBgezIEL2XYbaVm37AlPoXg3nBog9gXqFc0mXe82CrGDwuU120NvvPV0WxwY3EGNopGoJC
        p+wPz1ZzGz1i01fqGBc1/9VmMuy362q2uqAECp+1FDG/HVzvcYdtaA41sZXmjexOrKvK8A
        jXeay8tQ+owRTMNPc4tkmd/T/imzopI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-DM8vDMqKO9usoenquEioSQ-1; Tue, 05 Nov 2019 02:31:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D5118017DD;
        Tue,  5 Nov 2019 07:31:00 +0000 (UTC)
Received: from ovpn-116-229.phx2.redhat.com (ovpn-116-229.phx2.redhat.com [10.3.116.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24D15D9CD;
        Tue,  5 Nov 2019 07:30:59 +0000 (UTC)
Message-ID: <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 05 Nov 2019 01:30:58 -0600
In-Reply-To: <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de>
References: <20191028150716.22890-1-frederic@kernel.org>
          <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
          <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
          <20191030133130.GY4097@hirez.programming.kicks-ass.net>
         <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
         <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DM8vDMqKO9usoenquEioSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 00:43 +0100, Thomas Gleixner wrote:
> On Mon, 4 Nov 2019, Thomas Gleixner wrote:
> > On Fri, 1 Nov 2019, Scott Wood wrote:
> > > On Wed, 2019-10-30 at 14:31 +0100, Peter Zijlstra wrote:
> > > > Oh argh! that's a bit radical of the remote tick. The normal tick
> > > > runs
> > > > just fine on idle CPUs, so lets mirror that.
> > > >=20
> > > > How's this then?
> >=20
> > ....
> > =20
> > > Needs to be tick_nohz_tick_stopped_cpu(cpu)
> > >=20
> > > After fixing that, I get:
> > >=20
> > > [    7.439068] WARNING: CPU: 20 PID: 7 at
> > > /home/root/linux/kernel/sched/core.c:3681
> > > sched_tick_remote+0x132/0x150
> >=20
> > So I'm going to apply Scotts patch if nobody comes up with a better ide=
a
> > until tomorrow.
>=20
> As Peter pointed out to me privately we should rather go and analyze the
> real thing instead of just applying duct tape.
>=20
> /me drops the patch again.

The warning is due to kernel/sched/idle.c not updating curr->se.exec_start.

While debugging I noticed an issue with a particular load pattern.  The CPU
goes non-nohz for a brief time at an interval very close to twice=20
tick_period.  When the tick is started, the timer expiration is more than
tick_period in the past, so hrtimer_forward() tries to catch up by adding
2*tick_period to the expiration.  Then the tick is stopped before that new
expiration, and when the tick is woken up the expiry is again advanced by
2*tick_period with the timer never actually running.  sched_tick_remote()
does fire every second, but there are streaks of several seconds where it
keeps catching the CPU in a non-nohz state, so neither the normal nor remot=
e
ticks are calling calc_load_nohz_remote().

Is there a reason to not just remove the hrtimer_forward() from
tick_nohz_restart(), letting the timer fire if it's in the past, which will
take care of doing hrtimer_forward()?

As for the warning in sched_tick_remote(), it seems like a test for time
since the last tick on this cpu (remote or otherwise) would be better than
relying on curr->se.exec_start, in order to detect things like this.

-Scott


