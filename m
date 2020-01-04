Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8F7C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949782464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atnmd4Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgADOdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:33:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43738 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:33:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so44949748wre.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=89bNMHaRa6L3vpJUbDlkwRJl5HZuJPwEMdwIffQFxwc=;
        b=atnmd4Roh9tkaAm3zd5I+/gPbZ6bZ00+TNkaXeP5xsra4QOFaNBEZDLi9PQNEaMg6B
         rAv+/X/ZFsMV5PHNpjs8pnnQlAOF+ulqk1FRUaBO58tChSwwhR8KJHKxQt2vUTd4n5mi
         xCtRXWIbnTeZmks/zThswc0/bCCzENXIk1XPvm1N/pH2UKlXKeW2Qlv6CBjmk5pODIqK
         sTZ5D1+vcoUTTdT4IaFdGEwp76w1U3taEN2WneZKhXDqR03Bv1xY7yoSYn6T+k85RoX0
         /jK56Es7trvUUnyXUzgph+AHwmiru3ARx4UZo8UE0UjD0g3tTVXNSBFHrVPDN3viYimF
         Iy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89bNMHaRa6L3vpJUbDlkwRJl5HZuJPwEMdwIffQFxwc=;
        b=PTfvsIfyCGDXllt7acHuddVMa6pXtAH7vlzIwQsCF5BPN9UTlAjRk2eC8e7Nq+Zmam
         s7lXfREcIjkOBc3lEOEo5PFAAfKdhqaOBH2k+L2+dxOFO5m8u8Ws35fvZvIvKvtCkAT1
         rieOVz8P4WNAgK0Ty0Lk6Ukx0WcLG0PNUp+sE+0+UzFyWWmBW4lvpUMvjMPLSfEs3M/y
         catFcUH8zBzg9A7nj1Ix4nmNeN25vvWaf5CULFpeFzfa67BuT5TofZxceN7gkBKc0x9Y
         MvbQk5KmfLuzbDhc8N18fi4ghXjbBRdfnGeHtqMWoFPLt2aLVYxEaEE2jydo5CglWG7c
         AeKQ==
X-Gm-Message-State: APjAAAUpZqwlPFbPY/kmnmoXuLMAiFydxDdP9qJ/OOVQb4etKEyJxMNJ
        C+Iib3N6KNlBfC8nyO/8D6M=
X-Google-Smtp-Source: APXvYqwYXp6v3I7pyLMrm0npHaao7g16+FX2Olhs4pJQyoDHKOq4Arc3PfiwxFYkR0XFK2uI28TEmg==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr91702666wrt.339.1578148401442;
        Sat, 04 Jan 2020 06:33:21 -0800 (PST)
Received: from andrea ([93.187.88.19])
        by smtp.gmail.com with ESMTPSA id n8sm65204186wrx.42.2020.01.04.06.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 06:33:20 -0800 (PST)
Date:   Sat, 4 Jan 2020 15:33:14 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20200104143314.GA3468@andrea>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191221142235.GA7824@andrea>
 <87imm7820z.fsf@linutronix.de>
 <20200103102420.n6i5chgxaygfvx5h@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103102420.n6i5chgxaygfvx5h@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:24:20AM +0100, Petr Mladek wrote:
> On Mon 2019-12-23 17:01:00, John Ogness wrote:
> > Hi Andrea,
> > 
> > On 2019-12-21, Andrea Parri <parri.andrea@gmail.com> wrote:
> > >> +	*desc_out = READ_ONCE(*desc);
> > >> +
> > >> +	/* Load data before re-checking state. */
> > >> +	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */
> > >
> > > I looked for a matching WRITE_ONCE() or some other type of marked write,
> > > but I could not find it.  What is the rationale?  Or what did I miss?
> 
> Good question. READ_ONCE() looks superfluous here because it is
> surrounded by two read barriers. In each case, there is no
> corresponding WRITE_ONCE().
> 
> Note that we are copying the entire struct prb_desc here. All values
> are written only when state_val is in desc_reserved state. It happens
> between two full write barriers:
> 
>   + A writer is allowed to modify the descriptor after successful
>     cmpxchg in desc_reserve(), see LMM_TAG(desc_reserve:A).
> 
>   + The writer must not touch the descriptor after changing
>     state_var to committed state, see
>     LMM_TAG(prb_commit:A) in prb_commit().
> 
> These barriers are mentioned in the comments for the two
> read barriers here.

Thanks for these remarks.  As usual, I'd recommend to (try to) map those
comments into litmus tests and check with the LKMM simulator.


> BTW: Documentation/memory-barriers.txt describes various aspects of
> the memory barriers. It describes implicit barriers provided
> by spin locks, mutexes, semaphores, and various scheduler-related
> operations.
> 
> But I can't find any explanation of the various variants of the atomic
> operations: acquire, release, fetch, return, try, relaxed. I can find
> some clues here and there but it is hard to get the picture.

Documentation/atomic_t.txt could serve this purpose.  Please have a look
there and let me know if you have any comments.

Thanks,
  Andrea
