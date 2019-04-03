Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36C220700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDCQ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:26:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41591 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:26:10 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBiiF-0003e0-8U; Wed, 03 Apr 2019 18:26:07 +0200
Date:   Wed, 3 Apr 2019 18:26:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 15/14] x86/dumpstack/64: Speedup in_exception_stack()
In-Reply-To: <6205D576-694A-4C7D-B1B7-A9FF2E1F9E77@amacapital.net>
Message-ID: <alpine.DEB.2.21.1904031823100.1967@nanos.tec.linutronix.de>
References: <20190331214020.836098943@linutronix.de> <20190331215136.039902969@linutronix.de> <alpine.DEB.2.21.1904021214340.1676@nanos.tec.linutronix.de> <20190402154329.scp7i7uqevubgwrz@treble> <alpine.DEB.2.21.1904021746080.1676@nanos.tec.linutronix.de>
 <7789E14E-C623-4DB7-B076-76B931957C9C@amacapital.net> <alpine.DEB.2.21.1904022027170.1812@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904022127210.1812@nanos.tec.linutronix.de> <6205D576-694A-4C7D-B1B7-A9FF2E1F9E77@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1646928762-1554308767=:1967"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1646928762-1554308767=:1967
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 2 Apr 2019, Andy Lutomirski wrote:
> > On Apr 2, 2019, at 1:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>> How about a much better fix: make the DB stack be the same size as all
> >>> the others and just have 4 of them (DB0, DB1, DB2, and DB3.  After all,
> >>> overflowing from one debug stack into another is just as much of a bug as
> >>> overflowing into a different IST stack.
> >> 
> >> That makes sense.
> > 
> > Except that we just have two not four.
> > 
> > It needs some tweaking of the ist_shift stuff in entry_64.S but that's not
> > rocket science. Famous last words....
> > 
> 
> The ist_shift mess should probably be in C, but that’s a big can of
> worms. That being said, why do we have it at all?  Once upon a time, we’d
> do ICEBP from user mode (or a legit breakpoint), then send a signal and
> hit a data breakpoint, and we’d recurse.  But we don’t run user debug
> handlers on the IST stack at all anymore.
>
> Maybe we can convince ourselves it’s safe?

Maybe. Need to think about it for a while.

Thanks,

	tglx

--8323329-1646928762-1554308767=:1967--
