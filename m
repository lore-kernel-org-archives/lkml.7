Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B6C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6C6208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfHNOfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:35:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40825 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:35:49 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxuNP-0001Pa-BG; Wed, 14 Aug 2019 14:35:47 +0000
Date:   Wed, 14 Aug 2019 16:35:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        alistair23@gmail.com, ebiederm@xmission.com, arnd@arndb.de,
        dalias@libc.org, torvalds@linux-foundation.org,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        palmer@sifive.com, macro@wdc.com, zongbox@gmail.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, hpa@zytor.com
Subject: Re: [PATCH v2 1/1] waitid: Add support for waiting for the current
 process group
Message-ID: <20190814143545.tu6xfp2mxmnzwkx4@wittgenstein>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814130732.23572-1-christian.brauner@ubuntu.com>
 <20190814130732.23572-2-christian.brauner@ubuntu.com>
 <20190814141956.GC11595@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814141956.GC11595@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:19:57PM +0200, Oleg Nesterov wrote:
> On 08/14, Christian Brauner wrote:
> >
> > +static struct pid *find_get_pgrp(pid_t nr)
> > +{
> > +	struct pid *pid;
> > +
> > +	if (nr)
> > +		return find_get_pid(nr);
> > +
> > +	rcu_read_lock();
> > +	pid = get_pid(task_pgrp(current));
> > +	rcu_read_unlock();
> > +
> > +	return pid;
> > +}
> 
> I can't say I like this helper... even its name doesn't look good to me.

Well, naming scheme obviously stolen from find_get_pid(). Not sure if
that doesn't look good as well. ;)

> 
> I forgot that we already have get_task_pid() when I replied to the previous
> version... How about
> 
> 	case P_PGID:
> 
> 		if (upid)
> 			pid = find_get_pid(upid);
> 		else
> 			pid = get_task_pid(current, PIDTYPE_PGID);
> 
> ?

Hmyeah, that works but wouldn't it still be nicer to simply have:

static struct pid *get_pgrp(pid_t nr)
{
	if (nr)
		return find_get_pid(nr);

	return get_task_pid(current, PIDTYPE_PGID);
}

That allows us to have all cases equivalent with a single call to a
function without any if-elses.
Imho, this becomes especially nice when considering that P_PIDFD goes on
top of that:

	switch (which) {
	case P_ALL:
		type = PIDTYPE_MAX;
		break;
	case P_PID:
		type = PIDTYPE_PID;
		if (upid <= 0)
			return -EINVAL;

		pid = find_get_pid(upid);
		break;
	case P_PGID:
		type = PIDTYPE_PGID;
		if (upid < 0)
			return -EINVAL;

		pid = find_get_pgrp(upid);
		break;
	case P_PIDFD:
		type = PIDTYPE_PID;
		if (upid < 0)
			return -EINVAL;

		pid = pidfd_get_pid(upid);
		if (IS_ERR(pid))
			return PTR_ERR(pid);
		break;
	default:
		return -EINVAL;
	}

Christian
