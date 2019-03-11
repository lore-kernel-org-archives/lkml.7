Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A240C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A242075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfCKOQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:16:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:16:07 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h3Lin-0006Sa-7C; Mon, 11 Mar 2019 15:16:05 +0100
Date:   Mon, 11 Mar 2019 15:16:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] scheduler updates for 5.1
In-Reply-To: <CAHk-=wi_krg9B2B0i7+mV4rRCdowiNw3bOC9rssaZTVFQvKMxQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1903111514180.1691@nanos.tec.linutronix.de>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de> <155221755097.13878.2888459223557668046.tglx@nanos.tec.linutronix.de> <CAHk-=wi_krg9B2B0i7+mV4rRCdowiNw3bOC9rssaZTVFQvKMxQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-357931329-1552313765=:1691"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-357931329-1552313765=:1691
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 10 Mar 2019, Linus Torvalds wrote:
> On Sun, Mar 10, 2019 at 4:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > A small set of fixes for the scheduler:
> 
> What? No.
> 
> This is completely broken, and even warns loudly about it.
> 
>   kernel/sched/cpufreq_schedutil.c: In function ‘sugov_iowait_boost’:
>   ./include/linux/kernel.h:827:29: warning: comparison of distinct
> pointer types lacks a cast
>   kernel/sched/cpufreq_schedutil.c:346:26: note: in expansion of macro ‘min’
>      sg_cpu->iowait_boost = min(sg_cpu->iowait_boost << 1,
> SCHED_CAPACITY_SCALE);
>                             ^~~
> 
> because 'SCHED_CAPACITY_SCALE' is of type 'long' and 'iowait_boost' is
> 'unsigned int'.
> 
> Why are you sending me code that hasn't even been compiled, and call it a "fix"?

Sorry. Should have been more careful...

Thanks,

	tglx
--8323329-357931329-1552313765=:1691--
