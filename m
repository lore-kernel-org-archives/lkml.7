Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA0C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C57521783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP98btX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfGRLaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:30:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42644 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:29:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so12760392pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 04:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IXN6tBOn9742CwcvhjcLaTFptFk037zPhxHTUhOqHvs=;
        b=HP98btX4EinKwxJWborSBP35sYAMvoIzYVdMaep0VO8zLeuTIxbT9nr2OKCe6Yiumv
         hNKsQYEWvKTq+9hrvN07MUyQrH/z1RZ00FegbS5DAjEVSulNidW9y6cIw3pHPJKjGhyZ
         P5R5vHo1dyop/sXl5GB2vqjV6AI6btInD5AGrrowOIGsph5JS4MLxxB+Rr6lT7iah36M
         kEDR0TRr8p+/x5/ipA8N9IOR7HlHmpE30TACILIdjnDVZAE4GdTvzGjjkFSpFfCQsQxz
         CtHn/drnPh6iCmJgGYCyDDiWe3EVOXDN6ok6vHAOooh4JoTTNU9/MCdmiiL54NREo5ub
         KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IXN6tBOn9742CwcvhjcLaTFptFk037zPhxHTUhOqHvs=;
        b=QVrjPHdBxPMZiniAgB1uBVKIJSNGmGq8xTHd3GMr+QcGEDRWrhHLx2EhsuiMz7y5N5
         +AvGD+TwYScQqltk1zKK4kNwVmbfy/WTFXU3RU/gEmkmuy8HbuzRpllI+y+HlfLRFO1r
         ykOKygZVgwWgvxaRx2mNc4GED5P0hLNRMMAAMtKfpDKJoPcG13nTW9vRW1akxRCPZtAb
         fDcDZRsqKmjDtUd3aD4hdnzXn+V3E9aF+RUGT/vz32Sb4z3O4IUd8tuFfJRW6bo9DGrn
         jHQcnk84sRVBxmbl2aL7YcZV3D92DeB3CQIImzEF8hkIeMAllUn5Ld1zw38JmbOFGzm3
         Jogg==
X-Gm-Message-State: APjAAAW0TubmP1ZC1V1396ILvAypwTh+Jr35TLWJVjyyr/1V0xVqHe+D
        Wl/xfK+bxFKcAXRoIPZAZFVlYAgm
X-Google-Smtp-Source: APXvYqzUFygz6Z97TylRIv+ZdLCzz93hsA3cMib/Uz0jEQHw51nimecSpEDc4QHrMA4yyr6F1+sFUA==
X-Received: by 2002:a65:5188:: with SMTP id h8mr14807872pgq.294.1563449399025;
        Thu, 18 Jul 2019 04:29:59 -0700 (PDT)
Received: from localhost ([39.7.59.92])
        by smtp.gmail.com with ESMTPSA id b126sm41216659pfa.126.2019.07.18.04.29.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 04:29:58 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:29:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] printk/panic/x86: Allow to access printk log buffer
 after crash_smp_send_stop()
Message-ID: <20190718112954.GA1774@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-3-pmladek@suse.com>
 <20190718104756.GA22851@jagdpanzerIV>
 <CALYGNiMnqUKxKsY1JRi075xs-P_QzfA4Pg3XANiW0mFYkp_RQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiMnqUKxKsY1JRi075xs-P_QzfA4Pg3XANiW0mFYkp_RQQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/18/19 14:07), Konstantin Khlebnikov wrote:
> > Let me test the waters. Criticize the following idea:
> >
> > Can we, sort of, disconnect "supposed to be dead" CPUs from printk()
> > so then we can unconditionally re-init printk() from panic-CPU?
> >
> > We have per-CPU printk_state; so panic-CPU can set, let's say,
> > DEAD_CPUS_TELL_NO_TALES bit on all CPUs but self, and vprintk_func()
> > will do nothing if DEAD_CPUS_TELL_NO_TALES bit set on particular
> > CPU. Foreign CPUs are not even supposed to be alive, and smp_send_stop()
> > waits for IPI acks from secondary CPUs long enough on average (need
> > to check that) so if one of the CPUs is misbehaving and doesn't want
> > to die (geez...) we will just "disconnect" it from printk() to minimize
> > possible logbuf/console drivers interventions and then proceed with
> > panic; assuming that misbehaving CPUs are actually up to something
> > sane. Sometimes, you know, in some cases, those CPUs are already dead:
> > either accidentally powered off, or went completely nuts and do nothing,
> > etc. etc. but we still can kdump() and console_flush_on_panic().
> 
> Good idea.
> Panic-CPU could just increment state to reroute printk into 'safe'
> per-cpu buffer.

Yeah, that's better.

So we can do something like this

@@ -269,15 +269,21 @@ void printk_safe_flush_on_panic(void)
 	 * Make sure that we could access the main ring buffer.
 	 * Do not risk a double release when more CPUs are up.
 	 */
-	if (raw_spin_is_locked(&logbuf_lock)) {
-		if (num_online_cpus() > 1)
-			return;
+	debug_locks_off();
+	raw_spin_lock_init(&logbuf_lock);
+	/* + re-init the rest of printk() locks */
+	printk_safe_flush();
+}

[..]

+void printk_switch_to_panic_mode(int panic_cpu)
+{
+	int cpu;
 
+	for_each_possible_cpu(cpu) {
+		if (cpu == panic_cpu)
+			continue;
+		per_cpu(printk_context, cpu) = 42;
+	}
 }

And call printk_switch_to_panic_mode() from panic(). And we don't
need to touch arch code (it also covers the case when some new ARCH
will gain NMI support).

	-ss
