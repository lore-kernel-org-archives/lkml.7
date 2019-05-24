Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A28C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AF220851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vlce1W9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391459AbfEXL7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:59:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40431 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391289AbfEXL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:59:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so8923258wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ylCdvZjvw5YApJTYZtzD5E81VMyO184/XWz6sUowkYc=;
        b=Vlce1W9j2Ag36I5ChjwChL/0RfGbZ/S3espio/TnQWoNjhpycwPWfcZcuvtvVwMMRV
         dbqnmhKfwbA1mcdwbAHNZsF0tXXHV2GtA1cnof3zXGusROvX3DI+Gm7q7JD1s6CFV9mR
         y0OiPOYsWVzX4jkLhY91z9m7iM3CQ5bhQa8ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ylCdvZjvw5YApJTYZtzD5E81VMyO184/XWz6sUowkYc=;
        b=YaTjuTumofgcbDkN8S7Nw3/jlHJnXge3mpqAaqiHOdMCJucalJcLBvYeMuvrCzwmtQ
         NDXanG+Au+GPwD3Az23vRItMZWHHhhtL6XiuRaLn9thcCfckTrjRzQgbTVN45O1B5SRC
         BewOfg67vmjNNA4rkRfQ9elPcSQCCKpNxgW6iyUGzpHGjdwVF3KszOQGfM6bHT7aSGc+
         9roPYxpkV9aukbDVim/WF3itafVC67UhwPsdtZ8U1Rt69HZ25OsDe6YQJFWs2fXVGzLh
         /6ui0ANkNtRbjFFk3hyVYMTFxdD3G7fjUzP03UnXqBhw/DJu2DTbxvWmIoPYde+/csFR
         wQiA==
X-Gm-Message-State: APjAAAWBeWp/RGgH4Ib9iYqF/TTPfnr0q8uLMI/x0kedkGeWTfSKCtNo
        YM1vsV21BzNnntu3poTJONB9pA==
X-Google-Smtp-Source: APXvYqyI74qzxxv7ozq3We0Rv+V5cuSv4Hn0KidnLAc1LZBKaKle9t0O0Kl1/gwa/lGAY+Duqz4JDQ==
X-Received: by 2002:a1c:7303:: with SMTP id d3mr15466105wmb.119.1558699163047;
        Fri, 24 May 2019 04:59:23 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id j190sm2539268wmb.19.2019.05.24.04.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:59:22 -0700 (PDT)
Date:   Fri, 24 May 2019 13:59:20 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/2] vmw_vmci: Clean up uses of atomic*_set()
Message-ID: <20190524115920.GB21365@andrea>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558694136-19226-2-git-send-email-andrea.parri@amarulasolutions.com>
 <20190524103934.GO2606@hirez.programming.kicks-ass.net>
 <20190524114042.GA360@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524114042.GA360@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > All that should just die a horrible death. That code is crap.
> > 
> > See:
> > 
> >   lkml.kernel.org/r/20190524103731.GN2606@hirez.programming.kicks-ass.net
> 
> I agree, Peter's patch should be the thing that is applied, not this
> one.

Thanks for the confirmation, Greg.  I'll drop mine.

At this time, it's not clear to me where Peter's patch will be applied,
and where/whether I should rebase 2/2 (if there is interested in that):

Please let me know.

Thanks,
  Andrea
