Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C68ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F0205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfJOPnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731230AbfJOPnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFE75A3CD81;
        Tue, 15 Oct 2019 15:43:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 754425D9CD;
        Tue, 15 Oct 2019 15:43:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Oct 2019 17:43:31 +0200 (CEST)
Date:   Tue, 15 Oct 2019 17:43:27 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Christian Kellner <christian@kellner.me>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org, Jann Horn <jannh@google.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] pidfd: verify task is alive when printing fdinfo
Message-ID: <20191015154327.GB16978@redhat.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
 <20191015144356.GA16978@redhat.com>
 <20191015145646.72eqrw6j52ehvfn2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015145646.72eqrw6j52ehvfn2@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 15 Oct 2019 15:43:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15, Christian Brauner wrote:
>
> On Tue, Oct 15, 2019 at 04:43:57PM +0200, Oleg Nesterov wrote:
> > But in fact I'd suggest to simply use !hlist_empty(&pid->tasks[PIDTYPE_PID])
> > in pidfd_show_fdinfo() and do not add a new helper.
>
> Sounds good to me. But can't we then just do something similar just with
> !hlist_empty(&pid->tasks[PIDTYPE_TGID])
>
> in v5.4-rc3:kernel/pid.c:pidfd_open():514-517 ?

Agreed. Actually, it seems to me I suggested to use rcu_lock_acquire() rather
than rcu_read_lock() in pidfd_open() too.

But hlist_empty(pid->tasks[type]) looks even better.

If you decide to add a new helper, you can also change do_wait() which checks
hlist_empty(&wo->wo_pid->tasks[wo->wo_type]). May be even __change_pid().

Oleg.

