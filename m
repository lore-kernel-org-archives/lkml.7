Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC241C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0512077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfDXNZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:25:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27821 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfDXNZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:25:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D105C0B2C4D;
        Wed, 24 Apr 2019 13:25:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 072E961D32;
        Wed, 24 Apr 2019 13:25:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Apr 2019 15:25:06 +0200 (CEST)
Date:   Wed, 24 Apr 2019 15:25:03 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     Zhenliang Wei <weizhenliang@huawei.com>, ebiederm@xmission.com,
        colona@arista.com, akpm@linux-foundation.org, arnd@arndb.de,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] signal: trace_signal_deliver when signal_group_exit
Message-ID: <20190424132502.GE16167@redhat.com>
References: <20190424125238.83264-1-weizhenliang@huawei.com>
 <20190424130751.jckvq535ipfx5cq6@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424130751.jckvq535ipfx5cq6@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 24 Apr 2019 13:25:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Christian Brauner wrote:
>
> On Wed, Apr 24, 2019 at 08:52:38PM +0800, Zhenliang Wei wrote:
>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Yes, but ...

> > Reported-by: kbuild test robot <lkp@intel.com>

Hmm, really?

> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2441,6 +2441,8 @@ bool get_signal(struct ksignal *ksig)
> >  	if (signal_group_exit(signal)) {
> >  		ksig->info.si_signo = signr = SIGKILL;
> >  		sigdelset(&current->pending.signal, SIGKILL);
> > +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> > +			&sighand->action[signr - 1]);
>
> Hm, sorry for being the really nitpicky person here. Just for the sake
> of consistency how about we do either:
>
> +		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
> +			&sighand->action[SIGKILL - 1]);
>
> or
>
> +		trace_signal_deliver(signr, SEND_SIG_NOINFO,
> +			&sighand->action[signr - 1]);

Agreed!

Oleg.

