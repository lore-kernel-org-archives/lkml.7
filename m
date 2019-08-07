Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0C6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F290122305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbfHGSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:05:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58961 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbfHGSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:05:54 -0400
Received: from c-67-180-61-213.hsd1.ca.comcast.net ([67.180.61.213] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hvQJf-00089A-92; Wed, 07 Aug 2019 18:05:39 +0000
Date:   Wed, 7 Aug 2019 20:05:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807180534.rhojrgy4j52n2eup@wittgenstein>
References: <20190806191551.22192-1-areber@redhat.com>
 <20190807160856.GE24112@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807160856.GE24112@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 06:08:56PM +0200, Oleg Nesterov wrote:
> On 08/06, Adrian Reber wrote:
> >
> > @@ -2573,6 +2575,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> >  		.tls		= args.tls,
> >  	};
> >  
> > +	if (size == sizeof(struct clone_args)) {
> > +		/* Only check permissions if set_tid is actually set. */
> > +		if (args.set_tid &&
> > +			!ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> 
> and I just noticed this uses pid_ns = task_active_pid_ns() ...
> 
> is it correct?
> 
> I feel I am totally confused, but should we use the same
> p->nsproxy->pid_ns_for_children passed to alloc_pid?

We need to have CAP_SYS_ADMIN in the owning user namespace of the target
pidns for the pidns in which we spawn the new process. The value for
pid_ns_for_children could've been altered by either passing CLONE_NEWPID
or by having called unshare(CLONE_NEWPID) before. So yes,
pid_ns_for_children is what we want.

Sorry again for the delay in my responses. On vacation atm.

Christian
