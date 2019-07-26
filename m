Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719ACC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F162086D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGZKC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZKC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA20F30970CF;
        Fri, 26 Jul 2019 10:02:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id C18D65DA97;
        Fri, 26 Jul 2019 10:02:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 26 Jul 2019 12:02:56 +0200 (CEST)
Date:   Fri, 26 Jul 2019 12:02:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com
Subject: Re: [OFFLIST] [PATCH v1 0/2] pidfd: waiting on processes through
 pidfds
Message-ID: <20190726100252.GB16112@redhat.com>
References: <20190726093934.13557-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726093934.13557-1-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 26 Jul 2019 10:02:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

just fyi, can't read this patch till Monday


On 07/26, Christian Brauner wrote:
> Hey everyone,
> 
> /* v1 */
> This adds the ability to wait on processes using pidfds. This is one of
> the few missing pieces to make it possible to manage processes using
> only pidfds.
> 
> Please note the following major changes (More details can be found in
> the individual commit changelogs.):
> - Add the new type P_PIDFD to waitid() instead of a new dedicated
>   pidfd_wait() syscall.
>   This is the same approach we discussed a few months ago and still
>   prefer over adding a dedicated syscall.
> - Adapt the tests to the new type P_PIDFD for waitid().
> - Remove struct waitid_info patch.
>   This will be sent out as a separate patch.
> - Remove CLONE_WAIT_PID patch.
>   This will be sent out as a separate patch.
> 
> The core patch for waitid is pleasantly small. The largest change is
> caused by adding proper tests for waitid(P_PIDFD).
> 
> /* v0 */
> Link: https://lore.kernel.org/lkml/20190724144651.28272-1-christian@brauner.io
> 
> Thanks!
> Christian
> 
> Christian Brauner (2):
>   pidfd: add P_PIDFD to waitid()
>   pidfd: add pidfd_wait tests
> 
>  include/linux/pid.h                        |   4 +
>  include/uapi/linux/wait.h                  |   1 +
>  kernel/exit.c                              |  25 ++-
>  kernel/fork.c                              |   8 +
>  kernel/signal.c                            |   7 +-
>  tools/testing/selftests/pidfd/pidfd.h      |  25 +++
>  tools/testing/selftests/pidfd/pidfd_test.c |  14 --
>  tools/testing/selftests/pidfd/pidfd_wait.c | 245 +++++++++++++++++++++
>  8 files changed, 311 insertions(+), 18 deletions(-)
>  create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c
> 
> -- 
> 2.22.0
> 

