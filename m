Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4EFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BD620663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYWX6ZGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbfKGPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:51:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727142AbfKGPvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573141903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mwYqD5W078qyciDk7k9AIq+YAsZM74It8HoGfRNTJNo=;
        b=TYWX6ZGE4IJEAt1aJ/ZImSHHmMd4MjzLwhYtEESGP6zsIymlB9KgxO/dtfdl+ZcY7EqNVf
        o/ZqbKbWvsiBnQn+D+jItihdcfRETBb6raXIosU/sixM7jbUy0MsucfBk9JZ1DTIbTsrvd
        pGRae5VXBYe5Cu1wxV0QdkXe3XGIQ2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-2iala_i5O12Cmv23G3z22Q-1; Thu, 07 Nov 2019 10:51:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3A1C477;
        Thu,  7 Nov 2019 15:51:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id CE1C3100032F;
        Thu,  7 Nov 2019 15:51:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  7 Nov 2019 16:51:35 +0100 (CET)
Date:   Thu, 7 Nov 2019 16:51:30 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Weimer <fweimer@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: handle_exit_race && PF_EXITING
Message-ID: <20191107155130.GB24042@redhat.com>
References: <alpine.DEB.2.21.1911051800070.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051851380.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051920420.1869@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1911051959260.1869@nanos.tec.linutronix.de>
 <20191106085529.GA12575@redhat.com>
 <alpine.DEB.2.21.1911061028020.1869@nanos.tec.linutronix.de>
 <20191106103509.GB12575@redhat.com>
 <alpine.DEB.2.21.1911061154520.1869@nanos.tec.linutronix.de>
 <20191106121111.GC12575@redhat.com>
 <alpine.DEB.2.21.1911061808030.1869@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911061808030.1869@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2iala_i5O12Cmv23G3z22Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06, Thomas Gleixner wrote:
>
> On Wed, 6 Nov 2019, Oleg Nesterov wrote:
> >
> > I think that (with or without this fix) handle_exit_race() logic needs
> > cleanups, there is no reason for get_futex_value_locked(), we can drop
> > ->pi_lock right after we see PF_EXITPIDONE. Lets discuss this later.
>
> Which still is in atomic because the hash bucket lock is held, ergo
> get_futex_value_locked() needs to stay for now.

Indeed, you are right.

> Same explanation as before just not prosa this time:
>
> exit()=09=09=09=09=09lock_pi(futex2)
>   exit_pi_state_list()
>    lock(tsk->pi_lock)
>    tsk->flags |=3D PF_EXITPIDONE;=09=09 attach_to_pi_owner()
> =09=09=09=09=09  ...
>   // Loop unrolled for clarity
>   while(!list_empty())=09=09=09  lock(tsk->pi_lock);
>      cleanup(futex1)
>        unlock(tsk->pi_lock)
         ^^^^^^^^^^^^^^^^^^^^
Ah! Thanks.


Hmm. In particular, exit_pi_state() drops pi_lock if refcount_inc_not_zero(=
) fails.

Isn't this another potential source of livelock ?

Suppose that a realtime lock owner X sleeps somewhere, another task T
calls put_pi_state(), refcount_dec_and_test() succeeds.

What if, say, X is killed right after that and preempts T on the same
CPU?

Oleg.

