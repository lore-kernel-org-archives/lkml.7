Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B15AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53921872
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bnc1ZJ5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfGSQ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:27:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfGSQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:27:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so32860867wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZARTyX51+oWxlzZP/xE/jjvdHua869qaEF3yPA/+4vw=;
        b=bnc1ZJ5LPNgeU2UgeT0U/1yuhAIi1ZIj1pTP9ZexxAGNDB87ehZohl8r35KrJRn3s+
         F7V8+Cx8xNaC3KTZly1d4ZKrjqTma+4FffZCyFLszHQFtab1uZKkifGZ0jDDHwHEaV4U
         i38bT/X5eAMAV5DUzlxLv5ZiHoaedib+ngiaR0H159eiQEiVtuaxKY852da8SVlGe+7B
         giG92yevoz2YqlbNGKW8hEHZoHkHJtTfu6B/q+/gtPVWpXdbkmd2+TcgeFHPxDE8RPjw
         Degrtgl0hlbpKjqDn+eT3s/l+zs7ugP2TKd3fjY6620FImYbtAPtP/hnB762d+SmHsZw
         PK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZARTyX51+oWxlzZP/xE/jjvdHua869qaEF3yPA/+4vw=;
        b=XCVFf19iMqVQLQktFPykJIRNwQZZVWaJ4Ebanu1Efx5kJgA7Fa504VKrGpTPr/xToy
         cJo0Kijgrvo4+6cFKxPoe3MthHcF08MWzpDLDbMgypv05PkNUXo2GGIXZ0ZLg7lWJk6/
         BwEQGxhBvxF4enzTbLL1dehkHyh7Q0Wciujia5pwyRTqfJHUlDc+NN3qFXXZXtaBUFnb
         9VwGnKR+ofv54j6pDjzAzdpfXR6E1/YzDxRoMxzxs4D5Y0MVuGFI0yOT9STbIkOxlwQn
         ZFdn3T4iTiuDWpvLFgkms0DvXIctxGH8JCPeKxabq5IJ8v2rOA5qB+dzdBtUPnVvAZhc
         V/mA==
X-Gm-Message-State: APjAAAWlmPJSIipMHly2hx/nConWrU3/ytU/b3+BamaFuz+67Rn3A9Lv
        MQPkMwVWOJACktWj12jSJUw=
X-Google-Smtp-Source: APXvYqzVUK8eobE607PjmG1wn4Gt9cqRQVwaJSoHwdwd3asH9W30FAwQN4oLRpLYQKdI+xFyhHlVDg==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr26469377wrq.174.1563553654426;
        Fri, 19 Jul 2019 09:27:34 -0700 (PDT)
Received: from brauner.io (p5097b50e.dip0.t-ipconnect.de. [80.151.181.14])
        by smtp.gmail.com with ESMTPSA id g19sm52076113wrb.52.2019.07.19.09.27.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 09:27:33 -0700 (PDT)
Date:   Fri, 19 Jul 2019 18:27:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190719162726.u5fi5k3tqove6hgn@brauner.io>
References: <20190717172100.261204-1-joel@joelfernandes.org>
 <20190719161404.GA24170@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190719161404.GA24170@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 06:14:05PM +0200, Oleg Nesterov wrote:
> it seems that I missed something else...
> 
> On 07/17, Joel Fernandes (Google) wrote:
> >
> > @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
> >  		ptrace_unlink(p);
> >  
> >  		/* If parent wants a zombie, don't release it now */
> > -		state = EXIT_ZOMBIE;
> > +		p->exit_state = EXIT_ZOMBIE;
> >  		if (do_notify_parent(p, p->exit_signal))
> > -			state = EXIT_DEAD;
> > -		p->exit_state = state;
> > +			p->exit_state = EXIT_DEAD;
> > +
> > +		state = p->exit_state;
> >  		write_unlock_irq(&tasklist_lock);
> 
> why do you think we also need to change wait_task_zombie() ?
> 
> pidfd_poll() only needs the exit_state != 0 check, we know that it
> is not zero at this point. Why do we need to change exit_state before
> do_notify_parent() ?

Oh, because of?:

	/*
	 * Move the task's state to DEAD/TRACE, only one thread can do this.
	 */
	state = (ptrace_reparented(p) && thread_group_leader(p)) ?
		EXIT_TRACE : EXIT_DEAD;
	if (cmpxchg(&p->exit_state, EXIT_ZOMBIE, state) != EXIT_ZOMBIE)
		return 0;

So exit_state will definitely be set in this scenario. Good point.

Christian
