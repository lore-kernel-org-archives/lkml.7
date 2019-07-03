Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AF5C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860B72189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcbpZBvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfGCJNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:13:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44910 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGCJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:13:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so927501pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qoaq7jYEK9Y8KU+pev6G7OqMMzQ0hfC8Vclv9dGTDQ8=;
        b=BcbpZBvdQV9VM97tdih7Nj70BFB4ybXqpDQOTw8WW74AR8dY9v86m17IoGXnZQ+Zsh
         8Avb61Z0egDKTnBfA4vAtGFEPhpmNzNUOSC85xArM8GrFqN6RwABSbjF4qPBXb0/OCRn
         BgXqNO57YJzN4JwqTuC8bTMNH2H3hboyI5G/ZvDVFXHrpjxz9I4cWNEeEFmJQ+QIB4JE
         yVsUi0wKFBNwl95/8E4NNbq/MRJIQj2DdsD5pk1rGo33lS228FkHSdvEPHkSZ9OhgIXi
         K0oVwRjiDu4l/QrdJl107y5ZeLy9QZRFezCA6l/rgCzR15LaW9VfmHYtalKx4yi4o5wl
         OYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qoaq7jYEK9Y8KU+pev6G7OqMMzQ0hfC8Vclv9dGTDQ8=;
        b=pwV+b1rNL71GksrawdgzNok6MCHa5d94sp8FIuPhojD0cqXL08NOHgQ8t8GlPBrSmG
         rc3DMMC0i2TEubKGYrZMlkUIawMMngYJMxA7DvbdOclMsX+qAZ06wM5+MrrVmqE35QtA
         2h6l+14qjxJW9RaT87k0+UIUpV0o+I3u02ksd4PLcZtcdCJpy+fS9CqRBzw9A9ZRsMQt
         zS10KTWF9RfdHBksH5/0qwar991EPK0fG0qyuh6TcpmjEPdU6LbcfZJc4BcGvFF/F0zB
         yJ9MzTN1YpeHlE4tfb2uNCLYoVmlgp2RDWqpU0Y2Hva9cbp2XpkqMmmk1gY61TdtiD/f
         y49w==
X-Gm-Message-State: APjAAAVoo630fdwr4SoCSeA5HX3e+6iVLBBRYmR7jYF2OxIjwZ/81vrV
        z+4oTJoRARmhlO4CLw05z1PiuYHXSCw=
X-Google-Smtp-Source: APXvYqyJYZPUMDVTNdAFBBn4p26s3QkOk/ST3JAv1FSN809kalFyIt+diDaMTn1Mc6vlohj+jq/21g==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr11139641pjc.23.1562145214989;
        Wed, 03 Jul 2019 02:13:34 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id y16sm3810478pff.89.2019.07.03.02.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:13:33 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:43:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        steven.sistare@oracle.com, subhra.mazumdar@oracle.com,
        songliubraving@fb.com
Subject: Re: [PATCH V3 0/2] sched/fair: Fallback to sched-idle CPU in absence
 of idle CPUs
Message-ID: <20190703091331.gnoouol3hn77r65b@vireshk-i7>
References: <cover.1561523542.git.viresh.kumar@linaro.org>
 <20190701134343.GT3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701134343.GT3402@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-19, 15:43, Peter Zijlstra wrote:
> On Wed, Jun 26, 2019 at 10:36:28AM +0530, Viresh Kumar wrote:
> > Hi,
> > 
> > We try to find an idle CPU to run the next task, but in case we don't
> > find an idle CPU it is better to pick a CPU which will run the task the
> > soonest, for performance reason.
> > 
> > A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> > should be a good target based on this criteria as any normal fair task
> > will most likely preempt the currently running SCHED_IDLE task
> > immediately. In fact, choosing a SCHED_IDLE CPU over a fully idle one
> > shall give better results as it should be able to run the task sooner
> > than an idle CPU (which requires to be woken up from an idle state).
> > 
> > This patchset updates both fast and slow paths with this optimization.
> 
> So this basically does the trivial SCHED_IDLE<-* wakeup preemption test;

Right.

> one could consider doing the full wakeup preemption test instead.

I am not sure what you meant by "full wakeup preemption test" :(

> Now; the obvious argument against doing this is cost; esp. the cgroup
> case is very expensive I suppose. But it might be a fun experiment to
> try.

> That said; I'm tempted to apply these patches..

Please do, who is stopping you :)

-- 
viresh
