Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B3C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234D2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCJU3wUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLIRia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:38:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbfLIRia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575913108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cskWMHDbaOvsYGdMAJALBwtGm8+LhVNrf6PtRp0lH0k=;
        b=eCJU3wUOAmKdDX3kML10s9V6X1Pvwt+u1m/lROvPBX8YgmBVOjRWUF1mxA10EukSZPu4vv
        M6MMUWcbM9DLUg/6z1U/4hEL7AJNvirsFGODhlFSywz4AHE8ralQI+XYeLuLpdygJD88sC
        dKXOqZXBtVm6/PeuVYnDaxPYLUUlM+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-Nv0cIWjkNI-Qijna-0c6mw-1; Mon, 09 Dec 2019 12:38:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F9EE1005512;
        Mon,  9 Dec 2019 17:38:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 87BCE5D6B7;
        Mon,  9 Dec 2019 17:38:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  9 Dec 2019 18:38:25 +0100 (CET)
Date:   Mon, 9 Dec 2019 18:38:20 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: Fundamental race condition in
 wait_event_interruptible_exclusive() ?
Message-ID: <20191209173820.GA11415@redhat.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Nv0cIWjkNI-Qijna-0c6mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have alredy replied to Ingo, but if I was not clear...

On 12/08, Linus Torvalds wrote:
>
> The reason it is buggy is that wait_event_interruptible_exclusive()
> does this (inside the __wait_event() macro that it expands to):
>
>                 long __int =3D prepare_to_wait_event(&wq_head,
> &__wq_entry, state);\
>
>          \
>                 if (condition)
>          \
>                         break;
>          \
>
>          \
>                 if (___wait_is_interruptible(state) && __int) {
>          \
>                         __ret =3D __int;
>          \
>                         goto __out;
>          \
>
> and the thing is, if does that "__ret =3D __int" case and returns
> -ERESTARTSYS, it's possible that the wakeup event has already been
> consumed,

Afaics, no.

> because we've added ourselves as an exclusive writer to the
> queue. So it _says_ it was interrupted, not woken up, and the wait got
> cancelled, but because we were an exclusive waiter, we might be the
> _only_ thing that got woken up,

And that is why ___wait_event() always checks the condition after
prepare_to_wait_event(), whatever it returns.

And. If it actually does "__ret =3D __int" and returns -ERESTARTSYS, then
this task was already removed from the list, so we should not worry about
the case when wake_up() comes after prepare_to_wait_event().

> And the basic point is that the return value
> from wait_event_interruptible_exclusive() seems to not really be
> reliable. You can't really use it -

see above ...

> even if it says you got
> interrupted, you still have to go back and check the condition and do
> the work, and only do interruptability handling after that.

This is exactly what ___wait_event() does. Even if prepare_to_wait_event()
says you got interrupted, it still checks the condition and returns success
if it is true.

Oleg.

