Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C074EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969CB20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574694498;
	bh=5Hj4gAGkP8GoOYEWBiLZ2o5hpaesQxMs9VVRS+5bR3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XUBff7mm+EWm00qDatSN+3QLkh8huqBEtuSRRwOYNHk3xBKsjNuL4qoYdXzvTlHWF
	 +yZQ35rGbC7Z5y4+j5TlISYwpal3usUgLs/yAHkpCsle6+T4ZJ5I4OGrFwlPVMmbkr
	 CoTEpVz72FEXWdO9kpu+JUfp8jHMSMoEYSnmsEsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfKYPIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:08:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52562 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfKYPIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:08:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so15813984wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z0I/vvRv/FeVTegY7J6G12JD9kr0hp3pUvS0FB/3p5M=;
        b=Z7BD44h5Bd8jZiYosKKeartA0rTtdwQF359A8aMpBYPcpVrSge42t4xpHxaqkJQbSe
         m4y/UTfQigJrgT58Np3jhX4LjopYnNLWLsA489bvivOUEGQ/rOr47E6O6+Z/s2kZaM+j
         7pfvCdMpDUv16ZhyLqoQKN0sngWhr9+ZT35TaTnPAPUZUB3BSkfSQd8DleyrgBxaMADZ
         r6Hw3tCGjHftJqLf4HTI9mgkzRWb64BM7seW/OSNLptptZ6fL93XPitTWXvxe+pkxQn9
         kOVHfI5rIxbFBQOSOH30P7eo3tQQrD6303uEMFnW91dTkOpqO2EHj4a8l+aGcJl8BTYf
         Kh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z0I/vvRv/FeVTegY7J6G12JD9kr0hp3pUvS0FB/3p5M=;
        b=TShzUbw4ECgsdo+FP/sUeDeNp+wp+bk8fdICTBjjXO1pKlQKTPjOZuk5uBZS8X1cOG
         b1Mtt3Nc8TumIXGcH9CzxIl7sX4blGXwBjgRccmz8NwUa+6SC5OFvJaSDtt01HEMWRky
         mkom8u0SY0V2kaAJimfblQnEG/WZFc8qkMR/ai4G/Q7/kraw8WqZrJWae0WTpeDXQlod
         yhT1u2/0uQDtBLQmV6gJWlARQ4R4C3dAVtGvUSnCoBiZVnMLnMH0KMTM+4oGQd9M9pC6
         g0KWrXIqKurdlRLbcZsf2NOYlkitdG+ysXNWtEvlA5XWIdWDvWJ5j7ZqkaG3d8vJjq1L
         ROFA==
X-Gm-Message-State: APjAAAWia/RnbDnMgfB8LF4xu5FviJHFsPoOL6GOdSh7oRnyQBits4Rr
        192/nhC/V3x60AkdUzk2qd8=
X-Google-Smtp-Source: APXvYqzKnItFU3HrxP4rIurAJNnGgJVKkH9IFKKSrH/EE54ddwd8P9M3Bzh+kW8OHVIhfg5yu7KVPA==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr26071133wmk.78.1574694494076;
        Mon, 25 Nov 2019 07:08:14 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a15sm11447120wrx.81.2019.11.25.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:08:13 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:08:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [GIT PULL] scheduler changes for v5.5
Message-ID: <20191125150811.GA116487@gmail.com>
References: <20191125125944.GA22218@gmail.com>
 <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af8a5eb-5104-ad0b-bf46-dedb65d66a07@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 25/11/2019 12:59, Ingo Molnar wrote:
> 
> So I really don't want to be labeled as "that annoying scheduler PR guy",
> but some patches in Vincent's rework should be squashed to avoid being
> performance bisection honeypots.

I really didn't want to do an intrusive rebasing of the Git tree though, 
especially as we didn't know whether the improvements a) improved things 
b) were stable:

> > Vincent Guittot (14):
> >       sched/fair: Remove meaningless imbalance calculation
> >       sched/fair: Rework load_balance()
> 
> These two ^ (were split for ease of reviewing, [1])
> 
> >       sched/fair: Rework find_idlest_group()
> >       sched/fair: Fix rework of find_idlest_group()
> 
> And these two ^ (Mel voiced similar concerns at [2])

We can give testers a linearized tree for testing, should this come up 
(which I doubt it will ...), ok?

Thanks,

	Ingo
