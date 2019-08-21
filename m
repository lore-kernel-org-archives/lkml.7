Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F34C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817C322DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QwineO+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfHUAwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:52:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40415 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHUAwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:52:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so341519pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pbppln3FnKyqVlRJygT2B6SgzOfnHFv1Prefdnvt17A=;
        b=QwineO+6eezEllrI2gW6kup6pia36NF654QzQuGX/N5BE6w7MCw1g62W9XyixJQW5r
         zXfckRM4/p+rWVYgvPAz0TYRi+ngrJjmba7b1TM/KqpVbzscyjiXlEsW1SbAJQm9eANZ
         qhWfFa/8/1BawUIvtNIxmlJdwvmr3VMDa6ygg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pbppln3FnKyqVlRJygT2B6SgzOfnHFv1Prefdnvt17A=;
        b=L7qSd8X0fDVZGgwfhsuRcv1XX+bi4pwhJWOWL22dPyzkShLgOiwXjPPc6oYxm4qQM1
         QMWgyR7xQPkKPVC3zo7HBTnrhsrRRioJGpoJIiz0USmpiA7lvJPo3jzp9eGZERWk0LSz
         okuyxFMd6Utf//rbEb12zeFvFkn9XI3qjtWVL/RW2MfVC6lHXjIpF964CLGt6xZbAFPZ
         zn3bUGFxdvcBVP9f+c2dFQlfawtsYfvBgEacN/AxhuJxooLyTBvBzlyr3C/ucVhRFIt6
         qOk81HP33EwHA1WTaxQbavEOincBdoEyFV10JcfZPImIhWv2MO4phf8ayV8yFnXbcDRg
         mX5g==
X-Gm-Message-State: APjAAAWiZ0XyUBh8eHkA700qGXgw9gORSW9SDX+9YZ5NfHlGAP5Ca80G
        /LtsdDflY4R6LV7msH6AcdaSDQ==
X-Google-Smtp-Source: APXvYqyF2wj0lTQLg1t1n2SrV4tY/jDnvE7Po7qyiXBL7BzwCq3+Saoie8JxaXZ9G2pTRp6QgiyLGw==
X-Received: by 2002:a17:902:1123:: with SMTP id d32mr226220pla.218.1566348731838;
        Tue, 20 Aug 2019 17:52:11 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id t9sm1096167pji.18.2019.08.20.17.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 17:52:11 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:51:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com, Rao Shoaib <rao.shoaib@oracle.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 2/2] rcuperf: Add kfree_rcu() performance Tests
Message-ID: <20190821005154.GA27466@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190814160411.58591-2-joel@joelfernandes.org>
 <20190814225850.GZ28441@linux.ibm.com>
 <20190819193327.GF117548@google.com>
 <20190819222330.GH28441@linux.ibm.com>
 <20190819235123.GA185164@google.com>
 <20190820025056.GL28441@linux.ibm.com>
 <20190821002705.GA212946@google.com>
 <20190821003132.GA25611@google.com>
 <20190821004436.GB28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821004436.GB28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:44:36PM -0700, Paul E. McKenney wrote:
> On Tue, Aug 20, 2019 at 08:31:32PM -0400, Joel Fernandes wrote:
> > On Tue, Aug 20, 2019 at 08:27:05PM -0400, Joel Fernandes wrote:
> > [snip]
> > > > > > Or is the idea to time the kfree_rcu() loop separately?  (I don't see
> > > > > > any such separate timing, though.)
> > > > > 
> > > > > The kmalloc() times are included within the kfree loop. The timing of
> > > > > kfree_rcu() is not separate in my patch.
> > > > 
> > > > You lost me on this one.  What happens when you just interleave the
> > > > kmalloc() and kfree_rcu(), without looping, compared to the looping
> > > > above?  Does this get more expensive?  Cheaper?  More vulnerable to OOM?
> > > > Something else?
> > > 
> > > You mean pairing a single kmalloc() with a single kfree_rcu() and doing this
> > > several times? The results are very similar to doing kfree_alloc_num
> > > kmalloc()s, then do kfree_alloc_num kfree_rcu()s; and repeat the whole thing
> > > kfree_loops times (as done by this rcuperf patch we are reviewing).
> > > 
> > > Following are some numbers. One change is the case where we are not at all
> > > batching does seem to complete even faster when we fully interleave kmalloc()
> > > with kfree() while the case of batching in the same scenario completes at the
> > > same time as did the "not fully interleaved" scenario. However, the grace
> > > period reduction improvements and the chances of OOM'ing are pretty much the
> > > same in either case.
> > [snip]
> > > Not fully interleaved: do kfree_alloc_num kmallocs, then do kfree_alloc_num kfree_rcu()s. And repeat this kfree_loops times.
> > > =======================
> > > (1) Batching
> > > rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=0 rcuperf.kfree_rcu_test=1
> > > 
> > > root@(none):/# free -m
> > >               total        used        free      shared  buff/cache   available
> > > Mem:            977         251         686           0          39         684
> > > Swap:             0           0           0
> > > 
> > > [   15.574402] Total time taken by all kfree'ers: 14185970787 ns, loops: 20000, batches: 1548
> > > 
> > > (2) No Batching
> > > rcuperf.kfree_loops=20000 rcuperf.kfree_alloc_num=8000 rcuperf.kfree_no_batch=1 rcuperf.kfree_rcu_test=1
> > > 
> > > root@(none):/# free -m
> > >               total        used        free      shared  buff/cache   available
> > > Mem:            977          82         855           0          39         853
> > > Swap:             0           0           0
> > > 
> > > [   13.724554] Total time taken by all kfree'ers: 12246217291 ns, loops: 20000, batches: 7262
> > 
> > And the diff for changing the test to do this case is as follows (I don't
> > plan to fold this diff in, since I feel the existing test suffices and
> > results are similar):
> 
> But why not?  It does look to be a nice simplification, after all.

That's true. Ok, I'll squash it in. thanks!

thanks,

 - Joel
[snip]
