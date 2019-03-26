Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28C52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfCZMbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:31:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCZMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:31:22 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8lEc-0004Tz-96; Tue, 26 Mar 2019 13:31:18 +0100
Date:   Tue, 26 Mar 2019 13:31:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] timekeeping: Force upper bound for setting
 CLOCK_REALTIME
In-Reply-To: <20190326092607.GE14186@localhost>
Message-ID: <alpine.DEB.2.21.1903261329040.1789@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903231125480.2157@nanos.tec.linutronix.de> <20190326092607.GE14186@localhost>
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

On Tue, 26 Mar 2019, Miroslav Lichvar wrote:
> On Sat, Mar 23, 2019 at 11:36:19AM +0100, Thomas Gleixner wrote:
> > It is reasonable to force an upper bound for the various methods of setting
> > CLOCK_REALTIME. Year 2262 is the absolute upper bound. Assume a maximum
> > uptime of 30 years which is plenty enough even for esoteric embedded
> > systems. That results in an upper bound of year 2232 for setting the time.
> 
> The patch looks good to me.
> 
> I like this approach better than using a larger value closer to the
> overflow (e.g. one week) and stepping the clock back automatically
> when the clock reaches that time, but I suspect it might possibly
> break more tests (or any unusual applications messing with time) as a
> much larger interval is now EINVAL.

I'm fine with breaking a few tests on the way rather than having undefined
behaviour and the constant flow of patches tackling the wrong end of the
stick.

Thanks,

	tglx
