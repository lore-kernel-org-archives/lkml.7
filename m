Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12499215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXr+rfS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfFYKD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:03:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41318 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYKD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:03:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so9211972pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZBl3YBCGr2TkoynfSi6k0BV9mYucHFfZB7RzFEuUl4=;
        b=WXr+rfS/rszZ4yQsdLfXsyMkLO6mhuPEzfQ87IU+Ico7psF7w4ljJ+GK97Zpfddrhq
         PB366eC9oTuaqMgZ2x2E0e55033ERqbA+bAtEZ/LngETvGbdMZfftPEKFNeyIRi40vUe
         wee42/h5Rqv1SwmaAnAg0ssDEG7hg629ABhooO3IpXEoRKBxLHFsL4hFwwbqWAYc5otk
         TwRjxKToFUmwVExWKMyTYbgpAsV487CdnOzYNof3Is0agTeSD8Wr9xPuH1S/krDY+0db
         aXxP4hTCwetawDInx97AOtp+89E5NVj2d46jdbc/Pt5Sk93RJzulH+kTJT34nQ175/Lw
         kxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZBl3YBCGr2TkoynfSi6k0BV9mYucHFfZB7RzFEuUl4=;
        b=o6R64rSFR5SGKpdrkaoiV9H83f6hC6gZDqwcdOecHoBe3yOjCKSP1DW1GHZVE5wUYC
         n5jW+qgaheok/syI5HSJNgZppcUQqSpt3U/ibqdMkfmh/XHMY1MFVczoQGz16PrU0hU5
         SmTrE0l8O4oEblXfK1PxAjkM5b/325m/RmnXf2EEt72QwrR4+YykoyqhmxLUFU8dVmnU
         3+M1QGdmZhJvQcscQASgOgMwPQlz43K22ZXtoPUPs30TS6DngW7LmGQZ8LXstrRI6lYL
         j4rwhtMSGZvEQvMKV1Lm8bTfSX8P042C1PPAHgq5UICPIKk9+LBHSUo7YqxMxDI6odxh
         5sRQ==
X-Gm-Message-State: APjAAAWhZzM+p9n3n22VElAW6CmyobgVDX345l7K7wvBC4uAb4PXltOm
        oj61UxoBUZOZd66XX6iv4Fw=
X-Google-Smtp-Source: APXvYqyifQUMisgnYyI/ZiqlDTise+qowJ2uoRmtol0JbCRaNSkTVvO4EnTV7O09mHwqeH7NDX5MWw==
X-Received: by 2002:a65:40cb:: with SMTP id u11mr39968946pgp.333.1561457007433;
        Tue, 25 Jun 2019 03:03:27 -0700 (PDT)
Received: from localhost ([175.223.22.38])
        by smtp.gmail.com with ESMTPSA id z13sm5336351pjn.32.2019.06.25.03.03.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 03:03:26 -0700 (PDT)
Date:   Tue, 25 Jun 2019 19:03:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190625100322.GD532@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
 <20190625064543.GA19050@jagdpanzerIV>
 <20190625071500.GB19050@jagdpanzerIV>
 <875zoujbq4.fsf@linutronix.de>
 <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/25/19 11:06), Petr Mladek wrote:
> On Tue 2019-06-25 10:44:19, John Ogness wrote:
> > On 2019-06-25, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> > > In vprintk_emit(), are we going to always reserve 1024-byte
> > > records, since we don't know the size in advance, e.g.
> > > 
> > > 	printk("%pS %s\n", regs->ip, current->name)
> > > 		prb_reserve(&e, &rb, ????);
> > > 
> > > or are we going to run vscnprintf() on a NULL buffer first,
> > > then reserve the exactly required number of bytes and afterwards
> > > vscnprintf(s) -> prb_commit(&e)?
> > 
> > (As suggested by Petr) I want to use vscnprintf() on a NULL
> > buffer. However, a NULL buffer is not sufficient because things like the
> > loglevel are sometimes added via %s (for example, in /dev/kmsg). So
> > rather than a NULL buffer, I would use a small buffer on the stack
> > (large enough to store loglevel/cont information). This way we can use
> > vscnprintf() to get the exact size _and_ printk_get_level() will see
> > enough of the formatted string to parse what it needs.
> 
> vscnprintf() with NULL pointer is perfectly fine. Only the formatted
> string has variable size.

Yeah, that should work. Probably. Can't think of any issues, except
for increased CPU usage. Some sprintf() format specifiers are heavier
than the rest (pS/pF on ia64/ppc/hppa).

OK, very theoretically.

There is a difference.

Doing "sz = vscprintf(NULL, msg); vscnprintf(buf, sz, msg)" for
msg_print_text() and msg_print_ext_header() was safe, because the
data - msg - would not change under us, we would work with logbuf
records, IOW with data which is owned by printk() and printk only.

But doing
		sz = vcsprintf(NULL, "xxx", random_pointer);
		if ((buf = prb_reserve(... sz))) {
			vscnprintf(buf, sz, "xxx", random_pointer);
			prb_commit(...);
		}

might have different outcome sometimes. We probably (!!!) can have
some race conditions. The problem is that, unlike msg_print_text()
and msg_print_ext_header(), printk() works with pointers which it
does not own nor control. IOW within single printk() we will access
some random kernel pointers, then do prb stuff, then access those
same pointers, expecting that none of them will ever change their
state. A very simple example

		printk("Comm %s\n", current->comm)

Suppose printk on CPU0 and ia64_mca_modify_comm on CPU1

CPU0								CPU1
printk(...)
 sz = vscprintf(NULL, "Comm %s\n", current->comm);
								ia64_mca_modify_comm()
								  snprintf(comm, sizeof(comm), "%s %d", current->comm, previous_current->pid);
								  memcpy(current->comm, comm, sizeof(current->comm));
 if ((buf = prb_reserve(... sz))) {
   vscnprintf(buf, "Comm %s\n", current->comm);
				^^^^^^^^^^^^^^ ->comm has changed.
					       Nothing critical, we
					       should not corrupt
					       anything, but we will
					       truncate ->comm if its
					       new size is larger than
					       what it used to be when
					       we did vscprintf(NULL).
   prb_commit(...);
 }

Probably there can be other examples.

	-ss
