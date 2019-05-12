Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C68C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7B92183F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IvKuWLSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfELBFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:05:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfELBFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:05:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so11437166wro.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n/nF5HmPck3P16YwkGOhnRGMBRJSGU2dKOtRBHDyA3o=;
        b=IvKuWLStYVYoW4GCr8lFMa2+RcWSrJ8IaD+FQaW6W8ZtTM2Hvaki0QlHe08kT3hD61
         lwwegU29PQ5Bblyn5Gp9LZNOKE5f8UnB1x1VOMKn4YuEG4XkA+rnl0jELLue7MgybO0H
         83ytCg279vnSc/kuTSWbtrYazRTQTyXeTJFwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n/nF5HmPck3P16YwkGOhnRGMBRJSGU2dKOtRBHDyA3o=;
        b=RnpvevuguN/wEuAWh6I+N7vls1Nnhjco+0dOfFDvqid3nOVn8pbXtafhNvzsDXhnnM
         wXwXswpZbR+T+4zy1PckLQxHvo2Y3PTZddG1U54xL9gp+Pc/nNzByrNs6XNdSvEX/mF0
         VuWK7FeUnitkqgM7ust96uxdFppmee4AQnupjpmZOi2FuM0E5+qz3lT2sVnaiFHPx9WN
         FJCFbz+hLj6/AcUAgWqXHb0S59slDmaxfckYsEmvuMkZFCEmJqmmp9lAympQ/U7jI3w3
         KXTxm8CK9e6wrpzxauBDzaNNV+Csovs52K7e2f1hlWkAANsoY1MXiuXkI3cWXYpmUqPH
         66qg==
X-Gm-Message-State: APjAAAWnh+7EQ7WeIuZ8TuUH7/+j7ipSEL2f2p6SpwUTGPFBAHHWfi0w
        KWR+QgpS5UGUsFKH0r37yWRHrw==
X-Google-Smtp-Source: APXvYqxRM55WQBhbehlUAr02IW1oulvaR6GWjkopEgYnu5+3BMZephX7Za+FnggDnsJ/jtaI0Iz2Pg==
X-Received: by 2002:adf:fa4e:: with SMTP id y14mr176530wrr.149.1557623147859;
        Sat, 11 May 2019 18:05:47 -0700 (PDT)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id j10sm30488864wrb.0.2019.05.11.18.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:05:46 -0700 (PDT)
Date:   Sun, 12 May 2019 03:05:39 +0200
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
Message-ID: <20190512010539.GA8167@andrea>
References: <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
 <20190510120819.GR2589@hirez.programming.kicks-ass.net>
 <20190510230742.GY3923@linux.ibm.com>
 <20190511214520.GA3251@andrea>
 <20190512003915.GD3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512003915.GD3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The fix is straightforward.  I just added "rcutorture.shuffle_interval=0"
> > > to the TRIVIAL.boot file, which stops rcutorture from shuffling its
> > > kthreads around.
> > 
> > I added the option to the file and I didn't reproduce the issue.
> 
> Thank you!  May I add your Tested-by?

Please feel free to do so.  But it may be worth to squash "the commits"
(and adjust the changelogs accordingly).  And you might want to remove
some of those debug checks/prints?

  Andrea
