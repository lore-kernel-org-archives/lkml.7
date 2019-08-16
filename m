Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F62EC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F01D2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="w2hQUmQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfHPU57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:57:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42815 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:57:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so3700994pfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 13:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BrykIQptEr5uG2ppILJEV/PA8/ETiDoByQ19l2TgJ8w=;
        b=w2hQUmQ2uCA4bsTeqtI4e/zAXtzZY+2GTQpvsj4kSYdNqKLA1cJCjyu3WSGdflzw8X
         zgs71DMZYr0B/6uDfrewd68czoxM+No49TBIG6SHn9jgHnRsZjoqwiYUVjwj6R99lV1+
         HecLABQVbF/pxL3j1+W4n2jB+0Dh3stE/rTcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BrykIQptEr5uG2ppILJEV/PA8/ETiDoByQ19l2TgJ8w=;
        b=RqvUdGo0SzDidHQ0RKkJeX4+jpwWcOLKSaEh2xp67fKPN6rh/w0kmsTlCYI5Gl78WS
         RiT/IvWg+IiTiYBzxqdcu2LQxEmrNDa5o1N36b2RjomdgMmjT/aVWpa113jbTyPGZwbE
         33fOMEo1V6IcBlN71/dRi2cFCWQ27kB//UjZs0rPUSUY/gO+t2LwYHa3mh1ulcUDjvsu
         BxTZA2bohkU7HPWKxmq7vJQFEOOfC66nfc0OytFZaYXyr4wfT7lsUzaEhonRxlxuiQio
         3VGa8+lhWcVpwqy1D9qz3o1bhitKKFfdTIX8x2YdzxXydS1v9n51OS3Q1FyKeBUHhPRE
         ld3g==
X-Gm-Message-State: APjAAAV1vaCVB9P0Z+YBWNXkgZq5fdhNIQfNxw8omXBrdMYERdb4CbIY
        d0e1UxeXQu480cUpt1twHqdsHA==
X-Google-Smtp-Source: APXvYqxUNi7/M11mZXT95oU4yvtDLnTar6+mooy+YNfIlqcgF9dPMY2CiEl/WsZQKmG+dyM9qhYcnw==
X-Received: by 2002:a65:4489:: with SMTP id l9mr9620185pgq.207.1565989077931;
        Fri, 16 Aug 2019 13:57:57 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id c13sm8110467pfi.17.2019.08.16.13.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 13:57:57 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:57:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816205740.GF10481@google.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:49:04PM +0200, Thomas Gleixner wrote:
> On Fri, 16 Aug 2019, Joel Fernandes wrote:
> > On Fri, Aug 16, 2019 at 3:19 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Fri, 16 Aug 2019, Mathieu Desnoyers wrote:
> > >
> > > > If you choose not to use READ_ONCE(), then the "load tearing" issue can
> > > > cause similar spurious 1 -> 0 -> 1 transitions near 16-bit counter
> > > > overflow as described above. The "Invented load" also becomes an issue,
> > > > because the compiler could use the loaded value for a branch, and re-load
> > > > that value between two branches which are expected to use the same value,
> > > > effectively generating a corrupted state.
> > > >
> > > > I think we need a statement about whether READ_ONCE/WRITE_ONCE should
> > > > be used in this kind of situation, or if we are fine dealing with the
> > > > awkward compiler side-effects when they will occur.
> > >
> > > The only real downside (apart from readability) of READ_ONCE and
> > > WRITE_ONCE is that they prevent the compiler from optimizing accesses
> > > to the location being read or written.  But if you're just doing a
> > > single access in each place, not multiple accesses, then there's
> > > nothing to optimize anyway.  So there's no real reason not to use
> > > READ_ONCE or WRITE_ONCE.
> > 
> > I am also more on the side of using *_ONCE. To me, by principal, I
> > would be willing to convert any concurrent plain access using _ONCE,
> > just so we don't have to worry about it now or in the future and also
> > documents the access.
> 
> By that argumentation we need to plaster half of the kernel with _ONCE()
> and I'm so not looking forward to the insane amount of script kiddies
> patches to do that.

Really? That is quite scary that you are saying half of the kernel has issues
with concurrent access or compiler optimizations. It scares me that a
concurrent access can tear down a store/load and existing code can just fail,
if that is the case.

> Can we finally put a foot down and tell compiler and standard committee
> people to stop this insanity?

Sure, or could the compilers provide flags which prevent such optimization
similar to -O* flags?

thanks,

 - Joel

