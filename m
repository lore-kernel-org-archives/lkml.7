Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BC52081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEBV0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:26:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfEBV0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F18643086215;
        Thu,  2 May 2019 21:26:41 +0000 (UTC)
Received: from x230.aquini.net (dhcp-17-61.bos.redhat.com [10.18.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B049608A5;
        Thu,  2 May 2019 21:26:38 +0000 (UTC)
Date:   Thu, 2 May 2019 17:26:36 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        Yury Norov <norov.maillist@gmail.com>
Subject: Re: [PATCH v2 0/2] sys/prctl: expose TASK_SIZE value to userspace
Message-ID: <20190502212636.GB13077@x230.aquini.net>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 02 May 2019 21:26:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:52:20PM -0400, Joel Savitz wrote:
> In the mainline kernel, there is no quick mechanism to get the virtual
> memory size of the current process from userspace.
> 
> Despite the current state of affairs, this information is available to the
> user through several means, one being a linear search of the entire address
> space. This is an inefficient use of cpu cycles.
> 
> A component of the libhugetlb kernel test does exactly this, and as
> systems' address spaces increase beyond 32-bits, this method becomes
> exceedingly tedious.
> 
> For example, on a ppc64le system with a 47-bit address space, the linear
> search causes the test to hang for some unknown amount of time. I
> couldn't give you an exact number because I just ran it for about 10-20
> minutes and went to go do something else, probably to get coffee or
> something, and when I came back, I just killed the test and patched it
> to use this new mechanism. I re-ran my new version of the test using a
> kernel with this patch, and of course it passed through the previously
> bottlenecking codepath nearly instantaneously.
> 
> As such, I propose that the prctl syscall be extended to include the
> option to retrieve TASK_SIZE from the kernel.
> 
> This patch will allow us to upgrade an O(n) codepath to O(1) in an
> architecture-independent manner, and provide a mechanism for others
> to do the same.
> 
> Joel Savitz(2):
>   sys/prctl: add PR_GET_TASK_SIZE option to prctl(2)
>   prctl.2: Document the new PR_GET_TASK_SIZE option
> 
>  include/uapi/linux/prctl.h |  3 +++
>  kernel/sys.c               | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
>  man2/prctl.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --
> 2.18.1
>

If you decide to repost patch 1/2 to sort out the minor nit I
pointed out, you can keep my ack.
 
Acked-by: Rafael Aquini <aquini@redhat.com>
