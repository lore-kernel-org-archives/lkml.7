Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D072C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6BE217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HYxy1KIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHIU0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:26:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33837 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfHIU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:26:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so46618213pfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOuW1vgX9GzFRp2BRQ/iIfg703Hr+CMx7KleXDC/WG4=;
        b=HYxy1KIX9AuqfYtuDEcK2vFQoVptOaJM58zzimG166ZRrQaEFEojoAYysKO/VsTDrh
         MqlcfLIELyedo0vYqOdQC/mYWTZwklODssnIqVaGJZix716kdil2q8mwtxz6HM6o5Lq2
         T7Is3OfxzNcKg8aO4oPDsFaLmt9QMk+8wnAPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOuW1vgX9GzFRp2BRQ/iIfg703Hr+CMx7KleXDC/WG4=;
        b=c/ygQu3oWBz+Tm8nZOKSblKT17zI5m5PkoyVOMKX6G658FIoW5rUHa4dlGc4Qoay54
         5Wc8Z5zlb41k9syhUPLWw2oXkjJSVrG+VxVrP62ky799Y/Py6hbrj7ZqwQJCpFWhPI0I
         75mu9kuQxIVoauuFH5sUVjRgBMQLDJCQcgae2asJmalGfwv7pdXeFY5sSXr/iHIp5BOO
         +dg/sYvKlhxoClsZmt03x02m3DLjZNrItp/6OESvUMg3oZNbCqxCrGS+aT3z2GjpDZb1
         ZGqAWxD4FZEAgyMDBNDUyQAeHV3uzsIbknPFlPcyuSTT43dEijhJNxl1Wfglqghc2c+T
         YxEw==
X-Gm-Message-State: APjAAAWdy056RnkQHarfQhJVs7PareEozmiwcLmYs0yTOaJgvaZayuVo
        smsCwGl8f4s6DpBP7CR9u5RhTA==
X-Google-Smtp-Source: APXvYqxMFNtQ4nA4/C5aiCp3MykTBQtEBdXrVMvA9Oy0yBPLQQVU2L/dsI00+DZBW/BXrZ5W2n6f7Q==
X-Received: by 2002:a62:1941:: with SMTP id 62mr6792441pfz.188.1565382407972;
        Fri, 09 Aug 2019 13:26:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v14sm21317794pgi.79.2019.08.09.13.26.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 13:26:46 -0700 (PDT)
Date:   Fri, 9 Aug 2019 16:26:45 -0400
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
Message-ID: <20190809202645.GD255533@google.com>
References: <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <20190808233014.GA184373@google.com>
 <20190809151619.GD28441@linux.ibm.com>
 <20190809153924.GB211412@google.com>
 <20190809163346.GF28441@linux.ibm.com>
 <20190809202226.GC255533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809202226.GC255533@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:22:26PM -0400, Joel Fernandes wrote:
> On Fri, Aug 09, 2019 at 09:33:46AM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 09, 2019 at 11:39:24AM -0400, Joel Fernandes wrote:
> > > On Fri, Aug 09, 2019 at 08:16:19AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Aug 08, 2019 at 07:30:14PM -0400, Joel Fernandes wrote:
> > > [snip]
> > > > > > But I could make it something like:
> > > > > > 1. Letting ->head grow if ->head_free busy
> > > > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > > > 
> > > > > > This would even improve performance, but will still risk going out of memory.
> > > > > 
> > > > > It seems I can indeed hit an out of memory condition once I changed it to
> > > > > "letting list grow" (diff is below which applies on top of this patch) while
> > > > > at the same time removing the schedule_timeout(2) and replacing it with
> > > > > cond_resched() in the rcuperf test.  I think the reason is the rcuperf test
> > > > > starves the worker threads that are executing in workqueue context after a
> > > > > grace period and those are unable to get enough CPU time to kfree things fast
> > > > > enough. But I am not fully sure about it and need to test/trace more to
> > > > > figure out why this is happening.
> > > > > 
> > > > > If I add back the schedule_uninterruptibe_timeout(2) call, the out of memory
> > > > > situation goes away.
> > > > > 
> > > > > Clearly we need to do more work on this patch.
> > > > > 
> > > > > In the regular kfree_rcu_no_batch() case, I don't hit this issue. I believe
> > > > > that since the kfree is happening in softirq context in the _no_batch() case,
> > > > > it fares better. The question then I guess is how do we run the rcu_work in a
> > > > > higher priority context so it is not starved and runs often enough. I'll
> > > > > trace more.
> > > > > 
> > > > > Perhaps I can also lower the priority of the rcuperf threads to give the
> > > > > worker thread some more room to run and see if anything changes. But I am not
> > > > > sure then if we're preparing the code for the real world with such
> > > > > modifications.
> > > > > 
> > > > > Any thoughts?
> > > > 
> > > > Several!  With luck, perhaps some are useful.  ;-)
> > > > 
> > > > o	Increase the memory via kvm.sh "--memory 1G" or more.  The
> > > > 	default is "--memory 500M".
> > > 
> > > Thanks, this definitely helped.
> 
> Also, I can go back to 500M if I just keep KFREE_DRAIN_JIFFIES at HZ/50. So I
> am quite happy about that. I think I can declare that the "let list grow
> indefinitely" design works quite well even with an insanely heavily loaded
> case of every CPU in a 16CPU system with 500M memory, indefinitely doing
> kfree_rcu()in a tight loop with appropriate cond_resched(). And I am like
> thinking - wow how does this stuff even work at such insane scales :-D

Oh, and I should probably also count whether there are any 'total number of
grace periods' reduction, due to the batching!

thanks,

 - Joel

