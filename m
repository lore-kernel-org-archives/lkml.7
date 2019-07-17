Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B82C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5EB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFqEuvaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGQJ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:56:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44489 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:56:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so10569351pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nax5vQ5xGwguAqm1prl5ksmoGIUJLSz7zleAyUU5rWE=;
        b=gFqEuvaqsl/ZBRg+ZPS76pKU58aLlVcEhOMPMXMBntGcSwuGOZgdwZa1tc3UVe4s7O
         Z+X766VOnYUfxhob2LTLScdzKtl4wlSLHddii3EL9jXjALC4K9iABrU2R48IdU45GEWp
         ydmFA1PHvqpT80Waq9BFbcwndhvIGxw+GkRcpst33a1oLNMzX+N4yMshQtJEo0G+079u
         rgcGqBPV3agugXaPFnI2AheXOQw7DZQbjTW73bQD1ln/M+8WPGtYhraQCyOed5JTLus2
         Z2RHtAUDiS00mQizu6TAcIEQGY874ETwHOjfBVbaxOAeliKdgjAB+Gbq2Bq7lhS/3D2f
         6tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nax5vQ5xGwguAqm1prl5ksmoGIUJLSz7zleAyUU5rWE=;
        b=Pal/Qq4tVx86HLtjElo7NpeAgosrASkAmXXqF238FfnO2k1use/4UM+YzZ6YUj9liy
         IQzBTbxkCT2LTiDF6S4BNjlrs1gIaSQyMkuxtOQtTzeUd3Hmxd0oQkNwS3MfzXUbLEEq
         UlUXbq86xlKG1yEBbn4ru4252gyMp5+uzKdiTCZREbM1rDA3y5xGJX4fEBzHqJGiUnqW
         x8LcJs5CHBB7UR832gU6PZMMCjjVczOYeZLw6a9G1co76ePLBeg7sQqrCiuI/VfI8kqg
         zBm/GuqH0v1PsFv/KU1nGyp4OuyAS6CLbZ3879peL2KnwIa4BcPsdjXIqu0GsC9spaKW
         Yahw==
X-Gm-Message-State: APjAAAXxSEEcRgkvu17LywPK0241s1kRhuGA/qnSVrcTYVJZvIi8Alhj
        2vnW2QbkCnOWShdpp5LNA6k=
X-Google-Smtp-Source: APXvYqzbAoGw6nO5lQvb84hPyjLYMlJG+E1jcpKlZH5f2xpglEcGLbwGwz5jHvL86cEMQVji2bCt5g==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr4044827pgb.307.1563357380073;
        Wed, 17 Jul 2019 02:56:20 -0700 (PDT)
Received: from localhost ([175.223.17.76])
        by smtp.gmail.com with ESMTPSA id u128sm26521884pfu.48.2019.07.17.02.56.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 02:56:18 -0700 (PDT)
Date:   Wed, 17 Jul 2019 18:56:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>,
        Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190717095615.GD3664@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716072805.22445-2-pmladek@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/16/19 09:28), Petr Mladek wrote:
> Kernel tries hard to store and show printk messages when panicking. Even
> logbuf_lock gets re-initialized when only one CPU is running after
> smp_send_stop().
> 
> Unfortunately, smp_send_stop() might fail on architectures that do not
> use NMI as a fallback. Then printk log buffer might stay locked and
> a deadlock is almost inevitable.

I'd say that deadlock is still almost inevitable.

panic-CPU syncs with the printing-CPU before it attempts to SMP_STOP.
If there is an active printing-CPU, which is looping in console_unlock(),
taking logbuf_lock in order to msg_print_text() and stuff, then panic-CPU
will spin on console_owner waiting for that printing-CPU to handover
printing duties.

	pr_emerg("Kernel panic - not syncing");
	smp_send_stop();


If printing-CPU goes nuts under logbuf_lock, has corrupted IDT or anything
else, then we will not progress with panic(). panic-CPU will deadlock. If
not on
	pr_emerg("Kernel panic - not syncing")

then on another pr_emerg(), right before the NMI-fallback.

	static void native_stop_other_cpus()
	{
	...
		pr_emerg("Shutting down cpus with NMI\n");
		           ^^ deadlock here
		apic->send_IPI_allbutself(NMI_VECTOR);
		           ^^ not going to happen
	...
	}

And it's not only x86. In many cases if we fail to SMP_STOP other
CPUs, and one of hem is holding logbuf_lock then we are done with
panic(). We will not return from smp_send_stop().

arm/kernel/smp.c

void smp_send_stop(void)
{
	...
	if (num_online_cpus() > 1)
		pr_warn("SMP: failed to stop secondary CPUs\n");
}

arm64/kernel/smp.c

void crash_smp_send_stop(void)
{
	...
	pr_crit("SMP: stopping secondary CPUs\n");
	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);

	...
	if (atomic_read(&waiting_for_crash_ipi) > 0)
		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
				cpumask_pr_args(&mask));
	...
}

arm64/kernel/smp.c

void smp_send_stop(void)
{
	...
	if (num_online_cpus() > 1)
		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
				cpumask_pr_args(cpu_online_mask));
	...
}


riscv/kernel/smp.c

void smp_send_stop(void)
{
	...
	if (num_online_cpus() > 1)
		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
			cpumask_pr_args(cpu_online_mask));
	...
}

And so on.

	-ss
