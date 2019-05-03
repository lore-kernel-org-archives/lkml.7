Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27393C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF35C2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMqxNGkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfECVIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 17:08:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34681 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 17:08:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so3296567pgt.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hkcd8BIELveqcx9zYf9kxHBBlus+ent2nCS3r3QjzQI=;
        b=kMqxNGktXx21zOAK3MY0c+Pp38CX/Agrku2MgGsjRK0Tgasr5jg+ugyZ+UZ9ljJ9SQ
         ObF7pyzTtJ3/AqVl7Q4sGJeXN5IO4ZIHqTh0YNshH20MJHuGlK+pRltKQTn0QKDr6s74
         YAaDydb1Sd1CIqicyWFrjxwnpsHfE44x63ZX6gL+HwoQbXRQtX79Z5VavW1gE2D2CesN
         7q2nG77q8Y/UI92ZKL/LY0LyVI4eUukYnXv4aZyvTj7d8R95QMoG++A10e64pqondCEh
         I9HS6MHckRxfauIuD4Ar5dV07R06ZampDSttcms1DhHsfgrIcWRKuIvICVAWQsve5o/f
         C8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hkcd8BIELveqcx9zYf9kxHBBlus+ent2nCS3r3QjzQI=;
        b=UXmBN7cvEHUfvoJDv2WRirQaq1L9AfH8En47S2paeaR/u6xdJ8zebHOnQ9MrVmK64w
         4bBrRGcqa2cWBy5RkV83PqOXAvqXmM12RpiEXXV1GH2kJAtPb6UengiETZIn2+YUGqha
         GTquVZCYLo/O04mNH3gHKJJ+cHWi5SZpf2mNoCgVnTod7edtW7B+f314srWRYGLIiKP/
         hwkCs5guUHTPH+aefh08//SoxkwdnN9mLmdkue2gT17KyeMCGNftvFkI2yFEk5ZQ65MT
         qae1hUh5OPo7ZdlPKuNlB4jn/Sies9uVkOh0tolbufhjnV/slB7od+Wh58gWinyqY+1a
         UQoQ==
X-Gm-Message-State: APjAAAX7UQM5jIat+OO7IDF1r0HP9yIOMVRhgRjfnb6fbHUXlHh8v92z
        Euxj8VQh8j49VUzTvhbuOCE=
X-Google-Smtp-Source: APXvYqyE6RBZ+qsnc03uzbuc/KxwH4q06iDk9aYXZfGE0tmEAhDISzUwqwz3sbCHaXR+ZdRJzzVCPQ==
X-Received: by 2002:a63:8f49:: with SMTP id r9mr13359168pgn.306.1556917713160;
        Fri, 03 May 2019 14:08:33 -0700 (PDT)
Received: from localhost ([208.54.5.135])
        by smtp.gmail.com with ESMTPSA id d129sm4696466pfa.142.2019.05.03.14.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 14:08:32 -0700 (PDT)
Date:   Fri, 3 May 2019 14:08:31 -0700
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
Subject: Re: [PATCH v3 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Message-ID: <20190503210831.GB5887@yury-thinkpad>
References: <1556907021-29730-1-git-send-email-jsavitz@redhat.com>
 <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556907021-29730-2-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 02:10:20PM -0400, Joel Savitz wrote:
> When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
> copy the value of TASK_SIZE to the userspace address in arg2.
> 
> It is important that we account for the case of the userspace task
> running in 32-bit compat mode on a 64-bit kernel. As such, we must be
> careful to copy the correct number of bytes to userspace to avoid stack
> corruption.
> 
> Suggested-by: Yuri Norov <yury.norov@gmail.com>

I actually didn't suggest that. If you _really_ need TASK_SIZE to
be exposed, I would suggest to expose it in kernel headers. TASK_SIZE
is a compile-time information, and it may available for userspace at
compile time as well.

> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  include/uapi/linux/prctl.h |  3 +++
>  kernel/sys.c               | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..2c261c461952 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,7 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY                        (1UL << 3)
>  # define PR_PAC_APGAKEY                        (1UL << 4)
> 
> +/* Get the process virtual memory size (i.e. the highest usable VM address) */
> +#define PR_GET_TASK_SIZE               55
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..709584400070 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2252,6 +2252,26 @@ static int propagate_has_child_subreaper(struct task_struct *p, void *data)
>         return 1;
>  }
> 
> +static int prctl_get_tasksize(void __user *uaddr)
> +{
> +	unsigned long current_task_size, current_word_size;
> +
> +	current_task_size = TASK_SIZE;
> +	current_word_size = sizeof(unsigned long);
> +
> +#ifdef CONFIG_64BIT
> +	/* On 64-bit architecture, we must check whether the current thread
> +	 * is running in 32-bit compat mode. If it is, we can simply cut
> +	 * the size in half. This avoids corruption of the userspace stack.
> +	 */
> +	if (test_thread_flag(TIF_ADDR32))

It breaks build for all architectures except x86 since TIF_ADDR32 is
defined for x86 only.

In comment to v2 I suggested you to stick to fixed-size data type to
avoid exactly this problem.

NACK

Yury

> +		current_word_size >>= 1;
> +#endif
> +
> +	return copy_to_user(uaddr, &current_task_size, current_word_size) ? -EFAULT : 0;
> +}
> +
>  int __weak arch_prctl_spec_ctrl_get(struct task_struct *t, unsigned long which)
>  {
>         return -EINVAL;
> @@ -2486,6 +2506,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error = PAC_RESET_KEYS(me, arg2);
>                 break;
> +	case PR_GET_TASK_SIZE:
> +		error = prctl_get_tasksize((void *)arg2);
> +		break;
>         default:
>                 error = -EINVAL;
>                 break;
> --
> 2.18.1
