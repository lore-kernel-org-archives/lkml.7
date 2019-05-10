Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C043C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA63217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e0ZX4Jpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfEJGcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:32:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50234 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfEJGcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:32:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so619275wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5aFXxfy77Ic34QWQ5GyVYlUA7W7TfPuD7q4ka2XVqr0=;
        b=e0ZX4JpibBrisiBzW5fDSI4DF9+D/cUR4XX40zQgHn7PJLeRee2ODl9CwEjegfnu9Q
         S3E0LdTX5shnBKw/c5Uvb4WINrFHwLJy3KkmhKVZvq6yU7IDY3QbdcKrakU+MYmCLLwu
         /3aGbM8Iv4b3eVJCtzHKm7132wqfzhzpibwlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5aFXxfy77Ic34QWQ5GyVYlUA7W7TfPuD7q4ka2XVqr0=;
        b=VB7MdQmZoc3uJytEY47DwbzewkjahM0vIQq+r+mknl66QOSHHZHuDoHS8Hlbu2Wi9w
         vZZR7FarqRNGCg6JfYROXUoJKmhu5awX1vTGpqH9twP64gdZLoM2gU1WcdFQGHMWPG4d
         Ycx+QfXbMicdnyVFKhln4hKccgWmMprL3Imeqpwk/7pYAJn3d6ACjsW2OjGVcHWzIHYU
         3ILQU/EK91jvG44bUQVoCM38cFVB8BlEHmorrFU5WZ3Yp7AimCGRZnYnMFJ85fmSdIRu
         iKu04L1QcYTpuqLi2zdZabLI3WRTbgO957GT5jYOXeubOCDtJMun+XV1rG/yG7O4PFaw
         /tJA==
X-Gm-Message-State: APjAAAVSrb45Vs4coP+angW5EVnfbQmpxH3jGHAs29vs84Yk5pnkm3/N
        u6LiREF/2reO3JXbKr2j8b92Qw==
X-Google-Smtp-Source: APXvYqzy1xJJdTFH2o8HtuPJUDy8LO0XXT9dLr9SIccg7b0Y35dFsFQf2Gz0PeZb1/AqBFwhYfn+xw==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr5509469wmf.132.1557469961097;
        Thu, 09 May 2019 23:32:41 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id f2sm10470036wmh.3.2019.05.09.23.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 23:32:40 -0700 (PDT)
Date:   Fri, 10 May 2019 08:32:34 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190510063234.GA4865@andrea>
References: <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509214025.GA5385@andrea>
 <20190509215505.GB5820@andrea>
 <20190509221730.GM3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509221730.GM3923@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Adding some "sched" folks in Cc: hopefully, they can shed some light
> > > about this.
> > 
> > +Thomas, +Sebastian
> > 
> > Thread starts here:
> > 
> > http://lkml.kernel.org/r/20190427180246.GA15502@linux.ibm.com
> 
> Peter Zijlstra kindly volunteered over IRC to look at this more closely
> tomorrow (well, today, his time).  It is quite strange, though!  ;-)

Sounds good!  ;-)

Thanx,
  Andrea
