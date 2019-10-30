Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C1420862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IssXzYXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJ3Isd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:48:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49871 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbfJ3Isd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572425311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxeEn5vTSgM9eH45CLFbxbgOktGOR7e/qmHK5tiEGJk=;
        b=IssXzYXl9/vHSxtrz5a68oG78qscf2mKO/J9CYeJrw5mBGzptdjsUbE672flCahWg+PFUN
        zih+z7Xz0h07ZzStsMHxhsGBQ+hvdSOr52q7kxTsAPG9vAtADRlOM0yhcB2JWCNq47XpKS
        PKBbjBx+6aqjUiXb+XcwgkLK81Q4LmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-uXwssujUOo-NFLOe28wEEA-1; Wed, 30 Oct 2019 04:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4808481A334;
        Wed, 30 Oct 2019 08:48:27 +0000 (UTC)
Received: from ovpn-116-229.phx2.redhat.com (ovpn-116-229.phx2.redhat.com [10.3.116.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA6BE5D6D8;
        Wed, 30 Oct 2019 08:48:26 +0000 (UTC)
Message-ID: <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Oct 2019 03:48:26 -0500
In-Reply-To: <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
References: <20191028150716.22890-1-frederic@kernel.org>
         <20191029100506.GJ4114@hirez.programming.kicks-ass.net>
Organization: Red Hat
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: uXwssujUOo-NFLOe28wEEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-29 at 11:05 +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2019 at 04:07:16PM +0100, Frederic Weisbecker wrote:
> > From: Scott Wood <swood@redhat.com>
> >=20
> > The way loadavg is tracked during nohz only pays attention to the load
> > upon entering nohz. This can be particularly noticeable if nohz is
> > entered while non-idle, and then the cpu goes idle and stays that way
> > for
> > a long time. We've had reports of a loadavg near 150 on a mostly idle
> > system.
> >=20
> > Calling calc_load_nohz_start() regardless of whether the tick is alread=
y
> > stopped addresses the issue when going idle. Tracking load changes when
> > not going idle (e.g. multiple SCHED_FIFO tasks coming and going) is not
> > addressed by this patch.
>=20
> Hurph, is that phenomena you describe NOHZ or NOHZ_FULL? Because that
> second thing you talk about, multiple SCHED_FIFO tasks running without a
> tick is definitely NOHZ_FULL.
>=20
> I'm thinking all of this is NOHZ_FULL because IIRC we always start the
> tick when there is a runnable task. So your example of going idle in
> NOHZ already cannot happen for regular NOHZ.

Yes, NOHZ_FULL (sorry for not stating that clearly).

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index eb42b71faab9..209e50d48f80 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3666,6 +3666,8 @@ static void sched_tick_remote(struct work_struct
> *work)
>  =09 * having one too much is no big deal because the scheduler tick
> updates
>  =09 * statistics and checks timeslices in a time-independent way,
> regardless
>  =09 * of when exactly it is running.
> +=09 *
> +=09 * XXX should we be checking tick_nohz_tick_stopped_cpu() under rq-
> >lock ?
>  =09 */
>  =09if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
>  =09=09goto out_requeue;
> @@ -3686,6 +3688,7 @@ static void sched_tick_remote(struct work_struct
> *work)
>  =09curr->sched_class->task_tick(rq, curr, 0);
> =20
>  out_unlock:
> +=09calc_load_nohz_remote(cpu);
>  =09rq_unlock_irq(rq, &rf);

This gets skipped when the cpu is idle, so it still misses the update.

-Scott


