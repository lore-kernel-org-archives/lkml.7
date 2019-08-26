Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54476C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253C22080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd/F/MZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfHZIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:34:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfHZIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:34:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so14625105wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 01:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YW/Jo817XWr8MI8HTBn2UtIsjb8vIOn9fZasMixVQ+8=;
        b=Xd/F/MZ17KqMjt1etIGDAkP4wvnI3KJfYP7vC0p9r1UjthPJHHOKH46q/JqkW37nCg
         ecSH2+KNOS4EiAcBsTDXCM6eWl+rOiNrgcnaP0rMKB2ZjvYS1ThMVpcQ4jgG/V+peHQx
         cEg3Wmcl6mgM+g2AgL+tTkr2SAgo7Rc+N+voRgzGWvJ8pupOWFj84Rg7F3uA64XRIwNa
         yWJQnAeqAxg206tg8j95Udxt80x4kRJvuN0l6ixFYaHTHvwiMCH6wulbA3QBm5uZbDBJ
         jgptNOL8XjYdHIYkNjFJusetrtEqNVOpr7gduJUDJ7gwmip8lEYhkcAglI09BsD97b06
         UjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YW/Jo817XWr8MI8HTBn2UtIsjb8vIOn9fZasMixVQ+8=;
        b=R89w5940YkvZSBxAGjGChlKUtjSlJNawSn8OPxUfLwi8aLrLKoycLYd1ffzn0L4+ct
         T1oyEVzfdV5ru5Kd2hblqwUkq5gNxeyp1wp1n5ENriGlW13vEumVzV8uBZLfpnNZGLYu
         st7sl3tjIfzjHqSipcjaGWzQybmXhiG+TXgeiFAHmPspmqCCwr+Yo1z93+kLI0jxF8tF
         RXgV+ektmjs6P3JLzH5VTHwvlIM5Ps+QXD3BRdBLo5YDSuvy0HpJ3JJYXmj/s+tGD7Lw
         G0u7PMC9909j1vdQgcBi5isSyUr42zkiNSMsfjJ9bKfTnYf8ylGuFNQsR296Vfeez6PT
         XMZw==
X-Gm-Message-State: APjAAAWie+cTdMlQ9sGyOJa4ITAZjrW/PNkwW8KyCRaAE/kZyAigV0KV
        TG95lCty4H/kxDhI4z/NxAM=
X-Google-Smtp-Source: APXvYqxcCZJHrCCpPZYcvRI5fuVrN34C4axkkLwD4m2nyjFjXfjgonKa/aYmg/ihsaygQCy/wIO14g==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr21512730wmf.161.1566808483252;
        Mon, 26 Aug 2019 01:34:43 -0700 (PDT)
Received: from andrea ([167.220.197.36])
        by smtp.gmail.com with ESMTPSA id d207sm11115277wmd.0.2019.08.26.01.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 01:34:42 -0700 (PDT)
Date:   Mon, 26 Aug 2019 10:34:36 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: numlist_push() barriers Re: [RFC PATCH v4 1/9] printk-rb: add a
 new printk ringbuffer implementation
Message-ID: <20190826083436.GA3047@andrea>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823092109.doduc36avylm5cds@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/*
> > +	 * bA:
> > +	 *
> > +	 * Setup the node to be a list terminator: next_id == id.
> > +	 */
> > +	WRITE_ONCE(n->next_id, id);
> 
> Do we need WRITE_ONCE() here?
> Both "n" and "id" are given as parameters and do not change.
> The assigment must be done before "id" is set as nl->head_id.
> The ordering is enforced by cmpxchg_release().

(Disclaimer: this is still a very much debated issue...)

According to the LKMM, this question boils down to the question:

  Is there "ordering"/synchronization between the above access and
  the "matching accesses" bF and aA' to the same location?

Again according to the LKMM's analysis, such synchronization is provided
by the RELEASE -> "reads-from" -> ADDR relation.  (Encoding address dep.
in litmus tests is kind of tricky but possible, e.g., for the pattern in
question, we could write/model as follows:

C S+ponarelease+addroncena

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

	r0 = READ_ONCE(*y);
	*r0 = 1;
}

exists (1:r0=x /\ x=2)

Then

  $ herd7 -conf linux-kernel.cfg S+ponarelease+addroncena
  Test S+ponarelease+addroncena Allowed
  States 2
  1:r0=a; x=2;
  1:r0=x; x=1;
  No
  Witnesses
  Positive: 0 Negative: 2
  Condition exists (1:r0=x /\ x=2)
  Observation S+ponarelease+addroncena Never 0 2
  Time S+ponarelease+addroncena 0.01
  Hash=7eaf7b5e95419a3c352d7fd50b9cd0d5

that is, the test is not racy and the "exists" clause is not satisfiable
in the LKMM.  Notice that _if the READ_ONCE(*y) in P1 were replaced by a
plain read, then we would obtain:

  Test S+ponarelease+addrnana Allowed
  States 2
  1:r0=x; x=1;
  1:r0=x; x=2;
  Ok
  Witnesses
  Positive: 1 Negative: 1
  Flag data-race		[ <-- the LKMM warns about a data-race ]
  Condition exists (1:r0=x /\ x=2)
  Observation S+ponarelease+addrnana Sometimes 1 1
  Time S+ponarelease+addrnana 0.00
  Hash=a61acf2e8e51c2129d33ddf5e4c76a49

N.B. This analysis generally depends on the assumption that every marked
access (e.g., the cmpxchg_release() called out above and the READ_ONCE()
heading the address dependencies) are _single-copy atomic, an assumption
which has been recently shown to _not be valid in such generality:

  https://lkml.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck

(Bug in the LKMM? or in the Linux implementation of these primitives? or
in the compiler? your blame here...)


[...]

> > +		/*
> > +		 * bD:
> > +		 *
> > +		 * Set @seq to +1 of @seq from the previous head.
> > +		 *
> > +		 * Memory barrier involvement:
> > +		 *
> > +		 * If bB reads from bE, then bC->aA reads from bD.
> > +		 *
> > +		 * Relies on:
> > +		 *
> > +		 * RELEASE from bD to bE
> > +		 *    matching
> > +		 * ADDRESS DEP. from bB to bC->aA
> > +		 */
> > +		WRITE_ONCE(n->seq, seq + 1);
> 
> Do we really need WRITE_ONCE() here? 
> It is the same problem as with setting n->next_id above.

Same considerations as above would apply here.

  Andrea
