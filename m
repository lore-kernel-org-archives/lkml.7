Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968FC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5881B2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhMmDJex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfGMNUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 09:20:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32916 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 09:20:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so5512984pfq.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t3ZLqWcrgfhZARjYVG38FnXLowWxYFGSUF90TwdQKak=;
        b=LhMmDJexwpmDvlUUqG9AZ0eqr/cR9BbdJh9N8GK2wc3brzk6sE81mzT865WRFJC5ig
         4XoBn7Hao9QwObCiDCbQy5q+VsiGlhPQxgj7SKIf2Co5fnsByjhAdHXUUZCrT1kSpIWO
         nSTX+ekBk/4KuYgTvPGeRkgtTBGreqHZtjGRY1tNQNvzzo5yFedlkzbtgNYT1hZicUVz
         CJdQCUVpsnPDNRSmNILCWnrC1XFydlpAdLN/6yn/bp80DkTg9Qrqkbs+ul3JLHKknp+Q
         7bJf6JDHG6Vtf05dIXwK5a44rMDmI6sAoRMvuSrJ9KH9nGC+fpuOYG9E5bH27x/nxWnK
         DPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t3ZLqWcrgfhZARjYVG38FnXLowWxYFGSUF90TwdQKak=;
        b=o7FIj9UP9z6Nfysc1K4q7rEnAMSbxN2ZoMWMHoGDGstoOft6l3tkB4CW/kv+JGrpL3
         XTxERccd9iD2DFzZlvcKOPUSfCMf6xUOUuIJQLDCiejpiBl9qkFjmAzHzA8AmSk3TsVb
         2sphm3MjMsNjFi9trMmq16Tj6VfRA152uILRaP/syoLXML4wFGLgkIaRi3SMJFL0Dr6w
         G/lKCwwbVMJFphAVeq4yg69JxN/XTyKCeBNV0K14pIloiNp30S9qwj3lViSR9ssXG56k
         jCP7JE0D2jksoUiGnxIa1ZW87Z9FuwUbk8VF7l3+C4Xylm9KUYcFlSWfWJuPLXjHKtrP
         T65A==
X-Gm-Message-State: APjAAAX1cMTsBndk4l98/IS51oF7+3KMJTd9kiW/NqQbCOfPBcJPDduZ
        Pjwq7kzrkWxkt+VuO2V8Gyo=
X-Google-Smtp-Source: APXvYqyOee2O8F1rFI8E7UGw7sE8Lvg3la871hAMyIz1mfS4821xEZYdOCJlIJbUsCl7TPstC3rhnw==
X-Received: by 2002:a63:f118:: with SMTP id f24mr17344644pgi.322.1563024005191;
        Sat, 13 Jul 2019 06:20:05 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id t29sm14383786pfq.156.2019.07.13.06.20.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 06:20:03 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 13 Jul 2019 22:19:47 +0900
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump
 from NMI context
Message-ID: <20190713131947.GA4464@tigerII.localdomain>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain>
 <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/13/19 09:46), Konstantin Khlebnikov wrote:
> > On (07/12/19 17:54), Konstantin Khlebnikov wrote:
> 
> Yep printk() can deal with NMI, but kmsg_dump() is a different beast.
> It reads printk buffer and saves content into persistent storage like ACPI ERST.

Ah, sorry! I misread your patch. Yeah, I see what you are doing.

OK. So, I guess that for kmsg_dump(KMSG_DUMP_PANIC) we should be
fine in general.

We call kmsg_dump(KMSG_DUMP_PANIC) after smp_send_stop() and after
printk_safe_flush_on_panic(). printk_safe_flush_on_panic() resets
the state of logbuf_lock, so logbuf_lock, in general case, should
be unlocked by the time we call kmsg_dump(KMSG_DUMP_PANIC).
Even for nested contexts.

	CPU0
	printk()
	 logbuf_lock_irqsave(flags)
	  -> NMI
	   panic()
	    smp_send_stop()
	     printk_safe_flush_on_panic()
	      raw_spin_lock_init(&logbuf_lock) << reinit >>
	    kmsg_dump(KMSG_DUMP_PANIC)
	     logbuf_lock_irqsave(flags)        << expected to be OK >>

So do we have strong reasons to disable NMI->panic->kmsg_dump(DUMP_PANIC)?

Other kmsg_dump(), maybe, can experience some troubles sometimes,
need to check that.

	-ss
