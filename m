Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7E3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C47233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567095722;
	bh=yfzsmqtHVcxU58IiLWMkZ2wW2SOsZ+0cJNaEYROK0hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vfkIfLq1WGd5736/wYbMdnWoSix0cUO4gRnqu4m9+Xddwa+pOm0uRkkdo4Y12ZmLR
	 xDV2XWmO63xBXcxUbQBBjBtAlBwWPN+oaSiWII0KM6DpPEvFZSLJ/zJZPcGofztH8U
	 JFIsFqdLADki8iM5VgJRTQN7nluj5cteP6WpTNTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfH2QWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfH2QWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:22:00 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C2823427
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567095719;
        bh=yfzsmqtHVcxU58IiLWMkZ2wW2SOsZ+0cJNaEYROK0hg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WTVSQe3M3O36C2hHmO4C0PE5Jk4r6myJcarVYynfCz93uYgnG0Eg6NuyMvGs6f3jL
         n3laAbJx7/dxUnLKSSig2sxmXClBThloqMPAElS9lREgFtKrD6iBGFkpfuNNhEdaGu
         6igLeVpsbJ8U5azWAejqfCEherJlWbm6kCaOtXmc=
Received: by mail-wm1-f42.google.com with SMTP id d16so4466886wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:21:59 -0700 (PDT)
X-Gm-Message-State: APjAAAVJZDspOgjnmWpO33A+ZDV9Gk5/vIPs9Iv57IBWaopdROCIkHwB
        urRT9k4z0cHxb/hyPNmS48CLmQIeCDlEivDhTIlfXg==
X-Google-Smtp-Source: APXvYqzP6/jAXk8d7DB4MU1R71kThKX52pb8K9ShVzAGw7sIo6b1HNDK1m6Zf68a2BUyONA0Hh6ESmfNcso3WPAA4u4=
X-Received: by 2002:a1c:f910:: with SMTP id x16mr12055557wmh.173.1567095718086;
 Thu, 29 Aug 2019 09:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190828202330.GS26530@linux.ibm.com> <20190828210525.GB75931@google.com>
 <20190828211904.GX26530@linux.ibm.com> <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com> <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com> <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com> <20190829144355.GE63638@google.com> <20190829160946.GP4125@linux.ibm.com>
In-Reply-To: <20190829160946.GP4125@linux.ibm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Aug 2019 09:21:46 -0700
X-Gmail-Original-Message-ID: <CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com>
Message-ID: <CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Android Kernel Team <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 9:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Aug 29, 2019 at 10:43:55AM -0400, Joel Fernandes wrote:
>
> [ . . . ]
>
> > Paul, do we also nuke rcu_eqs_special_set()?  Currently I don't see anyone
> > using it. And also remove the bottom most bit of dynticks?
> >
> > Also what happens if a TLB flush broadcast is needed? Do we IPI nohz or idle
> > CPUs are the moment?
> >
> > All of this was introduced in:
> > b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
>
> Adding Andy Lutomirski on CC.
>
> Andy, is this going to be used in the near term, or should we just get
> rid of it?
>

Let's get rid of it.  I'm not actually convinced it *can* be used as designed.

For those who forgot the history or weren't cc'd on all of it: I had
this clever idea about how we could reduce TLB flushes.  I implemented
some of it (but not the part that would have used this RCU feature),
and it exploded in nasty and subtle ways.  This caused me to learn
that speculative TLB fills were a problem that I had entirely failed
to account for.  Then PTI happened and thoroughly muddied the water.

So I think we should just drop this :(
