Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF2C20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 06:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge5GSEbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCGGl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 01:41:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45986 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfCGGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 01:41:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id v21so10668214pfm.12;
        Wed, 06 Mar 2019 22:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+2f9XrPBaMlGd84FaxuYDQuAX24n8uEwrKI1q5ASyME=;
        b=ge5GSEbWmOnuw5RrJmxF2hRuEMTfr0ZedppfW26Nr3GuIQ6ahb/jOhJ9b6nx5YRwt8
         qATg/7n8aj7jJwO0XNtmNYfa1UGQz0vlIbA+zH7fxkv99qcG+zPTVUKNEZaQ20mbd1dp
         ipyM+xg4LQA4Qtpx/a7a1n6z2LyD2V/N2G5Y7OrxAYoyz2k+DikLAQWscNMJCo8EwntR
         9cgoTAi9zZraxFXRLXrAQKu8FI1EFBdA9v3psvamjOfBAmMkyELb5nZxfJToD+9NoFn2
         8Z0eDT/A2AUblaFq0SRATEg7gkGZefJBHfco+izJc5EPPMmmYstEO09fK1auumvN3hDI
         2OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+2f9XrPBaMlGd84FaxuYDQuAX24n8uEwrKI1q5ASyME=;
        b=G0rsaNlPIcMCJZvk8xGKAk9D3DYbPVt31U8ZnH7gWOIs9HeQzotIF936JFaHI6f3/a
         XWb3N9b/fCoPGWw+YHzIqAAVtKfjcCz9yQWq544a1wh7xkTiCqhBnLDbnPKBlmvpPaGJ
         u7VvYZp7VQlOU/TdhQz/gnNGq6wf4Mhek8fXysbSjNg6E6Sx773dd2UCclgX9aBoJxB5
         yfdLZnZo2osPKnAxeeQL0ZpGtLuG/UTiRrRzxILv1R2fIX7Y1xG47x636GTpYA2HWVtg
         Rfd5YbqetTfrOAc6ticw+14jzxw/1HGSxO0Tunkf6j33DSzEPhdsw9ySu8Gx5hD8S8Zt
         iPKA==
X-Gm-Message-State: APjAAAWT87p+knuZuAl2dtlu9h6Rlu3WXJ+Ip5bGj7csW0tXV4ZDACBd
        pzfFEBFLt5UUJFPbNCP30PMv4R5o
X-Google-Smtp-Source: APXvYqzinqJToUfo0bMMooKnBOpXmRA1+lTvR9q2l918KGRLE4hut3puFvd9itWruHoRCfl/DTxv/g==
X-Received: by 2002:a63:1947:: with SMTP id 7mr9979954pgz.279.1551940916521;
        Wed, 06 Mar 2019 22:41:56 -0800 (PST)
Received: from localhost ([175.223.39.30])
        by smtp.gmail.com with ESMTPSA id q7sm10975034pfa.119.2019.03.06.22.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 22:41:55 -0800 (PST)
Date:   Thu, 7 Mar 2019 15:41:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190307064152.GA425@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
 <20190304073856.GA552@jagdpanzerIV>
 <20190304100044.GC21004@jagdpanzerIV>
 <20190304110703.GA960@tigerII.localdomain>
 <87o96p9gtx.fsf@linutronix.de>
 <20190306155701.wc22i2no5swdcids@pathway.suse.cz>
 <87r2bjbt47.fsf@linutronix.de>
 <87k1hbbq2m.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1hbbq2m.fsf@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/06/19 23:22), John Ogness wrote:
> On 2019-03-06, Petr Mladek <pmladek@suse.com> wrote:
> >> _Both_ categories are important for the user, but their requirements
> >> are different:
> >> 
> >>    informational: non-disturbing
> >>    emergency:     reliable
> >
> > Isn't this already handled by the console_level?
> >
> > The informational messages can be reliably read via syslog, /dev/kmsg.
> > They are related to the normal works when the system works well.
> >
> > The emergency messages (errors, warnings) are printed in emergency
> > situations. They are printed as reliably as possible to the console
> > because the userspace might not be reliable enough.
> 
> I've never viewed console_level this way. _If_ console_level really is
> supposed to define the emergency/informational boundary, all
> informational messages are supposed to be handled by userspace, and
> console printing's main objective is reliability... then I would change
> my proposal such that:

OK, you guys are ahead of me.

FB folks want to have a per-console sysfs knob to dynamically adjust
loglevel on each console. The use case is to temporarily set loglevel
to, say, debug on fast consoles, gather some data/logs, set loglevel
back to less verbose afterwards.

Preserving the existing loglevel behaviour looks right to me.

> - if a console supports write_atomic(), _all_ console printing for that
>   console would use write_atomic()

Sounds right.
But Big-Konsole-Lock looks suspicious.

> - only consoles without write_atomic() will be printing via the
>   printk-kthread(s)
> 
> IMO, for consoles with write_atomic(), this would increase reliability
> over the current mainline implementation. It would also simplify
> write_atomic() implementations because they would no longer need to
> synchronize against write().

[..]
> For those consoles that cannot implement write_atomic() (vt and
> netconsole come to mind), or as a transition period until remaining
> console drivers have implemented write_atomic(), these would use the
> "fallback" of printing fully preemptively in their own kthread using
> write().

This sounds concerning. IMHO, netconsole is too important to rely
on preemptible printk and scheduler. Especially those netcons which
run in "report only when oops_in_progress" mode. Sometimes netconsole
is the fastest console available, but preemptible printk may turn it
into the slowest one.

	-ss
