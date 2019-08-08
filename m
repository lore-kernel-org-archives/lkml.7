Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8EEC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C197216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BcWN/VGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404421AbfHHUNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:13:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41860 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404145AbfHHUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:13:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so44719816pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9sMOZsMmM5Lpw8cXggccHt5rzebNEC661iNldG1cOs=;
        b=BcWN/VGLlpKo6esnGMMEI4neARxvmhNtTepPjbHmrFB+qA5ES8L2L4p2JlbrvlhKBd
         L/dX6rVFtuUrXwwftuYKrFJuMV+prsjHuwgAg3GqAgNs4/t8jH8WZzyy3cGpSR0jbyB/
         dkhLp0cv+vsO74i7jLtMGDg4hRVi6kvY9X3qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9sMOZsMmM5Lpw8cXggccHt5rzebNEC661iNldG1cOs=;
        b=BluTXE5lCWZMEWOVOxppPm95IgunzFqlQp4OyArYlJJcXZsXZ4jmDmg5yRU2bKaZml
         EPz/nJ7DidFhMTTYCIbzkO8krw21Ft+LX49TBHtVrnCm48LCm1GwYvizK6hkeDkZ0FEq
         JnBXosfx6ypPy1aD17AnyCMlw4P/DAsuAIvbxl/hkQP3nEb947BqxkRUoCYj9Nd9FVAd
         3OSn6Z1WlZhz9kFlMT7l/f0DlFVVDpJu/9e7sgtKlcF8uep6k+X84cxAHKdfG/hQxXry
         We697SRUH2L3fBFT5pgxDKAOPh1AdVbdb2Mgl/wCGeb1vTW2rstnrkZ2jZ+IVsIqIaqG
         5kiQ==
X-Gm-Message-State: APjAAAWSt4nibquqtQll2vtptn03YrApPHCwIkk90cbHGreGFGc6PHx8
        J4Ktv6ou9DX87W9vqknnNETBUQ==
X-Google-Smtp-Source: APXvYqzFRiyivZgz9qJrup7ETS9xb43+C4sUfe7Us+iiOvf9cxp167vsC4K+vWR2WL1jBl0Z406u5g==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr1084395pfa.135.1565295215431;
        Thu, 08 Aug 2019 13:13:35 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h70sm91248123pgc.36.2019.08.08.13.13.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:13:34 -0700 (PDT)
Date:   Thu, 8 Aug 2019 16:13:33 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, kernel-team@android.com,
        kernel-team@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190808201333.GE261256@google.com>
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190808102610.GA7227@X58A-UD3R>
 <20190808181112.GQ28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808181112.GQ28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:11:12AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 08, 2019 at 07:26:10PM +0900, Byungchul Park wrote:
> > On Wed, Aug 07, 2019 at 05:45:04AM -0400, Joel Fernandes wrote:
> > > On Tue, Aug 06, 2019 at 04:56:31PM -0700, Paul E. McKenney wrote:
> > 
> > [snip]
> > 
> > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > > Of course, I am hoping that a later patch uses an array of pointers built
> > > > at kfree_rcu() time, similar to Rao's patch (with or without kfree_bulk)
> > > > in order to reduce per-object cache-miss overhead.  This would make it
> > > > easier for callback invocation to keep up with multi-CPU kfree_rcu()
> > > > floods.
> > > 
> > > I think Byungchul tried an experiment with array of pointers and wasn't
> > > immediately able to see a benefit. Perhaps his patch needs a bit more polish
> > > or another test-case needed to show benefit due to cache-misses, and the perf
> > > tool could be used to show if cache misses were reduced. For this initial
> > > pass, we decided to keep it without the array optimization.
> > 
> > I'm still seeing no improvement with kfree_bulk().
> > 
> > I've been thinking I could see improvement with kfree_bulk() because:
> > 
> >    1. As you guys said, the number of cache misses will be reduced.
> >    2. We can save (N - 1) irq-disable instructions while N kfrees.
> >    3. As Joel said, saving/restoring CPU status that kfree() does inside
> >       is not required.
> > 
> > But even with the following patch applied, the result was same as just
> > batching test. We might need to get kmalloc objects from random
> > addresses to maximize the result when using kfree_bulk() and this is
> > even closer to real practical world too.
> > 
> > And the second and third reasons doesn't seem to work as much as I
> > expected.
> > 
> > Do you have any idea? Or what do you think about it?
> 
> I would not expect kfree_batch() to help all that much unless the
> pre-grace-period kfree_rcu() code segregated the objects on a per-slab
> basis.

You mean kfree_bulk() instead of kfree_batch() right? I agree with you, would
be nice to do per-slab optimization in the future.

Also, I am thinking that whenever we do per-slab optimization, then the
kmem_cache_free_bulk() can be optimized further. If all pointers are on the
same slab, then we can just do virt_to_cache on the first pointer and avoid
repeated virt_to_cache() calls. That might also give a benefit -- but I could
be missing something.

Right now kmem_cache_free_bulk() just looks like a kmem_cache_free() in a
loop except the small benefit of not disabling/enabling IRQs across each
__cache_free, and the reduced cache miss benefit of using the array.

thanks,

 - Joel

[snip] 
