Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B79C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877602173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfH2LWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:22:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfH2LWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:22:11 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3IV5-0000zc-VP; Thu, 29 Aug 2019 13:22:00 +0200
Date:   Thu, 29 Aug 2019 13:21:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kbuild test robot <lkp@intel.com>
cc:     tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>,
        kbuild-all@01.org, linux-tip-commits@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: timers/core] posix-cpu-timers: Use common permission check
 in posix_cpu_clock_get()
In-Reply-To: <201908291858.PW3xOkIL%lkp@intel.com>
Message-ID: <alpine.DEB.2.21.1908291320010.1938@nanos.tec.linutronix.de>
References: <156698737946.5688.8980349129135194974.tip-bot2@tip-bot2> <201908291858.PW3xOkIL%lkp@intel.com>
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

On Thu, 29 Aug 2019, kbuild test robot wrote:
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190828]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

I have no idea what you are testing there.

>    kernel/time/posix-cpu-timers.c: In function 'posix_cpu_clock_get':
> >> kernel/time/posix-cpu-timers.c:275:8: error: implicit declaration of function 'get_task_for_clock'; did you mean 'get_task_struct'? [-Werror=implicit-function-declaration]
>      tsk = get_task_for_clock(clock);
>            ^~~~~~~~~~~~~~~~~~
>            get_task_struct
> >> kernel/time/posix-cpu-timers.c:275:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>      tsk = get_task_for_clock(clock);
>          ^
>    cc1: some warnings being treated as errors

That commit comes _after_ the commit which introduced the function and
get_task_for_clock() is defined above posix_cpu_clock_get(), so I assume
you missed to apply the commit on which this depends on.

Thanks,

	tglx
