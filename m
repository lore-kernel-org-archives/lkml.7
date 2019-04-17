Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F521C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4847021773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555480672;
	bh=4zjdeyrlTUes5XlDgTAxACNcRO4l0UuN6MbeUkjZIQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XbepASpO8o0n3+Bhv4OoV5UEyMGRqQeKb6noVMC4ovRRt0qqB4FRHgS3XS8ie96gb
	 mfYAx/5T9WF/kx8DVXDVNqYQrsoxgjXMW+AswG38D4XYTGud2bJXl0UljUYym0CDlx
	 q0MR/vJm6G6u5+5OJPUQ/Z9t+vmU5xNwluuAfUBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfDQF5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:57:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44061 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfDQF5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:57:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so69078wrv.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ud8Y7hJFyd11bvF8mlu3ELwQOWk5sXwQ2iYqBOr8hmQ=;
        b=Kxfx0nTlM0wSJQG22Hvpl1R+QsYQGJx/WtQRjWOXEc37pSUrZU3hqD/WLDfe3WxHKx
         2xgrlluaAuRzA6Uzw0epx/wUCOu8ShNsTjCOvD5l1zKDiLd31fSMvWvJuUIDJp/GzfA6
         80fxtD/Kgq4idovfBzhg0em7mHoOGLW7uQV/bq+Sx+2zk9mEHizlJ6PwxyO8aReye9wq
         K1JuC8pFK+c5gtxY6r33neEyC5jgWDEpTHiKu3iYINcetYJcq6EzRC6qnDqg1hIQJ4Hy
         h43TGG9g8t2DBlUM6w1+srybr0pZACJVyqYJmpGU9Z5RAvBQyQm5Gfw8wKgiBRNXZX1E
         qkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ud8Y7hJFyd11bvF8mlu3ELwQOWk5sXwQ2iYqBOr8hmQ=;
        b=AodKAPVwXleMDJZrfRrG0j5TJ19zJyjSafCUbXSy10XmMxz4xe+RXhleaEtNWQLcNl
         4UArYhCNDgCR/eGfFJwNjH2f+i8W7SuAQwjt9+AlwepHsR/mhbVHwnIJzt1mT3haEo5I
         7BTe3lcczc0i9w5KVKtq+rTP74eo3LZ0wdxaxLWV4FdWFX7NdjADYH0LvtB0yGXQ7wcr
         oDwAE/8Ymi8CNdh7b9G7+Zr3/zjKunF3qQky8HYMV3qBqnT8Rot3XgZ3lCyenm7cABEP
         /VMpbmD1l5jtJ+YzhaZZxXdmH/JRqjOoC1HPlUBPZ+H8S7v+rEsPjHC8h9v5lQqHhq4S
         i/NA==
X-Gm-Message-State: APjAAAX0WWpK593YMGDsWPoTlGOqFLPl596L8MXGnu2mTdlyCwLGEzMp
        jvgQLa5T78nsN6fM9bB1ufs=
X-Google-Smtp-Source: APXvYqyaCH5s8Y1QXy5pdkoyJUBbcFoINiue62YWeXR0GQ8ugiCeOjsL5loGWY0KHNSb7q+LL8T/kg==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr58026933wrn.51.1555480668830;
        Tue, 16 Apr 2019 22:57:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 61sm178930757wre.50.2019.04.16.22.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:57:48 -0700 (PDT)
Date:   Wed, 17 Apr 2019 07:57:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip 0/2] locking/rwsem: Rwsem rearchitecture part 2
 follow-up patches
Message-ID: <20190417055745.GA95755@gmail.com>
References: <20190415205829.32707-1-longman@redhat.com>
 <20190416131047.GW11158@hirez.programming.kicks-ass.net>
 <4747d10b-e9a4-f453-ab4e-13fc984a4067@redhat.com>
 <20190416141747.GN4038@hirez.programming.kicks-ass.net>
 <18af71ce-1ef3-c6cd-4088-3b2a9bf0016e@redhat.com>
 <20190416173700.GQ4038@hirez.programming.kicks-ass.net>
 <2873c42c-f2a6-64e9-bf0f-9c86536984b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2873c42c-f2a6-64e9-bf0f-9c86536984b7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 04/16/2019 01:37 PM, Peter Zijlstra wrote:
> > On Tue, Apr 16, 2019 at 01:03:10PM -0400, Waiman Long wrote:
> >> On 04/16/2019 10:17 AM, Peter Zijlstra wrote:
> >>> On Tue, Apr 16, 2019 at 09:18:50AM -0400, Waiman Long wrote:
> >>>> On 04/16/2019 09:10 AM, Peter Zijlstra wrote:
> >>>>> On Mon, Apr 15, 2019 at 04:58:27PM -0400, Waiman Long wrote:
> >>>>>> This series contain 2 follow-up patches to alleviate the performance
> >>>>>> regression found in the page_fault1 test of the will-it-scale benchmark.
> >>>>>> This does not recover all the lost performance, but reclaim a sizeable
> >>>>>> portion of it.
> >>>>>>
> >>>>>> The regression was found on an Intel system. I have run the test on
> >>>>>> an AMD system. The regression wasn't seen there.  There are only minor
> >>>>>> variations in performance. Perhaps the page fault path is quite different
> >>>>>> between Intel and AMD systems.
> >>>>> Can you please just fold this back into the appropriate patches? Trying
> >>>>> to review all the back and forth is painful.
> >>>> I will send out an update part 2 patch with patch 1 of this series
> >>>> merged into the writer spinning on reader patch. Patch 2 of this series
> >>>> will be a standalone one.
> >>> Hmm, in that case I can fold it back too. So hold off on sending it.
> >>>
> >>> I thought #2 was a fixup for an earlier patch as well.
> >> #2 is a performance fix.
> > Of this patch?
> >
> > 206038 N T Apr 13 Waiman Long     (7.5K) ├─>[PATCH v4 11/16] locking/rwsem: Enable readers spinning on writer
> >
> > Fixes should have a Fixes: tag. And if the patch it fixes isn't a commit
> > yet, the patch should be refreshed to not need a fix.
> 
> The original patch isn't wrong. This patch just introduce another idea
> to make it better. That is why I would still like to separate it as a
> distinct patch.

Yeah, I think it's better to have it in two separate patches. Basically 
patch #1 has a downside for certain workloads, which the heuristics in 
patch #2 improve. That's the only connection between the two patches.

If we find some other worst-case workload then the split of the commits 
would allow more finegrained examination of the effects of these 
performance tunings.

Thanks,

	Ingo
