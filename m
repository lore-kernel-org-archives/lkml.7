Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B4C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DA221872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Q1+09v/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfGQUvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:51:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38737 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQUvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:51:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so2900003pgu.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UB70Pl95De4aMH6sG+K8b1SReAqlkJ/qWgP62skcQHI=;
        b=Q1+09v/yS4NfrSGnTgctWJ0ZUVgRNQ5Z9clmyc+Rk+ebBgnUmdgZZ2lalrCP9vRmzH
         /kH4I68xlHSDV88sddXw2FWcqVA0g3xmsu2dQa2wkkcTRZ+03LoDKYs0yJp6SiXO0O5Q
         97qXqKX3WT1CtoDHXLKw4vgXtF6Ih4dFymLow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UB70Pl95De4aMH6sG+K8b1SReAqlkJ/qWgP62skcQHI=;
        b=RueyAf3+BqYanfTbhnC4Ife8SpKlAHua4/gDmnzb5qFLmjSlN0ae4GE6ylC+6k9w1n
         nGAnK7BKHFW9kSmEJ9PpnrfgyLcXaOU/UsDspkEX0+JNkDWKQLuqLgE8Vv2bxiexq9c7
         O80gX6jdaqiK5Bw4oq8zky8UFgpyQJONZpyxNSpbmfuGf2ltT+rbv8VuoZ7EXI9KHxc4
         brwtKMaoe09vgOOmAxp/dw8NHolQO7QtOlxuTeI+2fTxWfivoBwBkrj/DrQRa7XgpqQX
         tP7mfL+jMHFSfmweoyCYbQ6R8sGEsjG++jbMgnTL6/BJfgtD4bJ3zb1X4pUl38ATOUDI
         I4ag==
X-Gm-Message-State: APjAAAXoXkHjVMui20mQTorfwydXZ6xhTM2/djfVdEiPnq1V8nIo/a1t
        f/umk0uLogBIp196k4v31+A=
X-Google-Smtp-Source: APXvYqz2kpTKv/0QsbE7id+tmI6KgwqPCvcZTnQ71RqEtLbk90PD+NT0T0wZ66E5wuuZ1NdkwD4sGg==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr44853908pjj.13.1563396675308;
        Wed, 17 Jul 2019 13:51:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y22sm30467711pfo.39.2019.07.17.13.51.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 13:51:14 -0700 (PDT)
Date:   Wed, 17 Jul 2019 16:51:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        jannh@google.com
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190717205112.GC72146@google.com>
References: <20190717172100.261204-1-joel@joelfernandes.org>
 <20190717175556.axe2pne7lcrkmtzr@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717175556.axe2pne7lcrkmtzr@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 07:55:57PM +0200, Christian Brauner wrote:
> On Wed, Jul 17, 2019 at 01:21:00PM -0400, Joel Fernandes wrote:
> > From: Suren Baghdasaryan <surenb@google.com>
> > 
> > There is a race between reading task->exit_state in pidfd_poll and writing
> > it after do_notify_parent calls do_notify_pidfd. Expected sequence of
> > events is:
> > 
> > CPU 0                            CPU 1
> > ------------------------------------------------
> > exit_notify
> >   do_notify_parent
> >     do_notify_pidfd
> >   tsk->exit_state = EXIT_DEAD
> >                                   pidfd_poll
> >                                      if (tsk->exit_state)
> > 
> > However nothing prevents the following sequence:
> > 
> > CPU 0                            CPU 1
> > ------------------------------------------------
> > exit_notify
> >   do_notify_parent
> >     do_notify_pidfd
> >                                    pidfd_poll
> >                                       if (tsk->exit_state)
> >   tsk->exit_state = EXIT_DEAD
> > 
> > This causes a polling task to wait forever, since poll blocks because
> > exit_state is 0 and the waiting task is not notified again. A stress
> > test continuously doing pidfd poll and process exits uncovered this bug,
> > and the below patch fixes it.
> > 
> > To fix this, we set tsk->exit_state before calling do_notify_pidfd.
> > 
> > Cc: kernel-team@android.com
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> That means in such a situation other users will see EXIT_ZOMBIE where
> they didn't see that before until after the parent failed to get
> notified.
> 
> That's a rather subtle internal change. I was worried about
> __ptrace_detach() since it explicitly checks for EXIT_ZOMBIE but it
> seems to me that this is fine since we hold write_lock_irq(&tasklist_lock);
> at the point when we do set p->exit_signal.

Right.

> Acked-by: Christian Brauner <christian@brauner.io>

Thanks.

> Once Oleg confirms that I'm right not to worty I'll pick this up.

Ok.

