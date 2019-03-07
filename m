Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949B520663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+/oJeqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfCGCM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:12:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34649 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfCGCM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:12:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so9966532pgd.1;
        Wed, 06 Mar 2019 18:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lMptHAcBEYC7MEKdBI7yXvacPzttGiXkC9lEO09Rpg0=;
        b=e+/oJeqZrjaFVeqghbgseyLoD0wRM9R/eHJQP86ZgIXTTHFvqJnVhI4hKwt/uRkAao
         22r4VR8vSwHe1K+SC6sMoM+f6RxJiA2bSeLHRtyiTkiuzlYmyeZ/4AGsDM8CWnNT6aUY
         G+YsOrKGLgkQ2qU4CewiAML7usp75K5SarFDE7GtPuUq3OwAgwdVcyFUKcFOz9vlf61P
         zeFgjQxn/+8UBCzgMeNQcDPFRDjhkRssRjaxSxVqrYqQ92BE94XoCT25NJM5EB4PGfvD
         21Ia9oX3VPGy9Z/xC/tcLpE2IAaFB42Tox7it7mxyfYlNu0XeuTsRjx4pp3amhFlDtWd
         VTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lMptHAcBEYC7MEKdBI7yXvacPzttGiXkC9lEO09Rpg0=;
        b=chIZ1aKdOo8ru5L6OKkXP0zHh/w73/4UwhrSHRLJvOd5plwsH9wW4HOym3XtztguwS
         xLEQYEth8YuetWkGJ+QqxFGlq4cnYZhv1T6Dn7Ml4eCL77l7oSmDjFfUOvKDDl9AuPID
         9CFdFc2meVkyaCdy4Lb6lSW5i5Wxg6iRHM1naAMZqCQYsGDVmgfz2k/o3qvJpMiqWA29
         itqG192nuh4sdaqMNa3uANWL++S8UTO8kqIuOLKE/JDtoSFmJw+loHFjb65w9aLh+vOT
         94FIhU9u6lKudFIcPQWr4hB8qJGXjGz0fzjx3yxRpM9v6D6B3pk8vH9LsdXgAb0FoQZ2
         QqiA==
X-Gm-Message-State: APjAAAXY61tejmjhV68a0jCqTFCjYMqxXKvEiF4x9B/KW7xy5ZPc6e02
        Q/bLQe3KwnkHYZjWyph44jc=
X-Google-Smtp-Source: APXvYqxiJzxo22+6MPsYSgTIv5oRHbxTCq6jpa85dGd/EsasQTygtRue5MLcsKe0ZXI4SGjRiKrWjA==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr10466671pln.74.1551924746166;
        Wed, 06 Mar 2019 18:12:26 -0800 (PST)
Received: from localhost ([175.223.39.30])
        by smtp.gmail.com with ESMTPSA id n15sm9374635pfi.173.2019.03.06.18.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 18:12:24 -0800 (PST)
Date:   Thu, 7 Mar 2019 11:12:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Message-ID: <20190307021221.GA9676@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/12/19 15:29), John Ogness wrote:
> +static bool __prb_trylock(struct prb_cpulock *cpu_lock,
> +			  unsigned int *cpu_store)
> +{
> +	unsigned long *flags;
> +	unsigned int cpu;
> +
> +	cpu = get_cpu();
> +
> +	*cpu_store = atomic_read(&cpu_lock->owner);
> +	/* memory barrier to ensure the current lock owner is visible */
> +	smp_rmb();
> +	if (*cpu_store == -1) {
> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
> +		local_irq_save(*flags);
> +		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
> +					       cpu_store, cpu)) {
> +			return true;
> +		}
> +		local_irq_restore(*flags);
> +	} else if (*cpu_store == cpu) {
> +		return true;
> +	}
> +
> +	put_cpu();
> +	return false;
> +}
> +
> +/*
> + * prb_lock: Perform a processor-reentrant spin lock.
> + * @cpu_lock: A pointer to the lock object.
> + * @cpu_store: A "flags" pointer to store lock status information.
> + *
> + * If no processor has the lock, the calling processor takes the lock and
> + * becomes the owner. If the calling processor is already the owner of the
> + * lock, this function succeeds immediately. If lock is locked by another
> + * processor, this function spins until the calling processor becomes the
> + * owner.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store)
> +{
> +	for (;;) {
> +		if (__prb_trylock(cpu_lock, cpu_store))
> +			break;
> +		cpu_relax();
> +	}
> +}

Any chance to make it more fair? A ticket based lock, perhaps?

	-ss
