Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FCCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A350920848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qdzvA3VM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLBVI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:08:57 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38223 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:08:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so336718pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k9dGjGCO+7zbmccYGCfjWcaU0D0XLobeWL4r3GmgINY=;
        b=qdzvA3VMi0NIkfoVj0gAQ6zt/Nx13PBrCL4NXRabzZ2Tcq93XlDbRhvK4CtOR0s9HX
         tihGgm5JB6w5gv/0Sx8sZwswkYEd+QYOWSAoJCsxJAh07EEB9mNAB0soEqUAkOo9l/ny
         MEU5xGJj0H74QKwnrSMd8hT5ahqUoAZWhRXP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k9dGjGCO+7zbmccYGCfjWcaU0D0XLobeWL4r3GmgINY=;
        b=nyMqVGYR3f2ztovLELksk/z+/G9YEkOZqFCuCrUUVMWdWqNOskMykoPTRa2Rw8WAF7
         5WQFPXOqVzvGSI0pHNNoKazm478MdP9tU2uzcJU3oxXGZom+XurAjK98cDLLLTELmf1G
         idONObcefqnQRbH8W8LFpYTR/LrPn+ew1V3lACK8TyR3vMuKuMDXXoJcf8nBZG4POtqW
         vcBF+r8xqLqm1E/3ADoFoI1Mey0UOl/zr810btAVpcBHoGFIR+5Uhz8UDeRNhk/Fawid
         /ueONIZpGbwnF4ph24I8rCrvpZmGXeQp2j08JhOuKfWxAoTd7z8k5I+OKR6BwQn5NeSy
         zkdg==
X-Gm-Message-State: APjAAAV9LGSdgx80t1PSxk5gK3BDBtJzCIuLC52B7ZDf0qusZkk5AR+z
        SneO5/SwHCzvnWyzCg1QNSUNcyuczuw=
X-Google-Smtp-Source: APXvYqwsWf09CwJxxHcuSb94ipsJPq4AO0P067FS3qUYyngpVfg4JS9yauEtsTSlZgqKzIDNq4cnFw==
X-Received: by 2002:a17:90b:252:: with SMTP id fz18mr1259557pjb.49.1575320936772;
        Mon, 02 Dec 2019 13:08:56 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w4sm264400pjt.21.2019.12.02.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 13:08:55 -0800 (PST)
Date:   Mon, 2 Dec 2019 16:08:54 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191202210854.GD17234@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157527193358.11113.14859628506665612104.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> Anders reported that the lockdep warns that suspicious
> RCU list usage in register_kprobe() (detected by
> CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> access kprobe_table[] by hlist_for_each_entry_rcu()
> without rcu_read_lock.
> 
> If we call get_kprobe() from the breakpoint handler context,
> it is run with preempt disabled, so this is not a problem.
> But in other cases, instead of rcu_read_lock(), we locks
> kprobe_mutex so that the kprobe_table[] is not updated.
> So, current code is safe, but still not good from the view
> point of RCU.
> 
> Let's lock the rcu_read_lock() around get_kprobe() and
> ensure kprobe_mutex is locked at those points.
> 
> Note that we can safely unlock rcu_read_lock() soon after
> accessing the list, because we are sure the found kprobe has
> never gone before unlocking kprobe_mutex. Unless locking
> kprobe_mutex, caller must hold rcu_read_lock() until it
> finished operations on that kprobe.
> 
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Instead of this, can you not just pass the lockdep_is_held() expression as
the last argument to list_for_each_entry_rcu() to silence the warning? Then
it will be a simpler patch.

thanks,

 - Joel

> ---
>  kernel/kprobes.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 53534aa258a6..fd814ea7dbd8 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -319,6 +319,7 @@ static inline void reset_kprobe_instance(void)
>   * 	- under the kprobe_mutex - during kprobe_[un]register()
>   * 				OR
>   * 	- with preemption disabled - from arch/xxx/kernel/kprobes.c
> + * In both cases, caller must disable preempt (or acquire rcu_read_lock)
>   */
>  struct kprobe *get_kprobe(void *addr)
>  {
> @@ -435,6 +436,7 @@ static int kprobe_queued(struct kprobe *p)
>  /*
>   * Return an optimized kprobe whose optimizing code replaces
>   * instructions including addr (exclude breakpoint).
> + * This must be called with locking kprobe_mutex.
>   */
>  static struct kprobe *get_optimized_kprobe(unsigned long addr)
>  {
> @@ -442,9 +444,12 @@ static struct kprobe *get_optimized_kprobe(unsigned long addr)
>  	struct kprobe *p = NULL;
>  	struct optimized_kprobe *op;
>  
> +	lockdep_assert_held(&kprobe_mutex);
> +	rcu_read_lock();
>  	/* Don't check i == 0, since that is a breakpoint case. */
>  	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH; i++)
>  		p = get_kprobe((void *)(addr - i));
> +	rcu_read_unlock();	/* We are safe because kprobe_mutex is held */
>  
>  	if (p && kprobe_optready(p)) {
>  		op = container_of(p, struct optimized_kprobe, kp);
> @@ -1478,18 +1483,21 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
>  {
>  	struct kprobe *ap, *list_p;
>  
> +	lockdep_assert_held(&kprobe_mutex);
> +	rcu_read_lock();
>  	ap = get_kprobe(p->addr);
>  	if (unlikely(!ap))
> -		return NULL;
> +		goto out;
>  
>  	if (p != ap) {
>  		list_for_each_entry_rcu(list_p, &ap->list, list)
>  			if (list_p == p)
>  			/* kprobe p is a valid probe */
> -				goto valid;
> -		return NULL;
> +				goto out;
> +		ap = NULL;
>  	}
> -valid:
> +out:
> +	rcu_read_unlock();	/* We are safe because kprobe_mutex is held */
>  	return ap;
>  }
>  
> @@ -1602,7 +1610,9 @@ int register_kprobe(struct kprobe *p)
>  
>  	mutex_lock(&kprobe_mutex);
>  
> +	rcu_read_lock();
>  	old_p = get_kprobe(p->addr);
> +	rcu_read_unlock();	/* We are safe because kprobe_mutex is held */
>  	if (old_p) {
>  		/* Since this may unoptimize old_p, locking text_mutex. */
>  		ret = register_aggr_kprobe(old_p, p);
> 
