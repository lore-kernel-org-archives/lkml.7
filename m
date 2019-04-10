Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D26C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUDjrTcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfDJIQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:16:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34699 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbfDJIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:16:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so1010249pfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Aa5aLM1S3NN8i7NLvb9S+SdITo6ZrVhIye2LZ4MXdeM=;
        b=kUDjrTcIuFiVpFzVASgPp/59EHGuhoSI3EVhWtXQ9c3atQHaBvGNxJEtFFMZjH6HXx
         JtlrL+W18WW6aPF3OhEtOs67JINoCd52Xy9MiSPxHvANvSdjQXGniPax8ipJxlR8Uq+p
         4C0aeP8FAlwABrfx1V7M5wk0nGM4u1brs0BuToiRZab0zm49ojhY0dSsgyzeDs9y8cg5
         pYH8latK/VPYQLMRrEJ/Gwy0hEcCxF0PQbA1QOm3WbqQPU7D6HojLvGYYpqUUrhFib3w
         Yc1uRhBp30uTfGz7dnhvoP4z9noexFxOySK4EjwxUq+6iaexPx0cWkqyScSIx5ApiBoN
         ms2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Aa5aLM1S3NN8i7NLvb9S+SdITo6ZrVhIye2LZ4MXdeM=;
        b=IIY67ZMT3EIMDXzOMSpzDlSSkq3oAcvjnxcbtER6VPahTUeYUaR39J6r+Vihq7J6MB
         yJIGoYSpu3G0XvQ4l1ScyUnNuXFMNRNcC3G336DHNidJK0XfLc1MuaG9LVX2pZWVUQFh
         kshVm/COz9DAyk9mjSz88zH4ZtY86PzcfGXepfbbCXTrKl7JSMfHvzkZsuclV8jJhOE5
         VCk5n9u2skzqYkSR6JY98HHrSaSSsJMg5I3+aX29K69jbWG/e/yJyKsEO97sBtDwyJoT
         UHt1q0I1L6S5aMwVPqdLmkOKdms5ru86lcDqIcZZiU/ke0UivWpFBKdFvvuotWOwmuXN
         Ayxg==
X-Gm-Message-State: APjAAAVzq+IYNbB7AxhgHIfr8q2mb5eis6W8DLAd/fkt1veL0uJctOtw
        UK0EZsljec2zzresWdbEC4c=
X-Google-Smtp-Source: APXvYqyLJ53VE7rjorpEfiAufpoYYXRgED/NBTRFrZV4ftZNEwd3HF89oFOqlj0fOjhxxIqbK1l9rw==
X-Received: by 2002:a65:44cd:: with SMTP id g13mr33355110pgs.258.1554884174355;
        Wed, 10 Apr 2019 01:16:14 -0700 (PDT)
Received: from localhost ([175.223.11.210])
        by smtp.gmail.com with ESMTPSA id c3sm66559464pfg.88.2019.04.10.01.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 01:16:13 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:16:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/2] panic: Enable to print out all printk msg in buffer
Message-ID: <20190410081610.GA25962@jagdpanzerIV>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <1554115684-26846-2-git-send-email-feng.tang@intel.com>
 <20190409141430.w2fulp7jnnthojrc@pathway.suse.cz>
 <20190410015926.GC26212@jagdpanzerIV>
 <20190410080224.hmyzv2mqcjyceiw3@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410080224.hmyzv2mqcjyceiw3@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/10/19 10:02), Petr Mladek wrote:
> On Wed 2019-04-10 10:59:26, Sergey Senozhatsky wrote:
> > On (04/09/19 16:14), Petr Mladek wrote:
> > > We should:
> > > 
> > >    + Flush the latest messages before we replay the log.
> > 
> > Do you mean the pending messages? When we replay the log we also should
> > print "header line" and panic-cpu backtrace. So we will print panic-cpu
> > oops twice
> 
> console_flush_on_panic() is just the last resort. I believe
> that the panic header and backtrace reach the console even
> without it in most cases. Explicit flush before reply
> would just make it consistent.

I would agree. On big systems console_sem is usually unlocked (no fbcon,
no DRI, no tty writers, etc.) On desktops, laptops, and embedded device,
however, killing the kernel with console_sem locked is not entirely
uncommon.

> The panic() message is usually the most important one for debugging.
> I feel a bit uneasy that we would delay it until full replay that
> might get killed from several reasons:
>
>    + external monitoring system would force reboot
>
>    + user might realize, e.g. after 20 minutes, that the full
>      log reply was probably not worth it.
>
> I understand that people enabling this option would most likely
> wait but still. I do not see it as a big deal to repeat
> the messages.

Well, OK, this sounds reasonable. At the same time this option
depends on panic_print, which is probably debugging option anyway
and panic_print output can get a bit large and time consuming, so
maybe external monitors are not part of the picture when panic_print
is used. But no real objections; need to make sure that no one else,
except panic, will ever use that new symbol.

	-ss
