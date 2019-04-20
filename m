Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3085C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5CF20859
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfDTAbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:31:12 -0400
Received: from relay13.nicmail.ru ([195.208.6.7]:16150 "EHLO
        relay13.nicmail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDTAbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:31:11 -0400
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 20:31:10 EDT
Received: from [109.70.25.252] (port=53474 helo=sghpc.hn.golosunov.pp.ru)
        by f17.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hHdjr-000MkY-4H; Sat, 20 Apr 2019 03:20:15 +0300
Received: from [5.165.42.149] (account sghpc@golosunov.pp.ru HELO sghpc.hn.golosunov.pp.ru)
        by proxy09.mail.nic.ru (Exim 5.55)
        with id 1hHdjr-0002Ob-5m; Sat, 20 Apr 2019 03:20:15 +0300
Received: from stepan by sghpc.hn.golosunov.pp.ru with local (Exim 4.89)
        (envelope-from <stepan@golosunov.pp.ru>)
        id 1hHdjm-0008Ss-Bt; Sat, 20 Apr 2019 04:20:10 +0400
Date:   Sat, 20 Apr 2019 04:20:10 +0400
From:   Stepan Golosunov <stepan@golosunov.pp.ru>
To:     Lukasz Majewski <lukma@denx.de>, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     libc-alpha@sourceware.org, Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] y2038: linux: Provide __clock_settime64
 implementation
Message-ID: <20190420002009.l65upn2t3qqoj5uy@sghpc.golosunov.pp.ru>
References: <20190414220841.20243-1-lukma@denx.de>
 <20190414220841.20243-4-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190414220841.20243-4-lukma@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.04.2019 в 00:08:38 +0200 Lukasz Majewski написал:
> +# if defined __NR_clock_settime64
> +  /* Make sure that passed __timespec64 struct pad is 0.  */
> +  struct __timespec64 ts = *tp;
> +  ts.tv_pad = 0;
> +  return INLINE_SYSCALL_CALL (clock_settime64, clock_id, &ts);

Isn't kernel supposed to zero out padding on its own?
At least comment in kernel's get_timespec64 says so:

	/* Zero out the padding for 32 bit systems or in compat mode */
	if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
		kts.tv_nsec &= 0xFFFFFFFFUL;

The code looks buggy though. It fails to zero out the padding in
32-bit kernels. That part is probably broken since
98f76206b3350 ("compat: Cleanup in_compat_syscall() callers").

And, hmm, is CONFIG_64BIT_TIME enabled anywhere?
