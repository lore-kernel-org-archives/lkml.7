Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A455BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717562133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfHNOUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfHNOUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:20:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 733FB83F3C;
        Wed, 14 Aug 2019 14:20:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5FD0710495B5;
        Wed, 14 Aug 2019 14:19:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Aug 2019 16:20:00 +0200 (CEST)
Date:   Wed, 14 Aug 2019 16:19:57 +0200
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
Message-ID: <20190814141956.GC11595@redhat.com>
References: <CAKmqyKMJPQAOKn11xepzAwXOd4e9dU0Cyz=A0T-uMEgUp5yJjA@mail.gmail.com>
 <20190814130732.23572-1-christian.brauner@ubuntu.com>
 <20190814130732.23572-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814130732.23572-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 14 Aug 2019 14:20:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14, Christian Brauner wrote:
>
> +static struct pid *find_get_pgrp(pid_t nr)
> +{
> +	struct pid *pid;
> +
> +	if (nr)
> +		return find_get_pid(nr);
> +
> +	rcu_read_lock();
> +	pid = get_pid(task_pgrp(current));
> +	rcu_read_unlock();
> +
> +	return pid;
> +}

I can't say I like this helper... even its name doesn't look good to me.

I forgot that we already have get_task_pid() when I replied to the previous
version... How about

	case P_PGID:

		if (upid)
			pid = find_get_pid(upid);
		else
			pid = get_task_pid(current, PIDTYPE_PGID);

?

Oleg.

