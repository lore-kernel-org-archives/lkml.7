Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452DFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93021019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LotEC8sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfEHIYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:24:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEHIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:24:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so10117446pfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iC6daHVC1NjMNGNI2NQyqVsJzQK+nooSjenlYkW2TAs=;
        b=LotEC8sC4S7OHW3lyc/DZgBDExW5f8NYUNxF+UL7csOiDFo0e7S7DuLAj/kBNS8nK5
         fNs18GG3nzobAm179wPW3ldJT71IhNB+zALy0X4Pu97IZugwWwKZ3UrWqsMIqK+NNdRi
         8QIy96WeKuqpX09N6gxHn4AAI2FlvZJNfl/x5ypn9f0rYe4MWeNXUelYzIxky5VYe/rQ
         90P0eRCMBUodgnnZ5TdJawgxrh4jJeiX26IKbIlCySs7P/zpdY6JWPXELKyCENCnZhnn
         t9dPbA2bRu6xl+m0O1UmQyl5ecqV5ljKgCPUlXwrOriaJTOigmRXWnXeTMaJXUNOsWgT
         +Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iC6daHVC1NjMNGNI2NQyqVsJzQK+nooSjenlYkW2TAs=;
        b=hrHslQf7ZI3Lkf915NhmRESgcthKK3Q0Y761WQn7voIkLuzQjRZQ5q85bniQg+JiPP
         tM72Ecg6GS6uMYriqsnA82ytvoFCXmW9hkl3UQK2Qe1gQ7ZjBbmJnIpYRh4eMH2jxC3l
         ar8NUOe5T8iGLUE70UsXHi4TpYZl1Vn+cCjtR3Puq5voytjEC6nvZfglKqJgnUAW4rMf
         IZxEgVYxi27qFdn55UHxdrn5DbZ224L1y7+t5xyg2RPYvuhMtauyliWE89NaKWvT240g
         h+QFCYPn/TwMIZdQRqXhht4Tnq3VDw0IDwvFtO5AZGAAZY2/TkmsZT3FRbmXUFLLUaI4
         Eirg==
X-Gm-Message-State: APjAAAVXqsoJGE6db2WEOFFSc3HC9YgZNPl7voPcWI4eAudkaLBgulyl
        CKO45wStS/M6znkRAwWEoow=
X-Google-Smtp-Source: APXvYqyYfBf1RTyexTFlq2oWjBFattsYJaqLo/svM/xoIyftGy6bk1B1kKSVwC4upWQHDvoP1QeYpg==
X-Received: by 2002:a63:2a89:: with SMTP id q131mr6147801pgq.359.1557303875912;
        Wed, 08 May 2019 01:24:35 -0700 (PDT)
Received: from localhost ([175.223.21.172])
        by smtp.gmail.com with ESMTPSA id 10sm27569688pft.100.2019.05.08.01.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:24:34 -0700 (PDT)
Date:   Wed, 8 May 2019 17:24:31 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] RFC: x86/smp: use printk_deferred in
 native_smp_send_reschedule
Message-ID: <20190508082431.GA21654@jagdpanzerIV>
References: <20190507173329.17031-1-daniel.vetter@ffwll.ch>
 <20190508074420.GB15704@jagdpanzerIV>
 <20190508075302.GC15704@jagdpanzerIV>
 <CAKMK7uFeRmSGkqFj-xmdebwKok9+z1pyDZWUMNXfzTT4H2=-fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFeRmSGkqFj-xmdebwKok9+z1pyDZWUMNXfzTT4H2=-fA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/08/19 10:06), Daniel Vetter wrote:
[..]
> > Any printk-related patch in this area will make PeterZ really-really
> > angry :)
> 
> Hm any more context for someone with no clue about this? Just that the
> dependencies are already terribly complex and it's not going to get
> better, or something more specific?

The main problem is that it's a deferred error-reporting, so such
a report has chances to never be reported. It's not like 'normal'
printk() is always guaranteed to immediately start printing; sometimes
it will, sometimes it won't, and sometimes it never will, for instance
when console_sem was locked by offline-ed CPU.

An example of PeterZ's opinion on printk_deferred()
/* message ID: 20181122101606.GP2131@hirez.programming.kicks-ass.net */

  | No, printk_deferred() is a disease, it needs to be eradicated, not
  | spread around.

> > printk_deferred(), just like prinkt_safe(), depends on IRQ work;
> > printk_safe(), however, can redirect multiple lines, unlike
> > printk_deferred(). So if you want to keep the backtrace, you may
> > do something like
> >
> >         if (unlikely(cpu_is_offline(cpu))) {
> >                 printk_safe_enter(...);
> >                 WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n",
> >                          cpu);
> >                 printk_safe_exit(...);
> >                 return;
> >         }
> >
> > I think, in this case John's reworked-printk can do better than
> > printk_safe/printk_deferred.
> 
> Hm I think this is what Petr was suggesting, but somehow I didn't find
> the printk_safe_* functions and didn't connect the dots.

These are in kernel/printk/printk_safe.c as of now.

> Needs the _irqsave variants I guess, I'll respin a v2 of this.

Let's wait a bit before respin.

	-ss
