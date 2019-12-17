Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588952176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csMVd4Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfLQOZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:25:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728903AbfLQOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576592725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAx8txCepvJSwllvplJt1X8cg5M0O6h6PZ0wrniM3ew=;
        b=csMVd4Xi1iJHhCZzqpI3JBhSUX31oz0iSLh5woH7U2iz5kIYZQvx66moRaKkJGbQGo9fmS
        0sx1oE+V2yH7ra87Qw9m0+L+p7aQn7f4XuFUjlDzD1MZLmay4K5jnxsWBGae773GW/WmRB
        gMcqdaiuSPxq8zrT4VKmaKeJvTVbfSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-I5e3_c6gMruGIaFpqT6k-A-1; Tue, 17 Dec 2019 09:25:22 -0500
X-MC-Unique: I5e3_c6gMruGIaFpqT6k-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFA0110054E3;
        Tue, 17 Dec 2019 14:25:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 324715D9E1;
        Tue, 17 Dec 2019 14:25:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Dec 2019 15:25:18 +0100 (CET)
Date:   Tue, 17 Dec 2019 15:25:15 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        peterz@infradead.org, mingo@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191217142515.GB23152@redhat.com>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
 <20191217105042.GA21784@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217105042.GA21784@cqw-OptiPlex-7050>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, chenqiwu wrote:
>
> @@ -728,6 +724,15 @@ void __noreturn do_exit(long code)
>                 panic("Attempted to kill the idle task!");
>
>         /*
> +        * If all threads of global init have exited, do panic imeddiately
> +        * to get the coredump to find any clue for init task in userspace.
> +        */
> +       if (unlikely(is_global_init(tsk) &&
> +               (atomic_read(&tsk->signal->live) == 1)))

Well, I guess this will work in practice, but in theory this is racy.

Suppose that signal->live == 2 and both threads exit in parallel. They
both can see tsk->signal->live == 2 before atomic_dec_and_test().

If you are fine with this race I won't object, but please add a comment.

But why can't you simply do

	--- x/kernel/exit.c
	+++ x/kernel/exit.c
	@@ -786,6 +786,8 @@ void __noreturn do_exit(long code)
		acct_update_integrals(tsk);
		group_dead = atomic_dec_and_test(&tsk->signal->live);
		if (group_dead) {
	+		if (unlikely(is_global_init(tsk)
	+			panic(...);
	 #ifdef CONFIG_POSIX_TIMERS
			hrtimer_cancel(&tsk->signal->real_timer);
			exit_itimers(tsk->signal);

?

Oleg.

