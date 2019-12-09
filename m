Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD25C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB24207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoxVbfAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLIMJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:09:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbfLIMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575893341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX+67ZmyIXVMB/vHTra+DNSxKSbnpWTCuPptcTimGIc=;
        b=UoxVbfAP3vdd53gpPJ9JLo31ebuop2o9BKVh+ZA3cC3SGz0hp/faLRgWdZqSndtQAFaDhy
        dXjmqEgcoY6hl/TBbfoT12VmdVSpkeFmxsGMlYeih4ClfmEZAwoLv7ZXXgI6QFaSWo+HGy
        57INynqy2mbZX+D+NEFaphqxXfh5vTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-eas5Il7rOry9-2VuAlTcLg-1; Mon, 09 Dec 2019 07:09:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C40721005502;
        Mon,  9 Dec 2019 12:08:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5972060BEC;
        Mon,  9 Dec 2019 12:08:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  9 Dec 2019 13:08:58 +0100 (CET)
Date:   Mon, 9 Dec 2019 13:08:53 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [RFC PATCH] sched/wait: Make interruptible exclusive waitqueue
 wakeups reliable
Message-ID: <20191209120852.GA5388@redhat.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191209091813.GA41320@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eas5Il7rOry9-2VuAlTcLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09, Ingo Molnar wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > The reason it is buggy is that wait_event_interruptible_exclusive()
> > does this (inside the __wait_event() macro that it expands to):
> >
> >                 long __int =3D prepare_to_wait_event(&wq_head, &__wq_en=
try, state);
> >
> >                 if (condition)
> >                         break;
> >                 if (___wait_is_interruptible(state) && __int) {
> >                         __ret =3D __int;
> >                         goto __out;
> >
> > and the thing is, if does that "__ret =3D __int" case and returns
> > -ERESTARTSYS,

But note that it checks "condition" after prepare_to_wait_event(), if it is
true then ___wait_is_interruptible() won't be even called.

> it's possible that the wakeup event has already been
> > consumed, because we've added ourselves as an exclusive writer to the
> > queue. So it _says_ it was interrupted, not woken up, and the wait got
> > cancelled, but because we were an exclusive waiter, we might be the
> > _only_ thing that got woken up, and the wakeup basically got forgotten
> > - all the other exclusive waiters will remain waiting.
>
> So the place that detects interruption is prepare_to_wait_event():

Yes,

> long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_q=
ueue_entry *wq_entry, int state)
> {
>         unsigned long flags;
>         long ret =3D 0;
>
>         spin_lock_irqsave(&wq_head->lock, flags);
>         if (signal_pending_state(state, current)) {
>                 /*
>                  * Exclusive waiter must not fail if it was selected by w=
akeup,
>                  * it should "consume" the condition we were waiting for.
>                  *
>                  * The caller will recheck the condition and return succe=
ss if
>                  * we were already woken up, we can not miss the event be=
cause
>                  * wakeup locks/unlocks the same wq_head->lock.
>                  *
>                  * But we need to ensure that set-condition + wakeup afte=
r that
>                  * can't see us, it should wake up another exclusive wait=
er if
>                  * we fail.
>                  */
>                 list_del_init(&wq_entry->entry);
>                 ret =3D -ERESTARTSYS;

...

> I think we can indeed lose an exclusive event here, despite the comment
> that argues that we shouldn't: if we were already removed from the list

If we were already removed from the list and condition is true, we can't
miss it, ret =3D -ERESTARTSYS won't be used. This is what this part of the
comment above

=09 * The caller will recheck the condition and return success if
=09 * we were already woken up, we can not miss the event because
=09 * wakeup locks/unlocks the same wq_head->lock.

tries to explain.

> then list_del_init() does nothing and loses the exclusive event AFAICS.

list_del_init() ensures that wake_up() can't pick this task after
prepare_to_wait_event() returns.

IOW. Suppose that ___wait_event() races with

=09condition =3D true;
=09wake_up();

if wake_up() happens before prepare_to_wait_event(), __wait_event() will
see condition =3D=3D true, -ERESTARTSYS returned by prepare_to_wait_event()=
 has
no effect.

If wake_up() comes after prepare_to_wait_event(), the task was already remo=
ved
from the list, another exclusive waiter (if any) will be woken up. In this =
case
__wait_event() can return success or -ERESTARTSYS, both are correct.

No?

Oleg.

