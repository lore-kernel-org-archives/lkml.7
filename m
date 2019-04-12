Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96248C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6307420818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555048046;
	bh=eANXyXm87iVrWzmhKnUkY9yTAsxJTPN+sYmkJAgKnXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d4K0gP1bLqzQeOhAIZFH6advtIA+vfVnnlpPtx5fWoFAequ4soED2bk/zvtdYvGTC
	 SmGGrksCiBYrPFZFOgLPiN/JIhwaQ67lglCwUPvZTmOoeQnuta8zAZc1Dyh6mw8/UC
	 Ycm/pIUHd/kSNJ5FvWzOjq70f3dBeOdv1j/Hrl8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDLFrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:47:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45039 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfDLFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:47:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so10241322wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 22:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0HK10Hof8oLKF93odeobTgirk0suVrKdv8vbW7FEpVY=;
        b=ccsDnnZ6zNgqkGzBLy7oZyewPjMDjRr3FvINRBT1zeGiwPgvjUZfDMBIWqpUeb5EIe
         YH3axR1BawkTVT4j/G1Ud2QldG3K05FqSJRYQa/dOa4hHvOzBidG2DtX8wwR95vhRtUB
         eusQsfNh0xvoPrH/sn502fzs+NSgShOSUzyTqu+v9XWiHCMp0ge89sdIYdim3dJvmjN+
         qMDCdVcHZ+leLxKoTczTGkJ4uvci/4TXajqgDqd60H5YnbvQDv5qiWGE4yAzFn1ObcJh
         cxxRS8EWX2jbLpa5IlrE8oirtNdAWdhwHe8keXKyxKU3xYU3B4oc+iXUkjYWYc24jw3r
         CpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0HK10Hof8oLKF93odeobTgirk0suVrKdv8vbW7FEpVY=;
        b=Gv4mfrYbrOOJtlNLWXocrfH+PBdbNlBhsBqLKD8hedegUKOtt5yUZ6GcvPGpOm15xG
         GSP1Ab6asK8emKoGvIlwEVR7d/GoA3QoEJA1mWViStb60jiSN6dSUxUbq0hn49oKBiEo
         vTjseUXQsxkWDGZYAVjSfH3PkK/7kxZKOqjrdTXfom+uN8PUtebEg0YBPOHmH1rr20Aq
         Ft+8yLyGEUuwI2GGdWzHmhrtAh0V/4VFj+gUdTVnymP/pAU0l7nfjF9uoG270KrX6mhb
         +ClUG3fAd8d4ew3o5XT0WFNIugbGoTNd9BWr8XZdR9Z9mI6GbKWqeZtlweMndhtky4hv
         twJg==
X-Gm-Message-State: APjAAAXeYLSlll10KAkX0m4TSEMpKewy/EbpdRcevb+8/kWEC3e8QyDv
        7gUHew4fUBfkUZJnRedQic0=
X-Google-Smtp-Source: APXvYqyyV+uNQqKgCzHKPUS4btI12st/mabjKv8+Y2bB30IiQrltlWGriWo8vLcWUfU5W2QXrh3ygg==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr4682767wru.161.1555048042800;
        Thu, 11 Apr 2019 22:47:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o17sm48689550wrw.73.2019.04.11.22.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 22:47:21 -0700 (PDT)
Date:   Fri, 12 Apr 2019 07:47:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: Re: [PATCH] locking/lockdep: Make lockdep_register_key() ignore
 'debug_locks'
Message-ID: <20190412054719.GA80743@gmail.com>
References: <20190411172612.39180-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411172612.39180-1-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Bart Van Assche <bvanassche@acm.org> wrote:

> If lockdep_register_key() and lockdep_unregister_key() are called with
> debug_locks == false then the following warning is reported:
> 
> WARNING: CPU: 2 PID: 15145 at kernel/locking/lockdep.c:4920 lockdep_unregister_key+0x1ad/0x240
> 
> That warning is reported because lockdep_unregister_key() ignores the
> value of 'debug_locks' and because the behavior of lockdep_register_key()
> depends on whether or not 'debug_locks' is set. Fix this inconsistency
> by making lockdep_register_key() unconditionally register lock keys.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: shenghui <shhuiw@foxmail.com>
> Reported-by: shenghui <shhuiw@foxmail.com>
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  kernel/locking/lockdep.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index d2d65bbfae01..a228509b62f1 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1027,15 +1027,16 @@ void lockdep_register_key(struct lock_class_key *key)
>  	hash_head = keyhashentry(key);
>  
>  	raw_local_irq_save(flags);
> -	if (!graph_lock())
> -		goto restore_irqs;
> +	arch_spin_lock(&lockdep_lock);
> +	current->lockdep_recursion = 1;
>  	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>  		if (WARN_ON_ONCE(k == key))
>  			goto out_unlock;
>  	}
>  	hlist_add_head_rcu(&key->hash_entry, hash_head);
>  out_unlock:
> -	graph_unlock();
> +	current->lockdep_recursion = 0;
> +	arch_spin_unlock(&lockdep_lock);
>  restore_irqs:
>  	raw_local_irq_restore(flags);
>  }

So why don't we add a debug_locks test to lockdep_unregister_key() 
instead? The general principle to bring lockdep to a screeching halt when 
bugs are detected, ASAP.

Thanks,

	Ingo
