Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B43C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED02173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 14:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbM8IWYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395258AbfHWO1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 10:27:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40625 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbfHWO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 10:27:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so8811463wrd.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHvSmoSmDvSNNSbRGXLQshanw3+uRXJ2ONHrn0tkDQw=;
        b=FbM8IWYZ48uigQRt74quaG0kgIsk63LbOofdZ7aZ/X3GPHw9i9wE8vAFm+8UOr4HTH
         inTl5+HR2mSHUBimT06Tj+Votem5Mnyi3Rg+n4wVW0XAiM7kBBkCvW+UPqG/6t2YXfNz
         Lqajld73G2hYvdl4tBzYPY0czexNPhw6iOPiy9dlydQJD4C5gBh3jaZxkHkB770BEk7A
         0zyspsIsNB3Uw93jTqgWRG9Q+3tP2Cd18IfmuZKtRkPWp6c6BzCeuVgppDQzkrlqzqJV
         ZhT+Yltq0PJl5dShimADgOXbcirLgeLpp5wjDN7ZhczER0MaVTE2NFNvVJvTHQn4dZUr
         c7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHvSmoSmDvSNNSbRGXLQshanw3+uRXJ2ONHrn0tkDQw=;
        b=dZhwsFZFGnsGdP6XFelIBV7x2VsDi5FIxasThjjFCeT7cJ5hKSDWjKKcMR0Ib/nVnr
         BrtmT5xlm5tVQDnpNiCWLWd8htAAyBDk73FMknmUmT+uliPINF3DbIQLHbK0nuN7eYn0
         0/BwqnDpqiu9ANT3COKb1RHDJpy+Prn2voTJiOQ4wYSbKgNwl7rK0mwHql2ub5oSYeYt
         NGezBA7TMI4cCAXL5QrRyKw9D5TFmoIxZvfaTcw+Yc8TZN8vScM0PKb4GXxBjXWx/6KY
         aoU3BuQnO64wEMm6r2J30jXu9JDrn6Vs6uAY3FrJ0TXVv0zQmzVBUDpZ/oMwc7fCFw0r
         d0JA==
X-Gm-Message-State: APjAAAUxZ5RzS7SkNt/WSC/h7PFy0sMde96p2Z87wxtuuNBiaUknvdGj
        9dMipZS3wTEcUZAabu9qHb8=
X-Google-Smtp-Source: APXvYqzoHLcPGI5/I3s5TfP34APAeTrtIVfTwQ2dZtv9Cb2F7V2w5S+w8XJjF7009QdBgdTq5D3dbA==
X-Received: by 2002:adf:f206:: with SMTP id p6mr5788787wro.216.1566570440610;
        Fri, 23 Aug 2019 07:27:20 -0700 (PDT)
Received: from andrea ([167.220.196.36])
        by smtp.gmail.com with ESMTPSA id h23sm4368017wml.43.2019.08.23.07.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 07:27:19 -0700 (PDT)
Date:   Fri, 23 Aug 2019 16:27:08 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190823142708.GA2068@andrea>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <20190820092731.GA14137@jagdpanzerIV>
 <87a7c3f4uj.fsf@linutronix.de>
 <20190822135052.dp4dvav6fy2ajzkx@pathway.suse.cz>
 <20190822173801.GA2218@andrea>
 <20190823104713.mtxarc3ywtnryd2d@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823104713.mtxarc3ywtnryd2d@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not suggesting to remove all comments. Some human readable
> explanation is important as long as the code is developed by humans.
> 
> I think that I'll have to accept also the extra comments if you are
> really going to use them to check the consistency by a tool. Or
> if they are really used for review by some people.

Glad to hear this.  Thank you, Petr.


> Do all this manuals, tools, people use any common syntax, please?
> Would it be usable in our case as well?
> 
> I would like to avoid reinventing the wheel. Also I do not want
> to create a dialect for few people that other potentially interested
> parties will not understand.

Right; I think that terms such as "(barrier) matching", "reads-from"
and "overwrites" are commonly used to refer to litmus tests.  (The
various primitives/instructions are of course specific to the given
context: the language, the memory model, etc. )

IOW, I'd say that that wheel _and a common denominator here can be
represented by the notion of "litmus test".  I'm not suggesting to
reinvent this wheel of course; my point was more along the lines of
"let's use the wheel, it'll be helpful..."  ;-)

  Andrea
