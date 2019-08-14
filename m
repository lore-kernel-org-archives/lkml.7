Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E55C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12FD2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfHNP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:27:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15555 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHNP1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:27:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4944A81DF7;
        Wed, 14 Aug 2019 15:27:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2794F8069C;
        Wed, 14 Aug 2019 15:27:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Aug 2019 17:27:16 +0200 (CEST)
Date:   Wed, 14 Aug 2019 17:27:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v2 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814152712.GE11595@redhat.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814130732.23572-1-christian.brauner@ubuntu.com>
 <20190814130732.23572-2-christian.brauner@ubuntu.com>
 <20190814141956.GC11595@redhat.com>
 <20190814143545.tu6xfp2mxmnzwkx4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814143545.tu6xfp2mxmnzwkx4@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 14 Aug 2019 15:27:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Christian Brauner wrote:
>
> On Wed, Aug 14, 2019 at 04:19:57PM +0200, Oleg Nesterov wrote:
> > On 08/14, Christian Brauner wrote:
> > >
> > > +static struct pid *find_get_pgrp(pid_t nr)
> > > +{
> > > +	struct pid *pid;
> > > +
> > > +	if (nr)
> > > +		return find_get_pid(nr);
> > > +
> > > +	rcu_read_lock();
> > > +	pid = get_pid(task_pgrp(current));
> > > +	rcu_read_unlock();
> > > +
> > > +	return pid;
> > > +}
> >
> > I can't say I like this helper... even its name doesn't look good to me.
>
> Well, naming scheme obviously stolen from find_get_pid(). Not sure if
> that doesn't look good as well. ;)

find_get_pid() actually tries to find a pid. The helper above does "find"
or "use current" depending on nr != 0.

> > I forgot that we already have get_task_pid() when I replied to the previous
> > version... How about
> >
> > 	case P_PGID:
> >
> > 		if (upid)
> > 			pid = find_get_pid(upid);
> > 		else
> > 			pid = get_task_pid(current, PIDTYPE_PGID);
> >
> > ?
>
> Hmyeah, that works but wouldn't it still be nicer to simply have:
>
> static struct pid *get_pgrp(pid_t nr)
> {
> 	if (nr)
> 		return find_get_pid(nr);
>
> 	return get_task_pid(current, PIDTYPE_PGID);
> }

Who else can ever use it?

It saves 4 lines in kernel_waitid() but adds 7 lines outside, and you
need another ^] to see these lines if you try to understand what
PIDTYPE_PGID actually does. IOW, I think this helper will make waitid
less readable for no reason.


Christian, I try to never argue when it comes to cosmetic issues, and
in this case I won't insist too.

Oleg.

