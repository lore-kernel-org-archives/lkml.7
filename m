Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C783C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3320872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfDQNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:50:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbfDQNuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:50:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4178C3199386;
        Wed, 17 Apr 2019 13:50:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC5B160C64;
        Wed, 17 Apr 2019 13:50:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 Apr 2019 15:50:05 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:50:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't silently convert SI_USER signals to
 non-current pidfd
Message-ID: <20190417135002.GF32622@redhat.com>
References: <20190330021232.191205-1-jannh@google.com>
 <20190408131315.GA24111@redhat.com>
 <20190417130336.i55vmf3x6cby2mvi@brauner.io>
 <20190417131602.GE32622@redhat.com>
 <20190417131904.qjkv2xuenhcsz36l@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417131904.qjkv2xuenhcsz36l@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 17 Apr 2019 13:50:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17, Christian Brauner wrote:
>
> On Wed, Apr 17, 2019 at 03:16:03PM +0200, Oleg Nesterov wrote:
> > On 04/17, Christian Brauner wrote:
> > >
> > > On Mon, Apr 08, 2019 at 03:13:16PM +0200, Oleg Nesterov wrote:
> > > >
> > > > but perhaps it should always fail, even if task_pid(current) == pid.
> > > >
> > > > sys_rt_sigqueueinfo() allows to send any siginfo to yourself, but this is only needed
> > > > for checkpoint/restart.
> > >
> > > Yes, that's why this was added. I would leave it in exactly because of
> > > checkpoint/restart.
> >
> > I don't understand...
> >
> > c/r doesn't need this "feature" in pidfd_send_signal(), so it can be removed.
> > But,
>
> Just out of curiosity: in what sense? They don't need it since they have
> other ways of doing this

Yes. The restarting process needs to "restore" the pending signals, including the
signals with si_code >= 0. It does this using tgsigqueueinfo() and that is why we
allow this if the signal sent to itself.

So criu simply doesn't need pidfd_send_signal() to do this. And at the same time,

> or they *can't* use it for some other reason

Yes again. pidfd_send_signal() does kill_pid_info(), so it can't be used to restore
the "per-thread" task->pending signals.

Oleg.

