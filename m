Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDBFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2A2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551856123;
	bh=Di9k5isDuVb/fU1SoCwBrNfNQOWb5Enn5a11WMrBO44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1quy/Wmhyh/ty8naz8TPdhw19CSkNfM7Y7/XFSQ1sBW323baDgcaAkUPjvR/Ooiqb
	 e7FFtTWBL7/4Dtbk8uzWeTc4RZT1wJBf3dAiTPO4NIIMkX6UZv09U8d4eYEzcT/Q8D
	 m+awwyGPNGoHh1R5XgEnkSfb9ZCf2N9O8xIRuKao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfCFHIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:08:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39474 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfCFHIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:08:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so12084351wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jnTBlefSsxoOy+hS+iAfj8Y7Xs3PR2bQcJeXSFj38p0=;
        b=prR4/9fbluzJHs5K6C9Jq/XHRUyPxOd/d3kAc05BVT6MhVcUXeIX6baRXaJn/HmbMT
         5N9HmUBrVFW1XVuINK2QYb1xB5pAXS9HWzY0UMUuVpk/dKJr8uNJmLv6rYqiaPsaVYlS
         KKymJFtFPWsMixFmdfn8P4kGI3YC/2UREWjwGkmPaKs2rUiJEKrMqq3ZsFvcJ/5F4eFo
         18Y9EYRzWzfh5sNo0jQsL9TZJMajmyvFYJtubjCn+b0rM8gLfvI9kyFwmJLIU0Qjl+Bn
         O9hMeu2DJeS4nkFStRzPLOqn9t5y38YqPnhBECYNh5QcaWaTQYA/+dU53GyC1wTm0p+P
         prHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jnTBlefSsxoOy+hS+iAfj8Y7Xs3PR2bQcJeXSFj38p0=;
        b=ZxcBgpWFNZ2PmKPe4LFhQUWF4BcSgU2ZO+2aAVkKh4Fi6l6WJpjXZ9JiygRCaYg+/c
         jzNrrWYIazge7e4oF9VnXeE2tSEkFhaPFVn7NZsbWIThd3mI2I52IaT5x+u37fQ9i1Gb
         mLkZME8vWsPYPYGZkdxUHYRxJby86rYMrz5+mShuMBYRgQy+rlr+fvVWxyx8gegbKDX4
         EL/BmDj27QiOBGJpUVbHj4FuwpZXtJhKcNCrg4Frr9AqaBSB14vEuUyw5HOOK8ClMCG6
         cACaZQJPzCJ96EVUZVPD2A6OqeN0eybnTgPby+N98zbqsarKXfwn+znW6OpI7oD8J7QI
         Degg==
X-Gm-Message-State: APjAAAWl/djTVVNxW+FQP80ED/8E9EeUct5HzvJrqfxgYkvFL2wHTGbL
        Xg4JOX42EA5tqJxCwepz/wY=
X-Google-Smtp-Source: APXvYqzo1S+FfDLt1Os9Cn78bYT2PEAAyed3lve10J/1VQnkDYBm616s7WX7Vx3rM7q6qi2vUcc86g==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr1734525wrr.93.1551856118836;
        Tue, 05 Mar 2019 23:08:38 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d2sm1225711wrq.94.2019.03.05.23.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 23:08:38 -0800 (PST)
Date:   Wed, 6 Mar 2019 08:08:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] RCU updates for v5.1
Message-ID: <20190306070836.GA111385@gmail.com>
References: <20190305120301.GA93284@gmail.com>
 <CAHk-=wiM4_0ZDDAcN0nJ8TsK+MnO1ObmSH4nTvrirA5nenFTHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiM4_0ZDDAcN0nJ8TsK+MnO1ObmSH4nTvrirA5nenFTHA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Mar 5, 2019 at 4:03 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest core-rcu-for-linus git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
> 
> Hmm. I think this made my build time explode.
> 
> I'm bisecting, but it looks like my allmodconfig builds went from ~31
> min to ~39 min with this pull.
> 
> NOTE! I'm  not saying that the kernel slowed down. Just the *build*
> (with the same kernel) slowed down.
> 
> It's odd, and maybe I did something wrong, so I'll have to
> double-check the numbers, but I thought I'd mention it in case
> somebody goes "Ahh, I did X to the include files, so now every
> compiler invocation probably sees all of xyz and that will slow things
> down enormously".

Could it be the locking tree?

In particular the atomics auto-generation slowed down the build before, 
but this build regression was thought to be fixed with:

  0cf264b3133d: locking/atomics: Check atomic headers with sha1sum

but maybe that's not the whole story?

Or it's an unreported slowdown related to the RCU tree, as you say.

Thanks,

	Ingo
