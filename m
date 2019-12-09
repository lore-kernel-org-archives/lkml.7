Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C157CC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E022077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLEgXA5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfLINAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:00:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727268AbfLINAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575896421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PToppvBGgoJ4HzIVSd6dCqQlJDe/OieeWuQiyuHp0M0=;
        b=eLEgXA5AXnf7S16iG2LUvWBg1+ccGpNNFboSCevSBaqpM/Wg30ly3vC8MzY/RlfIQIyh+a
        SfT8BFwKvfF5VsNMvg/duJXW4WA8JW2KVAzTO7djS476H08aNi3LzUbS3mPctDuSAlPGHH
        O14c7QcV49Y1ertARQok4mmW9bjvEDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-1En_jaMEOCKjZftqq0Zc6A-1; Mon, 09 Dec 2019 08:00:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B98C718A8C8A;
        Mon,  9 Dec 2019 13:00:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0526B6E531;
        Mon,  9 Dec 2019 13:00:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  9 Dec 2019 14:00:15 +0100 (CET)
Date:   Mon, 9 Dec 2019 14:00:06 +0100
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
Message-ID: <20191209130005.GB5388@redhat.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
 <20191209102759.GA123769@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191209102759.GA123769@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1En_jaMEOCKjZftqq0Zc6A-1
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
> Any consumed exclusive event is handled in finish_wait_exclusive() now:
>
> +               } else {
> +                       /* We got removed from the waitqueue already, wak=
e up the next exclusive waiter (if any): */
> +                       if (interrupted && waitqueue_active(wq_head))
> +                               __wake_up_locked_key(wq_head, TASK_NORMAL=
, NULL);

See my previous email, I don't think we need this...

But if we do this, then __wake_up_locked_key(key =3D> NULL) doesn't look ri=
ght.
It should use the same "key" which was passed to __wake_up(key) which remov=
ed
us from list.

Currently this doesn't really matter, the only user of prepare_to_wait_even=
t()
which relies on the "keyed" wakeup is ___wait_var_event() and it doesn't ha=
ve
"exclusive" waiters, but still.

Hmm. and it seems that init_wait_var_entry() is buggy? Again, currently thi=
s
doesn't matter, but don't we need the trivial fix below?

Oleg.

--- x/kernel/sched/wait_bit.c
+++ x/kernel/sched/wait_bit.c
@@ -179,6 +179,7 @@ void init_wait_var_entry(struct wait_bit
 =09=09=09.bit_nr =3D -1,
 =09=09},
 =09=09.wq_entry =3D {
+=09=09=09.flags=09 =3D flags,
 =09=09=09.private =3D current,
 =09=09=09.func=09 =3D var_wake_function,
 =09=09=09.entry=09 =3D LIST_HEAD_INIT(wbq_entry->wq_entry.entry),

