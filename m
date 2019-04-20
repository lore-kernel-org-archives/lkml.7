Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D0C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3122621855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfDTLWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfDTLWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95F663082E4F;
        Sat, 20 Apr 2019 11:22:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5D1B210027DE;
        Sat, 20 Apr 2019 11:22:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 20 Apr 2019 13:22:22 +0200 (CEST)
Date:   Sat, 20 Apr 2019 13:22:20 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     ebiederm@xmission.com, colona@arista.com,
        akpm@linux-foundation.org, christian@brauner.io, arnd@arndb.de,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190420112219.GB17468@redhat.com>
References: <20190420104102.44336-1-weizhenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420104102.44336-1-weizhenliang@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sat, 20 Apr 2019 11:22:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Zhenliang Wei wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2441,6 +2441,8 @@ bool get_signal(struct ksignal *ksig)
>  	if (signal_group_exit(signal)) {
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
> +		trace_signal_deliver(signr, &ksig->info,
> +				&sighand->action[signr - 1]);

Well, in this case ksig->info is not fully initialized for TP_STORE_SIGINFO()
which reads si_errno/si_code...

How about

		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL)

?

We know that action[SIGKILL] must be SIG_DFL.

And SEND_SIG_NOINFO matches the fact that SIGKILL doesn't have any info,
collect_signal() sets SI_USER and clears si_errno in this case.

Oleg.

