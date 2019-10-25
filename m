Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A24ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5F121872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfJYUoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:44:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38999 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfJYUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:44:06 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iO6RE-0004il-IH; Fri, 25 Oct 2019 22:44:00 +0200
Date:   Fri, 25 Oct 2019 22:43:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Hemminger <stephen@networkplumber.org>
cc:     Andy Lutomirski <luto@kernel.org>, dev@dpdk.org,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
In-Reply-To: <20191025091310.05770edc@hermes.lan>
Message-ID: <alpine.DEB.2.21.1910252232590.1905@nanos.tec.linutronix.de>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com> <20191025091310.05770edc@hermes.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019, Stephen Hemminger wrote:
> On Thu, 24 Oct 2019 21:45:56 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
> > 3. Use ioperm() instead of iopl().
> 
> Ioperm has the wrong thread semantics. All DPDK applications have
> multiple threads and the initialization logic needs to work even
> if the thread is started later; threads can also be started by
> the user application.
> 
> Iopl applies to whole process so this is not an issue.

No. iopl is also per thread and not per process. That has been that way
forever. The man page is blantantly wrong.

Both iopl and ioperm are inherited on fork.
 
Thanks,

	tglx
