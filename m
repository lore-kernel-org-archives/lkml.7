Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A75C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F7F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EOjaMuwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfHIVZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:25:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39894 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfHIVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:25:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so45492668pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G4ABWhOgY+3mhNhK294ojAME4IETU+ywywa2ntO92Zc=;
        b=EOjaMuwxDTmNbbMp5AqBHBhKz2tbW4foGzn8NunssyfyoEVCBNkwJn3D8xphI7+Ac5
         mDeuKvKJsSR5hPAESbkz8KLaXQiPyL2wSEWSmlhglaw6lXUXfHQpHGBHKpkmTpdg7npO
         25kllWW1pytXCVIg+TSKjaPd0ZgeZ5jWCYim8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G4ABWhOgY+3mhNhK294ojAME4IETU+ywywa2ntO92Zc=;
        b=uGM23lY4CHUIw/GXH7qygvacs9Dfp+hLCu1R4be05sVakMCTCrPzOlRLJifrSWWivS
         Px0uoVTpR3wMCAHwYNUZmsI6lNi0YCoIgKgaOoYyHqwxRkUg1pwNFM+xDGTQxLdHKZaM
         xwpXEuFHrlSTp7jUHnNAR1QLfcAGwPE0CvRFygEr5TB8i9Kh//zyM01mZUt5l57v7lHL
         /jq3zR10THOM0IOGXesgS+IVnEMVmt46iMoGAaEEk7eqctzNtxnjbMyNjw0Mmq6IHdGR
         8DlXGjeKTeV74bHywsmFnbu5pb1JiwTFoTn/dcFs2pRUpbh0erjp2lxpj1HN5wi8EsQN
         wPBA==
X-Gm-Message-State: APjAAAVxyMsVDLnkkmYbSCf1PHnEz67RByW/8h1gZCr/n7p0SjUpIH9c
        8hc3nRT74eJMyVCgb33BzRHnWQ==
X-Google-Smtp-Source: APXvYqziDp2DjYbr7ZcinWPobCKuoKnmrF2D4ZgUBGWCJs8Tx2fTSj5fY0r9w3c3RF22QivMk+jTEA==
X-Received: by 2002:a17:902:7c12:: with SMTP id x18mr11912154pll.123.1565385914703;
        Fri, 09 Aug 2019 14:25:14 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a128sm114470075pfb.185.2019.08.09.14.25.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 14:25:13 -0700 (PDT)
Date:   Fri, 9 Aug 2019 17:25:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190809212512.GF255533@google.com>
References: <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
 <20190809202645.GD255533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809202645.GD255533@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:26:45PM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 04:22:26PM -0400, Joel Fernandes wrote:
> > On Fri, Aug 09, 2019 at 09:33:46AM -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 09, 2019 at 11:39:24AM -0400, Joel Fernandes wrote:
> > > > On Fri, Aug 09, 2019 at 08:16:19AM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
> > > > [snip]
> > > > > > > But I could make it something like:
> > > > > > > 1. Letting ->head grow if ->head_free busy
> > > > > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > > > > 
> > > > > > > This would even improve performance, but will still risk going out of memory.
> > > > > > 
> > > > > > It seems I can indeed hit an out of memory condition once I changed it to
> > > > > > "letting list grow" (diff is below which applies on top of this patch) while
> > > > > > at the same time removing the schedule_timeout(2) and replacing it with
> > > > > > cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> > > > > > starves the worker threads that are executing in workqueue context after a
> > > > > > grace period and those are unable to get enough CPU time to kfree things fast
> > > > > > enough. But I am not fully sure about it and need to test/trace more to
> > > > > > figure out why this is happening.
> > > > > > 
> > > > > > If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> > > > > > situation goes away.
> > > > > > 
> > > > > > Clearly we need to do more work on this patch.
> > > > > > 
> > > > > > In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> > > > > > that since the kfree is happening in softirq context in the _no_batch() case,
> > > > > > it fares better. The question then I guess is how do we run the rcu_work in a
> > > > > > higher priority context so it is not starved and runs often enough. I'll
> > > > > > trace more.
> > > > > > 
> > > > > > Perhaps I can also lower the priority of the rcuperf threads to give the
> > > > > > worker thread some more room to run and see if anything changes. But I am not
> > > > > > sure then if we're preparing the code for the real world with such
> > > > > > modifications.
> > > > > > 
> > > > > > Any thoughts?
> > > > > 
> > > > > Several!  With luck, perhaps some are useful.  ;-)
> > > > > 
> > > > > o	Increase the memory via kvm.sh "--memory 1G" or more.  The
> > > > > 	default is "--memory 500M".
> > > > 
> > > > Thanks, this definitely helped.
> > 
> > Also, I can go back to 500M if I just keep KFREE_DRAIN_JIFFIES at HZ/50. So I
> > am quite happy about that. I think I can declare that the "let list grow
> > indefinitely" design works quite well even with an insanely heavily loaded
> > case of every CPU in a 16CPU system with 500M memory, indefinitely doing
> > kfree_rcu()in a tight loop with appropriate cond_resched(). And I am like
> > thinking - wow how does this stuff even work at such insane scales :-D
> 
> Oh, and I should probably also count whether there are any 'total number of
> grace periods' reduction, due to the batching!
 
And, the number of grace periods did dramatically drop (by 5X) with the
batching!! I have modified the rcuperf test to show the number of grace
periods that elapsed during the test.

thanks,

 - Joel

