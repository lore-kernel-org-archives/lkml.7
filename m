Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ACC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808F20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgKXIPBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389707AbfGRJtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:49:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46484 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfGRJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:49:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so12358946pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEhDsVo3Nurhjhtki8EUR4Q4CvTeNIhYiFkcnjd2dF0=;
        b=CgKXIPBK92lRjRgVqUVgai5D43pz2FKCNFvz01oNHgIAj9zX0PWct/0XDFBMx0v/+A
         lOkDmQrEZjdUWdq/6cL+iwM5+KMlI0HXt3iSFzJ2kCGq+k2JwfjZx8KOOiDK0h0+Ehl+
         oK26AHGvq6qOaygfySx3TNcd239eXPsDcKC86nyb5R2Vq6z2+MT4ekm0j+r3AWu1PNhx
         0tG70PrdzH4ZdHZc40gTMtcxgMoaOd7wvWH3vVC3rcaJfywmESPMCY3BkX/x8Y4lDM3j
         dI1x5bYR6/ktYbwRh9+Fta0shJOWLrz6AGoEXRLehVGN6Oi+v4p4SkBhV84i3p+YysSd
         ArwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEhDsVo3Nurhjhtki8EUR4Q4CvTeNIhYiFkcnjd2dF0=;
        b=HNyUjDwK+PyS+M+D6AjCdu+s3K3wd02WhUHhh2mbkI+K00GQ64W32twcNAEL3Y/RzH
         U8Pf7dU1zrkHbnTdUNiAgfe9B2udOaOk+o+D0cWRdT6J0xzYMEMTUVdrb9O1G1DLNj3K
         1Lf/VrgOb3lKdpKgwqQUtF7vkypjuDrvEn8XpVJgWZU8f9hBB8JJSdJZLgtcw8FPKrPG
         mcF74ustZcSUfGeXFzU6YFhuQ0FagKJBl35pPn6WIAXot+LlHbEa33vBTA8QXP5IM8Qn
         ZxgjPIDWz/dVC/JqKAyt6KhBZzaZwD4yJ2OBoZOi+0UCCS9lvzfUFzDnwdVwuHGnNXu9
         LbtA==
X-Gm-Message-State: APjAAAWRxCnImJx/LKrnohoGS7i0giRgLab5nKFJi+86NRB65OzeJ4/s
        yBMHNUUpPFR7dU7cLJcHog9WgOox
X-Google-Smtp-Source: APXvYqwC8DmP2doNk64PuoJOKqwoHOFve00ouQW7taOhWzBN7zX2OFS7unUqM3MGQOgFZ92TYbIraw==
X-Received: by 2002:a63:1046:: with SMTP id 6mr48019870pgq.111.1563443378646;
        Thu, 18 Jul 2019 02:49:38 -0700 (PDT)
Received: from localhost ([39.7.59.92])
        by smtp.gmail.com with ESMTPSA id b37sm47020162pjc.15.2019.07.18.02.49.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 02:49:37 -0700 (PDT)
Date:   Thu, 18 Jul 2019 18:49:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk/panic: Access the main printk log in panic()
 only when safe
Message-ID: <20190718094934.GA10041@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-2-pmladek@suse.com>
 <20190717095615.GD3664@jagdpanzerIV>
 <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718083629.nso3vwbvmankqgks@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/18/19 10:36), Petr Mladek wrote:
> On Wed 2019-07-17 18:56:15, Sergey Senozhatsky wrote:
> > On (07/16/19 09:28), Petr Mladek wrote:
> > > Kernel tries hard to store and show printk messages when panicking. Even
> > > logbuf_lock gets re-initialized when only one CPU is running after
> > > smp_send_stop().
> > > 
> > > Unfortunately, smp_send_stop() might fail on architectures that do not
> > > use NMI as a fallback. Then printk log buffer might stay locked and
> > > a deadlock is almost inevitable.
> > 
> > I'd say that deadlock is still almost inevitable.
> > 
> > panic-CPU syncs with the printing-CPU before it attempts to SMP_STOP.
> > If there is an active printing-CPU, which is looping in console_unlock(),
> > taking logbuf_lock in order to msg_print_text() and stuff, then panic-CPU
> > will spin on console_owner waiting for that printing-CPU to handover
> > printing duties.
> > 
> > 	pr_emerg("Kernel panic - not syncing");
> > 	smp_send_stop();
> 
> Good point. I forgot the handover logic. Well, it is enabled only
> around call_console_drivers(). Therefore it is not under
> lockbuf_lock.
> 
> I had in mind some infinite loop or deadlock in vprintk_store().
> There was at least one long time ago (warning triggered
> by leap second).
> 
> 
> > If printing-CPU goes nuts under logbuf_lock, has corrupted IDT or anything
> > else, then we will not progress with panic(). panic-CPU will deadlock. If
> > not on
> > 	pr_emerg("Kernel panic - not syncing")
> > 
> > then on another pr_emerg(), right before the NMI-fallback.
> 
> Nested printk() should not be problem thanks to printk_safe.

Where do nested printk()-s come from? Which one of the following
scenarios you cover in commit message:

scenario 1

- we have CPUB which holds logbuf_lock
- we have CPUA which panic()-s the system, but can't bring CPUB down,
  so logbuf_lock stays locked on remote CPU

scenario 2

- we have CPUA which holds logbuf_lock
- we have panic() on CPUA, but it cannot bring down some other CPUB
  so logbuf_lock stays locked on local CPU, and it cannot re-init
  logbuf.

	-ss
