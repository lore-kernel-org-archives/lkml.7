Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5851A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfDQPVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfDQPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:21:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1700630016F2;
        Wed, 17 Apr 2019 15:21:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D2855C207;
        Wed, 17 Apr 2019 15:20:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 Apr 2019 17:21:05 +0200 (CEST)
Date:   Wed, 17 Apr 2019 17:20:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v1 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
Message-ID: <20190417152055.GJ32622@redhat.com>
References: <20190416170233.10208-1-christian@brauner.io>
 <20190416170233.10208-4-christian@brauner.io>
 <20190417140106.GG32622@redhat.com>
 <20190417141144.k2kmg7hd7pdpywyw@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417141144.k2kmg7hd7pdpywyw@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 17 Apr 2019 15:21:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17, Christian Brauner wrote:
>
> On Wed, Apr 17, 2019 at 04:01:06PM +0200, Oleg Nesterov wrote:
> > On 04/16, Christian Brauner wrote:
> > >
> > > @@ -3581,12 +3588,12 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> > >  	if (flags)
> > >  		return -EINVAL;
> > >
> > > -	f = fdget_raw(pidfd);
> > > +	f = fdget(pidfd);
> >
> > could you explain this change?
> >
> > I am just curious, I don't understand why should we disallow O_PATH and how
> > this connects to this patch.
>
> Sending a signal through a pidfd is considered to be on a par with a
> "write" to that pidfd.

OK, but how this connects to "support pidfds" ?

> Additionally, we use the fops associated with the fd to detect whether
> it is actually a pidfd or not. This is not possible with O_PATH since
> f_ops will be set to dummy fops.

indeed... I didn't know this, thanks!

But this means that pidfd_send_signal() will return -EBADF with or without
this change; pidfd_to_pid() will return -EBADF even if fdget_raw() suceeds,
right?

To clarify, I am not arguing. I am trying to understand why exactly do we
need this s/fdget_raw/fdget/ change and, why it doesn't come as a separate
patch. Can you add a note into the changelog?

Oleg.

