Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191EBC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E566320B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 12:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKJMnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 07:43:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54559 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfKJMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 07:43:52 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iTmZI-0005Vb-8n; Sun, 10 Nov 2019 13:43:48 +0100
Date:   Sun, 10 Nov 2019 13:43:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <JGross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 4/9] x86/io: Speedup schedule out of I/O bitmap user
In-Reply-To: <53B49BD3-6F9C-4A78-B203-1BD53034014D@amacapital.net>
Message-ID: <alpine.DEB.2.21.1911101341430.12583@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1911090043430.2605@nanos.tec.linutronix.de> <53B49BD3-6F9C-4A78-B203-1BD53034014D@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-894609131-1573389828=:12583"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-894609131-1573389828=:12583
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 8 Nov 2019, Andy Lutomirski wrote:
> > On Nov 8, 2019, at 3:45 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > ﻿On Fri, 8 Nov 2019, Andy Lutomirski wrote:
> >> SDM vol 3 27.5.2 says the BUILD_BUG_ON is right.  Or am I
> >> misunderstanding you?
> >> 
> >> I'm reasonably confident that the TSS limit is indeed 0x67 after VM
> >> exit, and I wrote the existing code that tries to optimize this to avoid
> >> LTR when not needed.
> > 
> > The BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 == 0x67) in the VMX code is bogus in
> > two aspects:
> > 
> > 1) This wants to be in generic x86 code
> 
> I think disagree. The only thing special about 0x67 is that VMX hard
> codes it. It’s specifically a VMX-ism. So I think the VMX code should
> indeed assert that 0x67 is a safe value.

Yes, it is a VMX specific issue, but I really prefer the build to fail in
the common code without having to enable VMX if something changes the
TSS layout in incompatible ways.

Thanks,

	tglx
--8323329-894609131-1573389828=:12583--
