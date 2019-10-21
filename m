Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F789CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539EC20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFg8OOv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfJUMAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:00:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48825 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfJUMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571659239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM1ipbW/NO3Ed+8uSTRI6lzRbVyT5XdIRw7D6wPdv/w=;
        b=bFg8OOv+CASYiqAFat3ZjUx3CZ5hMCZSRwGxP63Shxg+YFD2HU2RheVyYRAxPD/0GVl6+6
        xdrbe39NrjxHiNscLNGVnT412qqRaAHoYC1Bvts6W7lNElg0BR8vO367PSZNgVXDMKviYc
        uVMB+AyHv4xIeeRyhPB7YqQezoHq9P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-Y0FPjqH6PhiULItWA-_CgA-1; Mon, 21 Oct 2019 08:00:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57D682B7;
        Mon, 21 Oct 2019 12:00:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7A48D60CD0;
        Mon, 21 Oct 2019 12:00:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Oct 2019 14:00:33 +0200 (CEST)
Date:   Mon, 21 Oct 2019 14:00:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot <syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: KCSAN: data-race in exit_signals / prepare_signal
Message-ID: <20191021120029.GA24935@redhat.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021111920.frmc3njkha4c3a72@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191021111920.frmc3njkha4c3a72@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Y0FPjqH6PhiULItWA-_CgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21, Christian Brauner wrote:
>
> This traces back to Oleg fixing a race between a group stop and a thread
> exiting before it notices that it has a pending signal or is in the middl=
e of
> do_exit() already, causing group stop to get wacky.
> The original commit to fix this race is
> commit d12619b5ff56 ("fix group stop with exit race") which took sighand
> lock before setting PF_EXITING on the thread.

Not really... sig_task_ignored() didn't check task->flags until the recent
33da8e7c81 ("signal: Allow cifs and drbd to receive their terminating signa=
ls").
But I think this doesn't matter, see below.

> If the race really matters and given how tsk->flags is currently accessed
> everywhere the simple fix for now might be:
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c4da1ef56fdf..cf61e044c4cc 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2819,7 +2819,9 @@ void exit_signals(struct task_struct *tsk)
>         cgroup_threadgroup_change_begin(tsk);
>
>         if (thread_group_empty(tsk) || signal_group_exit(tsk->signal)) {
> +               spin_lock_irq(&tsk->sighand->siglock);
>                 tsk->flags |=3D PF_EXITING;
> +               spin_unlock_irq(&tsk->sighand->siglock);

Well, exit_signals() tries to avoid ->siglock in this case....

But this doesn't matter. IIUC the problem is not that exit_signals() sets
PF_EXITING, the problem is that it writes to tsk->flags and kasan detects
the data race.

For example, freezable_schedule() which sets PF_FREEZER_SKIP can equally
"race" with sig_task_ignored() or with ANY other code which checks this
task's flags.

I think this is WONTFIX.

Oleg.

