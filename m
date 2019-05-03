Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E32A20652
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfECV5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 17:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfECV5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 17:57:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C9E787620;
        Fri,  3 May 2019 21:57:42 +0000 (UTC)
Received: from x230.aquini.net (ovpn-120-150.rdu2.redhat.com [10.10.120.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B180E189F5;
        Fri,  3 May 2019 21:57:34 +0000 (UTC)
Date:   Fri, 3 May 2019 17:57:31 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 0/2] sys/prctl: expose TASK_SIZE value to userspace
Message-ID: <20190503215731.GB10302@x230.aquini.net>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
 <20190503204912.GA5887@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503204912.GA5887@yury-thinkpad>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 03 May 2019 21:57:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 01:49:12PM -0700, Yury Norov wrote:
> On Fri, May 03, 2019 at 02:10:19PM -0400, Joel Savitz wrote:
> > In the mainline kernel, there is no quick mechanism to get the virtual
> > memory size of the current process from userspace.
> > 
> > Despite the current state of affairs, this information is available to the
> > user through several means, one being a linear search of the entire address
> > space. This is an inefficient use of cpu cycles.
> > 
> > A component of the libhugetlb kernel test does exactly this, and as
> > systems' address spaces increase beyond 32-bits, this method becomes
> > exceedingly tedious.
> > 
> > For example, on a ppc64le system with a 47-bit address space, the linear
> > search causes the test to hang for some unknown amount of time. I
> > couldn't give you an exact number because I just ran it for about 10-20
> > minutes and went to go do something else, probably to get coffee or
> > something, and when I came back, I just killed the test and patched it
> > to use this new mechanism. I re-ran my new version of the test using a
> > kernel with this patch, and of course it passed through the previously
> > bottlenecking codepath nearly instantaneously.
> > 
> > As such, I propose that the prctl syscall be extended to include the
> > option to retrieve TASK_SIZE from the kernel.
> > 
> > This patch will allow us to upgrade an O(n) codepath to O(1) in an
> > architecture-independent manner, and provide a mechanism for future
> > generations to do the same.
> 
> So the only reason for the new API is boosting some random poorly
> written userspace test? Why don't you introduce binary search instead?
>

there's no real cost in exposing the value that is known to the kernel,
anyways, as long as it's not a freaking hassle (like trying to go with
this prctl(2) stunt). We just need to get it properly exported alongside
other task's VM-related values at /proc/<pid>/status.
 
> Look at /proc/<pid>/maps. It may help to reduce the memory area to be
> checked.
>  
> > Changes from v2:
> >  We now account for the case of 32-bit compat userspace on a 64-bit kernel
> >  More detail about the nature of TASK_SIZE in documentation
> > 
> > Joel Savitz(2):
> >   sys/prctl: add PR_GET_TASK_SIZE option to prctl(2)
> >   prctl.2: Document the new PR_GET_TASK_SIZE option
> > 
> >  include/uapi/linux/prctl.h |  3 +++
> >  kernel/sys.c               | 23 +++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> >  man2/prctl.2 | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > --
> > 2.18.1
