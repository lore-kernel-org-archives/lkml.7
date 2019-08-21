Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1206C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E4322D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FvOJljDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfHUTDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:03:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38768 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfHUTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:03:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id o70so2033718pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JFQEqMXiHoOXFmfgJoDBfu82dbaZ9sv4TW7nsXwUw5o=;
        b=FvOJljDT+DhzXONemiuiRBuI25xz7IPoozAtQwv7flCDgAaW2KYnrHEjvXXOSkvNye
         XfJnMByk8CYDZ2kpXYbVrQ6GqEX8fec3bXfaZWPc8e/6T9wjKTCco7ycdVPbMjA9Rf0Z
         57/G7SBYImn+BOzo6dRwFyaXgyDenjG8TC5y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFQEqMXiHoOXFmfgJoDBfu82dbaZ9sv4TW7nsXwUw5o=;
        b=bxBdj/LdLgMTlFY3mcZoR8TsSNu7/8K0NrJi127d2/YH5LWPSr27x+P9yOIUw6wBOv
         YuvdKZcBeKKYIGUWgcwa77TDZZ+mYaVVoq93xa7RbEUWlH42Eoswc+EjfDM/F056EKU8
         pDKdtDGy55mZEGNyNkZSGS3L9MnXMXUMi8LsRyV+FlIcxk+XMk+1jTj80ieKaypNpF4t
         ptFkS7d53TCRpTwMEUQn4Ovw7/nWKZRQ+BroeneemKR9AJn+ecq4zOTT2Mbq7NIdO66A
         CxuwYC8xBaMRBghOPe2z+cnGrKQ1r+aNRi0nH8glR6UK8EIcnQ7ZjmAeJ6qSn1ZPcZXX
         69fg==
X-Gm-Message-State: APjAAAUXWiE3Yx071/4NNCYDvl3fps75mktO7laIsh+iVh1qU9zxg30m
        0Wsg8X7oSmCsYt+EIqAqIWH5Ig==
X-Google-Smtp-Source: APXvYqydKEytctc0ry70dhpI5Zsq3I+NWD57aezyMs0hej/M0aBJRFLsZORDdgd4+9ayXviH3KsZNw==
X-Received: by 2002:a62:26c4:: with SMTP id m187mr38407322pfm.49.1566414228909;
        Wed, 21 Aug 2019 12:03:48 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id s24sm21898805pgm.3.2019.08.21.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 12:03:48 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:03:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190821190331.GA113711@google.com>
References: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
 <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
 <20190821132310.GC28441@linux.ibm.com>
 <20190821153325.GD2349@hirez.programming.kicks-ass.net>
 <52600272.1909.1566402523680.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52600272.1909.1566402523680.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:48:43AM -0400, Mathieu Desnoyers wrote:
> ----- On Aug 21, 2019, at 8:33 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Wed, Aug 21, 2019 at 06:23:10AM -0700, Paul E. McKenney wrote:
> >> On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:
> > 
> >> > and so it is using a store-pair instruction to reduce the complexity in
> >> > the immediate generation. Thus, the 64-bit store will only have 32-bit
> >> > atomicity. In fact, this is scary because if I change bar to:
> >> > 
> >> > void bar(u64 *x)
> >> > {
> >> > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> >> > }
> >> > 
> >> > then I get:
> >> > 
> >> > bar:
> >> > 	mov	w1, 61200
> >> > 	movk	w1, 0xabcd, lsl 16
> >> > 	str	w1, [x0]
> >> > 	str	w1, [x0, 4]
> >> > 	ret
> >> > 
> >> > so I'm not sure that WRITE_ONCE would even help :/
> >> 
> >> Well, I can have the LWN article cite your email, then.  So thank you
> >> very much!
> >> 
> >> Is generation of this code for a 64-bit volatile store considered a bug?
> >> Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
> >> would guess that Thomas and Linus would ask a similar bugginess question
> >> for normal stores.  ;-)
> > 
> > I'm calling this a compiler bug; the way I understand volatile this is
> > very much against the intentended use case. That is, this is buggy even
> > on UP vs signals or MMIO.
> 
> And here is a simpler reproducer on my gcc-8.3.0 (aarch64) compiled with O2:
> 
> volatile unsigned long a;
>  
> void fct(void)
> {
>         a = 0x1234567812345678ULL;
> }
> 
> void fct(void)
> {
>         a = 0x1234567812345678ULL;
>    0:   90000000        adrp    x0, 8 <fct+0x8>
>    4:   528acf01        mov     w1, #0x5678                     // #22136
>    8:   72a24681        movk    w1, #0x1234, lsl #16
>    c:   f9400000        ldr     x0, [x0]
>   10:   b9000001        str     w1, [x0]
>   14:   b9000401        str     w1, [x0, #4]
> }
>   18:   d65f03c0        ret

Fwiw, and, interestingly, on clang v7.0.1-8 (aarch64), I get a proper 64-bit
str with the above example (even when not using volatile):

0000000000000000 <nonvol>:
   0:	d28acf08 	mov	x8, #0x5678                	// #22136
   4:	f2a24688 	movk	x8, #0x1234, lsl #16
   8:	f2cacf08 	movk	x8, #0x5678, lsl #32
   c:	f2e24688 	movk	x8, #0x1234, lsl #48
  10:	90000009 	adrp	x9, 8 <nonvol+0x8>
  14:	91000129 	add	x9, x9, #0x0
  18:	f9000128 	str	x8, [x9]
  1c:	d65f03c0 	ret

test1.o:     file format elf64-littleaarch64


And even with -O2 it is a single store:

Disassembly of section .text:

0000000000000000 <nonvol>:
   0:	d28acf09 	mov	x9, #0x5678                	// #22136
   4:	f2a24689 	movk	x9, #0x1234, lsl #16
   8:	f2cacf09 	movk	x9, #0x5678, lsl #32
   c:	90000008 	adrp	x8, 8 <nonvol+0x8>
  10:	f2e24689 	movk	x9, #0x1234, lsl #48
  14:	f9000109 	str	x9, [x8]
  18:	d65f03c0 	ret

thanks,

 - Joel

[...]
