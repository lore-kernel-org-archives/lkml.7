Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B430C46477
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A9620861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFQVJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:09:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQVJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:09:37 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hcyse-0005Xx-QB; Mon, 17 Jun 2019 23:09:33 +0200
Date:   Mon, 17 Jun 2019 23:09:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 0/2] printk: new ringbuffer implementation
In-Reply-To: <20190607162349.18199-1-john.ogness@linutronix.de>
Message-ID: <alpine.DEB.2.21.1906172309170.1963@nanos.tec.linutronix.de>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
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

On Fri, 7 Jun 2019, John Ogness wrote:

Polite ping ....

> This is a follow-up RFC on the work to reimplement much of
> the core of printk. The original thread can be seen here[0].
> 
> One of the results of that thread was that the work needs to
> be broken up into several pieces. A roadmap was laid out[1]
> and this RFC is for the base component of the first piece:
> a new ringbuffer implementation for printk.
> 
> This series does not touch any existing printk code. It is
> only the ringbuffer implementation. I am particularly
> interested in feedback relating to the design of the
> ringbuffer and the use of memory barriers.
> 
> The series also includes a test module that performs some
> heavy writer stress testing. I have successfully run these
> tests on a 16-core ARM64 platform.
> 
> John Ogness
> 
> [0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
> [1] https://lkml.kernel.org/r/87y35hn6ih.fsf@linutronix.de
> 
> John Ogness (2):
>   printk-rb: add a new printk ringbuffer implementation
>   printk-rb: add test module
> 
>  Documentation/core-api/index.rst             |   1 +
>  Documentation/core-api/printk-ringbuffer.rst | 104 +++
>  include/linux/printk_ringbuffer.h            | 238 +++++++
>  lib/Makefile                                 |   2 +
>  lib/printk_ringbuffer.c                      | 924 +++++++++++++++++++++++++++
>  lib/test_prb.c                               | 237 +++++++
>  6 files changed, 1506 insertions(+)
>  create mode 100644 Documentation/core-api/printk-ringbuffer.rst
>  create mode 100644 include/linux/printk_ringbuffer.h
>  create mode 100644 lib/printk_ringbuffer.c
>  create mode 100644 lib/test_prb.c
> 
> -- 
> 2.11.0
> 
> 
