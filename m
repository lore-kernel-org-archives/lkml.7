Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6722520651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfC0RpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:45:07 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:54622 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfC0RpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:45:06 -0400
X-Greylist: delayed 1408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2019 13:45:05 EDT
Received: from [2a01:e35:39f2:1220:98ae:65aa:acef:50cb] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1h9CEu-000Eaw-T9; Wed, 27 Mar 2019 18:21:25 +0100
Message-ID: <9254286c02dbe883c14e38ed2af0022d36b17355.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Christian Brauner <christian@brauner.io>, jannh@google.com,
        khlebnikov@yandex-team.ru, luto@kernel.org, dhowells@redhat.com,
        serge@hallyn.com, ebiederm@xmission.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com
Date:   Wed, 27 Mar 2019 18:21:24 +0100
In-Reply-To: <20190327162147.23198-3-christian@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
         <20190327162147.23198-3-christian@brauner.io>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:98ae:65aa:acef:50cb
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 27 mars 2019 à 17:21 +0100, Christian Brauner a écrit :

> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..c9e24e726aba 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -26,8 +26,10 @@
> +SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, procfd, int, pidfd,
> unsigned int,
> +		flags)
> +{
> +	long fd = -EINVAL;
> +
> +	if (flags & ~(PIDFD_TO_PROCFD | PROCFD_TO_PIDFD))
> +		return -EINVAL;
> +
> +	if (!flags) {
> +		struct pid *pidfd_pid;
> +
> +		if (pid <= 0)
> +			return -EINVAL;
> +
> +		if (procfd != -1 || pidfd != -1)
> +			return -EINVAL;
> +
> +		rcu_read_lock();
> +		pidfd_pid = get_pid(find_pid_ns(pid, task_active_pid_ns(current)));
> +		rcu_read_unlock();
> +
> +		fd = pidfd_create_fd(pidfd_pid, O_CLOEXEC);
> +		put_pid(pidfd_pid);
> +	} else if (flags & PIDFD_TO_PROCFD) {

[...]

> +	} else if (flags & PROCFD_TO_PIDFD) {
> +		if (flags & ~PROCFD_TO_PIDFD)
> +			return -EINVAL;
> +
> +		if (pid != -1)
> +			return -EINVAL;
> +
> +		if (pidfd >= 0)
> 

I think it can be stricter with:

                if (pidfd != -1)

(and match the check done for flag == 0).

Regards.

-- 
Yann Droneaud
OPTEYA


