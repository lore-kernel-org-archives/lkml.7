Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577F6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235342085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEBVY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:24:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBVY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2611308620F;
        Thu,  2 May 2019 21:24:58 +0000 (UTC)
Received: from x230.aquini.net (dhcp-17-61.bos.redhat.com [10.18.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D7419C4F;
        Thu,  2 May 2019 21:24:53 +0000 (UTC)
Date:   Thu, 2 May 2019 17:24:52 -0400
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
Subject: Re: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Message-ID: <20190502212451.GA13077@x230.aquini.net>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 02 May 2019 21:24:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:52:21PM -0400, Joel Savitz wrote:
> When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
> copy the value of TASK_SIZE to the userspace address in arg2.
> 
> Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  include/uapi/linux/prctl.h |  3 +++
>  kernel/sys.c               | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..2335fe0a8db8 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,7 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY			(1UL << 3)
>  # define PR_PAC_APGAKEY			(1UL << 4)
>  
> +/* Get the process virtual memory size */
> +#define PR_GET_TASK_SIZE 		55
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 12df0e5434b8..7ced7dbd035d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2252,6 +2252,13 @@ static int propagate_has_child_subreaper(struct task_struct *p, void *data)
>  	return 1;
>  }
>  
> +static int prctl_get_tasksize(void __user * uaddr)
> +{
> +	unsigned long task_size = TASK_SIZE;
> +	return copy_to_user(uaddr, &task_size, sizeof(unsigned long))
> +			? -EFAULT : 0;

Minor pick: I would keep the all of the ternary statement above in the
same line, to help on improving readability (even though it bursts a
little longer than 80 columns of text)

> +}
> +
>  int __weak arch_prctl_spec_ctrl_get(struct task_struct *t, unsigned long which)
>  {
>  	return -EINVAL;
> @@ -2486,6 +2493,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = PAC_RESET_KEYS(me, arg2);
>  		break;
> +	case PR_GET_TASK_SIZE:
> +		error = prctl_get_tasksize((void *)arg2) ;
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> -- 
> 2.18.1
> 
