Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E8C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B94206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfHPW14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:27:56 -0400
Received: from foss.arm.com ([217.140.110.172]:34058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfHPW14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:27:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D30F0344;
        Fri, 16 Aug 2019 15:27:55 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DC773F718;
        Fri, 16 Aug 2019 15:27:54 -0700 (PDT)
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
Date:   Fri, 16 Aug 2019 23:27:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816205740.GF10481@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2019 21:57, Joel Fernandes wrote:
>> Can we finally put a foot down and tell compiler and standard committee
>> people to stop this insanity?
> 
> Sure, or could the compilers provide flags which prevent such optimization
> similar to -O* flags?
> 

How would you differentiate optimizations you want from those you don't with
just a flag? There's a reason we use volatile casts instead of declaring
everything volatile: we actually *want* those optimizations. It just so
happens that we don't want them *in some places*, and we have tools to tag
them as such.

The alternative is having a compiler that can magically correlate e.g. locked
writes with lock-free reads and properly handle them, but I don't think
there's a foolproof way of doing that.

> thanks,
> 
>  - Joel
> 
