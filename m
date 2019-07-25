Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB2622CBD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404226AbfGYLoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbfGYLoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92FC37BEE3;
        Thu, 25 Jul 2019 11:44:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 34D3A60BEC;
        Thu, 25 Jul 2019 11:44:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Jul 2019 13:44:03 +0200 (CEST)
Date:   Thu, 25 Jul 2019 13:43:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725114359.GH4707@redhat.com>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
 <20190725112503.GG4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725112503.GG4707@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 25 Jul 2019 11:44:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Or. We can change wait_consider_task() to not clear ->notask_error if
WXXX and the child is PF_WAIT_PID.

This way you can "safely" use wait() without WNOHANG, it won't block if
all the children which can report an even are PF_WAIT_PID.

But I do not understand your use-cases, I have no idea if this can help
or not. Just I think the more discussion is always better when we are
going to add the new API.


On 07/25, Oleg Nesterov wrote:
>
> On 07/25, Christian Brauner wrote:
> >
> > On Thu, Jul 25, 2019 at 12:35:44PM +0200, Oleg Nesterov wrote:
> > >
> > > I have to admit this feature looks a bit exotic to me...
> >
> > It might look like it from the kernels perspective but from the feedback
> > on this when presenting on this userspace has real usecases for this.
> 
> OK...
> 
> but then perhaps we can make PF_WAIT_PID more flexible.
> 
> Say, we can add the new WXXX wait option and change eligible_child()
> 
> 	if ((p->flags & PF_WAIT_PID) && (wo->options & WXXX))
> 		return 0;
> 
> this way the parent can tell waitid() whether the PF_WAIT_PID tasks should
> be filtered or not.
> 
> And if we do this we can even add PR_SET_WAIT_PID/PR_CLR_WAIT_PID instead
> of the new CLONE_ flag.
> 
> Oleg.

