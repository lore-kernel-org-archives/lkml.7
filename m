Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72276C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E282220883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JeKVTZ6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDIBgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:36:31 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44557 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfDIBgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:36:31 -0400
Received: by mail-pg1-f182.google.com with SMTP id i2so8304973pgj.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 18:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MlsT9tOGZ2BXFxxEd8ABFVkuey5JJzy4naMf4YJabpY=;
        b=JeKVTZ6xNBJDl68tRoD8BANJBconB58a3lH69tJq3hhnLOWMZDT2FplobGhmTUPXkw
         uVksAcR6aXKWGtIRBppayNfW8//FiJuagerUeFF+7fontezlvjSgNFNWY/vouyUwK+ZJ
         Exmlabism4Jm/oiIsQwek2kgnmxHyiD2oWS6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MlsT9tOGZ2BXFxxEd8ABFVkuey5JJzy4naMf4YJabpY=;
        b=AgjBQbPPTCP+jtgC+j38nFDZ3Xgr2D8bhFxuq7oaegovo3YqoWKmsR07w8NS6N2b4I
         1brjCmsj54oQ27bYWfQI4WYS78ZwkWpN45N/lBoL+jxWLnF6X19PFDAagulB09Mar0X/
         wy4t7At+Afevn9vgqCIGPwIoAvi9AsIZOX/E+SqgOM2twphhRDrP3smSFxU/3ckmRuro
         H0Y5p1CS143R0je1ruKnQ/6DVhU00wNgPqUhrVpbdJTptXr/vCuuX5eK3cnimMatoh80
         uu2PTroibvO118OOtinf+KQbuzRjGFmtj+WU18Wyg3tsKz40cs8kqrVvRY3npEkrxTKt
         yL9g==
X-Gm-Message-State: APjAAAUUKEc4UqWcJ1DsuVXSrPhm6XzPFn/17Xb1vlFnZg2foYx57eq1
        2GEAVq84jfIRC6YRLPSQ8TB3FA==
X-Google-Smtp-Source: APXvYqzJEbj5oWK+RIii+lbFCerjsj+dqepP8qX79/aayZulHAakPIJ1QvfRQTHrIZXksI0d2M7cEQ==
X-Received: by 2002:a65:6489:: with SMTP id e9mr31457965pgv.364.1554773790202;
        Mon, 08 Apr 2019 18:36:30 -0700 (PDT)
Received: from andrea ([63.64.74.251])
        by smtp.gmail.com with ESMTPSA id c189sm48181257pfg.24.2019.04.08.18.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 18:36:29 -0700 (PDT)
Date:   Tue, 9 Apr 2019 03:36:18 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
Message-ID: <20190409013618.GA3824@andrea>
References: <20190408055117.GA25135@andrea>
 <Pine.LNX.4.44L0.1904081010090.1440-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904081010090.1440-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The formula was more along the line of "do not assume either of these
> > cases to hold; use barrier() is you need an unconditional barrier..."
> > AFAICT, all current implementations of smp_mb__{before,after}_atomic()
> > provides a compiler barrier with either barrier() or "memory" clobber.
> 
> Well, we have two reasonable choices: Say that 
> smp_mb__{before,after}_atomic will always provide a compiler barrier, 
> or don't say this.  I see no point in saying that the combination of 
> Before-atomic followed by RMW provides a barrier.

;-/ I'm fine with the first choice. I don't see how the second choice
(this proposal/patch) would be consistent with some documentation and
with the current implementations; for example,

1) Documentation/atomic_t.txt says:

Thus:

  atomic_fetch_add();

is equivalent to:

  smp_mb__before_atomic();
  atomic_fetch_add_relaxed();
  smp_mb__after_atomic();

[...]

2) Some implementations of the _relaxed() variants do not provide any
compiler barrier currently.

  Andrea
