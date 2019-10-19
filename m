Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254B8CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF01C21D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 10:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJSKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 06:13:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfJSKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 06:13:57 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iLlkA-0004MK-9K; Sat, 19 Oct 2019 12:13:54 +0200
Date:   Sat, 19 Oct 2019 12:13:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
In-Reply-To: <20191019073907.GA101301@gmail.com>
Message-ID: <alpine.DEB.2.21.1910191211410.2098@nanos.tec.linutronix.de>
References: <20191018203704.GC31027@cork> <20191018204220.GD31027@cork> <CAHk-=wi80VJ+4cUny2kwm0RxrmVdh24VPz5ZHjY4qCWR5iQBDQ@mail.gmail.com> <20191019073907.GA101301@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1579266021-1571480034=:2098"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1579266021-1571480034=:2098
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 19 Oct 2019, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Fri, Oct 18, 2019 at 4:42 PM Jörn Engel <joern@purestorage.com> wrote:
> 
> But from a softirq or threaded irq context that 'interrupted' regs 
> context might potentially be NULL.
> 
> NULL isn't a good thing to pass to mix_pool_bytes(), because the first 
> use of 'in' (='bytes') in _mix_pool_bytes() is a dereference without a 
> NULL check AFAICS:
> 
>                 w = rol32(*bytes++, input_rotate);
> 
> So at minimum I'd only mix this entropy into the pool if 'regs' is 
> non-zero. This would automatically do the right thing and not crash the 
> kernel on weird irq execution models such as threaded-only or -rt.

You don't even need threaded-only or RT. The timer is fired in the softirq
which very well can happen from thread context in mainline.

Thanks,

	tglx
--8323329-1579266021-1571480034=:2098--
