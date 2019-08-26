Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C482C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2689F20828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3OKeIj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfHZQBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:01:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37243 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731762AbfHZQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:01:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so15879628wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ncVLIgdViPhOQAa9P43ZL2WPAP3uw/peT9UUrCkcuDA=;
        b=R3OKeIj+SlV0mSN50pc6twLFfPARqeNA9UV4mEyaqIfWM/co72+YK6jE1+yDvFc437
         wsSMEIikTNZNYf+wxHnmFXMPL8CeftXeL6e0WwnWawQeekAa47gYaz9IHqNOiKBjZ0gU
         ej5Zqn+8+Ta36YP31jb4t9q2Ms7CtnuszrhmLEyQL5KLy/ZCZoSlrdBMCIlOB394yqz3
         EQS14j5Rv2Hn+y8AdTfvdI8J290SO2zyEaZHUwPeWfPLo8wbt1PPe/iGcTzqcWmia+q/
         SYpIcZO5Sc6VAggMSVbVaDpM9QoqwxhQ34j5wOjVMWZChgz24Az6Nt84W3jxfUV5vye4
         cUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ncVLIgdViPhOQAa9P43ZL2WPAP3uw/peT9UUrCkcuDA=;
        b=q+Umg8D0OZ8iUurhfUk0WKSvHakc29qFRtxYhFqQQS+kvZ7L5E3jJZmowcnv42Uw/n
         +bWoSSWz/zwRk5ImkNezrwmZQjnroldsaCtW3nUNJIF59ZucM2d3fnMIJAoq/F5Ce89o
         kjSMXsxEE18MpHxIr3gngwKJsagDWdHfVc+PZ4Fq56qsoTO+U3HV/w/TqOH7ECMG22UQ
         LJ0nv9qO1c+rL8e3jA2NdFII+E3dsDePBXfVObGfKCbIJRtPt+kDrMfqK+LaWbW+TIfC
         k1LohpTI3AxTxczLP6rVdZnsb4BOsgvBWF8pJsJgb9fAdbLoEDJ5M9OA7j7JgPOOaR7q
         dWOg==
X-Gm-Message-State: APjAAAXB4ynqhGuTuv3Rxpd+Szu1kTrQ8e2SuugoTKgl6YzWLDJFeccj
        QFJtFrOWlHaHlvcuWaR6lmE=
X-Google-Smtp-Source: APXvYqzKvIp/hDyc4V7bWtyOQ6puEyuWLlICsToMIUb748pfegxbT1hs3zPpRhB74KNCNRi0nIRVew==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr21676425wru.27.1566835280406;
        Mon, 26 Aug 2019 09:01:20 -0700 (PDT)
Received: from andrea ([167.220.196.36])
        by smtp.gmail.com with ESMTPSA id a18sm15085377wrt.18.2019.08.26.09.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 09:01:19 -0700 (PDT)
Date:   Mon, 26 Aug 2019 18:01:13 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190826160113.GA2062@andrea>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <20190826083436.GA3047@andrea>
 <20190826141058.y6idkqpjqkpbv5s7@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826141058.y6idkqpjqkpbv5s7@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > C S+ponarelease+addroncena
> > 
> > {
> > 	int *y = &a;
> > }
> > 
> > P0(int *x, int **y, int *a)
> > {
> > 	int *r0;
> > 
> > 	*x = 2;
> > 	r0 = cmpxchg_release(y, a, x);
> > }
> > 
> > P1(int *x, int **y)
> > {
> > 	int *r0;
> >
> > 	r0 = READ_ONCE(*y);
> > 	*r0 = 1;
> > }
> > 
> > exists (1:r0=x /\ x=2)
> 
> Which r0 the above exists rule refers to, please?
> Do both P0 and P1 define r0 by purpose?

"1:r0" is the value returned by the above READ_ONCE(*y), following the
convention [thread number]:[local variable]; but yes, I could probably
have saved you this question by picking a different name,  ;-)  sorry.


> 
> > Then
> > 
> >   $ herd7 -conf linux-kernel.cfg S+ponarelease+addroncena
> >   Test S+ponarelease+addroncena Allowed
> >   States 2
> >   1:r0=a; x=2;
> >   1:r0=x; x=1;
> >   No
> >   Witnesses
> >   Positive: 0 Negative: 2
> >   Condition exists (1:r0=x /\ x=2)
> >   Observation S+ponarelease+addroncena Never 0 2
> >   Time S+ponarelease+addroncena 0.01
> >   Hash=7eaf7b5e95419a3c352d7fd50b9cd0d5
> > 
> > that is, the test is not racy and the "exists" clause is not satisfiable
> > in the LKMM.  Notice that _if the READ_ONCE(*y) in P1 were replaced by a
> > plain read, then we would obtain:
> > 
> >   Test S+ponarelease+addrnana Allowed
> >   States 2
> >   1:r0=x; x=1;
> >   1:r0=x; x=2;
> 
> Do you have any explanation how r0=x; x=2; could happen, please?

I should have remarked: the states listed here lose their significance
when there is a data race: "data race" is LKMM's way of saying "I give
up, I'm unable to list all the reachable states; your call...".  ;-)

This example is "complicated", e.g., by the tearing of the plain read,
tearing which is envisaged/modelled by the LKMM: however, this tearing
doesn't explain the "1:r0=x; x=2;" state by itself, AFAICT.

Said this, I'm not sure how I copied this output...  For completeness,
I report the full/intended test at the bottom of my email.


> 
> Does the ommited READ_ONCE allows to do r0 = (*y) twice
> before and after *r0 = 1?
> Or the two operations P1 can be called in any order?
> 
> I am sorry if it obvious. Feel free to ask me to re-read Paul's
> articles on LWN more times or point me to another resources.
> 
> 
> 
> >   Ok
> >   Witnesses
> >   Positive: 1 Negative: 1
> >   Flag data-race		[ <-- the LKMM warns about a data-race ]
> >   Condition exists (1:r0=x /\ x=2)
> >   Observation S+ponarelease+addrnana Sometimes 1 1
> >   Time S+ponarelease+addrnana 0.00
> >   Hash=a61acf2e8e51c2129d33ddf5e4c76a49
> > 
> > N.B. This analysis generally depends on the assumption that every marked
> > access (e.g., the cmpxchg_release() called out above and the READ_ONCE()
> > heading the address dependencies) are _single-copy atomic, an assumption
> > which has been recently shown to _not be valid in such generality:
> > 
> >   https://lkml.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck
> 
> So, it might be even worse. Do I get it correctly?

Worse than I was hoping..., definitely!  ;-)

  Andrea

---
C S+ponarelease+addrnana

{
	int *y = &a;
}

P0(int *x, int **y, int *a)
{
	int *r0;

	*x = 2;
	r0 = cmpxchg_release(y, a, x);
}

P1(int *x, int **y)
{
	int *r0;

	r0 = *y;
	*r0 = 1;
}

exists (1:r0=x /\ x=2)
