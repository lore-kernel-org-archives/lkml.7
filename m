Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F73F206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 10:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfDOKwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfDOKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 06:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48E3481F18;
        Mon, 15 Apr 2019 10:52:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7BBC319C4F;
        Mon, 15 Apr 2019 10:52:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Apr 2019 12:52:14 +0200 (CEST)
Date:   Mon, 15 Apr 2019 12:52:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH 2/4] clone: add CLONE_PIDFD
Message-ID: <20190415105209.GA22204@redhat.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <20190414201436.19502-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414201436.19502-3-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Apr 2019 10:52:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14, Christian Brauner wrote:
>
> @@ -2260,6 +2363,10 @@ long _do_fork(unsigned long clone_flags,
>  	}
>
>  	put_pid(pid);
> +
> +	if (clone_flags & CLONE_PIDFD)
> +		nr = pidfd;
> +

Well, this doesn't look nice ...

CLONE_PARENT_SETTID doesn't look very usefule, so what if we add

	if ((clone_flags & (CLONE_PIDFD|CLONE_PARENT_SETTID)) ==
	                   (CLONE_PIDFD|CLONE_PARENT_SETTID))
		return ERR_PTR(-EINVAL);

at the start of copy_process() ?

Then it can do

	if (clone_flags & CLONE_PIDFD) {
		retval = pidfd_create(pid, &pidfdf);
		if (retval < 0)
			goto bad_fork_free_pid;
		retval = put_user(retval, parent_tidptr)
		if (retval < 0)
			goto bad_fork_free_pid;
	}

Oleg.

