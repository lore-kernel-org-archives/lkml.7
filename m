Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2AFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFFF206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="E7cMYjZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfGYKkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:40:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37846 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGYKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:40:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so49816552eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BGhGjGkqx26zhb3e825tZSpGwxL7pQ8J7DYvtVZD7+w=;
        b=E7cMYjZWN/V237c49DX1e1nzbZ7WGWjx92/9T6eNC4xybWF7WXMj1evR+ivXq2tL5H
         0GnbONt83ID2YRsieGlvSKvIwMafD8wcKllyceOWXSyZfZMsjWSHV0JwGuNtpztUs7gC
         pmPNu/IPzicrKQCUrkqzGtJ680YYHVdqn72Eg7r06RZBjhnD0wC2ybAVPhK51GHG0c4s
         wvXJJqFora1gEsEsE/Gtl8hZ5hqS3LpkC1zGJyROYf5G/sqX50dXyFJx5BhKGbMWrXyJ
         G/kUfYSlq4+ZV8aVOWAQ+C8/wgz2aKF48MqSKKZQkIgGf9bSwRm8lbYz9CAmW8budzjS
         AiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGhGjGkqx26zhb3e825tZSpGwxL7pQ8J7DYvtVZD7+w=;
        b=TnYN3BNMBgnq7kNgxAbTb4K54WDixWIDa1dtOKa5xoePg8LLVapv1S/S3JargfkOKY
         ZHdqbKtMIKcM/nXpRfg8NltW23XRATdpUb/GwQzRa0AXB1HRHYMIRg+hlJqNKFT0nFz3
         GEtIFWpsGJnnpr2xYlWjtNg7UajHLEznX1AeKFYFwrEt+acYT8uZqctCYwh4XAVKDdKT
         M2tc+keqtFGX+gs7d0hAK0c1TfqnzLvFnzi3G71CWuc10F3SRTdgwi0ZKTo8sCIVw9vY
         YRTO9Lv+vcMBkt4tZ47JD+swTGeVk2kMyEjgu6JicRt8E9m4Kac4yIrtmK4pjiOZQR0Q
         R63Q==
X-Gm-Message-State: APjAAAXOgW5Qc5VbKLxlHjs0rjnrsWY/tg074chl69q9cQtyEwyagu8B
        Zcr5+MPnBOrGW1MBGkCg+pA=
X-Google-Smtp-Source: APXvYqw4Sp6ilvWuGKGb93Lr59/Kmsrs47To0tqqsyM7rAJctQX7l45HNGwVqryINSNosedhbzjq3g==
X-Received: by 2002:a17:906:68d0:: with SMTP id y16mr67503047ejr.161.1564051207887;
        Thu, 25 Jul 2019 03:40:07 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id p43sm13593173edc.3.2019.07.25.03.40.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:40:07 -0700 (PDT)
Date:   Thu, 25 Jul 2019 12:40:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725104006.7myahvjtnbcgu3in@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725103543.GF4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:35:44PM +0200, Oleg Nesterov wrote:
> On 07/24, Christian Brauner wrote:
> >
> > If CLONE_WAIT_PID is set the newly created process will not be
> > considered by process wait requests that wait generically on children
> > such as:
> 
> I have to admit this feature looks a bit exotic to me...

It might look like it from the kernels perspective but from the feedback
on this when presenting on this userspace has real usecases for this.

> 
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -1019,6 +1019,9 @@ eligible_child(struct wait_opts *wo, bool ptrace, struct task_struct *p)
> >  	if (!eligible_pid(wo, p))
> >  		return 0;
> >
> > +	if ((p->flags & PF_WAIT_PID) && (wo->wo_type != PIDTYPE_PID))
> > +		return 0;
> 
> Even if ptrace == T ?
> 
> This doesn't look right. Say, strace should work even if its tracee (or
> one of the tracees) has PF_WAIT_PID.

As in
	if (!ptrace && (p->flags & PF_WAIT_PID) && (wo->wo_type != PIDTYPE_PID))
		return 0;

Sure, we can allow that.

Christian
