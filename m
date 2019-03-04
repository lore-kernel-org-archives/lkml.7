Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F80C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E7220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvMdE1i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfCDOiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:38:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43793 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:38:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so3153165pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzVh25RSsBoxQy7899IHe8WyNuhrp7x+m1RgmKBw3Ns=;
        b=bvMdE1i5ITLz9rMTHnX0bWLCAt+q+NCa7E6f2rT8NfyJHYpV3krdM104+t6S9rMJsx
         DQ3qdTAB0S6PoK0KX1KwGZ2esUAL2UewsLxvqFNXr6XDalYhCFAFjYORqDcfBvDK8wll
         nQ2kIxAvAuDg89FCLHt3AHMGYqg8FcEX6ihkfUciTLE//sThlOX15YRhK80yIsAlD6bP
         SJWTyT+LrWd61knV6JA+oNd/VcseqJEQi8XAichLmzeXrfyOfHq1iI1TLFSEDShWcrKZ
         /uFzUZ4q9nA2xUfCVeDTCxDOOk2gJlqFcXGTiSxnnHgZftaPKbnv/BuffZbwH/+spVy2
         HFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzVh25RSsBoxQy7899IHe8WyNuhrp7x+m1RgmKBw3Ns=;
        b=nbnhVwlJPNAQ8besu+R1bgLxsBzD2crjKdh7N1hCzXF9J69O4X0BrVphpm61akx7WK
         y5XVI4m9EaqEiBk+cE2qkRaZP2QPpMFruW4s/DCe7dxAQU0M56kHyELmI+g1V8Gj4D9s
         x6pcKpe0SIs6h25LOJ8rYSN6c7jQXIhNO0X3mJybkdmQJipYouiddeP1ucBjrMUNYvlk
         liP9eGb/Fm1lrGOLnDEaVi30QnwvFZtjv9i44ck+QcO8VEglGeozCGxmVQKQ7Bhwz+FT
         SucmS87nYiIV6ZdhlH7qQe0bAB/beq3yDJaycWSVL1BG9DIS242sIwAybIh5EDXawZ87
         GXVQ==
X-Gm-Message-State: APjAAAX6Zb60gJu6ezedYM5Imo4wittjvj+2Td6ihEnj0AITvA4dQ+po
        hafsS3HmHtemrUGUTz31Utc=
X-Google-Smtp-Source: APXvYqwliW1uJld9Kiz6G0vt6Ny4O3QIDaLd04QUuv4Tu1Eo+IldlnteKPEuRfdiD2kl3kdiG78UHg==
X-Received: by 2002:a63:20a:: with SMTP id 10mr18717207pgc.346.1551710282080;
        Mon, 04 Mar 2019 06:38:02 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id h65sm8960752pgc.93.2019.03.04.06.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 06:38:01 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 4 Mar 2019 23:37:58 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190304143758.GA9036@tigerII.localdomain>
References: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190304032202.GD23578@jagdpanzerIV>
 <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/04/19 15:23), Petr Mladek wrote:
> > I confirmed that printk_deferred() is not suitable for this purpose, for
> > it suddenly stalls for seconds at random locations flushing pending output
> > accumulated by printk_deferred(). Stalling inside critical section (e.g.
> > RCU read lock held) is what I don't like.
> 
> I still do not see why your async printk should be significantly
> better than printk_deferred(). There is still a random victim
> that would be responsible to flush the messages.
> 
> It might increase the chance that it will get printed from
> normal context. But it also adds the risk that consoles
> will not get handled at all.
> 
> BTW: The comment above printk_deferred() is there for a reason.
>      It is a hack that should not be used widely.
> 
>      If you convert half printk() calls into a deferred/async
>      module, you will just get into another problems. For example,
>      not seeing the messages at all, more lost messages, random
>      victims would spend even more time with flushing to the console.

The thing with printk_deferred/printk_safe is that it always involves
IRQ->console_unlock()->loop. This thing is not welcome, we need some
other task to hand off printing to badly or we simply hard lockup the
system. I'd say that this probably should be the main reason those
those symbols are not exported.

> For example, I would stop printing allocation failures until
> the currently running OOM killer succeeds in freeing some memory.
> It might print a message about that all further allocation
> failures will not get reported and then another message
> about the success...

I'm all for it.

	-ss
