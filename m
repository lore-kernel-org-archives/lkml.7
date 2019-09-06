Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F00C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A5B21848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lxuHvaTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfIFVRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:17:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40362 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388050AbfIFVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:17:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so8834066qtq.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KH2KM3AxaNxDfikJW3s2OI5HLlEQIpgR2HO2RNdIwJQ=;
        b=lxuHvaTgGzySasvfmE+zrfBd04thDMbIuR5Ckmjnj0FASAFn3jzKRQkkMniznIHGuu
         HnvEB7JQQCYNEFYZcarpvD2SN6lVyaZMk3/7+08Bneq+FJcf21D2d85fkp3qc2eRI8Nv
         CS6bgUREEMFD5bcPzZKrzqRRoZwjMHTHGH6C5acZA0DNK6933vsozwjNvo4F6K6nlbD/
         ozB4KgdnDvHu+o6VfENxQTvLiXXfdhojPqmes3QqFXmfjzNFOOViIB3llNkhDWnEf0qJ
         EE3R4b0NMI4faEF6LHZjCG2cCCATP/GcjlWYmiIVLOlufKCGvpIVx0XybdceTvGBpLWr
         1Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH2KM3AxaNxDfikJW3s2OI5HLlEQIpgR2HO2RNdIwJQ=;
        b=CBexlh2tQhUNVoBxfMDl84I3VLn/Ko5uNY8gjDnZ192U1NU78PbTaesIgECm17yHyu
         9B0919vUYy+FIbH9VNmXErpnu99B4T/4uI9QSEL8LPRfIOFb5P1+LS9CGIUPqIanF/yO
         sEcvwqtjNwlbSUuWzdrz8E+3+OPV+rL8e/CoGBImMf51lJNZG0c02EjAIJxodqXwx0U7
         daHUa37rj5wfwdH9L57vlvqVFNJBXAJMPRAfMDe5QG5kOqhlpxUH3Ue2tgVjZ5rGiv8g
         MgLOyuR1jGOQeE8+b7HWrdzrDa58vmp7sT7+zrZtp8NyW5y4YcQEeStvMdwb1KOcN9ep
         Z3Yg==
X-Gm-Message-State: APjAAAXGHaOa0GflVyfS8rmJE5sDB3HWMU3w+FSg9Wb8hTUnOxsl3vQ5
        gNknTAniuB7UogJdU+mwCq9v9A==
X-Google-Smtp-Source: APXvYqykWMJGC4WBJ7KYNk5n5eG2BjjJPxU8wawDh2GhocFTjSs4UJhyG5sFCP6hwBG0GPPCx3q5YQ==
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr11412578qta.335.1567804654971;
        Fri, 06 Sep 2019 14:17:34 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x33sm1049112qtd.79.2019.09.06.14.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 14:17:34 -0700 (PDT)
Message-ID: <1567804651.5576.114.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 06 Sep 2019 17:17:31 -0400
In-Reply-To: <20190906043224.GA18163@jagdpanzerIV>
References: <20190904061501.GB3838@dhcp22.suse.cz>
         <20190904064144.GA5487@jagdpanzerIV> <20190904065455.GE3838@dhcp22.suse.cz>
         <20190904071911.GB11968@jagdpanzerIV> <20190904074312.GA25744@jagdpanzerIV>
         <1567599263.5576.72.camel@lca.pw>
         <20190904144850.GA8296@tigerII.localdomain>
         <1567629737.5576.87.camel@lca.pw> <20190905113208.GA521@jagdpanzerIV>
         <1567699393.5576.96.camel@lca.pw> <20190906043224.GA18163@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-06 at 13:32 +0900, Sergey Senozhatsky wrote:
> On (09/05/19 12:03), Qian Cai wrote:
> > > ---
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index cd51aa7d08a9..89cb47882254 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2027,8 +2027,11 @@ asmlinkage int vprintk_emit(int facility, int level,
> > >  	pending_output = (curr_log_seq != log_next_seq);
> > >  	logbuf_unlock_irqrestore(flags);
> > >  
> > > +	if (!pending_output)
> > > +		return printed_len;
> > > +
> > >  	/* If called from the scheduler, we can not call up(). */
> > > -	if (!in_sched && pending_output) {
> > > +	if (!in_sched) {
> > >  		/*
> > >  		 * Disable preemption to avoid being preempted while holding
> > >  		 * console_sem which would prevent anyone from printing to
> > > @@ -2043,10 +2046,11 @@ asmlinkage int vprintk_emit(int facility, int level,
> > >  		if (console_trylock_spinning())
> > >  			console_unlock();
> > >  		preempt_enable();
> > > -	}
> > >  
> > > -	if (pending_output)
> > > +		wake_up_interruptible(&log_wait);
> > > +	} else {
> > >  		wake_up_klogd();
> > > +	}
> > >  	return printed_len;
> > >  }
> > >  EXPORT_SYMBOL(vprintk_emit);
> > > ---
> 
> Qian Cai, any chance you can test that patch?

So far as good, but it is hard to tell if this really nail the issue down. I'll
leave it running over the weekend and report back if it occurs again.
