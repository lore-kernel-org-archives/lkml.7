Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AEAC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A782171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY5wHoCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfDSBvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 21:51:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44177 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfDSBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 21:51:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id g12so1944253pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XvS3qKIr/Ejv+SveqCQaasuPf5uqSaB2yx4GMq+Ea/k=;
        b=aY5wHoCXOrFEwMN8m5tYFFoADR3kabD68UXcjEbWXc0draBZofWXaa5nH9x+P09G09
         ktJ7cWXcbpjTqg0BE0ni9e4jzDf3N0xZUOJE/iNzn3voDBhElVaOIFOczWa5Qx3Tw1Ak
         7COcScue2G87O62m93A96OjeEI0ItiB17HYC4Hi9mS4ukf6FtbkChOr5ONBTrRtc8Cao
         upe02pFPJI9FtQ8DoRbu/RDz6CGks+cFR6zDhmX2U/+E7XFvwU587K/y2atbBrtfH83q
         k5fSCcJa+nr518I4bryoLH3uw13vo5TDc5xLMgCmVQkMD8dJpwMiqK0ugv6pdgkie5Jt
         2kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XvS3qKIr/Ejv+SveqCQaasuPf5uqSaB2yx4GMq+Ea/k=;
        b=A3RCkA0cTuNT+UZgBbmzun1MbcSX3Cr82pFl1Liv/fqm01zSkHCk+I6ur/gAuOkIEl
         BjEaje8p5JfjBW3QBSFwIFcZr1MNWpXW0D/d0i+1E5+hgE0az+1mAM8OOABNUJt7fdJy
         YWscS4OTIYeQlm6HONGapQ5DoRYDYrKClrGST9+yYpUiTVinogKuQg5HKdZCyGIMmFB2
         VSfvU8lW1w5kfAfRqddgmQEczgtQ1aRSS567ClfGh4Bxk8BywCnNx/kUHOYnCKVrGJ8u
         58eEXp8PS9VBJFxXCtk7EDgSDXK1M/jmVnb8N8TYWTBeYbLmqHs0qzfu67RN18Y+BlzG
         Moog==
X-Gm-Message-State: APjAAAWXYjDL0OWhmOmbdY9rutFCkE27c6px+/eG7v6DJeL7YP9kBttB
        fMJpQl81ycRfa6io+IyaY94=
X-Google-Smtp-Source: APXvYqzVrFGT8/GqxXxXY7Cbx2ElMfFbQWidnmVNrfwF35nBvzarLpgV4QlTLCzNwHyy7J4e/9sYbg==
X-Received: by 2002:a17:902:5ac4:: with SMTP id g4mr918619plm.261.1555638676725;
        Thu, 18 Apr 2019 18:51:16 -0700 (PDT)
Received: from localhost ([175.223.3.190])
        by smtp.gmail.com with ESMTPSA id c3sm5065669pfg.88.2019.04.18.18.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 18:51:15 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:51:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] vsprintf: Prevent silent crashes and
 consolidate error handling
Message-ID: <20190419015112.GA18748@jagdpanzerIV>
References: <20190417115350.20479-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417115350.20479-1-pmladek@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/17/19 13:53), Petr Mladek wrote:
> Crash in vsprintf() might be silent when it happens under logbuf_lock
> in vprintk_emit(). This patch set prevents most of the crashes by probing
> the address. The check is done only by %s and some %p* specifiers that need
> to dereference the address.
>
> Only the first byte of the address is checked to keep it simple. It should
> be enough to catch most problems.
>
> The check is explicitly done in each function that does the dereference.
> It helps to avoid the questionable strchr() of affected specifiers. This
> change motivated me to do some preparation patches that consolidated
> the error handling and cleaned the code a bit.

The patch set looks OK to me.

I got confused by 'pC?' error string, but once you start looking
at it as a regex (? - zero or one occurrences) things look OK.
Regex in dmesg/serial output might be something very new to people,
stack traces, after all, is a rather common error reporting mechanism.
So the previous "WARN_ON() + exact unrecognized fmt[N] char" was not
totally awful or wrong (well, it was, before we introduced printk_safe()),
but I don't have strong objections against that new regex thing.

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
