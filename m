Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C3C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4E920989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Wvgz5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfEHHxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:53:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43855 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfEHHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:53:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id c6so4860649pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWVIY3U4u87uBqpX8q3XHH6irKlOA03Q7B0W5k01mmw=;
        b=F/Wvgz5Ok8Ade93VsE4p7w+Bw3YwJPVymRMeMtr3idBsR65KEMoDUPgkAxJDjODqh2
         NCU2ljU1CibfGKtC6+4e0CuxOZEUHfyF0QCsjJoRLAVvTgxPIGsR84KCo3hX8eqQpYnZ
         9XlBrrxLETEgiqxySINsWxhFCngcwGiiEr17Qb90AVUcg4uZOzVemsQY8Y8Y3LJQFHum
         73AJ/xAs7BGEHD27PyQiGLER/jiVrofcPNCU0Ts3cUNmxXwn89O08WroF/GC0uSM1ki0
         Ped6qCHD2anWdTmTxwfRlSfe1grxvKzXlV4Ae1MM2a9zOyvpMc+E0qxb65ZyFwPa7iHa
         KvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWVIY3U4u87uBqpX8q3XHH6irKlOA03Q7B0W5k01mmw=;
        b=PCp6q7UN4i7wUBudD0BuukEBjsIObYX+egAu5cdz6Jm2Hvcp70NxClh+hR2LgotsqH
         3mC0LOlbFfgIVW+vVCmMqTgA4pvh5JFJWVZCV0kRW82OgiD7eMUcNYUBsE5Tg8w23PoX
         uV9EW1SzxT0vnEoiiPsxOB+LJ1KyrH2xqhirY4ab+fj35ri1CUI1f6QSxQkX8gBqOKJv
         Xi9xqcQ75kUkSofpijrCdIYE7YFCOgVyWGq69G5Tl+ms4Rh0VUZOE3J5NnLTShoM1k/9
         E7zxbjOneMSrMfpL1KDNLaFPjLSadStTbWdqPwSWOnDSxcjXN9jSnoAA6WyN2bdkeD9u
         kldA==
X-Gm-Message-State: APjAAAXAlr4nU7wjSMeJSB0U1qAcNJ4lJIfpudJIPPbl/yjJMQJbFVP2
        MNnUqLBM85I1IMh0ASx70ZU=
X-Google-Smtp-Source: APXvYqzAmP0nAR6CZNHoHx0W3A+nIMSCramZJYYQeHEy6EPzBVkni9q0bq/QjXyW83MSBKe9XPk/1w==
X-Received: by 2002:a63:4a66:: with SMTP id j38mr15898170pgl.199.1557301987341;
        Wed, 08 May 2019 00:53:07 -0700 (PDT)
Received: from localhost ([175.223.21.172])
        by smtp.gmail.com with ESMTPSA id x30sm3026318pgl.76.2019.05.08.00.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 00:53:06 -0700 (PDT)
Date:   Wed, 8 May 2019 16:53:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] RFC: x86/smp: use printk_deferred in
 native_smp_send_reschedule
Message-ID: <20190508075302.GC15704@jagdpanzerIV>
References: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
 <20190508074420.GB15704@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508074420.GB15704@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/08/19 16:44), Sergey Senozhatsky wrote:
> [..]
> >  static void native_smp_send_reschedule(int cpu)
> >  {
> >  	if (unlikely(cpu_is_offline(cpu))) {
> > -		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> > +		printk_deferred(KERN_WARNING
> > +				"sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
> >  		return;
> >  	}
> >  	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
> 
> Hmm,
> One thing to notice here is that the CPU in question is offline-ed,
> and printk_deferred() is a per-CPU type of deferred printk(). So the
> following thing
> 
> 	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
> 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
> 
> might not print anything at all. In this particular case we always
> need another CPU to do console_unlock(), since this_cpu() is not
> really expected to do wake_up_klogd_work_func()->console_unlock().

D'oh... It's remote CPU which is offline, not this_cpu().
Sorry, my bad!

Any printk-related patch in this area will make PeterZ really-really
angry :)

printk_deferred(), just like prinkt_safe(), depends on IRQ work;
printk_safe(), however, can redirect multiple lines, unlike
printk_deferred(). So if you want to keep the backtrace, you may
do something like

	if (unlikely(cpu_is_offline(cpu))) {
		printk_safe_enter(...);
		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n",
			 cpu);
		printk_safe_exit(...);
		return;
	}

I think, in this case John's reworked-printk can do better than
printk_safe/printk_deferred.

	-ss
