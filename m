Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8509FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FE3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbfDRNMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733205AbfDRNMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:12:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B232E3099FD3;
        Thu, 18 Apr 2019 13:12:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id E8F4119C65;
        Thu, 18 Apr 2019 13:12:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 18 Apr 2019 15:12:12 +0200 (CEST)
Date:   Thu, 18 Apr 2019 15:12:07 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v2 2/5] clone: add CLONE_PIDFD
Message-ID: <20190418131206.GB13701@redhat.com>
References: <20190418101841.4476-1-christian@brauner.io>
 <20190418101841.4476-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418101841.4476-3-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Apr 2019 13:12:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18, Christian Brauner wrote:
>
> @@ -1674,13 +1729,14 @@ static __latent_entropy struct task_struct *copy_process(
>  					unsigned long clone_flags,
>  					unsigned long stack_start,
>  					unsigned long stack_size,
> +					int __user *parent_tidptr,
>  					int __user *child_tidptr,
>  					struct pid *pid,
>  					int trace,
>  					unsigned long tls,
>  					int node)
>  {
> -	int retval;
> +	int pidfd = -1, retval;

it seems that initialization is unneeded, but this is cosmetic.

I see no technical problems, feel free to add my reviewed-by.


But let me ask a couple of questions...


Why O_CLOEXEC? I am just curious, I do not really care.


Should we allow CLONE_THREAD | CLONE_PIDFD ?


Are you sure we will never need to extend this interface? If not, then perhaps it
make sense to add something like

	if (CLONE_PIDFD) {
		unsigned long not_used_yet;
		if (get_user(not_used_yet, parent_tidptr) ||
		    not_used_yet != 0)
			return -EINVAL;
	}

this way we can easily add more arguments in future or even turn CLONE_PIDFD into
CLONE_MORE_ARGS_IN_PARENT_TIDPTR.

Not that I think this is really good idea, sys_clone2() makes more sense, but still.

Oleg.

