Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDE220874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOZRnjFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfHZIoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 04:44:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbfHZIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 04:44:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id q12so14420529wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nidiqI1b7ngU4d9qgdaSsGaBrrFTleHCTwLxwq6aAhE=;
        b=WOZRnjFQOtH6008beiJ4uwa3yYWNNqKMadj1NgD72vaVUjVYEQ37ypagRHzHt27GX9
         YKjRMx+Gm9vDzPscsrKhWX25qz5yyv+LaqucLktGFZQwpTjJFGg+SXXCvenEutDlPKfX
         LfnobYZQkhV23nomB3BcbIH64cbQaKYt2vH8RXMgegI3kYESSPpvURvN1rmHKyEHmegn
         /nUlzsTBfbUrM2KKe1qzDyB9Vjtny1vvJ8cKi76CjUR6m8Q+YzrYbAcORxSkEfozaPN+
         3+GkZFzRcjVuG0O+BSG6gsdT26nWb5+hwaCtZTN+ITZD98lGPdyukh5+C6vt/PpwzNvR
         2cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nidiqI1b7ngU4d9qgdaSsGaBrrFTleHCTwLxwq6aAhE=;
        b=kA/7vpC9C276EbPesHYTWK1JrkA0z1sIpe8mgmN8R+IyGOflvFsYnx028gjxXHbTUG
         b2txaaZ3+n4bXQDkAtnhbAQt+kCXYC7OC0nCj15G5jRphlfjsqu4xDlLRSFHNCACgzzK
         sPf+0EBufk70VtvvtDstuH5Z6liXWL9rAZcw6snLzrmVvMFKfzQg0ZUvcp45rxwHADhn
         bcusFbdxB4t5VHsTXQzIBFGG+rPsbD9aCBqNAzw6ldHundt07nKRsdMNNN3rRagctDNB
         DL6BF8uTrCaXUlrBieZIjviLwHa1KbTRiOg75VFk8hH6BOwrY4Kh3chuWNZ+d0/ms/ye
         FJtA==
X-Gm-Message-State: APjAAAVMFd+PlrcCoXcVZ/uSzUWFohtZqlBorNB5TlMa1VsRPuknU8kH
        ZRq/oP75OR0uqMufpnDfQe0=
X-Google-Smtp-Source: APXvYqyzqMCE+xAp883JpscsPlqviZkRuxQaouPJxth9Wxw0F91uAszEuKjruilDe/97fORiSyzZGg==
X-Received: by 2002:adf:ea87:: with SMTP id s7mr10866075wrm.256.1566809040942;
        Mon, 26 Aug 2019 01:44:00 -0700 (PDT)
Received: from andrea ([167.220.197.36])
        by smtp.gmail.com with ESMTPSA id t198sm14351462wmt.39.2019.08.26.01.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 01:44:00 -0700 (PDT)
Date:   Mon, 26 Aug 2019 10:43:52 +0200
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
Message-ID: <20190826084352.GA3989@andrea>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823092109.doduc36avylm5cds@pathway.suse.cz>
 <20190826083436.GA3047@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826083436.GA3047@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for top posting, but I forgot to mention: as you might have
noticed, my @amarulasolutions address is not active anymore; FWIW,
you should still be able to reach me at this @gmail address.

Thanks,
  Andrea


On Mon, Aug 26, 2019 at 10:34:36AM +0200, Andrea Parri wrote:
> > > +	/*
> > > +	 * bA:
> > > +	 *
> > > +	 * Setup the node to be a list terminator: next_id == id.
> > > +	 */
> > > +	WRITE_ONCE(n->next_id, id);
> > 
> > Do we need WRITE_ONCE() here?
> > Both "n" and "id" are given as parameters and do not change.
> > The assigment must be done before "id" is set as nl->head_id.
> > The ordering is enforced by cmpxchg_release().
> 
> (Disclaimer: this is still a very much debated issue...)
> 
> According to the LKMM, this question boils down to the question:
> 
>   Is there "ordering"/synchronization between the above access and
>   the "matching accesses" bF and aA' to the same location?
> 
> Again according to the LKMM's analysis, such synchronization is provided
> by the RELEASE -> "reads-from" -> ADDR relation.  (Encoding address dep.
> in litmus tests is kind of tricky but possible, e.g., for the pattern in
> question, we could write/model as follows:
> 
> C S+ponarelease+addroncena
> 
> {
> 	int *y = &a;
> }
> 
> P0(int *x, int **y, int *a)
> {
> 	int *r0;
> 
> 	*x = 2;
> 	r0 = cmpxchg_release(y, a, x);
> }
> 
> P1(int *x, int **y)
> {
> 	int *r0;
> 
> 	r0 = READ_ONCE(*y);
> 	*r0 = 1;
> }
> 
> exists (1:r0=x /\ x=2)
> 
> Then
> 
>   $ herd7 -conf linux-kernel.cfg S+ponarelease+addroncena
>   Test S+ponarelease+addroncena Allowed
>   States 2
>   1:r0=a; x=2;
>   1:r0=x; x=1;
>   No
>   Witnesses
>   Positive: 0 Negative: 2
>   Condition exists (1:r0=x /\ x=2)
>   Observation S+ponarelease+addroncena Never 0 2
>   Time S+ponarelease+addroncena 0.01
>   Hash=7eaf7b5e95419a3c352d7fd50b9cd0d5
> 
> that is, the test is not racy and the "exists" clause is not satisfiable
> in the LKMM.  Notice that _if the READ_ONCE(*y) in P1 were replaced by a
> plain read, then we would obtain:
> 
>   Test S+ponarelease+addrnana Allowed
>   States 2
>   1:r0=x; x=1;
>   1:r0=x; x=2;
>   Ok
>   Witnesses
>   Positive: 1 Negative: 1
>   Flag data-race		[ <-- the LKMM warns about a data-race ]
>   Condition exists (1:r0=x /\ x=2)
>   Observation S+ponarelease+addrnana Sometimes 1 1
>   Time S+ponarelease+addrnana 0.00
>   Hash=a61acf2e8e51c2129d33ddf5e4c76a49
> 
> N.B. This analysis generally depends on the assumption that every marked
> access (e.g., the cmpxchg_release() called out above and the READ_ONCE()
> heading the address dependencies) are _single-copy atomic, an assumption
> which has been recently shown to _not be valid in such generality:
> 
>   https://lkml.kernel.org/r/20190821103200.kpufwtviqhpbuv2n@willie-the-truck
> 
> (Bug in the LKMM? or in the Linux implementation of these primitives? or
> in the compiler? your blame here...)
> 
> 
> [...]
> 
> > > +		/*
> > > +		 * bD:
> > > +		 *
> > > +		 * Set @seq to +1 of @seq from the previous head.
> > > +		 *
> > > +		 * Memory barrier involvement:
> > > +		 *
> > > +		 * If bB reads from bE, then bC->aA reads from bD.
> > > +		 *
> > > +		 * Relies on:
> > > +		 *
> > > +		 * RELEASE from bD to bE
> > > +		 *    matching
> > > +		 * ADDRESS DEP. from bB to bC->aA
> > > +		 */
> > > +		WRITE_ONCE(n->seq, seq + 1);
> > 
> > Do we really need WRITE_ONCE() here? 
> > It is the same problem as with setting n->next_id above.
> 
> Same considerations as above would apply here.
> 
>   Andrea
