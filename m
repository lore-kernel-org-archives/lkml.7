Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F066FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD5F206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTFteTCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfLJRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:30:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52740 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727516AbfLJRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575999017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5UMSx3WXyq4ntdzIIdQoavJRcBpD/Cn3JiwPc8bV3Q=;
        b=DTFteTCV1pT+xpOr+Xishfx2kNwEEjUAomPss8VU30Jtt7jArFtC1Dwd4zSh67K3iPS3NH
        bfkh1t9uR2K1PtTSJUHwJp1TmyHaoWMTj476bsfu+GLXjrSwAOJwnQ3sV0uDd5LqS0b2YF
        8oNh/ZqlVlGGk23uvkqFTOIxMXo41Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-v0TME5MqNNmT5BaY1JpOjg-1; Tue, 10 Dec 2019 12:30:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04C31800D45;
        Tue, 10 Dec 2019 17:30:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-205-240.brq.redhat.com [10.40.205.240])
        by smtp.corp.redhat.com (Postfix) with SMTP id 91BCE60BE0;
        Tue, 10 Dec 2019 17:30:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 10 Dec 2019 18:30:14 +0100 (CET)
Date:   Tue, 10 Dec 2019 18:30:08 +0100
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
Message-ID: <20191210173007.GA14449@redhat.com>
References: <CAHk-=whiKy63tpFVUUS1sH07ce692rKcoo0ztnHw5UaPaMg8Ng@mail.gmail.com>
 <20191209091813.GA41320@gmail.com>
 <20191209120852.GA5388@redhat.com>
 <20191210072921.GB114501@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191210072921.GB114501@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: v0TME5MqNNmT5BaY1JpOjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, Ingo Molnar wrote:
>
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -290,6 +290,11 @@ long prepare_to_wait_event(struct wait_queue_head *w=
q_head, struct wait_queue_en
>  =09=09 * But we need to ensure that set-condition + wakeup after that
>  =09=09 * can't see us, it should wake up another exclusive waiter if
>  =09=09 * we fail.
> +=09=09 *
> +=09=09 * In other words, if an exclusive waiter got here, then the
> +=09=09 * waitqueue condition is and stays true and we are guaranteed
> +=09=09 * to exit the waitqueue loop and will ignore the -ERESTARTSYS
> +=09=09 * and return success.
>  =09=09 */
>  =09=09list_del_init(&wq_entry->entry);
>  =09=09ret =3D -ERESTARTSYS;

Agreed, this makes it more clear... but at the same time technically this i=
s
not 100% correct, or perhaps I misread this comment.

We are not guaranteed to return success even if condition =3D=3D T and we w=
ere
woken up as an exclusive waiter, another waiter can consume the condition.
But this is fine. Say,

=09long LOCK;
=09wait_queue_head WQ;

=09int lock()
=09{
=09=09return wait_event_interruptible_exclusive(&WQ, xchg(&LOCK, 1) =3D=3D =
0);
=09}

=09void unlock()
=09{
=09=09xchg(&LOCK, 0);
=09=09wake_up(&WQ, TASK_NORMAL);
=09}

A woken exclusive waiter can return -ERESTARTSYS if it races with another
lock(), or it races with another sleeping waiter woken up by the signal,
this is fine.

So may be

=09=09 * In other words, if an exclusive waiter got here and the
=09=09 * waitqueue condition is and stays true, then we are guaranteed
=09=09 * to exit the waitqueue loop and will ignore the -ERESTARTSYS
=09=09 * and return success.

is more accurate?

Oleg.

