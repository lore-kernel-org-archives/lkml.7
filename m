Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4767C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBE1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfHVI5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:57:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfHVI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:57:45 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0iuc-0005yi-0z; Thu, 22 Aug 2019 10:57:42 +0200
Date:   Thu, 22 Aug 2019 10:57:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Clayton <chris2553@googlemail.com>
cc:     LKML <linux-kernel@vger.kernel.org>, vincenzo.frascino@arm.com,
        catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: Regression in 5.3-rc1 and later
In-Reply-To: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
Message-ID: <alpine.DEB.2.21.1908221047250.1983@nanos.tec.linutronix.de>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
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

Chris,

On Thu, 22 Aug 2019, Chris Clayton wrote:

Trimmed cc list

> I've found a problem that isn't present in 5.2 series or 4.19 series
> kernels, and seems to have arrived in 5.3-rc1. The problem is that if I
> suspend (to ram) my laptop, on resume 14 minutes or more after
> suspending, I have no networking functionality. If I resume the laptop
> after 13 minutes or less, networking works fine. I haven't tried to get
> finer grained timings between 13 and 14 minutes, but can do if it would
> help.
> 
> ifconfig shows that wlan0 is still up and still has its assigned ip
> address but, for instance, a ping of any other device on my network,
> fails as does pinging, say, kernel.org. I've tried "downing" the network
> with (/sbin/ifdown) and unloading the iwlmvm module and then reloading
> the module and "upping" (/sbin/ifup) the network, but my network is still
> unusable. I should add that the problem also manifests if I hibernate the
> laptop, although my testing of this has been minimal. I can do more if
> required.

What happens if you restart the network manager and/or wpa_supplicant or
whatever your distro uses for that.

> As I say, the problem first appears in 5.3-rc1, so I've bisected between
> 5.2.0 and 5.3-rc1 and that concluded with:

Just for confirmation, it's still broken as of 5.3-rc5, right? We had fixes
post rc1.

>     x86/vdso: Switch to generic vDSO implementation
 
> To confirm my bisection was correct, I did a git checkout of
> 7ac8707479886c75f353bfb6a8273f423cfccb2. As expected, the kernel
> exhibited the problem I've described. However, a kernel built at the
> immediately preceding (parent?) commit
> (bfe801ebe84f42b4666d3f0adde90f504d56e35b) has a working network after a
> (>= 14minute) suspend/resume cycle.

~14 minutes is odd. I can't come up with anything which rolls over, wraps
or overflows at that point.

Can you please provide the output of:

  dmesg | grep -i TSC

Thanks,

	tglx
