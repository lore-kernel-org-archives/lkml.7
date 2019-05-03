Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7EFC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFBB2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZjEJwtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfECUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:49:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43440 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfECUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:49:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so3252692pgi.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k4AJX+XLIQ3TE92X2ItqBrCbyi0kkAlpOWU5Nyv4b/o=;
        b=AZjEJwtDPHysF3UiBAKH8WwzJMEuQjIC+GtLdL8ndbQCEHxgvbgbIDptq2MM2mUNOV
         Qi5ZLvzmgNs7jMzxE3e90kveKl/WXaJ8u7NtsF3x6YL/x0uYVlkocb20MXNbUh49k41I
         9fkytR+n3AyxiLACeXZ9TmXeRVwPhDs+MpkMvTAfLsjoYlK8usYGOpUpQN4yFmv3QQst
         jJyaVqTb4je2HOS20O34HQE8bLB4h9ATwptrTlvz+yc2PExJeUXXb0k4zrU4wPaD7O09
         qZ6WSCWnRTgQs7EJs5n3NU9p8xHVKdNRPlX2vXXdPEWcgQHlLj8SguD9hCwHafblaCQ7
         i+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4AJX+XLIQ3TE92X2ItqBrCbyi0kkAlpOWU5Nyv4b/o=;
        b=R6G8wcoWLLyv7fXLWzZHuEtm7OxTDwBsCK0vKp9LCPqfW3FK/P+iEiUvkvuHsr3Z3c
         oFuCDzXRl2rXfnsMBJPsUjrav5pmb1Pw2CDjQdTDKTSBq3tCsMXU86iU4L3vY62VjjwZ
         nNq96oWAyhHjZMSxCga2z+2BMz9UAUNJbkYVPRipupNyQu8tqPmtuWqW9dbwWHlnl6hU
         Vykwr3k1OsAffFFKfHN3gZ5ML7smmoh4xHm5zQ96uus7tG3gLXcIsCTVXeryMlYtnfIr
         N1drJmSV4Pu0Z44rdZ3nPo4UtjGKSgSZYxdmIkR/rVe84Faz0npzZ/1iByZ7IbH99Vgf
         KqpQ==
X-Gm-Message-State: APjAAAVggiv4kqmX8H1LIApf77S/o4uaAfXG/Hrr8BWtyh+KfiYcBZl5
        pDnPTo0m3qBdZDd1nYiIPUQ=
X-Google-Smtp-Source: APXvYqxt2Hm2jiDPSsLmITUv0MCAWJXJRLmFK5pT2Kh/e7Br1aWQYMkjOT/wxNKsnULx6eX8PGL1Wg==
X-Received: by 2002:aa7:8383:: with SMTP id u3mr13739318pfm.245.1556916557178;
        Fri, 03 May 2019 13:49:17 -0700 (PDT)
Received: from localhost ([208.54.5.135])
        by smtp.gmail.com with ESMTPSA id 18sm4283751pfp.18.2019.05.03.13.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 13:49:15 -0700 (PDT)
Date:   Fri, 3 May 2019 13:49:12 -0700
From:   Yury Norov <yury.norov@gmail.com>
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
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v3 0/2] sys/prctl: expose TASK_SIZE value to userspace
Message-ID: <20190503204912.GA5887@yury-thinkpad>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 02:10:19PM -0400, Joel Savitz wrote:
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
> architecture-independent manner, and provide a mechanism for future
> generations to do the same.

So the only reason for the new API is boosting some random poorly
written userspace test? Why don't you introduce binary search instead?

Look at /proc/<pid>/maps. It may help to reduce the memory area to be
checked.
 
> Changes from v2:
>  We now account for the case of 32-bit compat userspace on a 64-bit kernel
>  More detail about the nature of TASK_SIZE in documentation
> 
> Joel Savitz(2):
>   sys/prctl: add PR_GET_TASK_SIZE option to prctl(2)
>   prctl.2: Document the new PR_GET_TASK_SIZE option
> 
>  include/uapi/linux/prctl.h |  3 +++
>  kernel/sys.c               | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
>  man2/prctl.2 | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> --
> 2.18.1
