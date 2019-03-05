Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C885EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BFF2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmjQBi0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfCEHwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:52:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38013 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfCEHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:52:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so5084650pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4JjP0iosaOL8sPuLZO/lObc3j8z/oaPYNv2+myVMrs=;
        b=lmjQBi0pP7dnvwvX/R2ZCVBmgZOWNxHXXquXzeafjNALyF5f45QP7UGroCL59Sg6zf
         8Oz5SrN0Mwj+KHsD2fyHxfaJMpDV2x01pz0LSYNx0nqJdzNUT83dsh7dzsjVXd2VSNBy
         nXXPBA/fZoBiwI903iwqBIeSMxVO9V0GgVOuyyOWENYYus/Hnpv2bfEzosxaFSbE6uRf
         oc0VPNZZBjYCXZU5s/mFv2/t3/hghcd0p8PaH+Hdg33ZVD9/XZND0o13nG8MEYhkRaq6
         vRQQrmyx+Qim19sRh+D3mcP5BtI0tKSwyyBUypcMeoGNmHMUABmYtFAje9rESzRVC0me
         A6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4JjP0iosaOL8sPuLZO/lObc3j8z/oaPYNv2+myVMrs=;
        b=XJEs8vR9q1eox4ntg+mbJeeRSLKtrSZli3gMtHv3MnDRCv5rpXqaWzqzF5RUz/OMii
         9OGeiF8aVRO9Q9nXYR98S5UBXbQ5cN0GqSXpHSyt6sRQ+L6Jie9OMEn6KU4M3bMbFcpF
         CxNI5lsNrcNJSVHMobIjmR1MngqYYTDDp7W1+kxaMaiDbigFLEc5gpCfIgA5TrKaVVc7
         UAwFOMHHJzuOVRTlGre11+P63XYw9syuaMLZ3D3MV0sAswAslOg1S+vLUEgO4Hgl2d6k
         B5b+27mBGMgc0qSEQ5R2QBTnBqV5/4CV/hGFZBZQvnUWXo1E+KGEYEVApFlqAucsoYZG
         U+hA==
X-Gm-Message-State: APjAAAU1MZx+YcjHiwmO/1qpogTTO0EUUSG5B4UDZA4fXPXCHtWmG36m
        /J6jr5tjXvl50f/sMv65MuA=
X-Google-Smtp-Source: APXvYqwI10/jcZ1k//PpP5HYbbHvLt+URyTRErF8meJB9m5/wcL6fyLTvQWuqa5WR9FORXXkB2pWqw==
X-Received: by 2002:aa7:8c4d:: with SMTP id e13mr575201pfd.53.1551772329625;
        Mon, 04 Mar 2019 23:52:09 -0800 (PST)
Received: from localhost ([110.70.27.66])
        by smtp.gmail.com with ESMTPSA id 23sm15726633pft.187.2019.03.04.23.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 23:52:08 -0800 (PST)
Date:   Tue, 5 Mar 2019 16:52:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190305075205.GC24774@jagdpanzerIV>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903050123.x251N312025685@www262.sakura.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/05/19 10:23), Tetsuo Handa wrote:
> > > > [..]
> > > >> This patch tries to address "don't lockup the system" with minimal risk of
> > > >> failing to "print out printk() messages", by allowing printk() callers to
> > > >> tell printk() "store $body_text_lines lines into logbuf but start actual
> > > >> printing after $trailer_text_line line is stored into logbuf". This patch
> > > >> is different from existing printk_deferred(), for printk_deferred() is
> > > >> intended for scheduler/timekeeping use only. Moreover, what this patch
> > > >> wants to do is "do not try to print out printk() messages as soon as
> > > >> possible", for accumulated stalling period cannot be decreased if
> > > >> printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
> > > >> prints out the messages. The point of this patch is to defer the stalling
> > > >> duration to after leaving the critical section.
> > > > 
> > > > We can export printk deferred, I guess; but I'm not sure if it's going
> > > > to be easy to switch OOM to printk_deferred - there are lots of direct
> > > > printk callers: warn-s, dump_stacks, etc; it might even be simpler to
> > > > start re-directing OOM printouts to printk_safe buffer.
> > 
> > Exactly. OOM calls many functions that are called also in other situations.
> > The async messages are not pushed to the console unless someone calls
> > a non-async printk.
> > 
> > How do you want to guarantee that the non-async printk will get called
> > in all situations? The async printk() API is too error-prone.
> 
> I'm suggesting to use a non-async printk() for $trailer_text_line line. I think
> that changing all printk() called from out_of_memory() to async is doable, if
> the caller of out_of_memory() wakes up a dedicated kthread described below.

I'm not objecting Petr's opinion on this.

But, personally, I think that this idea of "put this into logbuf,
but don't poke serial consoles now" is not bad. Sort of a buffering,
but not precisely buffering, because we keep messages in the logbuf,
so any other CPU can flush pending messages for us, and we don't mix
up messages' order and don't lose messages (unless we can't flush
logbuf).

This buffering is better than printk_safe(); first, because printk_safe()
buffers are much smaller in size, second, printk_safe() results in
out-of-order messages and timestamps (some people hate this) and, third,
printk_safe() eventually attempts to console_unlock() from IRQ.

And it's better than printk_deferred(), because printk_deferred() does
console_unlock() from IRQ.

But, at the same time, it's yet another buffering. I understand Petr's
concerns. And, in this particular case, this buffering might look like
we are fixing the problem on the wrong side (printk). Who knows, we
may find some use cases for this buffered printk, unrelated to OOM.
Just my 5 cents.

	-ss
