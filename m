Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E042C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CE720873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uIXjn9Ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfJDQhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:37:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35111 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJDQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:37:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so1969230pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0r+kspBGzbwJkofAXeQf0YDo6d6pCh/LPA05isPo7WU=;
        b=uIXjn9Ir1OYKzJYjCzrOVOb8dIi2FsiUWqNhm4g+dp/YQvmkp+PrZR8CFq7q3Wyu/V
         kMGEsLoqbf71gPWG+oWxtCozyVJN4sJota9i3g9dA7f5ySdYXqDsnttiAVa83+Y1Y2Px
         soNPvfO4bb2CLCSvI3iM+/Z0ZeLMBNZzOu5c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0r+kspBGzbwJkofAXeQf0YDo6d6pCh/LPA05isPo7WU=;
        b=XAVPyBouSc/GozOEsERII19HwmGuUcC2n1/QrY2+6ena759uxs6N69ixCV64YNTRiF
         kXOUeuQB5SmHIiznAEVxGZNB6EZACGHtFfO13bfT3DD9CakoVRdV+Shsc/k1D01PJ9xd
         3TgYL1pbwhyqxO9v0KIqO9NoWMj6hQpy2mj7iephtI/wMQI6lxrYwaXt6AdotGQP6BKl
         BXoDjcp1vL+1s//xR5deoRu6RF/GLRgQ0UicotGbVWg1OHEq2xEuesZRo5CytoHLTsjv
         aMrX0NUkwk872NDafB3wcuNUv9K0NKqO7p3DiCcn1Zj9g3ZfqOTJ7meUD42CZRCOE5Pg
         yy4A==
X-Gm-Message-State: APjAAAU6N6Wx2Jhk4LrVYANcHREetBBKeX1RD+F2RUnkMKWtBKwidvFc
        tz6NL6j9DsYHPaPetpn5gBoaDQ==
X-Google-Smtp-Source: APXvYqzoIYcxcnOAbtt+ZaZsgwY212u0mOxjh1mQapxZ7B4qp2hF8VvvsbvLx+NkKjoBOkq/nzNAiw==
X-Received: by 2002:a62:7684:: with SMTP id r126mr17569821pfc.26.1570207054408;
        Fri, 04 Oct 2019 09:37:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e14sm6907332pjt.8.2019.10.04.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:37:33 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:37:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        peterz@infradead.org, paulmck@kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove GP_REPLAY state from rcu_sync
Message-ID: <20191004163732.GA253167@google.com>
References: <20191004145741.118292-1-joel@joelfernandes.org>
 <20191004154102.GA20945@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004154102.GA20945@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Fri, Oct 04, 2019 at 05:41:03PM +0200, Oleg Nesterov wrote:
> On 10/04, Joel Fernandes (Google) wrote:
> >
> > But this is not always true if you consider the following events:
> 
> I'm afraid I missed your point, but...
> 
> > ---------------------->
> > GP num         111111     22222222222222222222222222222222233333333
> > GP state  i    e     p    x                 r              rx     i
> > CPU0 :         rse	  rsx
> > CPU1 :                         rse     rsx
> > CPU2 :                                         rse     rsx
> >
> > Here, we had 3 grace periods that elapsed, 1 for the rcu_sync_enter(),
> > and 2 for the rcu_sync_exit(s).
> 
> But this is fine?
> 
> We only need to ensure that we have a full GP pass between the "last"
> rcu_sync_exit() and GP_XXX -> GP_IDLE transition.
> 
> > However, we had 3 rcu_sync_exit()s, not 2. In other words, the
> > rcu_sync_exit() got batched.
> >
> > So my point here is, rcu_sync_exit() does not really always cause a new
> > GP to happen
> 
> See above, it should not.

Ok, I understand now. The point is to wait for a full GP, not necessarily
start a new one on each exit.

> > Then what is the point of the GP_REPLAY state at all if it does not
> > always wait for a new GP?
> 
> Again, I don't understand... GP_REPLAY ensures that we will have a full GP
> before rcu_sync_func() sets GP_IDLE, note that it does another "recursive"
> call_rcu() if it sees GP_REPLAY.

Ok, got it.

> > Taking a step back, why did we intend to have
> > to wait for a new GP if another rcu_sync_exit() comes while one is still
> > in progress?
> 
> To ensure that if another CPU sees rcu_sync_is_idle() (GP_IDLE) after you
> do rcu_sync_exit(), then it must also see all memory changes you did before
> rcu_sync_exit().

Would this not be better implemented using memory barriers, than starting new
grace periods just for memory ordering? A memory barrier is lighter than
having to go through a grace period. So something like: if the state is
already GP_EXIT, then rcu_sync_exit() issues a memory barrier instead of
replaying. But if state is GP_PASSED, then wait for a grace period. Or, do
you see a situation where this will not work?

thanks,

 - Joel

