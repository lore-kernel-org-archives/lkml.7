Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979862147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDHNNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfDHNNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2230C057F5D;
        Mon,  8 Apr 2019 13:13:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 12216271BB;
        Mon,  8 Apr 2019 13:13:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  8 Apr 2019 15:13:18 +0200 (CEST)
Date:   Mon, 8 Apr 2019 15:13:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't silently convert SI_USER signals to
 non-current pidfd
Message-ID: <20190408131315.GA24111@redhat.com>
References: <20190330021232.191205-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330021232.191205-1-jannh@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 08 Apr 2019 13:13:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30, Jann Horn wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3605,16 +3605,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
>  		if (unlikely(sig != kinfo.si_signo))
>  			goto err;
>
> +		/* Only allow sending arbitrary signals to yourself. */
> +		ret = -EPERM;
>  		if ((task_pid(current) != pid) &&
> -		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL)) {
> -			/* Only allow sending arbitrary signals to yourself. */
> -			ret = -EPERM;
> -			if (kinfo.si_code != SI_USER)
> -				goto err;
> -
> -			/* Turn this into a regular kill signal. */
> -			prepare_kill_siginfo(sig, &kinfo);
> -		}
> +		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> +			goto err;

ACK.


but perhaps it should always fail, even if task_pid(current) == pid.

sys_rt_sigqueueinfo() allows to send any siginfo to yourself, but this is only needed
for checkpoint/restart.

Oleg.

