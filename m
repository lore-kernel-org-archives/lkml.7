Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84340C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5409020740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573986713;
	bh=FjNNJzM9g3J9NbhLTQPOfNMtfZk7czsJCa4Fjp6ap68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=APbWz2JjMrl56ctGQ38+E8qTZjDLs07juJA72CPF/zD6SmIPNgbDy+OTr+fXiZZDW
	 HhgpIECMGwkldc3bcotf30sEiZ77YMaobb2VoUq5HRGZxMnUqfDp/JfzViSPmkeBvp
	 3J1dpUfp+bzPQZiTSlVFWxQ5kq290HpYQ5yeusYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfKQK34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 05:29:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39080 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 05:29:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id t26so15545701wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L35ud2R4z1sezUhGJHcfCtoPbn+hlhT+MvDZ8i/X+RU=;
        b=liBHn1t/0e5i5rLuDZHoiiI+6oV2MceYob79yZwzP55Ez4NDU7HxSXL85e+pr/e7lb
         svJHhp7f8+kP98xe3j4/hQSZE8Uxl3+B8U6eaajlTR4PKz5RDnROex8XohnYSw0vg4/L
         cXECchW+ujWNWfkdCAKas9smsmmEOYjeRdTaXTlKD27uQHHmHUmaF52a0sz/QijyWENZ
         8Kb23Mh+7+9wWon31BQgQzCqRgWEHuRxReoSu0dZ6aJTZ6V3VF6wNwpNNPKW5fm/zvI7
         OGKHw617BUafLY77rxkH7WBVXOtJZ1/B/W30wX1z7P5bDMCKnnIujHsOaTuUUedVIKqP
         7gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L35ud2R4z1sezUhGJHcfCtoPbn+hlhT+MvDZ8i/X+RU=;
        b=PsobKRXqvoojLGE+ECoJEJWmkzw2+qHx33/Zat47te1jRUyCUBcnJfhd3eXty38Phb
         rLZ4QAI7I+gr8CnBJoG5VCqzv7XVWEwvFdWNEkUiwb6WFXJOtiYzLngPboIZwqY2KsAV
         FsZ70sMl8/819o9hvC2XX3jM9KAOxAxsyLGGdbM7RcwX+BFXoBflaGu+aMZLgFUMEcqT
         Ymg3uu5yt8aOaGSV6EMLZQi+MGqygihvhjKlHFAWhSlU7knDMul4RXFkTwPsEa6gbYlQ
         xo5bmVhJEsSJJSTe4xI3nFC4LiNqr6AYC3bUREeVb7Kw6cXwBJ0hH0/aWdz1IGoDsUxK
         0iIQ==
X-Gm-Message-State: APjAAAW0AkoGVGwBDgJj0ehPc5AJrxqWsPmalAKK07nbddIpwfQPLgCx
        K5RbNsWxiiuSiIG7gBAeVaiBY1WY
X-Google-Smtp-Source: APXvYqxaKi3EqDW72F4p/K418446KwdDbvhHwIRMIY0d8y5OMYnTarvaYYnbLav9BxayhNRVnqAksA==
X-Received: by 2002:a1c:4c15:: with SMTP id z21mr15004526wmf.132.1573986595393;
        Sun, 17 Nov 2019 02:29:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g8sm16394215wmk.23.2019.11.17.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 02:29:54 -0800 (PST)
Date:   Sun, 17 Nov 2019 11:29:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <20191117102952.GA56088@gmail.com>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <20191117094549.GB126325@gmail.com>
 <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4b0828-abba-e27d-53f6-135df06eba1a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 17/11/2019 09:45, Ingo Molnar wrote:
> > I've picked v2 up instead. I suspect it's not really consequential as 
> > enums don't really get truncated by compilers, right? Is there any other 
> > negative runtime side effect possible from the imprecise enum/uint 
> > typing?
> > 
> 
> AFAIUI the requirement for the enum type is that it has to be an int type that
> covers all its values, so I could see some funky optimization (e.g. check the
> returned value is < 512 but it's assumed the type for the enum is 8 bits so
> this becomes always true). Then again we don't have any explicit check on
> those returned values, plus they fit in 11 bits, so as you say it's
> mostly likely inconsequential (and I didn't see any compile diff).

Yeah, so unless there's evidence of there being a nonzero chance of this 
being misbuilt I'd gravitate towards doing this via via sched/core, 
especially so late in the cycle.

> My "worry" wasn't really about this patch, it was more about the 
> following one - it didn't like the idea of merging an unneeded patch 
> (with a Fixes: tag on top of it).

Yeah, agreed - should be fixed now.

> >>>       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
> >>
> >> And this one is no longer needed, as Michal & I understood (IOW the fix in
> >> rc6 is sufficient), see:
> >>
> >>   c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com
> > 
> > Ok.
> > 
> > I'm inclined to just reduce sched/urgent back to these three fixes:
> > 
> >   6e1ff0773f49: sched/uclamp: Fix incorrect condition
> >   b90f7c9d2198: sched/pelt: Fix update of blocked PELT ordering
> >   ff51ff84d82a: sched/core: Avoid spurious lock dependencies
> > 
> > and apply v2 of the uclamp_id type fix to sched/core. This would reduce 
> > the risks of a Sunday pull request ...
> > 
> 
> This sounds good to me. Sorry for the hassle.

No hassle at all - thanks for catching these!

Thanks,

	Ingo
