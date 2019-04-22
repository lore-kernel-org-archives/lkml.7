Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8743AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692CD20656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 15:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfDVPFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfDVPFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 11:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EBC9DA70E;
        Mon, 22 Apr 2019 15:05:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA710600CC;
        Mon, 22 Apr 2019 15:05:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 Apr 2019 17:05:35 +0200 (CEST)
Date:   Mon, 22 Apr 2019 17:05:32 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Zhenliang Wei <weizhenliang@huawei.com>
Cc:     ebiederm@xmission.com, colona@arista.com,
        akpm@linux-foundation.org, christian@brauner.io, arnd@arndb.de,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190422150532.GA20151@redhat.com>
References: <20190422065623.49364-1-weizhenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422065623.49364-1-weizhenliang@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 22 Apr 2019 15:05:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22, Zhenliang Wei wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2441,6 +2441,7 @@ bool get_signal(struct ksignal *ksig)
>  	if (signal_group_exit(signal)) {
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO, SIG_DFL);
>  		recalc_sigpending();
>  		goto fatal;
>  	}

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

