Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4621226740
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfEaJ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:56:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfEaJz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:55:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E94A30C250E;
        Fri, 31 May 2019 09:55:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE5975DA34;
        Fri, 31 May 2019 09:55:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 31 May 2019 11:55:57 +0200 (CEST)
Date:   Fri, 31 May 2019 11:55:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190531095553.GA31323@redhat.com>
References: <20190529113157.227380-1-jannh@google.com>
 <20190529162120.GB27659@redhat.com>
 <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
 <20190530120531.GE22536@redhat.com>
 <20190531091245.GN2677@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531091245.GN2677@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 31 May 2019 09:55:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Peter Zijlstra wrote:
>
> On Thu, May 30, 2019 at 02:05:31PM +0200, Oleg Nesterov wrote:
> > > Anyway, looking at it, I think smp_acquire__after_ctrl_dep() doesn't
> > > make sense here;
> >
> > Well I still _think_ it should work, it provides the LOAD-LOAD ordering
> > and this is what we need.
>
> So it hard relies on being part of a control dependency,

Yes,

> IOW, it is an error to use smp_acquire__after_ctrl_dep() without an
> (immediate) preceding branch.

and it is still not clear to me if __ptrace_may_acess() has a control
dependency or not,

		if (uid_eq(caller_uid, tcred->euid) && ...)
			goto ok;
		retuurn;

	ok:
		// provide LOAD->LOAD
		smp_acquire__after_ctrl_dep();


again, again, I didn't suggest to change the patch, I was just curious
if it would be correct or not.

Oleg.

