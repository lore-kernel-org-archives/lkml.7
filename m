Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD43208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjr0Rgf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfDZPpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:45:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35907 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfDZPpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:45:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so1824282pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y6dN2nyKTNZ92X6vA0i9r07wHLAmBCY1ZOtUGSFVeSg=;
        b=Sjr0Rgf5DNAfIUqPx1dHdAMoJ8CrsRxNAYJ5NKF5A58HycBnTiABNxhTgaagM7Z3EL
         oemmepr7c0fWZEP+Nz5KFzpn1f+zDJagPEANrXpOgdyGlgNgAPVDl1ezF/S34rEJ5sKf
         h8WhJmaI8MXy9jhBlo50QKbDGzF7miYTUpv5HzxrwdlMxTwNMVKVFr9nFf2aYSDpCplV
         uxFOP0X3jJkbISd3Xs03JQDMldxRGFRVaMI1VxPIbAd0Hox7lHUkSSEVP/Sax3IuNNjN
         BBD8T3pKlB4ibVSM9ZdKn1zwn5GzrZdh3bgo9NrtRPZwg0Uds+14td2+Y8cynDGb67+H
         Dm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y6dN2nyKTNZ92X6vA0i9r07wHLAmBCY1ZOtUGSFVeSg=;
        b=gZqmoHpIfHnl8BlhIyE/IG3FFvF6AsIbTWXuYGo3ujpZuFAp2vFokt/y4ZB9DwSEJq
         T34wSGprZF9yXfrX7uK66fNfTnkKTAg32IJ5V3pGbVccR/QX4Ofsl1dKOQYwaSdDNlu0
         hwneJ0DLcFAdIb4UWKafWK8t/7y4zvRkLtOqqyNlCsx3cwD+5rLMoWdJCz2Yb071L81E
         G4fGAGKhQNV2DZND2i+Bo626jeddyxm9TnWCWdJrth0p33fsOdfRelfmSVRLIvbMQhzX
         UJIaMlQeTXwYwlFYcv0SEq3jm7XJXKttZ9QayN1L6ueUjwwpDBbOc7sZG+c9OriYyiQ6
         YrXQ==
X-Gm-Message-State: APjAAAVt+MLVcF7fR4yrDoE/VlKdqZPt72QfaJOt9GtPnsoNW+XgHWNk
        ZtbeZVQraGZfzfMekatMtEc=
X-Google-Smtp-Source: APXvYqxWJbiMhpZaA+EobG2kkxfSErQ2slWUtwFPgwXQho44dlqQ7L5MaU+qZnbhDZ50ORu3hRKbSw==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr21871263pgp.351.1556293501727;
        Fri, 26 Apr 2019 08:45:01 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id u5sm37035463pfm.121.2019.04.26.08.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 08:45:00 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 27 Apr 2019 01:43:02 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190426164302.GA26127@tigerII.localdomain>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
 <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
 <20190426135316.GA505@tigerII.localdomain>
 <20190426141426.h7hpvhr3rqp7umbk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426141426.h7hpvhr3rqp7umbk@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/26/19 16:14), Petr Mladek wrote:
>
> Then I wonder why, for example, native_stop_other_cpus() waits
> 10ms at maximum after sending the NMIs. What is the state
> of the CPUs that miss this deadline?

Well, I saw a case when CPU was forcibly powered off (embedded),
for instance.

> > - But, more importantly, if that CPUB is in atomic context, then panic
> >   CPUA will spin, waiting for that CPUB to handoff printing, before
> >   panic CPU will even try to stop all CPUs.
> > 
> > 	pr_emerg("Kernel panic - not syncing: %s\n", buf)
> > 
> >   is the point of 'synchronization' - panic CPU will wait for
> >   current console owner.
> 
> "Synchronization point" is too strong formulation.

But it is sort of synchronized. That's why console_owner patch
set solved the panic-printk deadlock which Google folks reported
a while ago.

> The console waiter logic is effective but it does not always
> work. The current console owner must be calling the console
> drivers.
>
> >   Hmm, we might have a bit of a problem here, maybe.
>
> Hmm, the printk() might wait forever when NMI stopped
> the current console owner in the console driver code
> or with the logbuf_lock taken.

I guess this is why we re-init logbuf lock from panic,
however, we don't do anything with the console_owner.

> The console waiter logic might get solved by clearing
> the console_owner in console_flush_on_panic(). It can't
> be much worse, we already ignore console_lock() there, ...

Right.

[..]
> Anyway, do we really need to have length discussion about
> whether the locks are needed? They will not break anything.

I'm not objecting v5 nor your request to add that locking there.
I'm talking about different things.

	-ss
