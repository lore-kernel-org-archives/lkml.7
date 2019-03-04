Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F7F20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH5fxNyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfCDDWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:22:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32952 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDDWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:22:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so1943571pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 19:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y1ZIi9rrDGPbCYde9xLaihwbQH505bEpaDEbN3g5hO4=;
        b=UH5fxNyGZKtvzc4qZ10cxKutGgqKkHqjudLEoVeECMG4SB6ETb0WNbN3Trn6Y0oZLm
         8ChdU0rZEhkdlBTGYTjN4/4Ldtivz2t9F6pPkNCZdWM3rT6lH5zU3kogXFwJOscjTJ1A
         jo7HdNTZbvGCgucfjLblETwMZk+1874xh7xLj9puWeHPaEaefQnwODuzU2FnWedidm6y
         Assrfk5vw8ujL1kQlOIIH5GI2ZuP9Ra4lDeMUs7tp5S1tqLwi2Dt4IDpkOhGapwOryiq
         k4h4BobQt8Ckp8IzwcffcAstyBFtol4YQyl3mTqQhzHWt6jtN+RYjN73ZepGAPd+7c0t
         uT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y1ZIi9rrDGPbCYde9xLaihwbQH505bEpaDEbN3g5hO4=;
        b=ApAU2jikzxOLoT0Do0klOdDu66cKW/ARoTA4Ly8YQDXGs7DKqEzNm683Ahb09W+JDJ
         qYPLI9x4iH7UzbaH7Om9Mu7dMOX/PUesi0fl5rimLGePquCdD+SrQUzmFR/WtIiyYWrF
         xfvFgrbezDYBL0W7URx6en7ElHMghESvWrxoOLMlhaQiz8uaJod6bUYrLk72lMs5RKMK
         HmokFjjFn5NDxhOO1GvTqhsTMXSUINrHVRBEFtYthq/cP4cQjNES8Ulu/BilEHxN71Iy
         7t1AlVuuKtsntgf5VHvNefxOU1Aw1yHefBqwN3Hb0V8fOgK6tmEEM0PUuaE8vE88LQdz
         azxg==
X-Gm-Message-State: AHQUAuacnzTXPj0aBCPvcJ4ZED/FSAM6YAkDBvegzSk+Ui/HCV8WiE6s
        kYWGuCCc0SbEFwqcniAzCWw=
X-Google-Smtp-Source: AHgI3IYto6J4yJ+cm3Mzv/S/N6CwpQtuDmiD2QD/JpslbvXnNDO1559AhlJdCiD8MUUDQYbb/ySK5g==
X-Received: by 2002:a62:1bd4:: with SMTP id b203mr17700600pfb.144.1551669727602;
        Sun, 03 Mar 2019 19:22:07 -0800 (PST)
Received: from localhost ([175.223.38.45])
        by smtp.gmail.com with ESMTPSA id e9sm9747098pfh.42.2019.03.03.19.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 19:22:06 -0800 (PST)
Date:   Mon, 4 Mar 2019 12:22:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190304032202.GD23578@jagdpanzerIV>
References: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/23/19 13:42), Tetsuo Handa wrote:
[..]
> This patch tries to address "don't lockup the system" with minimal risk of
> failing to "print out printk() messages", by allowing printk() callers to
> tell printk() "store $body_text_lines lines into logbuf but start actual
> printing after $trailer_text_line line is stored into logbuf". This patch
> is different from existing printk_deferred(), for printk_deferred() is
> intended for scheduler/timekeeping use only. Moreover, what this patch
> wants to do is "do not try to print out printk() messages as soon as
> possible", for accumulated stalling period cannot be decreased if
> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
> prints out the messages. The point of this patch is to defer the stalling
> duration to after leaving the critical section.

We can export printk deferred, I guess; but I'm not sure if it's going
to be easy to switch OOM to printk_deferred - there are lots of direct
printk callers: warn-s, dump_stacks, etc; it might even be simpler to
start re-directing OOM printouts to printk_safe buffer.

This is a bit of a strange issue, to be honest. If OOM prints too
many messages then we might want to do some work on the OOM side.

But, to begin with, can you give an example of such a lockup? Just
to understand how big/real the problem is.

What is that "OOM critical section" which printk can stall?

[..]
> The possibility of failing to store all printk() messages to logbuf might
> be increased by using "async" printk(). But since we have a lot of RAM
> nowadays, allocating large logbuf enough to hold the entire SysRq-t output
> using log_buf_len= kernel command line parameter won't be difficult.

Note, logbuf size is limited - 2G. Might be not as large as people
would want it to be.

	-ss
