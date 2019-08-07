Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0422DC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6FA22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbfHGQI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGQI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57155315C011;
        Wed,  7 Aug 2019 16:08:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D7175C21A;
        Wed,  7 Aug 2019 16:08:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  7 Aug 2019 18:08:59 +0200 (CEST)
Date:   Wed, 7 Aug 2019 18:08:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807160856.GE24112@redhat.com>
References: <20190806191551.22192-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806191551.22192-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 07 Aug 2019 16:08:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06, Adrian Reber wrote:
>
> @@ -2573,6 +2575,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		.tls		= args.tls,
>  	};
>  
> +	if (size == sizeof(struct clone_args)) {
> +		/* Only check permissions if set_tid is actually set. */
> +		if (args.set_tid &&
> +			!ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))

and I just noticed this uses pid_ns = task_active_pid_ns() ...

is it correct?

I feel I am totally confused, but should we use the same
p->nsproxy->pid_ns_for_children passed to alloc_pid?

Oleg.

