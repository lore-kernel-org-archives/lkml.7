Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F001C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B50B222C9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 07:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKGHpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 02:45:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46349 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfKGHpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 02:45:36 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iScU0-0000UI-FP; Thu, 07 Nov 2019 08:45:32 +0100
Date:   Thu, 7 Nov 2019 08:45:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage
 further
In-Reply-To: <20191107073719.GD30739@gmail.com>
Message-ID: <alpine.DEB.2.21.1911070844550.1869@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <20191107073719.GD30739@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1692257517-1573112732=:1869"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1692257517-1573112732=:1869
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 Nov 2019, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> >  	/*
> > -	 * The extra 1 is there because the CPU will access an
> > -	 * additional byte beyond the end of the IO permission
> > -	 * bitmap. The extra byte must be all 1 bits, and must
> > -	 * be within the limit.
> > +	 * The extra 1 is there because the CPU will access an additional
> > +	 * byte beyond the end of the I/O permission bitmap. The extra byte
> > +	 * must have all bits set and must be within the TSS limit.
> >  	 */
> >  	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
> >  } __aligned(PAGE_SIZE);
> 
> Note that on 32-bit kernels this blows up our CPU area calculations:
> 
> ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_181’ declared with attribute error: BUILD_BUG_ON failed: CPU_ENTRY_AREA_PAGES * PAGE_SIZE < CPU_ENTRY_AREA_MAP_SIZE
> ./include/linux/compiler.h:331:4: note: in definition of macro ‘__compiletime_assert’
> ./include/linux/compiler.h:350:2: note: in expansion of macro ‘_compiletime_assert’
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
> ./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
> arch/x86/mm/cpu_entry_area.c:181:2: note: in expansion of macro ‘BUILD_BUG_ON’
> make[2]: *** [scripts/Makefile.build:265: arch/x86/mm/cpu_entry_area.o] Error 1

Duh. /me goes investigate.

--8323329-1692257517-1573112732=:1869--
