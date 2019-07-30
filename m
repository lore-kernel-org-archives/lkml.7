Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F10206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfG3QeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:34:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfG3Qcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8C0181F0E;
        Tue, 30 Jul 2019 16:32:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 547B960922;
        Tue, 30 Jul 2019 16:32:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jul 2019 18:32:32 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:32:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tj@kernel.org, tglx@linutronix.de, prsood@codeaurora.org,
        avagin@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] exit: make setting exit_state consistent
Message-ID: <20190730163229.GD18501@redhat.com>
References: <20190729162757.22694-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729162757.22694-1-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 30 Jul 2019 16:32:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Christian Brauner wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -734,9 +734,10 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  		autoreap = true;
>  	}
>  
> -	tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
> -	if (tsk->exit_state == EXIT_DEAD)
> +	if (autoreap) {
> +		tsk->exit_state = EXIT_DEAD;
>  		list_add(&tsk->ptrace_entry, &dead);
> +	}
>  

Acked-by: Oleg Nesterov <oleg@redhat.com>

