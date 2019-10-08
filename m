Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB8ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EED7206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebhgc7zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJHQXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:23:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44346 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfJHQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:23:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id q12so7478095lfc.11;
        Tue, 08 Oct 2019 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vDv1klytpHASOjBcro99P7afE55WHuXFHU2DQg71q6U=;
        b=Ebhgc7zR/tw4LmSQ1R97WhArExCdPVSs73g4xH80QiHQyrPAGGoDnvWPBAUFBAMVJT
         jakVmtMcQdoFpNJwkX17F3VE0q+DbakIfWBZKfWkd+niMBC676hc0T7rgr63z/Hii2Iu
         w/AkBhGZMwNpFVcx8ic1VUep6eoIYsy6qtnAREGQa3+WPLRVgCglLf3BH1riV3sw7wK2
         s8loCOSjsImnSEu+UUrM0pvX9kRzGxPJzOBLE3mx6toNxXM4GXq0e8ZPtvJ2uaahC+Oz
         SGWWqo7wzmKbu2gQpo+XVrpAQGQh16IBg1uHE3vERDU1wKGrOtA7Ru+T4dd9pjc99r8f
         CVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDv1klytpHASOjBcro99P7afE55WHuXFHU2DQg71q6U=;
        b=R99T4P1DgUFxinGcyOrYwesCCYr4vzWhv9GY84UoAwbAp6wVFlUnURjta2gUZ9b85w
         syVqLf74XrJCku2CsMdHuWI1J08waNnOTO2AobfTpFHPm2tGRCo4RSO8pe6AZVp9cxBE
         KUqpJMZ3W8AHzuPpT5CbWNFh8W09I6DoOanKTKYvoggSrvQHWkBQPrsLs+OgCMW+gt5K
         VkQ+X/5FNXZbS4vzKnO4s+nZWRiK/5mXCCA6e+fYsrTbqjO06ca+nSFICPxxakBlwukA
         koNkG2IZHhFUEXe0ACugDV90Z2gipdRZXWBX8aehy+C+YKxeu7jwv/lUEPU5c11RDkS8
         J8Ug==
X-Gm-Message-State: APjAAAWM3Q+TzuxkMRMNMyZyzRrcjn+wmMqea9KSHnOVnhsPeCM19qSK
        N9Sq8/oPD7TgvjD/VtStC2o=
X-Google-Smtp-Source: APXvYqyLg1WX/oRFKmjXO7odTv9bLIpjPd9EZHh2nzwYBQsvoGnshtigNv07Z0M7s1VISFwYDRowLQ==
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr20302175lfk.119.1570551794933;
        Tue, 08 Oct 2019 09:23:14 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id d28sm3877793lfq.88.2019.10.08.09.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 09:23:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 8 Oct 2019 18:23:06 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kernel-team@lge.com,
        Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20191008162306.GA5901@pc636>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190918095811.GA25821@pc636>
 <20190930201623.GA134859@google.com>
 <20191001112702.GA22112@pc636>
 <20191004172038.GG253167@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004172038.GG253167@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 01:20:38PM -0400, Joel Fernandes wrote:
> On Tue, Oct 01, 2019 at 01:27:02PM +0200, Uladzislau Rezki wrote:
> [snip] 
> > > > I have just a small question related to workloads and performance evaluation.
> > > > Are you aware of any specific workloads which benefit from it for example
> > > > mobile area, etc? I am asking because i think about backporting of it and
> > > > reuse it on our kernel. 
> > > 
> > > I am not aware of a mobile usecase that benefits but there are server
> > > workloads that make system more stable in the face of a kfree_rcu() flood.
> > > 
> > OK, i got it. I wanted to test it finding out how it could effect mobile
> > workloads.
> > 
> > >
> > > For the KVA allocator work, I see it is quite similar to the way binder
> > > allocates blocks. See function: binder_alloc_new_buf_locked(). Is there are
> > > any chance to reuse any code? For one thing, binder also has an rbtree for
> > > allocated blocks for fast lookup of allocated blocks. Does the KVA allocator
> > > not have the need for that?
> > >
> > Well, there is a difference. Actually the free blocks are not sorted by
> > the its size like in binder layer, if understand the code correctly.
> > 
> > Instead, i keep them(free blocks) sorted(by start address) in ascending
> > order + maintain the augment value(biggest free size in left or right sub-tree)
> > for each node, that allows to navigate toward the lowest address and the block
> > that definitely suits. So as a result our allocations become sequential
> > what is important.
> 
> Right, I realized this after sending the email that binder and kva sort
> differently though they both try to use free sizes during the allocation.
> 
> Would you have any papers, which survey various rb-tree based allocator
> algorithms and their tradeoffs? I am interested in studying these more
> especially in relation to the binder driver. Would also be nice to make
> contributions to papers surveying both these allocators to describe the state
> of the art.
> 
So far i have not had any paper with different kind of comparison. But
that is interested for sure, especially to analyze the model for example
based on B-Tree, so when we can fully utilize a cache performance.
Because regular binary trees are just pointer chasing.

As for binder driver and its allocator, is it O(lognN) complexity? Is
there any bottleneck in its implementation?

Thanks!

--
Vlad Rezki
