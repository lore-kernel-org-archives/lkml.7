Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F13C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0D0214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVaAFDtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfGOHy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:54:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40807 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOHy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:54:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7871879pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2EqLe3LAwEFcMwoHbzXmTACPyJeJ406ewu59arKYTaM=;
        b=FVaAFDtJuZG19DfBwFD7hlUv0ewIEkytt8qottjjH6yLFKGLQZUmqtu92pVUnxR+T7
         OcymMZ2hW18LnQq9HLu1LPIrO7Z+u9v0I8vj3+gE2E9rqbjjZXeA/grpFTUVdaGQRP9D
         BIgVVX1dlFuJVALNj3JfQV+XjDQDcByO1nj3TsxlKwDpI1eudAuKEcVZ9k9eSu7PZi8Q
         MKcQ0GEAfd8cDbFrxWwdEHxmP9nenG19Y5FJEdeo/kDRsl5n2yqD0pXep6LyI8dHyl2c
         AUA+ixWxIXtyo1mEQByRj5WjiuO2b6xtMm5OUg4ldhoFxLVEAkXWccV9k8y/3CC3SEN3
         F8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2EqLe3LAwEFcMwoHbzXmTACPyJeJ406ewu59arKYTaM=;
        b=klwtQF6j3Rm11ts1CRqENogq3lvr90gHQPeM1YIlOArccLvobpG8bUCNBIttU9Zrsd
         I5mJ4GwFBu8357ccRtp3t87jnwQGXRbf6UvOyRBr/M20N1ysMpOg0rRBOj+1eFJvp73N
         kZrhK1FomOycNw9ORq4ldJLdVh7pAmNyefXH6pGghiNJsatK5jzhAJyj3PRIGYFpBqey
         iA5fv4LYOqwmOdnfaOu8s7OtOqES41GEamRrfR9eCwTcayf0xL5Vki1yrxAdaQD2x0pt
         VsZaR14vfHEk8BlLyRy94mE1twedoHpVXGyrP75innkt6qEsHLJ4hhxcQlPwm91SIttB
         WyLA==
X-Gm-Message-State: APjAAAWZfvDcm6zzMPVOJxKYFjMtXKFvZ3xjyH0LwpUy6B+/1gqQRl/z
        ZFtu1WxpVYTnlQKsQwSYdBk=
X-Google-Smtp-Source: APXvYqyvGX1c5xjAd2PUbd8cxy5fa7IPH68r/R9GT7KlHj5OcRJmtbddcpa/IxsmJz0m7D4/D2uKIg==
X-Received: by 2002:a17:902:f301:: with SMTP id gb1mr26442352plb.292.1563177296950;
        Mon, 15 Jul 2019 00:54:56 -0700 (PDT)
Received: from localhost ([39.7.59.60])
        by smtp.gmail.com with ESMTPSA id t17sm18816843pgg.48.2019.07.15.00.54.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 00:54:56 -0700 (PDT)
Date:   Mon, 15 Jul 2019 16:54:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kernel/printk: prevent deadlock at calling kmsg_dump
 from NMI context
Message-ID: <20190715075452.GA1875@jagdpanzerIV>
References: <156294329676.1745.2620297516210526183.stgit@buzz>
 <20190713060929.GB1038@tigerII.localdomain>
 <CALYGNiPedT3wyZ3CrvJra=382g6ETUvrhirHJMb29XkBA3uMyg@mail.gmail.com>
 <20190713131947.GA4464@tigerII.localdomain>
 <CALYGNiPp8546yGcC-TYSVq5X9tnPmrQsDecZxZ2smex9zKB5wg@mail.gmail.com>
 <20190715023338.GB3653@jagdpanzerIV>
 <d3958637-a03d-f899-63ef-8d0d50e78a1e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3958637-a03d-f899-63ef-8d0d50e78a1e@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/15/19 10:38), Konstantin Khlebnikov wrote:
> > > Indeed, panic is especially handled and looks fine.
> > > 
> > > Sanity check in my patch could be relaxed:
> > > 
> > >         if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
> > >                 return;
> > 
> > How critical kmsg_dump() is? We deadlock only if NMI->kmsg_dump()
> > happens on the CPU which already holds the logbuf_lock; in any
> > other case logbuf_lock is owned by another CPU which is expected
> > to unlock it eventually. So it doesn't look like disabling all
> > NMI->kmsg_dump() is the only way to fix it.
> > 
> > When we lock logbuf_lock we increment per-CPU printk_context
> > (PRINTK_SAFE_CONTEXT_MASK bits); when we unlock logbuf_lock
> > we decrement printk_context. Thus we always can tell if the
> > logbuf_lock was locked on the very same CPU - this_cpu printk_context
> > has PRINTK_SAFE_CONTEXT_MASK bits sets - and we are about to deadlock
> > in a nested context (NMI), or the lock was locked on another CPU and
> > it's "safe" to spin on logbuf_lock and wait for logbuf_lock to become
> > available.
> 
> I see no users who dumps dmesg from NMI context except panic.
> This shouldn't happen. But might happen is something goes very wrong.

I see. OK, if NMI->kmsg_dump() never happens (except for panic) then
we are fine, I guess.

	-ss
