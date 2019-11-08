Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34583C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2EA2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrYB+Fht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfKHIQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:16:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729873AbfKHIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573200969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OWhrJuGG8I8MK3cBXJGxKE/Vl+p35G59zs3aVFZAFsY=;
        b=UrYB+FhtdL82XPBLtI8c6yNPFIR6yCIYzmukSI2drGAEOARdZHUIjUyCdTTTgu3f8/datX
        ovaW4iv0wVIE1ZOtqGeetBvFgcIKGVjzD1sJbBCR5p2zbwMSS0AyB8NYZzxvvdL7ss1LWc
        AyzqthhVBDMSPz4b3B/829i8RTKFNKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-uy4gF92MPDWWLDxkCeCvWQ-1; Fri, 08 Nov 2019 03:16:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB72E1800DFB;
        Fri,  8 Nov 2019 08:16:04 +0000 (UTC)
Received: from ovpn-116-229.phx2.redhat.com (ovpn-116-229.phx2.redhat.com [10.3.116.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 642F3271AF;
        Fri,  8 Nov 2019 08:16:04 +0000 (UTC)
Message-ID: <37e46985b60839190f65c764da7c2eb2877d53b9.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Nov 2019 02:16:03 -0600
In-Reply-To: <alpine.DEB.2.21.1911051048190.17054@nanos.tec.linutronix.de>
References: <20191028150716.22890-1-frederic@kernel.org>
           <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
           <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
           <20191030133130.GY4097@hirez.programming.kicks-ass.net>
          <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>
          <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>
          <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de>
         <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
         <alpine.DEB.2.21.1911051048190.17054@nanos.tec.linutronix.de>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uy4gF92MPDWWLDxkCeCvWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 10:53 +0100, Thomas Gleixner wrote:
> On Tue, 5 Nov 2019, Scott Wood wrote:
> > On Tue, 2019-11-05 at 00:43 +0100, Thomas Gleixner wrote:
> > > As Peter pointed out to me privately we should rather go and analyze
> > > the
> > > real thing instead of just applying duct tape.
> > >=20
> > > /me drops the patch again.
> >=20
> > The warning is due to kernel/sched/idle.c not updating curr-
> > >se.exec_start.
> >=20
> > While debugging I noticed an issue with a particular load pattern.  The
> > CPU
> > goes non-nohz for a brief time at an interval very close to twice=20
> > tick_period.  When the tick is started, the timer expiration is more
> > than
> > tick_period in the past, so hrtimer_forward() tries to catch up by
> > adding
> > 2*tick_period to the expiration.  Then the tick is stopped before that
> > new
> > expiration, and when the tick is woken up the expiry is again advanced
> > by
> > 2*tick_period with the timer never actually
> > running.  sched_tick_remote()
> > does fire every second, but there are streaks of several seconds where
> > it
> > keeps catching the CPU in a non-nohz state, so neither the normal nor
> > remote
> > ticks are calling calc_load_nohz_remote().
> >=20
> > Is there a reason to not just remove the hrtimer_forward() from
> > tick_nohz_restart(), letting the timer fire if it's in the past, which
> > will
> > take care of doing hrtimer_forward()?
>=20
> Well, no. tick_nohz_restart() can be invoked in a situation where the
> timer
> is armed for something in the far future (or completelt disabled) due to
> previously entering an estimated long idle (or user space execution on
> NOHZ_FULL) period.
>=20
> That means if the timer is not canceled, realigned to the current tick an=
d
> forwarded to the next due tick, the tick will not fire on time causing
> another sort of trouble.

That might be true of the expiry on entering tick_nohz_restart(), but it
shouldn't be true of ts->last_tick which the expiry is set to before callin=
g
hrtimer_forward() -- and if it were, hrtimer_forward() is a no-op when the
expiry is in the future.

BTW, the name "last_tick" seems misleading as it's actually the saved
expiry, not the last time the tick ran.

-Scott


