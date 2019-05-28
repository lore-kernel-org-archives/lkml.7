Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC566C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E7C2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH3r38y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfE1EqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:46:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44774 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfE1EqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:46:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so10158809pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 21:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pfelsuE+NpfpiwwSPj+PJDOF17vKTZNaOiZ8Vzcpu0c=;
        b=SH3r38y4uya6eE4mQIAL3Ij9Je9PZgjL8tSNwmchiiQ6G9piQzs6JD27/RSIgNegpq
         rT9ab0yRMvMYbRIr4fWEEkNQY4gbyQtYT9lT/zG1cq+JRD8AItixY9+zS0WmJrIru/+I
         ZbAzLt+aZC3lwG6j5NPWtRuhiipzMeO1NyHOmN5Yp1HWNQTJy+Yj/PWpndxzu7v0D8fI
         ++TSW+anBbBgWe+WjoU5e+b1jGw9z82/RMvMUaeYX5gJFvRBr/+yqvnsMxSPcU56DBnn
         X9+1AtNUuL/h1zJmoLB97YLLNIm2rW3xqmXL6rrblbjN6wzp8nIPDS/RppBlZ9rDPijw
         NhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pfelsuE+NpfpiwwSPj+PJDOF17vKTZNaOiZ8Vzcpu0c=;
        b=rB1MeVu+1jagvj0XEz1fJflJsFCAH3B3Ugy3G7j05qkBz1R9XkukWwb8lwrYXdY6jx
         pODQcmK77T+65tMVk5a6LQhhb1lqBFe3ksnZ3wu1iCJ2+eQ8ZlO7yL78OBk7hNM8uNzC
         JK7S1/7xuTF87daN6fBuOzas+xqn9vdDvVpPwl+MLXHMrY75Sw7dnWvRI9mHwSVx6bqT
         Ry/QlMK6t573arhIQnxQNxuQZsBCxMYZ2nJlnlDr8m+d34zcXqUmRLSxz+6b8s5z87Ye
         7uah8U5JT10vIxiFfLaq3uPJ7RiFIjq/17dTzjNa4Y4y3u24OVUm7c9/QI3M/JEseHud
         KbCA==
X-Gm-Message-State: APjAAAWzS0NFYWoiqRtqEaEUCWK8d1go5YRpWEq7C3QOIWBhHp7zSQXL
        L3LEhx1w4u+JmiTlAsV7NoudteEZ
X-Google-Smtp-Source: APXvYqwndrNV6NvgvlHOb8PO9+7WqGbvhtU1vDPZJgowLHXlCWa5k2BpRmc/SCoNqQsGZGAPjiwpUA==
X-Received: by 2002:a65:6295:: with SMTP id f21mr29558483pgv.416.1559018783259;
        Mon, 27 May 2019 21:46:23 -0700 (PDT)
Received: from localhost ([175.223.45.124])
        by smtp.gmail.com with ESMTPSA id q98sm1181886pjc.1.2019.05.27.21.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 21:46:21 -0700 (PDT)
Date:   Tue, 28 May 2019 13:46:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528044619.GA3429@jagdpanzerIV>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528041500.GB26865@jagdpanzerIV>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/28/19 13:15), Sergey Senozhatsky wrote:
> On (05/28/19 01:24), Dmitry Safonov wrote:
> [..]
> > While handling sysrq the console_loglevel is bumped to default to print
> > sysrq headers. It's done to print sysrq messages with WARNING level for
> > consumers of /proc/kmsg, though it sucks by the following reasons:
> > - changing console_loglevel may produce tons of messages (especially on
> >   bloated with debug/info prints systems)
> > - it doesn't guarantee that the message will be printed as printk may
> >   deffer the actual console output from buffer (see the comment near
> >   printk() in kernel/printk/printk.c)
> > 
> > Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> > Make sysrq print the headers unsuppressed instead of changing
> > console_loglevel.
> 
> I've been thinking about this a while ago... So what I thought back
> then was that affected paths are atomic: sysrq, irqs, NMI, etc. Well
> at leasted it seemed to be so.

Ahh.. OK, now I sort of remember why I gave up on this idea (see [1]
at the bottom, when it comes to uv_nmi_dump_state()) - printk_NMI and
printk-safe redirections.

	NMI
		loglevel = NEW
		printk -> printk_safe_nmi
		loglevel = OLD

	iret

	IRQ
		flush printk_safe_nmi -> printk
		// At this point we don't remember about
		// loglevel manipulation anymore
	iret

We, probably, still need some flags to pass the "this was supposed to
be an important messages" info from printk-safe to normal printk. On
the other hand, if NMI printk-s then it's something rather important,
so we probably better print it anyway and avoid suppress_message_printing()
check for messages which are coming from printk-NMI buffers. To some
extent, it's the same with printk-safe: we don't use it unless we have
a very good reason. So if there is something in printk-safe buffers
then it better end up on consoles. So, maybe, we still can use that
per-CPU printk_context thing.

[1] https://lore.kernel.org/lkml/20180601044050.GA5687@jagdpanzerIV/

	-ss
