Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA247C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF82214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDCTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:42:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:42:45 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBlmU-0007ql-Lj; Wed, 03 Apr 2019 21:42:42 +0200
Date:   Wed, 3 Apr 2019 21:42:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
In-Reply-To: <alpine.DEB.2.21.1904031823100.1967@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904032038500.1833@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de> <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de> <20190402154329.scp7i7uqevubgwrz@treble> <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <7789E14E-C623-4DB7-B076-76B931957C9C@amacapital.net> <alpine.DEB.2.21.1904022027170.1812@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904022127210.1812@nanos.tec.linutronix.de> <6205D576-694A-4C7D-B1B7-A9FF2E1F9E77@amacapital.net>
 <alpine.DEB.2.21.1904031823100.1967@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1964072614-1554316784=:1833"
Content-ID: <alpine.DEB.2.21.1904032040110.1833@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1964072614-1554316784=:1833
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1904032040111.1833@nanos.tec.linutronix.de>

On Wed, 3 Apr 2019, Thomas Gleixner wrote:
> On Tue, 2 Apr 2019, Andy Lutomirski wrote:
> > > On Apr 2, 2019, at 1:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>> How about a much better fix: make the DB stack be the same size as all
> > >>> the others and just have 4 of them (DB0, DB1, DB2, and DB3.  After all,
> > >>> overflowing from one debug stack into another is just as much of a bug as
> > >>> overflowing into a different IST stack.
> > >> 
> > >> That makes sense.
> > > 
> > > Except that we just have two not four.
> > > 
> > > It needs some tweaking of the ist_shift stuff in entry_64.S but that's not
> > > rocket science. Famous last words....
> > > 
> > 
> > The ist_shift mess should probably be in C, but that¢s a big can of
> > worms. That being said, why do we have it at all?  Once upon a time, we¢d
> > do ICEBP from user mode (or a legit breakpoint), then send a signal and
> > hit a data breakpoint, and we¢d recurse.  But we don¢t run user debug
> > handlers on the IST stack at all anymore.
> >
> > Maybe we can convince ourselves it¢s safe?
> 
> Maybe. Need to think about it for a while.

What about kprobes. It has nasty reentrancy stuff as well...

Thanks,

	tglx
--8323329-1964072614-1554316784=:1833--
