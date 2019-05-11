Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED40C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1D4217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 21:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BdtQOkaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEKVpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 17:45:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 17:45:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so1296385wrq.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PPBGZkBoQo3Ukc85VDhfZeXzhApaOOcUc2m8QXSsq3Q=;
        b=BdtQOkaYnoAFy22dv+qrBSLmW3PUjkU/CFTnc3YG8/29yPpqaoX0EIKu7kcBZIJpnU
         3C+SqvRVMrl3x9puWWU94sAdFwW9rVE2ILksZY780tsnWfUJghwcZlaW3HpzAqvrvvhO
         UQp78xNTYidqyrNCzk8qmyjmzuN97i5qkMqUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PPBGZkBoQo3Ukc85VDhfZeXzhApaOOcUc2m8QXSsq3Q=;
        b=bV/8P95cNDsZ0/Bu9S9rGUp1u1Hdj86nAgd4nifJxSc7W5/JqNOA/JuaVGQI5Fr7eW
         eRyfQFSqu8UhOwfv1enUTuepbpLLIqqKt21eim2/cowBzHbGmVp2eBNXxafY5palynMo
         7G2+Lnuia1KWj1t+HaSs7cfZUQq0Mxj7oh0lJHJ0rokxf+RTgzKsHiPxxwp+jNnZElnQ
         rUuJjv1u73sq9MUUuRVF8StaBfmtzr48TdsS3vTChmPUGSBqbKDWN9qLuKMBT4XvI7Px
         2QqZpjZMJpovby7YhQb7GdcUd5cANa0itZ76r672qFspJTbj4gCex3/O+jnvNfgk9RRp
         bojQ==
X-Gm-Message-State: APjAAAUKQPa8zROnBf/qnKr+h2SNOftq7SOe+cA8q3+D6rdsK2mvZ6Ln
        dGo/bU/WSLxLISXhQdj+s0frRA==
X-Google-Smtp-Source: APXvYqyWpxql6Ydh91GFk5ZwhNDajUu3C6mPZiyE4ur8CDdVGlyqt4DOADmT05wNsx5HS3s/R8ZwVw==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr11894162wrx.136.1557611130178;
        Sat, 11 May 2019 14:45:30 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id o16sm8236649wro.63.2019.05.11.14.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 14:45:29 -0700 (PDT)
Date:   Sat, 11 May 2019 23:45:20 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>, joelaf@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190511214520.GA3251@andrea>
References: <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
 <20190510120819.GR2589@hirez.programming.kicks-ass.net>
 <20190510230742.GY3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510230742.GY3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The below trace explain the issue. Some Paul person did it, see below.
> > It's broken per construction :-)
> 
> *facepalm*  Hence the very strange ->cpus_allowed mask.  I really
> should have figured that one out.
> 
> The fix is straightforward.  I just added "rcutorture.shuffle_interval=0"
> to the TRIVIAL.boot file, which stops rcutorture from shuffling its
> kthreads around.

I added the option to the file and I didn't reproduce the issue.


> Please accept my apologies for the hassle, and thank you for tracking
> this down!!!

Peter (echoing Paul):  Thank you for pointing that shuffler out!

  Andrea
