Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12DFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7682021479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbfDROK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:10:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388346AbfDROKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:10:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82D048046F;
        Thu, 18 Apr 2019 14:10:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2FE5E1001E8A;
        Thu, 18 Apr 2019 14:10:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Apr 2019 16:10:24 +0200 (CEST)
Date:   Thu, 18 Apr 2019 16:10:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v2 2/5] clone: add CLONE_PIDFD
Message-ID: <20190418141019.GD13701@redhat.com>
References: <20190418101841.4476-1-christian@brauner.io>
 <20190418101841.4476-3-christian@brauner.io>
 <20190418131206.GB13701@redhat.com>
 <20190418132822.untjt7erfvbbiz7a@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418132822.untjt7erfvbbiz7a@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 18 Apr 2019 14:10:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18, Christian Brauner wrote:
>
> On Thu, Apr 18, 2019 at 03:12:07PM +0200, Oleg Nesterov wrote:
> > Should we allow CLONE_THREAD | CLONE_PIDFD ?
>
> I think so, yes. I have thought about this.

OK, I won't insist. But let me explain why did I ask.

> Yes, due to CLONE_FILES |
> CLONE_VM you'd necessarily hand the pidfd to the child but threads are
> no security boundary in the first place.

No, no, I am not not worried about security. CLONE_PARENT | CLONE_PIDFD
looks more problematic to me, but I see nothing dangerous security-wise..

I agree that CLONE_THREAD | CLONE_PIDFD may be usefule, but I am not sure
we should allow this from the very begining, until we have a "real" use-case.

IIUC, we are going to make it pollable soon. OK, but proc_tgid_base_poll()
(which should be turned into pidfd_poll) simply can't work if pid_task() is
not a group leader. poll(pidfd) will hang forever if pidfd was created by
CLONE_THREAD | CLONE_PIDFD.

Sure, we can (should?) improve pidfd_poll() but this will need more nasty
changes in the core kernel code. Do we really need/want this? Right now it
is not clear to me. Instead, we can simply disallow CLONE_THREAD|CLONE_PIDFD
until we decide that yes, we want to poll sub-threads.

But again, I am fine with CLONE_THREAD | CLONE_PIDFD.

Oleg.

