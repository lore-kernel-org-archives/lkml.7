Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A99C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4572168B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfIDNTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:19:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53992 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIDNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:19:44 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1i5VCF-0006HK-Oc; Wed, 04 Sep 2019 13:19:40 +0000
Date:   Wed, 4 Sep 2019 10:19:34 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3] sched/core: Fix uclamp ABI bug, clean up and
 robustify sched_read_attr() ABI logic and code
Message-ID: <20190904131932.GG4101@calabresa>
References: <20190903171645.28090-1-cascardo@canonical.com>
 <20190903171645.28090-2-cascardo@canonical.com>
 <20190904075532.GA26751@gmail.com>
 <20190904084934.GA117671@gmail.com>
 <20190904085519.GA127156@gmail.com>
 <db065b81-c373-f291-ad48-f556a209cc95@arm.com>
 <20190904103925.GA60962@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904103925.GA60962@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:39:25PM +0200, Ingo Molnar wrote:
> 
> * Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> 
> > > -v3 attached. Build and minimally boot tested.
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> > > 
> > 
> > This patch fixes the issue (almost).
> > 
> > LTP's sched_getattr01 passes again. But IMHO the prio 'chrt -p $$'
> > should be 0 instead of -65536.
> 
> Yeah, I forgot to zero-initialize the structure ...
> 
> Does the attached -v4 work any better for you?
> 
> Thanks,
> 
> 	Ingo

Hi, Ingo.

Thanks for the patch. It works just fine for me, I have only one comment about
it, below.

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Tested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

I also tested LTP, chrt, and that 5.2 (before the breaking commit) and 5.3 with
your patch behave the same when the user size is larger than what the kernel
knows, the return is 0 and the struct size is set to the known value.

There is one odd behaviour now, which is whenever size is set between VER0 and
VER1, we will have a partial struct filled up, instead of getting E2BIG or
EINVAL.

> 
> ===============================>
> Date: Wed, 4 Sep 2019 09:55:32 +0200
> Subject: [PATCH] sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code
> 
> Thadeu Lima de Souza Cascardo reported that 'chrt' broke on recent kernels:
> 
>   $ chrt -p $$
>   chrt: failed to get pid 26306's policy: Argument list too long
> 
> and he has root-caused the bug to the following commit increasing sched_attr
> size and breaking sched_read_attr() into returning -EFBIG:
> 
>   a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
> 
> The other, bigger bug is that the whole sched_getattr() and sched_read_attr()
> logic of checking non-zero bits in new ABI components is arguably broken,
> and pretty much any extension of the ABI will spuriously break the ABI.
> That's way too fragile.
> 
> Instead implement the perf syscall's extensible ABI instead, which we
> already implement on the sched_setattr() side:
> 
>  - if user-attributes have the same size as kernel attributes then the
>    logic is unchanged.
> 
>  - if user-attributes are larger than the kernel knows about then simply
>    skip the extra bits, but set attr->size to the (smaller) kernel size
>    so that tooling can (in principle) handle older kernel as well.
> 
>  - if user-attributes are smaller than the kernel knows about then just
>    copy whatever user-space can accept.
> 
> Also clean up the whole logic:
> 
>  - Simplify the code flow - there's no need for 'ret' for example.
> 
>  - Standardize on 'kattr/uattr' and 'ksize/usize' naming to make sure we
>    always know which side we are dealing with.
> 
>  - Why is it called 'read' when what it does is to copy to user? This
>    code is so far away from VFS read() semantics that the naming is
>    actively confusing. Name it sched_attr_copy_to_user() instead, which
>    mirrors other copy_to_user() functionality.
> 
>  - Move the attr->size assignment from the head of sched_getattr() to the
>    sched_attr_copy_to_user() function. Nothing else within the kernel
>    should care about the size of the structure.
> 
> With these fixes the sched_getattr() syscall now nicely supports an
> extensible ABI in both a forward and backward compatible fashion, and
> will also fix the chrt bug.
> 
> As an added bonus the bogus -EFBIG return is removed as well, which as
> Thadeu noted should have been -E2BIG to begin with.
> 
> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
> Link: https://lkml.kernel.org/r/20190904075532.GA26751@gmail.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/core.c | 82 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 010d578118d6..3c64eb28dd70 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5105,39 +5105,44 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
>  	return retval;
>  }
>  
> -static int sched_read_attr(struct sched_attr __user *uattr,
> -			   struct sched_attr *attr,
> -			   unsigned int usize)
> +/*
> + * Copy the kernel size attribute structure (which might be larger
> + * than what user-space knows about) to user-space.
> + *
> + * Note that all cases are valid: user-space buffer can be larger or
> + * smaller than the kernel-space buffer. The usual case is that both
> + * have the same size.
> + */
> +static int
> +sched_attr_copy_to_user(struct sched_attr __user *uattr,
> +			struct sched_attr *kattr,
> +			unsigned int usize)
>  {
> -	int ret;
> +	unsigned int ksize = sizeof(*kattr);
>  
> -	if (!access_ok(uattr, usize))
> +	if (!access_ok(uattr, ksize))
>  		return -EFAULT;
>  

I believe this should be either usize or kattr->size and moved below (or just
reuse min(usize,ksize)).

Otherwise, an old binary that uses the old ABI (that is, VER0 as size) may get
EFAULT here. This should almost never in practice. I tried, but I could hardly
use an address that would fail access_ok. But, theoretically, that still breaks
ABI.

Regards.
Cascardo.

>  	/*
> -	 * If we're handed a smaller struct than we know of,
> -	 * ensure all the unknown bits are 0 - i.e. old
> -	 * user-space does not get uncomplete information.
> +	 * sched_getattr() ABI forwards and backwards compatibility:
> +	 *
> +	 * If usize == ksize then we just copy everything to user-space and all is good.
> +	 *
> +	 * If usize < ksize then we only copy as much as user-space has space for,
> +	 * this keeps ABI compatibility as well. We skip the rest.
> +	 *
> +	 * If usize > ksize then user-space is using a newer version of the ABI,
> +	 * which part the kernel doesn't know about. Just ignore it - tooling can
> +	 * detect the kernel's knowledge of attributes from the attr->size value
> +	 * which is set to ksize in this case.
>  	 */
> -	if (usize < sizeof(*attr)) {
> -		unsigned char *addr;
> -		unsigned char *end;
> -
> -		addr = (void *)attr + usize;
> -		end  = (void *)attr + sizeof(*attr);
> -
> -		for (; addr < end; addr++) {
> -			if (*addr)
> -				return -EFBIG;
> -		}
> +	kattr->size = min(usize, ksize);
>  
> -		attr->size = usize;
> -	}
> -
> -	ret = copy_to_user(uattr, attr, attr->size);
> -	if (ret)
> +	if (copy_to_user(uattr, kattr, kattr->size))
>  		return -EFAULT;
>  
> +	printk("sched_attr_copy_to_user(): copied %d bytes. (ksize: %d, usize: %d)\n", kattr->size, ksize, usize);
> +
>  	return 0;
>  }
>  
> @@ -5145,20 +5150,18 @@ static int sched_read_attr(struct sched_attr __user *uattr,
>   * sys_sched_getattr - similar to sched_getparam, but with sched_attr
>   * @pid: the pid in question.
>   * @uattr: structure containing the extended parameters.
> - * @size: sizeof(attr) for fwd/bwd comp.
> + * @usize: sizeof(attr) that user-space knows about, for forwards and backwards compatibility.
>   * @flags: for future extension.
>   */
>  SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> -		unsigned int, size, unsigned int, flags)
> +		unsigned int, usize, unsigned int, flags)
>  {
> -	struct sched_attr attr = {
> -		.size = sizeof(struct sched_attr),
> -	};
> +	struct sched_attr kattr = { };
>  	struct task_struct *p;
>  	int retval;
>  
> -	if (!uattr || pid < 0 || size > PAGE_SIZE ||
> -	    size < SCHED_ATTR_SIZE_VER0 || flags)
> +	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
> +	    usize < SCHED_ATTR_SIZE_VER0 || flags)
>  		return -EINVAL;
>  
>  	rcu_read_lock();
> @@ -5171,25 +5174,24 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	if (retval)
>  		goto out_unlock;
>  
> -	attr.sched_policy = p->policy;
> +	kattr.sched_policy = p->policy;
>  	if (p->sched_reset_on_fork)
> -		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
> +		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
>  	if (task_has_dl_policy(p))
> -		__getparam_dl(p, &attr);
> +		__getparam_dl(p, &kattr);
>  	else if (task_has_rt_policy(p))
> -		attr.sched_priority = p->rt_priority;
> +		kattr.sched_priority = p->rt_priority;
>  	else
> -		attr.sched_nice = task_nice(p);
> +		kattr.sched_nice = task_nice(p);
>  
>  #ifdef CONFIG_UCLAMP_TASK
> -	attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
> -	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
> +	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
> +	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
>  #endif
>  
>  	rcu_read_unlock();
>  
> -	retval = sched_read_attr(uattr, &attr, size);
> -	return retval;
> +	return sched_attr_copy_to_user(uattr, &kattr, usize);
>  
>  out_unlock:
>  	rcu_read_unlock();
